//
//  CDActor.h
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDActor : NSManagedObject

@property (nonatomic, retain) NSString * actorDescription;
@property (nonatomic, retain) NSString * actorName;

@end
