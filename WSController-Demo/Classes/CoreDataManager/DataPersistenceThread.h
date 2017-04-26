//
//  DataPersistenceThread.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/28/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPersistenceThread : NSObject

+ (void)dataPersistenceThreadEntryPoint:(id __unused)object;
+ (NSThread *)dataPersistenceThread;

@end
