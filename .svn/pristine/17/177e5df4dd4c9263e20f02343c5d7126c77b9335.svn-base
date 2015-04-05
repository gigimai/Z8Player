//
//  ChannelModel.m
//  Z8Player
//
//  Created by Do Nhat Khanh on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel
- (id)initWithName:(NSString *)name andMediaURL:(NSString *)mediaURL andThumnailImage:(NSString *)thumnailImage
{
    if (self = [super init]) {
        self.mediaName = name;
        self.mediaURL = mediaURL;
        self.mediaThumbnailImage = thumnailImage;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.channelID forKey:@"channelID"];
    [aCoder encodeObject:self.mediaThumbnailImage forKey:@"mediaThumbnailImage"];
    [aCoder encodeObject:self.mediaName forKey:@"mediaName"];
    [aCoder encodeObject:self.mediaCategory forKey:@"mediaCategory"];
    [aCoder encodeObject:self.mediaURL forKey:@"mediaURL"];
    [aCoder encodeObject:self.channelCountry forKey:@"channelCountry"];
    [aCoder encodeBool:self.isFavorite forKey:@"isFavorite"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        int channelID = [aDecoder decodeIntForKey:@"channelID"];
        NSString *mediaThumbnailImage = [aDecoder decodeObjectForKey:@"mediaThumbnailImage"];
        NSString *mediaName = [aDecoder decodeObjectForKey:@"mediaName"];
        NSString *mediaCategory = [aDecoder decodeObjectForKey:@"mediaCategory"];
        NSString *mediaURL = [aDecoder decodeObjectForKey:@"mediaURL"];
        NSString *channelCountry = [aDecoder decodeObjectForKey:@"channelCountry"];
        BOOL isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
        
        self.channelID = channelID;
        self.mediaThumbnailImage = mediaThumbnailImage;
        self.mediaName = mediaName;
        self.mediaCategory = mediaCategory;
        self.mediaURL = mediaURL;
        self.channelCountry = channelCountry;
        self.isFavorite = isFavorite;
    }
    return self;
}

+ (NSString *)getPathToArchive
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,
                                                         NSUserDomainMask, YES);
    NSString *docSir = paths[0];
    return [docSir stringByAppendingPathComponent:@"channel.model"];
}

+ (void)saveChannel:(ChannelModel *)aChannel
{
    [NSKeyedArchiver archiveRootObject:aChannel toFile:[ChannelModel getPathToArchive]];
}

+ (ChannelModel *)getChannel
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[ChannelModel getPathToArchive]];
    
}
@end
