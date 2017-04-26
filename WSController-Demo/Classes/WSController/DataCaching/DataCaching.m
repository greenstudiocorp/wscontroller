//
//  DataCaching.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "DataCaching.h"

@interface DataCaching ()

-(void)performLoadCacheWithLock;

@end

@implementation DataCaching

@synthesize error           = _error;
@synthesize data            = _data;

#pragma mark - DataCaching life-cycle methods

- (id)initWithData:(id) data{
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

#pragma mark - Business methods

-(void)cacheData{
    [self performDataCaching];
}

-(void)performDataCaching{
    
}

@end
