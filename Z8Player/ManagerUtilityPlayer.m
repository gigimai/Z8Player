//
//  ManagerUtilityPlayer.m
//  Z8Player
//
//  Created by admin on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ManagerUtilityPlayer.h"

@implementation ManagerUtilityPlayer
-(void)playWithURL:(NSString *)urlLink{
    
}
-(void)pause{
    
}
-(void)stop{
    
}
-(void)resume{
    
}
-(void)seekToPos:(size_t)position  seekTime:(CMTime)seckTime{
    
}

-(void) saveFavoriteList:(NSArray*)listOfLiveChanel listOfFilm:(NSArray*)listOfFilm{

    NSUserDefaults *defaultData =[NSUserDefaults standardUserDefaults];
    [defaultData setObject:listOfLiveChanel forKey:kCHANEL];
    [defaultData setObject:listOfFilm forKey:kFILM];
}
-(NSDictionary *)getFavoriteList{
    NSUserDefaults *defaultData = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *favoriteList = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [defaultData objectForKey:kCHANEL], kCHANEL,
                                         [defaultData objectForKey:kFILM], kFILM, nil];
    return favoriteList;
}
-(void)loadingPlayer:(UIView *)objectView viewController:(UIViewController *)viewController urlLink:(NSString*) urlLink{
    
}

-(CMTime) getCurrentTime{
    return CMTimeMake(0,0);
}
- (AVPlayerItem*) getAVPlayerItem{
    return nil;
}
-(AVPlayer*) getAVPlayer{
    return nil;
}
@end
