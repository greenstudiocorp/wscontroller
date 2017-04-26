//
//  CDFilm.h
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDActor;

@interface CDFilm : NSManagedObject

@property (nonatomic, retain) NSString * filmDescription;
@property (nonatomic, retain) NSString * filmName;
@property (nonatomic, retain) NSString * filmId;
@property (nonatomic, retain) NSSet *actors;
@end

@interface CDFilm (CoreDataGeneratedAccessors)

- (void)addActorsObject:(CDActor *)value;
- (void)removeActorsObject:(CDActor *)value;
- (void)addActors:(NSSet *)values;
- (void)removeActors:(NSSet *)values;

@end
