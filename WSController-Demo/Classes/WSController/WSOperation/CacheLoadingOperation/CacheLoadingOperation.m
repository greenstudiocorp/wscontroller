//
//  CacheLoadingOperation.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "CacheLoadingOperation.h"
#import "DataPersistenceThread.h"
#import "WSControllerDelegate.h"

@interface CacheLoadingOperation ()

-(void)loadCache;
-(void)didLoadData:(id) data;
-(void)didFailWithError:(NSError*) error;

@end

@implementation CacheLoadingOperation

@synthesize cacheLoader             = _cacheLoader;
@synthesize wsControllerDelegate    = _wsControllerDelegate;

#pragma mark - CacheLoadingOperation life-cycle methods

- (id)initWithCacheLoader:(CacheLoader*) cacheLoader
     wsControllerDelegate:(id<WSControllerDelegate>) wsControllerDelegate{
    self = [super init];
    if (self) {
        self.cacheLoader = cacheLoader;
        self.wsControllerDelegate = wsControllerDelegate;
    }
    return self;
}

#pragma mark - NSOperation methods

- (void)start {
    [super start];
    NSLog(@"Start cache loading");
    [self.lock lock];
    if ([self isReady]) {
        self.state = CLOperationExecutingState;
        [self performSelector:@selector(operationDidStart)
                     onThread:[DataPersistenceThread dataPersistenceThread]
                   withObject:nil
                waitUntilDone:NO
                        modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}

#pragma mark - CacheLoading private methods

-(void)performOperation {
    
    [self.cacheLoader loadCachedData];
    
    WSResponse * response = nil;
    
    if (self.cacheLoader.error) {
        response = [WSResponse newErrorResponseWithDescription:self.cacheLoader.error];
    } else {
        response = [WSResponse newCacheResponseWithData:self.cacheLoader.data];
    }
    
    dispatch_async(self.callback_queue ?: dispatch_get_main_queue(), ^{
        if (![self isCancelled]
                    && self.wsControllerDelegate
                    && [self.wsControllerDelegate respondsToSelector:@selector(didReceivedResponse:)]) {
            [self.wsControllerDelegate didReceivedResponse:response];
        }
        [self finish];
    });
}

@end
