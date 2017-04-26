//
//  DataQueryBuilder+GetFilmDetailsQueryBuilder.h
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import "DataQueryBuilder.h"

@interface DataQueryBuilder (GetFilmDetailsQueryBuilder)

+ (NSOperationQueue*) getFilmDetailsWithId:(NSString*) filmId
                                  delegate:(id<WSControllerDelegate>) delegate;
+ (NSOperationQueue*) getFilmDetailsFromLocalDBWithId:(NSString*) filmId
                                             delegate:(id<WSControllerDelegate>) delegate;

@end
