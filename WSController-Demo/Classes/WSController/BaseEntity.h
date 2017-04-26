//
//  BaseEntity.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataMappingProtocol <NSObject>

@required
+(NSDictionary*)mapping;

@end

@interface BaseEntity : NSObject<DataMappingProtocol>

@end
