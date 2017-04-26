//
//  WSControllerDelegate.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSResponse.h"

@protocol WSControllerDelegate <NSObject>

@required
- (void)didReceivedResponse:(WSResponse*) response;

@optional
- (void)didReceived:(float) percent;

@end
