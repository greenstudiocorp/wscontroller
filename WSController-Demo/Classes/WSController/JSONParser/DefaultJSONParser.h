//
//  DefaultJSONParser.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONParser.h"

@interface DefaultJSONParser : NSObject <JSONParser>

@property (nonatomic, strong) Class entityClass;
@property (nonatomic, strong) NSDictionary *mapping;

#pragma mark - DefaultJSONParser life-cycle methods

- (id)initDefaultJSONParserWithEntityClass:(Class) class mapping:(NSDictionary*) mapping;

@end
