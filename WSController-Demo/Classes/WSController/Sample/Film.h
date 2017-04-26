//
//  Film.h
//  AFNetworking iOS Example
//
//  Created by Huy Le Duc on 7/27/13.
//  Copyright (c) 2013 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"
#import "BaseEntity.h"

@class CDFilm;

@interface Film : BaseEntity

@property (nonatomic, strong) NSString  *filmId;
@property (nonatomic, strong) NSString  *filmName;
@property (nonatomic, strong) NSString  *filmDescription;
@property (nonatomic, strong) Actor     *actor;

+ (Film*)filmFormCDFilm:(CDFilm*) cdFilm;

@end
