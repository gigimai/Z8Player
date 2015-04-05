//
//  MediaModel.m
//  Z8Player
//
//  Created by Do Nhat Khanh on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "MediaModel.h"

@implementation MediaModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.mediaThumbnailImage forKey:@"mediaThumbnailImage"];
    [aCoder encodeObject:self.mediaName forKey:@"mediaName"];
    [aCoder encodeObject:self.mediaCategory forKey:@"mediaCategory"];
    [aCoder encodeObject:self.mediaURL forKey:@"mediaURL"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *mediaThumbnailImage = [aDecoder decodeObjectForKey:@""];
    NSString *mediaName = [aDecoder decodeObjectForKey:@"mediaName"];
    NSString *mediaCategory = [aDecoder decodeObjectForKey:@"mediaCategory"];
    NSString *mediaURL = [aDecoder decodeObjectForKey:@"mediaURL"];
    
    self.mediaThumbnailImage = mediaThumbnailImage;
    self.mediaName = mediaName;
    self.mediaCategory = mediaCategory;
    self.mediaURL = mediaURL;
    
    return self;
}

@end
