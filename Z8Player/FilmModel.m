//
//  FilmModel.m
//  Z8Player
//
//  Created by Do Nhat Khanh on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "FilmModel.h"

@implementation FilmModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.filmID forKey:@"filmID"];
    [aCoder encodeObject:self.mediaThumbnailImage forKey:@"mediaThumbnailImage"];
    [aCoder encodeObject:self.mediaName forKey:@"mediaName"];
    [aCoder encodeObject:self.mediaCategory forKey:@"mediaCategory"];
    [aCoder encodeObject:self.mediaURL forKey:@"mediaURL"];
    [aCoder encodeObject:self.filmDescription forKey:@"filmDescription"];
    [aCoder encodeObject:self.filmDirector forKey:@"filmDirector"];
    [aCoder encodeObject:self.filmActors forKey:@"filmActors"];
    [aCoder encodeBool:self.isFavorite forKey:@"isFavorite"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        int filmID = [aDecoder decodeIntForKey:@"filmID"];
        NSString *mediaThumbnailImage = [aDecoder decodeObjectForKey:@"mediaThumbnailImage"];
        NSString *mediaName = [aDecoder decodeObjectForKey:@"mediaName"];
        NSString *mediaCategory = [aDecoder decodeObjectForKey:@"mediaCategory"];
        NSString *mediaURL = [aDecoder decodeObjectForKey:@"mediaURL"];
        NSString *filmDescription = [aDecoder decodeObjectForKey:@"filmDescription"];
        NSString *filmDirector = [aDecoder decodeObjectForKey:@"filmDirector"];
        NSString *filmActors = [aDecoder decodeObjectForKey:@"filmActors"];
        BOOL isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
        
        self.filmID = filmID;
        self.mediaThumbnailImage = mediaThumbnailImage;
        self.mediaName = mediaName;
        self.mediaCategory = mediaCategory;
        self.mediaURL = mediaURL;
        self.filmDescription = filmDescription;
        self.filmDirector = filmDirector;
        self.filmActors = filmActors;
        self.isFavorite = isFavorite;
    }
    return self;
}

+ (NSString *)getPathToArchive
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,
                                                         NSUserDomainMask, YES);
    NSString *docSir = paths[0];
    return [docSir stringByAppendingPathComponent:@"film.model"];
}

+ (void)saveChannel:(FilmModel *)aFilm
{
    [NSKeyedArchiver archiveRootObject:aFilm toFile:[FilmModel getPathToArchive]];
}

+ (FilmModel *)getFilm
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[FilmModel getPathToArchive]];
}

@end