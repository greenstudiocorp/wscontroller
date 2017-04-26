# WSController

Webservice Controller uses JObjectMapper, AFNetworking 2.x 

# Features

1. Support RESTful (PUT POST GET DELETE) webservice with core data caching.
2. Support object mapping using NSDictionary through JObjectMapper library.
3. Support caching with core data & auto loader.

# How to use WSController

## Step 01: Define Entity Class

```objective-c
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
```

## Step 2: Create DataQueryController

```objective-c
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

dataQueryController = [dataQueryBuilder buildDataQuery];
```

## Step 03: Define a Call-back delegate:

```objective-c
@implementation RootViewController

@synthesize dataQueryController = _dataQueryController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataQueryController = [DataQueryBuilder getFilmDetailsWithId:@"123"
                                                             delegate:self];
}

- (void)didReceivedResponse:(WSResponse*) response {
    NSLog(@"Response: %@", response);
}

@end
```

## Console log output:

```
WSController-Demo[3572:186560] Start data caching
WSController-Demo[3572:186560] Start cache loading
WSController-Demo[3572:186577] Start webservice
WSController-Demo[3572:186583] Save successfully
WSController-Demo[3572:186484] Response: Cache loaded: {"123","(Cached data) Film name 01","(Cached data) Description 01"}
WSController-Demo[3572:186484] Response: Fresh data loaded: {"1","Film name 1","Description 1"}
```

