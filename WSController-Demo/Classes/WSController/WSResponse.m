//
//  WSResponse.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "WSResponse.h"

@implementation WSResponse

@synthesize isSuccess       = _isSuccess;
@synthesize isCachedData    = _isCachedData;
@synthesize error           = _error;
@synthesize data            = _data;

+ (WSResponse*)newFreshResponseWithData:(id) data{
    WSResponse *response = [[WSResponse alloc] init];
    response.isCachedData = NO;
    response.data = data;
    return response;
}

+ (WSResponse*)newCacheResponseWithData:(id) data{
    WSResponse *response = [[WSResponse alloc] init];
    response.isCachedData = YES;
    response.data = data;
    return response;
}

+ (WSResponse*)newErrorResponseWithDescription:(NSError*) error{
    WSResponse *response = [[WSResponse alloc] init];
    response.isCachedData = YES;
    response.error = error;
    return response;
}

- (BOOL)isSuccess{
    return !(!self.data || self.error);
}

- (NSString*)description {
    NSString *description = nil;
    if (![self isSuccess]) {
        description = [NSString stringWithFormat:@"Request fail with error: %@", self.error];
    } else if (self.isCachedData) {
        description = [NSString stringWithFormat:@"Cache loaded: %@", self.data];
    } else {
        description = [NSString stringWithFormat:@"Fresh data loaded: %@", self.data];
    }
    return description;
}

@end
