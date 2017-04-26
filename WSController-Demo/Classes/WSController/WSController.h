//
//  WSController.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSResponse.h"
#import "WSControllerDelegate.h"

/*
#define BASE_URL = @"https://dl.dropboxusercontent.com/u/1313721/"

#define GET_FILM_LIST = @"film_list.json"
*/
@interface WSController : NSObject

#pragma mark - Utility methods

+ (WSController*)sharedWSController;

+ (void)unlinkSharedWSController;

#pragma mark - WSController business methods

+ (NSOperationQueue*)getResourcesWithWSControllerDelegate:(id<WSControllerDelegate>) wsControllerDelegate;

@end
