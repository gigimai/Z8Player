//
//  FilmModel.h
//  Z8Player
//
//  Created by Do Nhat Khanh on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "MediaModel.h"

@interface FilmModel : MediaModel <NSCoding>
@property (assign, nonatomic) int filmID;
@property (strong, nonatomic) NSString *filmDescription;
@property (strong, nonatomic) NSString *filmDirector;
@property (strong, nonatomic) NSString *filmActors;
@property (assign, nonatomic) BOOL isFavorite;
+ (void)saveChannel:(FilmModel *)aFilm;
+ (FilmModel *)getFilm;
@end
