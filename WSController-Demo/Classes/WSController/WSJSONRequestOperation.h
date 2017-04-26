//
//  WSJSONRequestOperation.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "DataCachingOperation.h"
#import "WSControllerDelegate.h"
#import "JSONParser.h"

@interface WSJSONRequestOperation : AFHTTPRequestOperation

@property (nonatomic, assign) NSJSONReadingOptions JSONReadingOptions;
@property (nonatomic, weak) DataCachingOperation *dataCachingOperation;
@property (nonatomic, weak) id<WSControllerDelegate> wsControllerDelegate;
@property (nonatomic, strong) id<JSONParser> jsonParser;
@property (nonatomic, strong) NSString *benchmarkName;

+ (instancetype)JSONRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure;
+ (instancetype)intanceWithNSURLRequest:(NSURLRequest*) reuqest
                             jsonParser:(id<JSONParser>) jsonParser
                   wsControllerDelegate:(id<WSControllerDelegate>) wsControllerDelegate
                   dataCachingOperation:(DataCachingOperation*) dataCachingOperation;

@end
