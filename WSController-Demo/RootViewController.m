//
//  RootViewController.m
//  WSController-Demo
//
//  Created by Huy Le Duc on 7/29/13.
//  Copyright (c) 2013 Huy Le Duc. All rights reserved.
//

#import "RootViewController.h"
#import "DataQueryBuilder+GetFilmDetailsQueryBuilder.h"
#import "CoreDataManager.h"
#import "CDFilm.h"

@interface RootViewController ()

@property (nonatomic, strong) NSOperationQueue *dataQueryController;

@end

@implementation RootViewController

@synthesize dataQueryController = _dataQueryController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataQueryController = [DataQueryBuilder getFilmDetailsWithId:@"123"
                                                             delegate:self];
}

- (void)didReceiveMemoryWarning{
    
}

- (void)didReceivedResponse:(WSResponse*) response {
    NSLog(@"Response: %@", response);
}

@end
