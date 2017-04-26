//
//  Film.m
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import "Film.h"
#import "CDFilm.h"

@implementation Film

@synthesize filmName            =   _filmName;
@synthesize filmDescription     =   _filmDescription;
@synthesize actor               =   _actor;

+ (Film*)filmFormCDFilm:(CDFilm*) cdFilm{
    if (!cdFilm) {
        return nil;
    }
    Film *film = [[Film alloc] init];
    film.filmId = cdFilm.filmId;
    film.filmName = cdFilm.filmName;
    film.filmDescription = cdFilm.filmDescription;
    return film;
}

+ (NSDictionary*)mapping{
    NSDictionary *mapping = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"filmId", @"film_id",
                             @"filmName", @"film_name",
                             @"filmDescription", @"description",
                             nil];
    return mapping;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"{\"%@\",\"%@\",\"%@\"}", self.filmId, self.filmName, self.filmDescription];
}

@end
