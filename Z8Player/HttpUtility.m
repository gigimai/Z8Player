//
//  HttpUtility.m
//  Z8Player
//
//  Created by admin on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "HttpUtility.h"

@implementation HttpUtility
-(void)playWithURL:(NSString *)urlLink{
    NSLog(@"Playing");
    [self.playerVideo play];
}
-(void)pause{
    NSLog(@"Pause");
    [self.playerVideo pause];
}
-(void)stop{
    NSLog(@"Stop");
    [self.playerVideo pause];
    [self.playerVideo seekToTime:CMTimeMake(0.01f, 1)];
}
-(void)loadingPlayer:(UIView *)objectView viewController:(UIViewController *)viewController urlLink:(NSString*) urlLink{
    NSURL *url = [NSURL URLWithString:urlLink];
    self.asset = [AVAsset assetWithURL:url];
    self.playerItem = [ [AVPlayerItem alloc] initWithAsset:self.asset];
    self.playerVideo = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.playerVideo];
    [self.playerLayer setFrame:objectView.bounds];
    [objectView.layer addSublayer:self.playerLayer];
    
}
-(void)seekToPos:(size_t)position  seekTime:(CMTime)seckTime{
    [self.playerVideo seekToTime:seckTime];
    
}

-(CMTime) getCurrentTime{
    return [self.playerVideo currentTime];
}
-(void)resume{
    NSLog(@"resume");
    [self.playerVideo play];
}
- (AVPlayerItem*) getAVPlayerItem{
    return self.playerItem;
}
-(AVPlayer*) getAVPlayer{
    return self.playerVideo;
}
@end
