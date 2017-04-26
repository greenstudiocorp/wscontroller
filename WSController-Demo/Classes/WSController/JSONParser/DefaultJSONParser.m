//
//  DefaultJSONParser.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "DefaultJSONParser.h"
#import "NSObject+JTObjectMapping.h"

@interface DefaultJSONParser ()

- (id)objectFromJSONString:(NSString*) jsonString
                   mapping:(NSDictionary*) mapping;

@end

@implementation DefaultJSONParser

@synthesize entityClass         = _entityClass;
@synthesize mapping             = _mapping;

#pragma mark - DefaultJSONParser life-cycle methods

- (id)initDefaultJSONParserWithEntityClass:(Class) class
                                   mapping:(NSDictionary*) mapping {
    self = [super init];
    if (self) {
        self.entityClass = class;
        self.mapping = mapping;
    }
    return self;
}

#pragma mark - Business methods

- (id)objectFromJSONString:(NSString*) jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    NSObject *object = [self.entityClass objectFromJSONObject:jsonObject mapping:self.mapping];
    return object;
}

@end
