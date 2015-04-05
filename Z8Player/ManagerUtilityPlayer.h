//
//  ManagerUtilityPlayer.h
//  Z8Player
// Using third party
//  Created by admin on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <FFEngine/FFEngine.h>




@interface ManagerUtilityPlayer : NSObject
-(void) playWithURL:(NSString*) urlLink;
-(void) stop;
-(void) pause;
-(void) resume;
-(void)seekToPos:(size_t)position  seekTime:(CMTime)seckTime;
-(void) saveFavoriteList:(NSArray*)listOfLiveChanel listOfFilm:(NSArray*)listOfFilm;
-(NSDictionary*) getFavoriteList;
-(void)loadingPlayer:(UIView *)objectView viewController:(UIViewController *)viewController urlLink:(NSString*) urlLinkr;
-(CMTime) getCurrentTime ;
- (AVPlayerItem*) getAVPlayerItem;
-(AVPlayer*) getAVPlayer;
@end
