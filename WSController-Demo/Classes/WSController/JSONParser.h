//
//  JSONParser.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONParser <NSObject>

@required
- (id)objectFromJSONString:(NSString*) jsonData;

@end
