//
//  RtmpUtility.m
//  Z8Player
//
//  Created by admin on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "RtmpUtility.h"

@implementation RtmpUtility
-(void) playWithURL:(NSString *)urlLink{
    if ([self.rtmpPlayer openMedia:urlLink]){
        NSLog(@"play this link successful");
    }
    else{
        NSLog(@"not loading");
    }
}

-(void) stop{
    [self.rtmpPlayer setDelegate:nil];
    [self.rtmpPlayer stopPlay];
}

-(void) pause{
    [self.rtmpPlayer pausePlay];
}

-(void)loadingPlayer:(UIView *)objectView viewController:(UIViewController<ELPlayerMessageProtocol,IELMediaPlayer> *)viewController urlLink:(NSString*) urlLink{
    self.rtmpPlayer = loadELMediaPlayer();
     [self.rtmpPlayer setDelegate:viewController];
    [self.rtmpPlayer setVideoContainerView:objectView];
    [self.rtmpPlayer setAutoPlayAfterOpen:YES];
    [self.rtmpPlayer setPlayerScreenType:ELScreenType_ASPECT_FULL_SCR];
}
-(void)resume{
    NSLog(@"resume");
    [self.rtmpPlayer resumePlay];
}


-(void)seekToPos:(size_t)position  seekTime:(CMTime)seckTime{
    [self.rtmpPlayer seekTo:position];
}

-(CMTime)getDurationTime{
    return CMTimeMake(0.01f, 1);
}
@end
