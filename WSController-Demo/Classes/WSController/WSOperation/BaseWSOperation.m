//
//  BaseWSOperation.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "BaseWSOperation.h"
#import "WSController.h"

@interface BaseWSOperation ()

@end

@implementation BaseWSOperation

@synthesize runLoopModes            = _runLoopModes;
@synthesize callback_queue          = _callback_queue;
@synthesize state                   = _state;
@synthesize lock                    = _lock;

static inline NSString * CLKeyPathFromOperationState(CacheLoadingOperationState state) {
    switch (state) {
        case CLOperationReadyState:
            return @"isReady";
        case CLOperationExecutingState:
            return @"isExecuting";
        case CLOperationFinishedState:
            return @"isFinished";
        default:
            return @"state";
    }
}

static inline BOOL CLStateTransitionIsValid(CacheLoadingOperationState fromState, CacheLoadingOperationState toState, BOOL isCancelled) {
    switch (fromState) {
        case CLOperationReadyState:
            switch (toState) {
                case CLPausedState:
                case CLOperationExecutingState:
                    return YES;
                case CLOperationFinishedState:
                    return isCancelled;
                default:
                    return NO;
            }
        case CLOperationExecutingState:
            switch (toState) {
                case CLPausedState:
                case CLOperationFinishedState:
                    return YES;
                default:
                    return NO;
            }
        case CLOperationFinishedState:
            return NO;
        case CLPausedState:
            return toState == CLOperationReadyState;
        default:
            return YES;
    }
}

#pragma mark - BaseWSOperation methods

- (id)init{
    self = [super init];
    if (self) {
        self.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
        self.state = CLOperationReadyState;
    }
    return self;
}

#pragma mark - Business methods

- (void)operationDidStart{
    [self.lock lock];
    [self begin];
    if (! [self isCancelled]) {
        [self performOperation];
    }
    [self.lock unlock];
    if ([self isCancelled]) {
        [self finish];
    }
}

- (void)performOperation{
    
}

#pragma mark - NSOperation methods

- (void)start {
    //[super start];
}

- (BOOL)isReady {
    return (self.state == CLOperationReadyState) && [super isReady];
}

- (BOOL)isExecuting {
    return (self.state == CLOperationExecutingState);
}

- (BOOL)isFinished {
    return (self.state == CLOperationFinishedState);
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)begin {
    
}

- (void)setState:(CacheLoadingOperationState)state {
    if (!CLStateTransitionIsValid(self.state, state, [self isCancelled])) {
        return;
    }
    
    [self.lock lock];
    NSString *oldStateKey = CLKeyPathFromOperationState(self.state);
    NSString *newStateKey = CLKeyPathFromOperationState(state);
    
    [self willChangeValueForKey:newStateKey];
    [self willChangeValueForKey:oldStateKey];
    _state = state;
    [self didChangeValueForKey:oldStateKey];
    [self didChangeValueForKey:newStateKey];
    [self.lock unlock];
}

- (void)finish {
    self.state = CLOperationFinishedState;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@:%@", NSStringFromClass(self.class), CLKeyPathFromOperationState(self.state)];
}

@end
