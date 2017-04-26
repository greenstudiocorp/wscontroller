//
//  CacheLoader.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "CacheLoader.h"

#define CACHE_LOADER_LOCK @"CacheLoaderLock"

@interface CacheLoader ()

-(void)performLoadCacheWithLock;

@end

@implementation CacheLoader

@synthesize data                    = _data;
@synthesize error                   = _error;

#pragma mark - CacheLoader life-cycle methods

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Business methods

-(void)loadCachedData{
    [self performLoadCache];
}

-(void)performLoadCache{
    self.data = nil;
}

@end
