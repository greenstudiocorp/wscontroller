//
//  CacheLoadingOperation.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheLoader.h"
#import "WSController.h"
#import "BaseWSOperation.h"

@interface CacheLoadingOperation : BaseWSOperation

@property (nonatomic, strong) CacheLoader *cacheLoader;
@property (nonatomic,   weak) id<WSControllerDelegate> wsControllerDelegate;

#pragma mark - CacheLoadingOperation life-cycle methods

- (id)initWithCacheLoader:(CacheLoader*) cacheLoader
     wsControllerDelegate:(id<WSControllerDelegate>) wsControllerDelegate;

@end
