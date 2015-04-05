//
//  ChannelModel.h
//  Z8Player
//
//  Created by Do Nhat Khanh on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "MediaModel.h"

@interface ChannelModel : MediaModel<NSCoding>
@property (assign, nonatomic) int channelID;
@property (strong, nonatomic) NSString *channelCountry;
@property (assign, nonatomic) BOOL isFavorite;
- (id)initWithName:(NSString *)name andMediaURL:(NSString *)mediaURL andThumnailImage:(NSString *)thumnailImage;
+ (void)saveChannel:(ChannelModel *)aChannel;
+ (ChannelModel *)getChannel;
@end
