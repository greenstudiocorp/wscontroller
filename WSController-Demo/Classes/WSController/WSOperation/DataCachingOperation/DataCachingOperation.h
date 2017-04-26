//
//  DataCachingOperation.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "BaseWSOperation.h"
#import "DataCaching.h"

@interface DataCachingOperation : BaseWSOperation

@property (nonatomic, strong) DataCaching *dataCaching;

- (id)initWithCacheCaching:(DataCaching*) dataCaching;

@end
