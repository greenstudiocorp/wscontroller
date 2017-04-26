//
//  DataQueryBuilder.h
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONParser.h"
#import "CacheLoader.h"
#import "DataCaching.h"
#import "WSController.h"

#define DEFAULT_TIMEOUT 60

#define BASE_URL @"https://590008970dcf7e0011170686.mockapi.io/v1"
#define GET_FILM_DETAIL_METHOD @"film/1"

@class DataQueryController;

@interface DataQueryBuilder : NSObject

@property (nonatomic, strong) NSString *webserviceMethod;
@property (nonatomic, strong) NSString *getParameter;
@property (nonatomic, strong) NSString *postParameter;
@property (nonatomic, strong) id<JSONParser> jsonParser;
@property (nonatomic, strong) CacheLoader* cacheLoader;
@property (nonatomic, strong) DataCaching* dataCaching;
@property (nonatomic, strong) id<WSControllerDelegate> wsControllerDelegate;

+ (DataQueryBuilder*) newBuilder;
- (NSURLRequest*)defaultRequestWithMethod:(NSString*) method;
- (DataQueryController*) buildDataQuery;

@end
