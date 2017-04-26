# WSController

Webservice Controller uses JObjectMapper, AFNetworking 2.x 

# Features

1. Support RESTful (PUT POST GET DELETE) webservice with core data caching.
2. Object Mapping using dictionary with JObjectMapper library

# How to use WSController


```
	DataQueryController *dataQueryController;
    
  DefaultJSONParser *defaultJSONParser = [[DefaultJSONParser alloc] initDefaultJSONParserWithEntityClass:Film.class mapping:[Film mapping]];
  
  DataQueryBuilder *dataQueryBuilder = [DataQueryBuilder newBuilder];
  
  [dataQueryBuilder setWebserviceMethod:GET_FILM_DETAIL_METHOD];
  [dataQueryBuilder setGetParameter:@"param01=value01&param02=value02"];
  [dataQueryBuilder setPostParameter:@"post_param01=post_value01&post_param02=post_value02"];
  [dataQueryBuilder setJsonParser:defaultJSONParser];
  [dataQueryBuilder setCacheLoader:[[FilmLoader alloc] initWithFilmId:filmId]];
  [dataQueryBuilder setDataCaching:[[FilmCaching alloc] init]];
  [dataQueryBuilder setWsControllerDelegate:delegate];
  
  return dataQueryController = [dataQueryBuilder buildDataQuery];
  
```