//
//  ORGDetailViewController.h
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/8/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer.h"
@interface ZPDetailViewController : UIViewController<ELPlayerMessageProtocol,IELMediaPlayer>


@property (strong, nonatomic) MediaPlayer *mediaplayer;
@end
