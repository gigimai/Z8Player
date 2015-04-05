//
//  ZPDetailViewController.m
//  Z8Player
//
//  Created by HieuSE on 8/15/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ZPDetailViewController.h"
#import "UISlider+FlatUI.h"
#import "FUIAlertView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LibraryAPI.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+FlatUI.h"

// Media states
typedef enum tagMEDIA_STATE{
    REACHED_END,
    PAUSED,
    STOPPED,
    PLAYING,
    READY,
    PLAYING_FULLSCREEN,
    NOT_READY,
    ERROR
} MEDIA_STATE;

@interface ZPDetailViewController ()<UIActionSheetDelegate, MBProgressHUDDelegate, UIAlertViewDelegate,UIActionSheetDelegate>{
    BOOL isPlaying;
    NSTimer* sliderTimer;
    NSInteger linkType ;
    MBProgressHUD *hud;
    UIView *descriptionView;
    MEDIA_STATE media_state;
    MEDIA_STATE old_media_state;
}
@property (strong, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIScrollView *infoView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UISlider *volumeSlider;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (strong, nonatomic) IBOutlet UIView *playerControlView;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UISlider *playSlider;
@property (nonatomic) size_t videoDuration;
@property (nonatomic) NSTimer * loadingTimer;
@property (nonatomic ) NSInteger counter;
@property (strong, nonatomic) IBOutlet UIButton *btnPrevious;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet UIImageView *muteButton;
@property (weak, nonatomic) IBOutlet UIButton *btnSeekPrevious;
@end

@implementation ZPDetailViewController
@synthesize urlLink;
@synthesize linkArray;
@synthesize btnNext;
@synthesize btnPrevious;
@synthesize mediaDict;
@synthesize filmsArr;
@synthesize film;
@synthesize channelsArr;
@synthesize channel;
@synthesize isPlayMovie;
@synthesize favChannelArr;
@synthesize favFilmArr;
@synthesize statusFav;
@synthesize toPrevious;
@synthesize toNext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withURLString:(NSString *)linkStr
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        urlLink = [NSString stringWithFormat:@"%@",linkStr];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChannel:(ChannelModel *)channel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        urlLink = channel.mediaURL;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFilm:(FilmModel *)film
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        urlLink = film.mediaURL;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLinkArrs:(NSMutableArray *)linkArr andLink:(NSString *)linkURL
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.linkArray = linkArr;
        urlLink = [NSString stringWithFormat:@"%@",linkURL];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChannelDictionaryArrs:(NSMutableArray *)channelDictsArr andDictionary:(NSDictionary *)channelDict
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.linkArray = channelDictsArr;
        self.mediaDict = channelDict;
        urlLink = [NSString stringWithFormat:@"%@",[channelDict objectForKey:@"MediaLink"]];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFilmArrs:(NSMutableArray *)filmArr andFilm:(FilmModel *)filmModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isPlayMovie = YES;
        self.filmsArr = filmArr;
        self.film = filmModel;
        urlLink = [NSString stringWithFormat:@"%@",self.film.mediaURL];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChannelArrs:(NSMutableArray *)channelArr andChannel:(ChannelModel *)channelModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isPlayMovie = NO;
        if (!self.channelsArr) {
            self.channelsArr = [[NSMutableArray alloc]init];
        }
        self.channelsArr = channelArr;
        self.channel = channelModel;
        urlLink = [NSString stringWithFormat:@"%@",self.channel.mediaURL];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //urlLink =@"http://videohcm114.fptplay.net.vn/mp4//OTT/Ca_Nhac/Nhac_Viet_Nam/NhacVietNam_Da_Quen_That_Sao_Liveshow_New_Hits_Ngoc_Tram.mp4";
    //urlLink = @"rtmp://cp79650.live.edgefcs.net/live/QVCLive1@14308";
   // urlLink = @"http://85.132.44.99:1935/turktv/startv.sdp/embedstv39.m3u8";
   // urlLink =@"http://10.88.106.248/film/Brave.mp4";

    // Do any additional setup after loading the view from its nib.
    if (!urlLink) {
        urlLink = @"http://videohcm114.fptplay.net.vn/mp4//OTT/Ca_Nhac/Nhac_Viet_Nam/NhacVietNam_Da_Quen_That_Sao_Liveshow_New_Hits_Ngoc_Tram.mp4";
    }
    
    [self setupView];
    [self.playButton setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
    self.playButton.hidden = YES;
    isPlaying = YES;
    media_state = NOT_READY;
    // Add gesture
    toNext = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didNextPress:)];
    [toNext setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.playerView addGestureRecognizer:toNext];
    
    toPrevious  = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didPreviousPress:)];
    [toPrevious setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.playerView addGestureRecognizer:toPrevious];
    
    [self checkBtnEnable];
    
    favFilmArr = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteFilm];
    if (!favFilmArr) {
        favFilmArr = [[NSMutableArray alloc]init];
    }
    
    favChannelArr = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteChannel];
    if (!favChannelArr) {
        favChannelArr = [[NSMutableArray alloc]init];
    }
    
    [self checkFavourite];

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        //self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveEventResign) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveEventActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)receiveEventResign
{
   // [self resumeStateOfFilm:old_media_state];
    old_media_state = media_state;
    if ( PLAYING == media_state)
    {
        media_state = PAUSED;
        [self.mediaplayer.managerUtility pause];
        self.playButton.hidden = NO;
        isPlaying = NO;
        [self.playButton setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
        [self.playerView bringSubviewToFront:self.playButton];
    }
}
-(void) receiveEventActive{
    [self resumeStateOfFilm:old_media_state];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //urlLink =@"http://videohcm114.fptplay.net.vn/mp4//OTT/Ca_Nhac/Nhac_Viet_Nam/NhacVietNam_Da_Quen_That_Sao_Liveshow_New_Hits_Ngoc_Tram.mp4";
    [self preparePlaying:urlLink];
    [self createAndDisplayMPVolumeView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self resetForPlaying];
}


-(void) updateTimer{
    if ( self.counter < 30)
    {
        self.counter ++;
        if ((linkType == kHTTP_LINK) &&
            (([urlLink rangeOfString:@"m3u8"].location != NSNotFound))){
            
            AVPlayerItem * playerItemHttp = self.mediaplayer.managerUtility.getAVPlayerItem;
           
            if (playerItemHttp.status == AVPlayerItemStatusReadyToPlay){
                [hud removeFromSuperview];
                [self.loadingTimer invalidate];
            }

        }

    }
    else{

//        [self.loadingTimer invalidate];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Link or connection error" message:@"Link or connection corrupted. Please check the connection or try other link" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        [self.loadingTimer invalidate];
        [self resetForPlaying];
    }
    
   
}

-(void)setupView
{

    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showAction)];
    [self.navigationItem setRightBarButtonItem:actionButton];
    [self.playerControlView setBackgroundColor:[UIColor lightTextColor]];
    [_infoView setBackgroundColor:[UIColor lightTextColor]];
    
    
    if (isPlayMovie) {
        _movieTitle = self.film.mediaName;
    } else{
        _movieTitle = self.channel.mediaName;
    }
    
    [_titleLabel setText:_movieTitle];
    [_titleLabel setFont:[UIFont boldFlatFontOfSize:18]];
    [_titleLabel setTextColor:[UIColor turquoiseColor]];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
    [backBarButton configureFlatButtonWithColor:[UIColor emerlandColor] highlightedColor:[UIColor greenSeaColor] cornerRadius:3];
    [self.navigationItem setBackBarButtonItem:backBarButton];
    [_playSlider configureFlatSliderWithTrackColor:[UIColor silverColor] progressColor:[UIColor turquoiseColor] thumbColor:[UIColor greenSeaColor]];
    [_playSlider setThumbImage:[[UIImage imageWithColor:[UIColor greenSeaColor] cornerRadius:0.f] imageWithMinimumSize:CGSizeMake(2.f, 15.f)]forState:UIControlStateNormal];
     [_playSlider setThumbImage:[[UIImage imageWithColor:[UIColor emerlandColor] cornerRadius:0.f] imageWithMinimumSize:CGSizeMake(2.f, 15.f)]forState:UIControlStateHighlighted];
  //  [_playSlider setThumbImage:[UIImage new] forState:UIControlStateNormal];
  
}

-(void)showAction
{

  
    //UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share to facebook",@"Share to Twitter",@"Add to favourite",nil];
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share to facebook",@"Share to Twitter",statusFav,nil];
    [actionSheet showInView:self.view];
    
    old_media_state = media_state;
    if ( PLAYING == media_state)
    {
        media_state = PAUSED;
        [self.mediaplayer.managerUtility pause];
        self.playButton.hidden = NO;
        isPlaying = NO;
        [self.playButton setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
        [self.playerView bringSubviewToFront:self.playButton];
    }
}

-(void)dismissCurrentView
{
    [self.mediaplayer.managerUtility stop];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"Exit");
    [self resetForPlaying];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)removeAllSubViewFrom:(UIView *)superView
{
    for (UIView *view in superView.subviews) {
        [view removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark Implementation Delegate of RTMP player

-(void)openOk{
    NSLog(@"Open ok");
    
    
}
-(void)openFailed{
    NSLog(@"Open failed");
}

-(void)readyToPlay{
    NSLog(@"ready to play");
    //[self.activityIndicator stopAnimating];
    [hud removeFromSuperview];
    [self.loadingTimer invalidate];
    [self.playButton setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
    isPlaying = YES;
    media_state = PLAYING;

}

-(void)bufferingStart{
    NSLog(@"buffering start");
//    [self.view bringSubviewToFront:self.activityIndicator];
//    [self.activityIndicator startAnimating];
    
}

-(void)mediaDuration:(size_t)duration{
    NSLog(@"Duration of film : %zd", duration);
    self.videoDuration = duration;
    
    [self.totalTimeLabel setText:[self timeFormatted:(int) (duration/1000)]];
}

- (void)mediaPosition:(size_t)position{
    if (self.videoDuration != 0 )
    {
    NSLog(@"position: %zd", position);
    Float32 percent_status = ((Float32)position/self.videoDuration);
    [self.timerLabel setText:[self timeFormatted:(int) (position/1000)]];
    NSLog(@"time: %f", percent_status);
    [self.playSlider setValue:percent_status];
    }
    else{
        [self.playSlider setValue:0.00f];
    }
}

- (IBAction)playOrPause:(id)sender {
    if (PLAYING == media_state) {
        [self.playButton setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
        isPlaying = NO;
        media_state = PAUSED;
        [self.mediaplayer.managerUtility pause];
        self.playButton.hidden = NO;
        [self.playerView bringSubviewToFront:self.playButton];
    }else if ( PAUSED == media_state){
        [self.playButton setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
        isPlaying = YES;
        [self.mediaplayer.managerUtility resume];
        self.playButton.hidden = YES;
        media_state = PLAYING;
    }
    else{
        //do nothing
    }

}

#pragma mark Implement Slider for HTTP

-(IBAction)sliding:(id)sender{
    
    [self.mediaplayer.managerUtility pause];
    media_state = PAUSED;
    CMTime newTime = CMTimeMakeWithSeconds(self.playSlider.value, 1);
    [self.mediaplayer.managerUtility seekToPos:0 seekTime:newTime];
    //[self.mediaplayer.managerUtility playWithURL:urlLink];
}

-(void)setSlider{
    
    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self  selector:@selector(updateSlider) userInfo:nil repeats:YES];
    self.playSlider.maximumValue = [self durationInSeconds];
    [self.playSlider addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventValueChanged];
    self.playSlider.minimumValue = 0.0;
    self.playSlider.continuous = YES;
}

- (void)updateSlider {
    
    self.playSlider.maximumValue = [self durationInSeconds];
    self.playSlider.value = [self currentTimeInSeconds];
    [self.timerLabel setText:[self timeFormatted:(int)([self currentTimeInSeconds])]];
}

- (Float64)durationInSeconds {
    AVPlayerItem * playerItemHttp = self.mediaplayer.managerUtility.getAVPlayerItem;
   static Float64 dur = 0.f;
//   static dispatch_once_t onePredicate;
    if (playerItemHttp.status == AVPlayerItemStatusReadyToPlay){
//        NSLog(@"ready for play");

//        dispatch_once(&onePredicate, ^{
            dur = CMTimeGetSeconds(playerItemHttp.duration);
//            NSLog(@"duratuon %0.2f", dur);
         [self.totalTimeLabel setText:[self timeFormatted:(int)(dur)]];
//        });
       
    }
    //NSLog(@"duratuon %0.2f", dur);
    if ( dur != 0 )
    {
        //[self.activityIndicator stopAnimating];
        [hud removeFromSuperview];
        [self.loadingTimer invalidate];
       
    }
    return dur;
}


- (Float64)currentTimeInSeconds {
    Float64 dur = CMTimeGetSeconds([self.mediaplayer.managerUtility getCurrentTime]);
    return dur;
}

- (IBAction)adjustVolume:(id)sender {
  
    
}

- (IBAction)didPreviousPress:(id)sender {
    [btnNext setEnabled:YES];
    toNext.enabled = YES;
    int index = 0;
    NSString *linkPrevious = @"";
    
    if (isPlayMovie) {
        index = [self.filmsArr indexOfObject:self.film];
        if (index >= 0) {
            if (index - 1 >= 0) {
                film = filmsArr[index - 1];
                linkPrevious = [NSString stringWithFormat:@"%@",film.mediaURL];
                _titleLabel.text = film.mediaName;
                urlLink = linkPrevious;
            } else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Full link" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else{
            linkPrevious = @"http://videohcm114.fptplay.net.vn/mp4//OTT/Ca_Nhac/Nhac_Viet_Nam/NhacVietNam_Da_Quen_That_Sao_Liveshow_New_Hits_Ngoc_Tram.mp4";
        }
    } else{
        index = [channelsArr indexOfObject:channel];
        if (index >= 0) {
            if (index - 1 >= 0) {
                channel = channelsArr[index -1];
                linkPrevious = [NSString stringWithFormat:@"%@",channel.mediaURL];
                _titleLabel.text = channel.mediaName;
                urlLink = linkPrevious;
            } else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Full link" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else{
            linkPrevious = @"http://videohcm114.fptplay.net.vn/mp4//OTT/Ca_Nhac/Nhac_Viet_Nam/NhacVietNam_Da_Quen_That_Sao_Liveshow_New_Hits_Ngoc_Tram.mp4";
        }
    }
    
    [self resetForPlaying];
    [self preparePlaying:linkPrevious];
    
     [self checkFavourite];
}

- (IBAction)didNextPress:(id)sender {
    [btnPrevious setEnabled:YES];
    toPrevious.enabled = YES;
    int index = 0;
    NSString *linkNext = @"";
    
    if (isPlayMovie) {
        index = [self.filmsArr indexOfObject:self.film];
        if (index >= 0) {
            if (index + 1 <= [filmsArr count] - 1) {
                film = filmsArr[index + 1];
                linkNext = [NSString stringWithFormat:@"%@",film.mediaURL];
                _titleLabel.text = film.mediaName;
                urlLink = linkNext;
            } else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Full link" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else{
            linkNext = @"http://videohcm114.fptplay.net.vn/mp4//OTT/Ca_Nhac/Nhac_Viet_Nam/NhacVietNam_Da_Quen_That_Sao_Liveshow_New_Hits_Ngoc_Tram.mp4";
        }
    } else{
        index = [channelsArr indexOfObject:channel];
        if (index >= 0) {
            if (index + 1 <= [self.channelsArr count] - 1) {
                channel = channelsArr[index + 1];
                linkNext = [NSString stringWithFormat:@"%@",channel.mediaURL];
                _titleLabel.text = channel.mediaName;
                urlLink = linkNext;
            } else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Full link" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else{
            linkNext = @"http://videohcm114.fptplay.net.vn/mp4//OTT/Ca_Nhac/Nhac_Viet_Nam/NhacVietNam_Da_Quen_That_Sao_Liveshow_New_Hits_Ngoc_Tram.mp4";
        }
    }
    
    [self resetForPlaying];
    [self preparePlaying:linkNext];
    
    [self checkFavourite];
}

- (IBAction)touchUpInside:(id)sender {
    [self.mediaplayer.managerUtility resume];
    media_state = PLAYING;
//    [self tapOnView:nil];
}

#pragma mark- UIAlertViewDeleage
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == [alertView cancelButtonIndex]) {
            [hud removeFromSuperview];
        }
    }
    if (alertView.tag == 1001) {
        if (buttonIndex == [alertView cancelButtonIndex]) {
            [self.mediaplayer.managerUtility resume];
            media_state = PLAYING;
        }
    }
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  //  UIImage *screenShot = [self makeImage];
    if (buttonIndex == 0) {
        SLComposeViewController *shareFB =[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewControllerCompletionHandler __block completionHandler = ^(SLComposeViewControllerResult result){
                [shareFB dismissViewControllerAnimated:YES completion:nil];
                switch (result) {
                    case SLComposeViewControllerResultCancelled:

                    {
                        NSLog(@"Cancel");
                        [self resumeStateOfFilm:old_media_state];
                        break;
                    }
                        
                        case SLComposeViewControllerResultDone:
                    {
                        NSLog(@"Posted");
                        [self resumeStateOfFilm:old_media_state];
                        break;
                    }
                    default:
                    {
                        [self resumeStateOfFilm:old_media_state];
                        break;
                    }
                
                }
            };
            
            NSString *imageLink = @"";
            NSString *initialText = @"";
            NSString * mediaStr;
            
            if (isPlayMovie) {
                imageLink = self.film.mediaThumbnailImage;
                initialText = [NSString stringWithFormat:@"Hey I 'm watching %@ at Z8 Player",self.film.mediaName];
                mediaStr = [NSString stringWithFormat:@"%@",self.film.mediaURL];
            } else{
                imageLink = self.channel.mediaThumbnailImage;
                initialText = [NSString stringWithFormat:@"Hey I 'm watching this channel with name:%@",self.channel.mediaName];
                mediaStr = [NSString stringWithFormat:@"%@",self.channel.mediaURL];
            }
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageLink]];
            
            [shareFB addImage:[UIImage imageWithData:data]];
            [shareFB setInitialText:initialText];
            [shareFB addURL:[NSURL URLWithString:mediaStr]];
            [shareFB setCompletionHandler:completionHandler];
            [self presentViewController:shareFB animated:YES completion:nil];
          
        }
        else{
            [self resumeStateOfFilm:old_media_state];
        }
        
    }else if(buttonIndex == 1){
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewController *tweetsheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            SLComposeViewControllerCompletionHandler __block completionHandler = ^(SLComposeViewControllerResult result){
                [tweetsheet dismissViewControllerAnimated:YES completion:nil];
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        [self resumeStateOfFilm:old_media_state];
                        break;
                    case SLComposeViewControllerResultDone:
                        [self resumeStateOfFilm:old_media_state];
                        break;
                    default:
                        [self resumeStateOfFilm:old_media_state];
                        break;
                }
            };
            
            NSString *imageLink = @"";
            NSString *initialText = @"";
            NSString * mediaStr;
            
            if (isPlayMovie) {
                imageLink = self.film.mediaThumbnailImage;
                initialText = [NSString stringWithFormat:@"Hey I 'm watching %@ at Z8 Player",self.film.mediaName];
                mediaStr = [NSString stringWithFormat:@"%@",self.film.mediaURL];
            } else{
                imageLink = self.channel.mediaThumbnailImage;
                initialText = [NSString stringWithFormat:@"Hey I 'm watching this channel with name:%@",self.channel.mediaName];
                mediaStr = [NSString stringWithFormat:@"%@",self.channel.mediaURL];
            }
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageLink]];

            [tweetsheet setInitialText:initialText];
            [tweetsheet addImage:[UIImage imageWithData:data]];
            [tweetsheet addURL:[NSURL URLWithString:mediaStr]];
            [tweetsheet setCompletionHandler:completionHandler];
            [self presentViewController:tweetsheet animated:YES completion:nil];
        }else{
            NSLog(@"boooo");
            [self resumeStateOfFilm:old_media_state];
        }

    }
    else if (buttonIndex == 2){
        NSString *infor = @"";
        BOOL isExist = NO;
        if (!isPlayMovie) {
            
            if ([favChannelArr count] == 0) {
                self.channel.isFavorite = YES;
                [favChannelArr addObject:self.channel];
                [[LibraryAPI sharedInstance]writeArrayWithCustomObjToUserDefaults:kFavouriteChannel withArray:favChannelArr];
                infor = @"Add channel to favourite successfully";
            } else{
                isExist = [self checkChannelInFavourtie:self.channel inFavChannelArr:favChannelArr];
                if (isExist) {
                    NSLog(@"Exist in Favourite");
                    //[self.channelsArr removeObject:self.channel];
                    [self removeChannel:self.channel fromArrChannel:favChannelArr];
                    [[LibraryAPI sharedInstance]writeArrayWithCustomObjToUserDefaults:kFavouriteChannel withArray:favChannelArr];
                    favChannelArr = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteChannel];
                    infor = @"Remove channel to favourite successfully";
                } else{
                    self.channel.isFavorite = YES;
                    [favChannelArr addObject:self.channel];
                    [[LibraryAPI sharedInstance]writeArrayWithCustomObjToUserDefaults:kFavouriteChannel withArray:favChannelArr];
                    
                    infor = @"Add channel to favourite successfully";

                }
            }
        } else{
            
            if ([favFilmArr count] == 0) {
                self.film.isFavorite = YES;
                [favFilmArr addObject:self.film];
                [[LibraryAPI sharedInstance]writeArrayWithCustomObjToUserDefaults:kFavouriteFilm withArray:favFilmArr];
                
                infor = @"Add film to favourite successfully";
            } else{
                isExist = [self checkFilmInFavourtie:self.film inFavFilmArr:self.favFilmArr];
                if (isExist) {
                    NSLog(@"Exist in Favourite");
                    //[favFilmArr removeObject:film];
                    [self removeFilm:self.film fromArrFilm:favFilmArr];
                    [[LibraryAPI sharedInstance]writeArrayWithCustomObjToUserDefaults:kFavouriteFilm withArray:favFilmArr];
                    favFilmArr = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteFilm];
                    infor = @"Remove film to favourite successfully";
                } else{
                    self.film.isFavorite = YES;
                    [favFilmArr addObject:self.film];
                    [[LibraryAPI sharedInstance]writeArrayWithCustomObjToUserDefaults:kFavouriteFilm withArray:favFilmArr];
                    
                    infor = @"Add film to favourite successfully";
                }
                
            }
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Info" message:infor delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
      
        [self checkFavourite];
        [self resumeStateOfFilm:old_media_state];
    }else if(buttonIndex == [actionSheet cancelButtonIndex]){
        [self resumeStateOfFilm:old_media_state];
    }
}
-(void) resumeStateOfFilm: (MEDIA_STATE ) oldState{
    if ( PLAYING == oldState )
    {
        [self.mediaplayer.managerUtility resume];
        media_state = PLAYING;
        self.playButton.hidden = YES;
    }
}

- (void)removeFilm:(FilmModel *)filmB fromArrFilm:(NSMutableArray *)arrFilms
{
    if (filmB) {
        for (int i = 0; i < [arrFilms count]; i++) {
            FilmModel *filmC = arrFilms[i];
            if (filmC.filmID == filmB.filmID) {
                [arrFilms removeObject:filmC];
            }
        }
    }
}

- (void)removeChannel:(ChannelModel *)channelB fromArrChannel:(NSMutableArray *)arrChannels
{
    if (channelB) {
        for (int i = 0; i < [arrChannels count]; i++) {
            ChannelModel *channelC = arrChannels[i];
            if (channelC.channelID == channelB.channelID) {
                [arrChannels removeObject:channelC];
            }
        }
    }
}

- (BOOL)checkChannelInFavourtie:(ChannelModel *)channelC inFavChannelArr:(NSMutableArray *)favChannels
{
    BOOL isExistF = NO;
    for (ChannelModel *channelS in favChannels) {
        if (channelS.channelID == channelC.channelID) {
            isExistF = YES;
            break;
        } else{
            isExistF = NO;
        }
    }
    return isExistF;
}

- (BOOL)checkFilmInFavourtie:(FilmModel *)filmC inFavFilmArr:(NSMutableArray *)favFilms
{
    BOOL isExistF = NO;
    for (FilmModel *filmS in favFilms) {
        if (filmS.filmID == filmC.filmID) {
            isExistF = YES;
            break;
        } else{
            isExistF = NO;
        }
    }
    return isExistF;
}


//-(void)actionSheetCancel:(UIActionSheet *)actionSheet
//{
//
//    if (PLAYING == media_state ){
//        [self.mediaplayer.managerUtility resume];
//        media_state = PLAYING;
//        self.playButton.hidden = YES;
//    }
//    NSLog(@"cancel");
//}
#pragma mark - Proccess play video:
-(void) preparePlaying:(NSString*) urlLinkforPlaying
{
    NSLog(@"Link:%@",urlLinkforPlaying);
    
    self.mediaplayer = [[MediaPlayer alloc] initWithURL:urlLinkforPlaying];
    [self.mediaplayer.managerUtility loadingPlayer:self.playerView viewController:self urlLink:urlLinkforPlaying];
    //[self.activityIndicator startAnimating];
    
    hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.dimBackground = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    hud.delegate = self;
    [hud show:YES];
    
    self.loadingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    self.counter = 0 ;
    
    [self.mediaplayer.managerUtility playWithURL:urlLinkforPlaying];
    media_state = PLAYING;
    self.playButton.hidden = YES;
    [self.playSlider setValue:0.0f];
    linkType = [self.mediaplayer checkLink:urlLinkforPlaying];
    if (
        (linkType == kHTTP_LINK) &&
        (
         ([urlLinkforPlaying rangeOfString:@"m3u8"].location == NSNotFound)
         ||([urlLinkforPlaying rangeOfString:@"mp4"].location != NSNotFound)
         )
        
        ){
        self.playSlider.userInteractionEnabled = YES;
        [self setSlider];
        self.btnSeekPrevious.enabled = YES;
        
    }
    else
    {
        self.playSlider.userInteractionEnabled = NO;
        self.btnSeekPrevious.enabled = NO;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
    
    [self.playerView addGestureRecognizer:tap];

}


-(void) resetForPlaying{
    [self.mediaplayer.managerUtility stop];
    //[self.activityIndicator stopAnimating];
    self.mediaplayer = nil;
    [hud removeFromSuperview];
    [sliderTimer invalidate];
    sliderTimer = nil;
    [self.loadingTimer invalidate];
    self.loadingTimer = nil;
    media_state = NOT_READY;
    [self checkBtnEnable];
    urlLink = nil;
}

- (void)checkBtnEnable
{
    int index = 0;
    int count = 0;
    if (isPlayMovie) {
        index = [self.filmsArr indexOfObject:self.film];
        count = [self.filmsArr count];
    } else{
        index = [self.channelsArr indexOfObject:self.channel];
        count = [self.channelsArr count];
    }
    
    if (index == 0) {
        [btnPrevious setEnabled:NO];
        toPrevious.enabled = NO;
    } else if(index ==  count - 1){
        [btnNext setEnabled:NO];
        toNext.enabled = NO;
    }
    if(count == 1){
        [btnPrevious setEnabled:NO];
        [btnNext setEnabled:NO];
        
        toPrevious.enabled = NO;
        toNext.enabled = NO;
    }

}

- (void)checkFavourite
{
    BOOL isNotAdd = NO;
    if (isPlayMovie) {
        isNotAdd = [self checkFilmInFavourtie:self.film inFavFilmArr:favFilmArr];
    } else{
        isNotAdd = [self checkChannelInFavourtie:self.channel inFavChannelArr:favChannelArr];
    }
    if (isNotAdd) {
        statusFav = @"Remove from favourite";
    } else{
        statusFav = @"Add to favourite";
    }
}

-(void) createAndDisplayMPVolumeView
{
    // Create a simple holding UIView and give it a frame
    UIView *volumeHolder = [[UIView alloc] initWithFrame: CGRectMake(42, self.muteButton.frame.origin.y, 230, 20)];
    [volumeHolder setBackgroundColor:[UIColor redColor]];
    NSLog(@"%0.2f", volumeHolder.frame.origin.x);
    NSLog(@"%0.2f", volumeHolder.frame.origin.y);
    volumeHolder.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    // set the UIView backgroundColor to clear.
    [volumeHolder setBackgroundColor: [UIColor clearColor]];
    
    // add the holding view as a subView of the main view
    [self.infoView addSubview: volumeHolder];
    
    // Create an instance of MPVolumeView and give it a frame
    MPVolumeView *myVolumeView = [[MPVolumeView alloc] initWithFrame: volumeHolder.bounds];
    [myVolumeView setVolumeThumbImage:[UIImage circularImageWithColor:[UIColor turquoiseColor] size:CGSizeMake(15, 15)] forState:UIControlStateNormal];
    [myVolumeView setMinimumVolumeSliderImage:[UIImage imageWithColor:[UIColor turquoiseColor] cornerRadius:0.f] forState:UIControlStateNormal];
    
    // Add myVolumeView as a subView of the volumeHolder
    [volumeHolder addSubview: myVolumeView];
}
#pragma mark - Convert second to hh:mm:ss
- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    if (hours < 1) {
        return [NSString stringWithFormat:@"%02d:%02d",minutes,seconds];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

-(void) tapOnView:(UITapGestureRecognizer* ) sender
{
//    CGPoint location = [sender locationInView:self.playerView];
            CATransition* transition = [CATransition animation];
            transition.duration = 1;
            transition.type = kCATransitionReveal;
            transition.subtype = kCATransitionFade;
            [self.playButton.layer addAnimation:transition forKey:kCATransition];

    if (PLAYING == media_state) {
        [self.playButton setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
        isPlaying = NO;
        media_state = PAUSED;
        [self.mediaplayer.managerUtility pause];
        self.playButton.hidden = NO;
        [self.playerView bringSubviewToFront:self.playButton];
    }else if ( PAUSED == media_state){
        [self.playButton setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
        isPlaying = YES;
        [self.mediaplayer.managerUtility resume];
        media_state = PLAYING;
        self.playButton.hidden = YES;
    }
    else {
        //do nothing
    }
}
- (IBAction)pressInfoButton:(id)sender {
    descriptionView = [[UIView alloc]init];
    [descriptionView setFrame:self.infoView.frame];
//    [descriptionView setBackgroundColor:[UIColor redColor]];
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.5];
    [transition setType:kCATransitionPush];
    [transition setSubtype:kCATransitionFromLeft];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [descriptionView.layer addAnimation:transition forKey:nil];
    [_infoView setHidden:YES];
   [self.view addSubview:descriptionView];
   
    UITextView *descriptionText = [[UITextView alloc]initWithFrame:CGRectMake(10, _titleLabel.frame.size.height + 10, 300, descriptionView.frame.size.height - _titleLabel.frame.size.height)];
    [descriptionText setUserInteractionEnabled:NO];
    [descriptionText setFont:[UIFont flatFontOfSize:15.f]];
    [descriptionView addSubview:descriptionText];
    
    if (self.isPlayMovie) {
        NSString *description = film.filmDescription;
        [descriptionText setText:description];
    }

    UISwipeGestureRecognizer *swipeBack = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeBack)];
    [swipeBack setDirection:UISwipeGestureRecognizerDirectionRight];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack)];
    
    [descriptionView addGestureRecognizer:swipeBack];
    [descriptionView addGestureRecognizer:tap];
    
    
}

-(void)swipeBack
{
    [descriptionView removeFromSuperview];
    [_infoView setHidden:NO];
}


#pragma mark - Resize image

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - getScreenShot

//-(UIImage *)makeImage
//{
//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return viewImage;
//}
- (IBAction)tapSeekPrevious:(id)sender {
        if (self.playSlider.userInteractionEnabled == YES)
        {
            Float64 dur = [self currentTimeInSeconds] - 30;
            
            if ( dur > 0 ) {
                self.playSlider.value = dur;
                CMTime seekThirtySec = CMTimeMakeWithSeconds(dur,1);
                [self.mediaplayer.managerUtility seekToPos:0 seekTime:seekThirtySec];
            }
            else{
                self.playSlider.value = 0.0f;
                CMTime seekThirtySec = CMTimeMakeWithSeconds(0.0f,1);
                [self.mediaplayer.managerUtility seekToPos:0 seekTime:seekThirtySec];
            }
            
        }
}

@end
