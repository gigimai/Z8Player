//
//  HttpUtility.h
//  Z8Player
//
//  Created by admin on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ManagerUtilityPlayer.h"

@interface HttpUtility : ManagerUtilityPlayer
@property (strong,nonatomic) AVPlayer *playerVideo;
@property (strong,nonatomic) AVPlayerLayer * playerLayer;
@property (strong,nonatomic) AVAsset *asset;
@property (strong,nonatomic) AVPlayerItem *playerItem;
//-(void) playWithURL:(NSString*) urlLink;
//-(void) stop;
//-(void) pause;
//-(void)loadingPlayer:(UIView *)objectView viewController:(UIViewController *)viewController urlLink:(NSString*) urlLink;
//-(void)seekToPos:(size_t)position  seekTime:(CMTime)seckTime;
//- (AVPlayerItem*) getAVPlayerItem;
//-(CMTime) getCurrentTime;
@end
