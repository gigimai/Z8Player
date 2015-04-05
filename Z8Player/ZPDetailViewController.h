//
//  ZPDetailViewController.h
//  Z8Player
//
//  Created by HieuSE on 8/15/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "BaseViewController.h"
#import "UIColor+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIFont+FlatUI.h"
#import "MediaPlayer.h"
#import "ChannelModel.h"
#import "FilmModel.h"

@interface ZPDetailViewController : UIViewController<ELPlayerMessageProtocol,IELMediaPlayer,UIScrollViewDelegate>

@property (strong, nonatomic) MediaPlayer *mediaplayer;
@property (nonatomic, strong) NSString *urlLink;
@property (nonatomic,strong) NSString *movieTitle;
@property (nonatomic, strong) NSMutableArray *linkArray;
@property (nonatomic, strong) NSDictionary *mediaDict;

@property (nonatomic, strong) NSMutableArray *filmsArr;
- (IBAction)pressInfoButton:(id)sender;
@property (nonatomic, strong) FilmModel *film;

- (IBAction)tapSeekPrevious:(id)sender;
@property (nonatomic, strong) NSMutableArray *channelsArr;
@property (nonatomic, strong) ChannelModel *channel;

@property (nonatomic, strong) NSMutableArray *favChannelArr;
@property (nonatomic, strong) NSMutableArray *favFilmArr;

@property (assign, nonatomic) BOOL isPlayMovie;

@property (strong, nonatomic) NSString *statusFav;

@property (strong, nonatomic) UISwipeGestureRecognizer *toNext;
@property (strong, nonatomic) UISwipeGestureRecognizer *toPrevious;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withURLString:(NSString *)linkStr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChannel:(ChannelModel *)channel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFilm:(FilmModel *)film;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLinkArrs:(NSMutableArray *)linkArr andLink:(NSString *)linkURL;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChannelDictionaryArrs:(NSMutableArray *)channelDictsArr andDictionary:(NSDictionary *)channelDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFilmArrs:(NSMutableArray *)filmArr andFilm:(FilmModel *)filmModel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChannelArrs:(NSMutableArray *)channelArr andChannel:(ChannelModel *)channelModel;


- (IBAction)didChangeSegment:(id)sender;
- (IBAction)adjustVolume:(id)sender;

- (IBAction)didPreviousPress:(id)sender;
- (IBAction)didNextPress:(id)sender;
- (IBAction)touchUpInside:(id)sender;

@end
