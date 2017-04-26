//
//  CoreDataManger.m
//  CoreDataManager
//
//  Created by Huy Le Duc on 13/03/12.
//  Copyright (c) 2012 Huy Le Duc. All rights reserved.
//

#import "CoreDataManager.h"

static CoreDataManager *coreDataManager;

@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

        NSLog(@"Save successfully");
    }
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:MODEL_NAME
                                              withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [CoreDataManager persistentStoreURL];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

#pragma mark - Util methods

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)persistentStoreURL {
    NSString *databaseFileName = [NSString stringWithFormat:
            @"%@.%@",
            DATABASE_NAME,
            DATABASE_EXTENSION];
    NSURL *databaseFilePath = [CoreDataManager.applicationDocumentsDirectory URLByAppendingPathComponent:databaseFileName];
    return databaseFilePath;
}

#pragma mark - Business methods

- (NSManagedObject *)newManagedObjectWithEntityClass:(Class)entityClass {
    NSString *strEntity = NSStringFromClass(entityClass);
    return [NSEntityDescription insertNewObjectForEntityForName:strEntity
                                         inManagedObjectContext:self.managedObjectContext];
}

- (NSArray *)getEntities:(Class)entityClass
           withPredicate:(NSPredicate *)predicate
         sortDescription:(NSArray *)sortDescArr {

    NSString *strEntity = NSStringFromClass(entityClass);
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity
                                              inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }

    if (sortDescArr) {
        [fetchRequest setSortDescriptors:sortDescArr];
    }

    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];

    return results;
}

- (NSArray *)getAllEntities:(Class)entityClass {

    return [self getEntities:entityClass withPredicate:nil sortDescription:nil];
}

+ (CoreDataManager *)sharedCoreDataManger {

    if (!coreDataManager) {
        coreDataManager = [[CoreDataManager alloc] init];
    }

    return coreDataManager;
}

+ (void)unshareCoreDataManger {
    coreDataManager = nil;
}

+ (NSManagedObjectContext *)sharedManagedObjectContext {

    if (!coreDataManager) {
        coreDataManager = [[CoreDataManager alloc] init];
    }

    return coreDataManager.managedObjectContext;
}

@end
