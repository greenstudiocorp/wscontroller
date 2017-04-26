//
//  DataCachingOperation.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "DataCachingOperation.h"
#import "DataCaching.h"
#import "DataPersistenceThread.h"

@implementation DataCachingOperation

@synthesize dataCaching = _dataCaching;

#pragma mark - DataCachingOperation life-cycle methods

- (id)initWithCacheCaching:(DataCaching*) dataCaching {
    self = [super init];
    if (self) {
        self.dataCaching = dataCaching;
    }
    return self;
}

#pragma mark - NSOperation methods

- (void)start {
    [super start];
    NSLog(@"Start data caching");
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
    if (![self isCancelled]) {
        [self.dataCaching cacheData];
    }
    
    dispatch_async(self.callback_queue ?: dispatch_get_main_queue(), ^{
        [self finish];
    });
}

@end
