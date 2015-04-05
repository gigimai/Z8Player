//
//  ORGDetailViewController.m
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/8/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ZPDetailViewController.h"
#import "UIColor+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIFont+FlatUI.h"

@interface ZPDetailViewController (){
    BOOL isPlaying;
    NSTimer* sliderTimer;
}
@property (strong, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UIView *playerControlView;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UISlider *playSlider;
@property (strong, nonatomic) IBOutlet FUISegmentedControl *segmentCtrl;

@property (nonatomic) size_t videoDuration;

@end

@implementation ZPDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *urlLink = @"http://10.88.107.5/vod/Cars.2.Air.Mater.mp4";
    //@"rtmp://www.planeta-online.tv:1936/live/channel_2"
    // Do any additional setup after loading the view from its nib.
     self.mediaplayer = [[MediaPlayer alloc] initWithURL:urlLink];
  //  [self.view setFrame:]

    //[self.mediaplayer.managerUtility loadingPlayer:self.playerView viewController:self urlLink:urlLink];
//    [self.activityIndicator startAnimating];
   //   [self.mediaplayer.managerUtility playWithURL:urlLink];
    NSLog(@"view did load");
    //segmentControl
    [self setupView];
   // [self.segmentCtrl setTintColor:kColor];
    [self.playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    
    isPlaying = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSString *urlLink = @"http://10.88.107.5/vod/Cars.2.Air.Mater.mp4";
    //@"rtmp://10.88.107.5/vod/mp4:Cars.2.Air.Mater";
   // self.mediaplayer = [[MediaPlayer alloc] initWithURL:urlLink];
    [self.mediaplayer.managerUtility loadingPlayer:self.playerView viewController:self urlLink:urlLink];
    [self.activityIndicator startAnimating];
    [self.mediaplayer.managerUtility playWithURL:urlLink];
    [self.playSlider setValue:0.0f];
    [self setSlider];
}
-(void)setupView
{
    [self.segmentCtrl setSelectedFont:[UIFont boldFlatFontOfSize:16]];
    [self.segmentCtrl setSelectedFontColor:[UIColor cloudsColor]];
    [self.segmentCtrl setDeselectedFont:[UIFont flatFontOfSize:16]];
    [self.segmentCtrl setDeselectedFontColor:[UIColor cloudsColor]];
    [self.segmentCtrl setSelectedColor:[UIColor turquoiseColor]];
    [self.segmentCtrl setDeselectedColor:[UIColor greenSeaColor]];
    [self.segmentCtrl setDisabledColor:[UIColor silverColor]];
    [self.segmentCtrl setDividerColor:[UIColor silverColor]];
    [self.segmentCtrl setCornerRadius:5.0];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"Exit");
    [self.mediaplayer.managerUtility stop];
   // [self.navigationController popViewControllerAnimated:YES];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playOrPause:(id)sender {
    if (isPlaying) {
        [self.playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        isPlaying = NO;
        [self.mediaplayer.managerUtility pause];
    }else{
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        isPlaying = YES;
        [self.mediaplayer.managerUtility resume];
    }
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
        [self.activityIndicator stopAnimating];
}

-(void)bufferingStart{
    NSLog(@"buffering start");
    [self.view bringSubviewToFront:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
}

-(void)mediaDuration:(size_t)duration{
    NSLog(@"Duration of film : %zd", duration);
    self.videoDuration = duration;
}

- (void)mediaPosition:(size_t)position{
    NSLog(@"position: %zd", position);
//    CGFloat time_status;
    //    time = (float)position/(float)self.videoDuration;
    
//    time_status = (CGFloat)position/(CGFloat)self.videoDuration;
    
    Float32 percent_status = ((Float32)position/self.videoDuration);
    NSLog(@"time: %f", percent_status);
    [self.playSlider setValue:percent_status];
}
#pragma mark Implement Slider for HTTP

-(IBAction)sliding:(id)sender{
    
    CMTime newTime = CMTimeMakeWithSeconds(self.playSlider.value, 1);
    [self.mediaplayer.managerUtility seekToPos:0 seekTime:newTime];
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
}

- (Float64)durationInSeconds {
    Float64 dur = CMTimeGetSeconds([self.mediaplayer.managerUtility getDurationTime]);
    return dur;
}


- (Float64)currentTimeInSeconds {
    Float64 dur = CMTimeGetSeconds([self.mediaplayer.managerUtility getCurrentTime]);
    return dur;
}

@end