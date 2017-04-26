//
//  FilmCaching.m
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import "FilmCaching.h"
#import "CoreDataManager.h"
#import "CDActor.h"
#import "CDFilm.h"
#import "Film.h"
#import "Actor.h"

@implementation FilmCaching

- (void)performDataCaching{
    Film *filmData = (Film*)self.data;
    CDFilm *cdFilm = (CDFilm*)[[CoreDataManager sharedCoreDataManger] newManagedObjectWithEntityClass:[CDFilm class]];
    cdFilm.filmName = filmData.filmName;
    cdFilm.filmDescription = filmData.filmDescription;
    
    [[CoreDataManager sharedCoreDataManger] saveContext];
}

@end
