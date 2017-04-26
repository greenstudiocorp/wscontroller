//
//  WSController.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "WSController.h"
#import "WSJSONRequestOperation.h"
#import "DataCachingOperation.h"
#import "CacheLoadingOperation.h"
#import "JSONParser.h"
#import "WSJSONRequestOperation.h"
#import "JSONParser.h"
#import "DefaultJSONParser.h"
#import "Film.h"
#import "CoreDataCacheLoader.h"
#import "CoreDataCaching.h"

@interface WSController ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

static WSController * __strong _sharedWSController;

@implementation WSController

@synthesize operationQueue = _operationQueue;

#pragma mark - Utility methods

+ (WSController*)sharedWSController {
    if (!_sharedWSController) {
        _sharedWSController = [[WSController alloc] init];
    }
    return _sharedWSController;
}

+ (void)unlinkSharedWSController {
    _sharedWSController = nil;
}

#pragma mark - WSController life-cycle methods

- (id)init {
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.name = @"WSControllerQueue";
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark - WSController business methods
/*
+ (NSOperationQueue*)getResourcesWithWSControllerDelegate:(id<WSControllerDelegate>) wsControllerDelegate{
    
    DefaultJSONParser *defaultJSONParser = [[DefaultJSONParser alloc] initDefaultJSONParserWithEntityClass:Film.class
                                                                                                   mapping:[Film mapping]];
    
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/1313721/film_list.json"];
    NSURLRequest *webserviceRequest = [NSURLRequest requestWithURL:url];
    
    CoreDataCacheLoader *cacheLoader = [[CoreDataCacheLoader alloc] init];
    CoreDataCaching *coreDataCaching = [[CoreDataCaching alloc] init];
    DataCachingOperation *dataCachingOperation = [[DataCachingOperation alloc] initWithCacheCaching:coreDataCaching];
    CacheLoadingOperation *cacheLoadingOperation = [[CacheLoadingOperation alloc] initWithCacheLoader:cacheLoader
                                                                                 wsControllerDelegate:wsControllerDelegate];
    
    WSJSONRequestOperation *jsonWebserviceRequestOperation = [WSJSONRequestOperation intanceWithNSURLRequest:webserviceRequest
                                                                                                  jsonParser:defaultJSONParser
                                                                                        wsControllerDelegate:wsControllerDelegate
                                                                                        dataCachingOperation:dataCachingOperation];
    
    [jsonWebserviceRequestOperation addDependency:cacheLoadingOperation];
    [dataCachingOperation addDependency:jsonWebserviceRequestOperation];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"WSOperationQueue";
    [queue addOperations:[NSArray arrayWithObjects:
                                        dataCachingOperation,
                                        cacheLoadingOperation,
                                        jsonWebserviceRequestOperation,
                                        nil]
                                 waitUntilFinished:NO];
    return queue;
}
*/

@end
