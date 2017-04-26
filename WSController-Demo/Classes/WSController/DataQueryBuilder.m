//
//  DataQueryBuilder.m
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import "DataQueryBuilder.h"
#import "DataQueryController.h"
#import "WSJSONRequestOperation.h"
#import "DataCachingOperation.h"
#import "CacheLoadingOperation.h"
#import "BlankJSONParser.h"

@implementation DataQueryBuilder

@synthesize webserviceMethod        = _webserviceMethod;
@synthesize getParameter            = _getParameter;
@synthesize postParameter           = _postParameter;
@synthesize jsonParser              = _jsonParser;
@synthesize cacheLoader             = _cacheLoader;
@synthesize dataCaching             = _dataCaching;
@synthesize wsControllerDelegate    = _wsControllerDelegate;

+ (DataQueryBuilder*) newBuilder {
    return [[DataQueryBuilder alloc] init];
}

- (NSURLRequest*)requestWithMethod:(NSString*) method {
    NSString *webserviceURLString = [NSString stringWithFormat:@"%@%@", BASE_URL, method];
    if (self.getParameter) {
        webserviceURLString = [webserviceURLString stringByAppendingFormat:@"?%@", self.getParameter];
    }
    NSURL *url = [NSURL URLWithString:webserviceURLString];
    NSMutableURLRequest *webserviceRequest = [NSMutableURLRequest requestWithURL:url
                                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                 timeoutInterval:DEFAULT_TIMEOUT];
    if (self.postParameter) {
        //Set post param
        [webserviceRequest setHTTPMethod:@"POST"];
        [webserviceRequest setHTTPBody:[self.postParameter dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return webserviceRequest;
}

- (DataQueryController*) buildDataQuery {
    
    DataQueryController *dataQueryController = [[DataQueryController alloc] init];
    
    WSJSONRequestOperation *wsRequestOperation = nil;
    DataCachingOperation *dataCachingOperation = nil;
    CacheLoadingOperation *cacheLoadingOperation = nil;
    
    //Init data caching
    if (self.dataCaching) {
        dataCachingOperation = [[DataCachingOperation alloc] initWithCacheCaching:self.dataCaching];
        [dataQueryController addOperation:dataCachingOperation];
    }
    
    //Init webservice loader
    if (self.webserviceMethod) {
        NSURLRequest *webserviceRequest = [self requestWithMethod:self.webserviceMethod];
        if (!self.jsonParser) {
            self.jsonParser = [[BlankJSONParser alloc] init];
        }
        wsRequestOperation = [WSJSONRequestOperation intanceWithNSURLRequest:webserviceRequest
                                                                  jsonParser:self.jsonParser
                                                        wsControllerDelegate:self.wsControllerDelegate
                                                        dataCachingOperation:dataCachingOperation];
        if (dataCachingOperation) {
            [dataCachingOperation addDependency:wsRequestOperation];
        }
        [dataQueryController addOperation:wsRequestOperation];
    }
    
    //Init cache loader
    if (self.cacheLoader) {
        cacheLoadingOperation = [[CacheLoadingOperation alloc] initWithCacheLoader:self.cacheLoader
                                                              wsControllerDelegate:self.wsControllerDelegate];
        if (wsRequestOperation) {
            [wsRequestOperation addDependency:cacheLoadingOperation];
        }
        [dataQueryController addOperation:cacheLoadingOperation];
    }
    
    return dataQueryController;
}

@end
