//
//  DataQueryBuilder+GetFilmDetailsQueryBuilder.m
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/30/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import "DataQueryBuilder+GetFilmDetailsQueryBuilder.h"
#import "DataQueryBuilder.h"
#import "DataQueryController.h"
#import "FilmCaching.h"
#import "FilmLoader.h"
#import "DefaultJSONParser.h"
#import "Film.h"

@implementation DataQueryBuilder (GetFilmDetailsQueryBuilder)

+ (NSOperationQueue*) getFilmDetailsWithId:(NSString*) filmId
                                     delegate:(id<WSControllerDelegate>) delegate{
    
    DataQueryController *dataQueryController;
    
    DefaultJSONParser *defaultJSONParser = [[DefaultJSONParser alloc] initDefaultJSONParserWithEntityClass:Film.class mapping:[Film mapping]];
    
    DataQueryBuilder *dataQueryBuilder = [DataQueryBuilder newBuilder];
    
    [dataQueryBuilder setWebserviceMethod:GET_FILM_DETAIL_METHOD];
    //[dataQueryBuilder setGetParameter:@"param01=value01&param02=value02"];
    //[dataQueryBuilder setPostParameter:@"post_param01=post_value01&post_param02=post_value02"];
    [dataQueryBuilder setJsonParser:defaultJSONParser];
    [dataQueryBuilder setCacheLoader:[[FilmLoader alloc] initWithFilmId:filmId]];
    [dataQueryBuilder setDataCaching:[[FilmCaching alloc] init]];
    [dataQueryBuilder setWsControllerDelegate:delegate];
    
    return dataQueryController = [dataQueryBuilder buildDataQuery];
}

+ (DataQueryController*) getFilmDetailsFromLocalDBWithId:(NSString*) filmId
                                                delegate:(id<WSControllerDelegate>) delegate{
    
    DataQueryController *dataQueryController;
    
    DataQueryBuilder *dataQueryBuilder = [DataQueryBuilder newBuilder];
    
    [dataQueryBuilder setWsControllerDelegate:delegate];
    [dataQueryBuilder setCacheLoader:[[FilmLoader alloc] initWithFilmId:filmId]];
    
    return dataQueryController = [dataQueryBuilder buildDataQuery];
}

@end
