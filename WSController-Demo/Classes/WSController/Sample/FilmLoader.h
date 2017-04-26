//
//  FilmLoader.h
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import "CoreDataCacheLoader.h"

@interface FilmLoader : CoreDataCacheLoader

@property (nonatomic, strong) NSString *filmId;

#pragma mark - FilmLoader life-cycle methods

- (id)initWithFilmId:(NSString*) filmId;

@end
