//
//  DataCaching.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCaching : NSObject

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id data;

#pragma mark - DataCaching life-cycle methods

#pragma mark - Business methods

-(void)cacheData;
-(void)performDataCaching;

@end
