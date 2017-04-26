//
//  CoreDataManger.h
//
//  Created by Huy Le Duc on 12/15/12.
//  Copyright (c) 2012 Huy Le Duc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define MODEL_NAME          @"Model"
#define DATABASE_NAME       @"Demo_DB"
#define DATABASE_EXTENSION  @"db"

@interface CoreDataManager : NSObject

@property(readonly, strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property(readonly, strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property(readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

#pragma mark - Util methods

+ (NSURL *)persistentStoreURL;

+ (NSURL *)applicationDocumentsDirectory;

#pragma Business methods

- (NSManagedObject *)newManagedObjectWithEntityClass:(Class)entityClass;

- (NSArray *)getEntities:(Class)entityClass
           withPredicate:(NSPredicate *)predicate
         sortDescription:(NSArray *)sortDescArr;

- (NSArray *)getAllEntities:(Class)entityClass;

+ (CoreDataManager *)sharedCoreDataManger;

+ (void)unshareCoreDataManger;

+ (NSManagedObjectContext *)sharedManagedObjectContext;

@end
