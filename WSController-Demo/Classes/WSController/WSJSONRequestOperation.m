//
//  WSJSONRequestOperation.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "WSJSONRequestOperation.h"
#import "WSController.h"

static dispatch_queue_t json_request_operation_processing_queue() {
    static dispatch_queue_t af_json_request_operation_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af_json_request_operation_processing_queue = dispatch_queue_create("vng.com.vn.json.to.object", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return af_json_request_operation_processing_queue;
}

@interface WSJSONRequestOperation ()

@property (readwrite, nonatomic, strong) NSError *JSONError;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;
@property (readwrite, nonatomic, strong) id responseObject;

@end


@implementation WSJSONRequestOperation

@synthesize dataCachingOperation    = _dataCachingOperation;
@synthesize wsControllerDelegate    = _wsControllerDelegate;
@synthesize jsonParser              = _jsonParser;
@synthesize responseObject          = _responseObject;
@synthesize JSONReadingOptions      = _JSONReadingOptions;
@synthesize JSONError               = _JSONError;
@synthesize benchmarkName           = _benchmarkName;
@dynamic lock;

+ (instancetype)intanceWithNSURLRequest:(NSURLRequest*) webserviceRequest
                             jsonParser:(id<JSONParser>) jsonParser
                   wsControllerDelegate:(id<WSControllerDelegate>) wsControllerDelegate
                   dataCachingOperation:(DataCachingOperation*) dataCachingOperation {
    
    WSJSONRequestOperation * __block webserviceRequestOperation = [WSJSONRequestOperation JSONRequestOperationWithRequest:webserviceRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (webserviceRequestOperation
                && webserviceRequestOperation.dataCachingOperation) {
            webserviceRequestOperation.dataCachingOperation.dataCaching.data = JSON;
        }
        webserviceRequestOperation = nil;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (webserviceRequestOperation
                && webserviceRequestOperation.dataCachingOperation) {
            [webserviceRequestOperation.dataCachingOperation cancel];
        }
        webserviceRequestOperation = nil;
    }];
    webserviceRequestOperation.jsonParser = jsonParser;
    webserviceRequestOperation.wsControllerDelegate = wsControllerDelegate;
    webserviceRequestOperation.dataCachingOperation = dataCachingOperation;
    return webserviceRequestOperation;
}

+ (instancetype)JSONRequestOperationWithRequest:(NSURLRequest *)urlRequest
										success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
										failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
    WSJSONRequestOperation *requestOperation = [(WSJSONRequestOperation *)[self alloc] initWithRequest:urlRequest];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation.request, operation.response, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation.request, operation.response, error, [(WSJSONRequestOperation *)operation responseObject]);
        }
    }];
    
    return requestOperation;
}

- (BOOL)isReady {
    return [super isReady];
}

-(void)start{
    [super start];
    NSLog(@"Start webservice");
}

- (id)responseObject {
    [self.lock lock];
    if (!_responseObject && [self.responseData length] > 0 && [self isFinished] && !self.JSONError && self.jsonParser) {
        NSError *error = nil;
        if (self.responseString && ![self.responseString isEqualToString:@" "] && self.jsonParser && [self.jsonParser respondsToSelector:@selector(objectFromJSONString:)]) {
            self.responseObject = [self.jsonParser objectFromJSONString:self.responseString];
        }
        
        self.JSONError = error;
    }
    [self.lock unlock];
    
    return _responseObject;
}

- (NSError *)error {
    if (_JSONError) {
        return _JSONError;
    } else {
        return [super error];
    }
}

#pragma mark - AFHTTPRequestOperation

+ (NSSet *)acceptableContentTypes {
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
}

+ (BOOL)canProcessRequest:(NSURLRequest *)request {
    return [[[request URL] pathExtension] isEqualToString:@"json"] || [super canProcessRequest:request];
}

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
#pragma clang diagnostic ignored "-Wgnu"
    
    self.completionBlock = ^ {
        if (self.error) {
            if (failure) {
                dispatch_async(self.failureCallbackQueue ?: dispatch_get_main_queue(), ^{
                    if (![self isCancelled]
                                && self.wsControllerDelegate
                                && [self.wsControllerDelegate respondsToSelector:@selector(didReceivedResponse:)]) {
                        WSResponse *response = [WSResponse newErrorResponseWithDescription:self.error];
                        [self.wsControllerDelegate didReceivedResponse:response];
                    }
                    failure(self, self.error);
                });
            }
        } else {
            dispatch_async(json_request_operation_processing_queue(), ^{
                id JSON = self.responseObject;
                
                if (self.error) {
                    if (failure) {
                        dispatch_async(self.failureCallbackQueue ?: dispatch_get_main_queue(), ^{
                            if (![self isCancelled]
                                        && self.wsControllerDelegate
                                        && [self.wsControllerDelegate respondsToSelector:@selector(didReceivedResponse:)]) {
                                WSResponse *response = [WSResponse newErrorResponseWithDescription:self.error];
                                [self.wsControllerDelegate didReceivedResponse:response];
                            }
                            failure(self, self.error);
                        });
                    }
                } else {
                    if (success) {
                        dispatch_async(self.successCallbackQueue ?: dispatch_get_main_queue(), ^{
                            if (![self isCancelled]
                                        && self.wsControllerDelegate
                                        && [self.wsControllerDelegate respondsToSelector:@selector(didReceivedResponse:)]) {
                                WSResponse *response = [WSResponse newFreshResponseWithData:self.responseObject];
                                [self.wsControllerDelegate didReceivedResponse:response];
                            }
                            success(self, JSON);
                        });
                    }
                }
            });
        }
    };
#pragma clang diagnostic pop
}

@end
