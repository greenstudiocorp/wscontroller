//
//  CacheLoader.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheLoader : NSObject

@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSError *error;

#pragma mark - Business methods

-(void)loadCachedData;
-(void)performLoadCache;

@end
