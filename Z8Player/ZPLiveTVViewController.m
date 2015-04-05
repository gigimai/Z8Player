//
//  ZPLiveTVViewController.m
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/11/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ZPLiveTVViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIFont+FlatUI.h"
#import "LibraryAPI.h"
#import "ChannelModel.h"
//#import "AsyncImageView.h"
#import "UIImageView+AFNetworking.h"
#import "ZPDetailViewController.h"



#define kHeaderColor [UIColor colorWithRed:193.0f/255.0f green:255.0f/255.0f blue:193.0f/255.0f alpha:1]
@interface ZPLiveTVViewController ()
@property (nonatomic,strong) UITableView *nowShowingTableView;
@property (strong, nonatomic) IBOutlet FUISegmentedControl *segmentCtrl;

@end

@implementation ZPLiveTVViewController
@synthesize channelArr;
@synthesize linkArr;
static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareData];
    [self loadNowShowingList];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Live TV"];
    [self.view setBackgroundColor:[UIColor cloudsColor]];
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)loadNowShowingList
{
    _nowShowingTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, self.view.bounds.size.height)style:UITableViewStyleGrouped];
    _nowShowingTableView.delegate = self;
    _nowShowingTableView.dataSource = self;
    [self.view addSubview:_nowShowingTableView];
    [_nowShowingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FUITableViewControllerCellReuseIdentifier];
   // [_nowShowingTableView setSeparatorColor:[UIColor cloudsColor]];
  //  [_nowShowingTableView setBackgroundView:nil];
    [_nowShowingTableView setBackgroundColor:[UIColor cloudsColor]];
    [_nowShowingTableView setShowsVerticalScrollIndicator:NO];
    [_nowShowingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_nowShowingTableView setSeparatorColor:[UIColor silverColor]];
    _nowShowingTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
}

- (void)prepareData
{
    //channelArr = [NSMutableArray arrayWithArray:[[LibraryAPI sharedInstance]getChannelList]];
    channelArr = [LibraryAPI sharedInstance].channelEditedArr;
    for (ChannelModel *channel in channelArr) {
        if (!linkArr) {
            linkArr = [[NSMutableArray alloc]init];
        }
        NSDictionary *channelDict = @{@"MediaID":[NSNumber numberWithInt:channel.channelID],
                                      @"MediaLink": channel.mediaURL};
        //[NSString stringWithFormat:@"%@",channel.mediaURL];
        [linkArr addObject:channelDict];
    }
}


-(void)addUnderSeparator : (UIView *)targetView
{
    CGRect separatorFrame = CGRectMake(0, targetView.frame.size.height - 1, targetView.frame.size.width, 1);
    UIView *separatorView = [[UIView alloc]initWithFrame:separatorFrame];
    [separatorView setBackgroundColor:[UIColor tangerineColor]];
    [targetView addSubview:separatorView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [channelArr count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIRectCorner corner = 0;
    if (tableView.style == UITableViewStyleGrouped) {
        if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
            corner = UIRectCornerAllCorners;
        }else if (indexPath.row == 0){
            corner = UIRectCornerTopLeft | UIRectCornerTopRight;
        }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1){
            corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
    }

   // static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [self.nowShowingTableView dequeueReusableCellWithIdentifier:FUITableViewControllerCellReuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FUITableViewControllerCellReuseIdentifier];
    }
    [cell configureFlatCellWithColor:[UIColor whiteColor] selectedColor:[UIColor cloudsColor] roundingCorners:corner];

    
    ChannelModel *channel = channelArr[indexPath.section];
    [[cell.contentView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIImageView *channelImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
    [channelImage setImageWithURL:[NSURL URLWithString:channel.mediaThumbnailImage] placeholderImage:[UIImage imageNamed:@"LogoFSO(2).png"]];
   
    [cell.contentView addSubview:channelImage];
    UILabel *channelName = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, cell.contentView.frame.size.width - channelImage.frame.size.width, 45)];
    [channelName setText:channel.mediaName];
    [channelName setFont:[UIFont boldFlatFontOfSize:17.f]];
    [channelName setTextColor:[UIColor turquoiseColor]];
    [cell.contentView addSubview:channelName];
    
    UILabel *channelNation = [[UILabel alloc]initWithFrame:CGRectMake(channelName.frame.origin.x,45, channelName.frame.size.width, 45)];
    [channelNation setText:[NSString stringWithFormat:@"Nation : %@",channel.channelCountry]];
    [channelNation setFont:[UIFont flatFontOfSize:15.f]];
    [cell.contentView addSubview:channelNation];
    
//    
    UIView *separator = [[UIView alloc]initWithFrame:CGRectMake(0,45, channelName.frame.size.width -10, 1)];
    [separator setBackgroundColor:[UIColor silverColor]];
    [separator setAlpha:0.8];
    [channelName addSubview:separator];

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.nowShowingTableView deselectRowAtIndexPath:indexPath animated:YES];
//    ZPDetailViewController *detailVC = [[ZPDetailViewController alloc]initWithNibName:@"ZPDetailViewController" bundle:nil withLinkArrs:self.linkArr andLink:channel.mediaURL];
    ZPDetailViewController *detailVC = [[ZPDetailViewController alloc] initWithNibName:@"ZPDetailViewController" bundle:nil withChannelArrs:self.channelArr andChannel:channelArr[indexPath.section]];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //!!!FIX for issue #1 Cell position wrong------------
    if(cell.layer.position.x != 0){
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    
    //4. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

//Helper function to get a random float
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

- (UIColor*)colorFromIndex:(int)index{
    UIColor *color;
    
    //Purple
    if(index % 3 == 0){
        color = [UIColor belizeHoleColor];
        //Blue
    }else if(index % 3 == 1){
        color = [UIColor emerlandColor];
        //Blk
    }else if(index % 3 == 2){
        color = [UIColor blackColor];
    }
    else if(index % 3 == 3){
        color = [UIColor midnightBlueColor];
    }
    
    
    return color;
    
}



@end