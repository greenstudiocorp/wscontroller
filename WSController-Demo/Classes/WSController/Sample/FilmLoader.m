//
//  FilmLoader.m
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import "FilmLoader.h"
#import "CDFilm.h"
#import "CoreDataManager.h"
#import "Film.h"

@implementation FilmLoader

@synthesize filmId  = _filmId;

- (id)initWithFilmId:(NSString*) filmId {
    self = [super init];
    if (self) {
        self.filmId = filmId;
    }
    return self;
}

- (void)performLoadCache{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filmId=%@", self.filmId];
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:@"filmId" ascending:YES];
    NSArray *cdFilmArray = [[CoreDataManager sharedCoreDataManger] getEntities:[CDFilm class]
                                                                 withPredicate:predicate
                                                               sortDescription:[[NSArray alloc] initWithObjects:sortDescription, nil]];
    if (cdFilmArray && cdFilmArray.count > 0) {
        Film *film = [Film filmFormCDFilm:[cdFilmArray objectAtIndex:0]];
        self.data = film;
    }
}

@end
