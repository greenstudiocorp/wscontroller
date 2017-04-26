//
//  DataPersistenceThread.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "DataPersistenceThread.h"

@implementation DataPersistenceThread

#pragma mark - Static methods

+ (void)dataPersistenceThreadEntryPoint:(id __unused)object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"DataPersistenceThread"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)dataPersistenceThread {
    static NSThread *_cacheLoadingThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _cacheLoadingThread = [[NSThread alloc] initWithTarget:self selector:@selector(dataPersistenceThreadEntryPoint:) object:nil];
        _cacheLoadingThread.name = @"DataPersistenceThread";
        [_cacheLoadingThread start];
    });
    
    return _cacheLoadingThread;
}

@end
