//
//  BaseWSOperation.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CLPausedState      = -1,
    CLOperationReadyState       = 1,
    CLOperationExecutingState   = 2,
    CLOperationFinishedState    = 3,
} CacheLoadingOperationState;

@interface BaseWSOperation : NSOperation


/**
 The run loop modes in which the operation will run on the network thread. By default, this is a single-member set containing `NSRunLoopCommonModes`.
 */
@property (nonatomic, strong) NSSet *runLoopModes;
@property (nonatomic        ) dispatch_queue_t callback_queue;
@property (nonatomic        ) CacheLoadingOperationState state;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;


#pragma mark - Business methods

- (void)operationDidStart;
- (void)performOperation;
- (void)begin;
- (void)finish;

@end
