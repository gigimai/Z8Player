//
//  ZPFavoriteViewController.m
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/26/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ZPFavoriteViewController.h"
#import "FilmModel.h"
#import "ChannelModel.h"
#import "UITableViewCell+FlatUI.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+FlatUI.h"
#import "FUISegmentedControl.h"
#import "LibraryAPI.h"
#import "UIImageView+AFNetworking.h"
#import "ZPDetailViewController.h"

@interface ZPFavoriteViewController () <UITableViewDelegate,UITableViewDataSource>{
}

@end

@implementation ZPFavoriteViewController
@synthesize favoriteList;
@synthesize favFilmArr;
@synthesize favChannelArr;
@synthesize channelCurrent;
@synthesize filmCurrent;

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
    [self setTitle:@"Favorite"];
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:3];
    
    // Default movie
    self.isShowFilm = YES;
    //favoriteList = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteFilm];
//    if (!favoriteList) {
//        favoriteList = [[NSMutableArray alloc]init];
//    }
    //[self reloadTable];
    [self.FavoriteTableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)reloadTable
{
    [self.FavoriteTableView reloadData];
    if (favoriteList.count == 0) {
        [self.FavoriteTableView setHidden:YES];
        [_placeHolderImage setHidden:NO];
    }else{
        [_placeHolderImage setHidden:YES];
        [self.FavoriteTableView setHidden:NO];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.isShowFilm) {
        favoriteList = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteFilm];
    } else{
        NSLog(@"%d",[[[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteChannel] count]);
        favoriteList = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteChannel];
    }
    [self reloadTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeSegment:(id)sender {
    
    if (_segmentCtrl.selectedSegmentIndex == 0) {
        self.isShowFilm = YES;
//        [self loadDataForModel:@"Film"];
//        favoriteList = [[LibraryAPI sharedInstance]favouriteFilmArr];
        favoriteList = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteFilm];
        
    }else if (_segmentCtrl.selectedSegmentIndex == 1){
        self.isShowFilm = NO;
//        [self loadDataForModel:@"Channel"];
//        favoriteList = [[LibraryAPI sharedInstance]favouriteChannelArr];
        favoriteList = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteChannel];
    }
    [self reloadTable];
}

-(void)loadDataForModel : (NSString *)model
{
    if ([model isEqualToString:@"Film"]) {
        NSLog(@"film");
        NSArray *filmArr;
        filmArr = [[LibraryAPI sharedInstance]getFilmList];
        [favoriteList removeAllObjects];
        for (FilmModel *film in filmArr) {
            if (film.isFavorite) {
                [favoriteList addObject:film];
            }
        }
    }else if ([model isEqualToString:@"Channel"]){
        NSLog(@"channel");
        NSArray *channelArr;
        [favoriteList removeAllObjects];
        for (ChannelModel *channel in channelArr) {
            if (channel.isFavorite) {
                [favoriteList addObject:channel];
            }
        }
    }
}


#pragma mark - UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 4;
    return [favoriteList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"FavoriteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *upperBorder = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 300, 1)];
    [upperBorder setBackgroundColor: [UIColor silverColor]];
    if (indexPath.section != 0) {
        [cell.contentView addSubview:upperBorder];
    }
//    [cell.contentView addSubview:upperBorder];
    CGFloat cellHeight = 0;
    if (self.segmentCtrl.selectedSegmentIndex == 0) {

        cellHeight = 117;
    }else if (self.segmentCtrl.selectedSegmentIndex == 1){
        cellHeight = 92;
    }
//    UIView *underBorder = [[UIView alloc]initWithFrame:CGRectMake(10, cellHeight, 300, 1)];
//    [underBorder setBackgroundColor:[UIColor turquoiseColor]];
//    
//    [cell.contentView addSubview:underBorder];
    
    NSString *title = @"";
    NSString *imgURL = @"";
    NSString *description = @"";
    if (self.isShowFilm) {
        FilmModel *film = favoriteList[indexPath.section];
        title = film.mediaName;
        imgURL = film.mediaThumbnailImage;
        description = film.filmDescription;
    } else{
        ChannelModel *channel = favoriteList[indexPath.section];
        title = channel.mediaName;
        imgURL = channel.mediaThumbnailImage;
        description = channel.channelCountry;
    }
    
    UIImageView *posterView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 82, cellHeight - 10)];
    [posterView setBackgroundColor:[UIColor amethystColor]];
    [posterView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"LogoFSO(2)"]];
    [posterView setContentMode:UIViewContentModeScaleToFill];
    [cell.contentView addSubview:posterView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(posterView.frame.size.width + 20,0 , cell.frame.size.width - posterView.frame.size.width - 10, 40)];
    //[titleLabel setText:@"This is movie Title"];
    //[titleLabel setText:title];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor turquoiseColor]];
    [titleLabel setFont:[UIFont boldFlatFontOfSize:17.f]];
    [cell.contentView addSubview:titleLabel];
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(posterView.frame.size.width + 20 ,40,cell.frame.size.width - posterView.frame.size.width - 30, cellHeight - 40)];
       [descriptionLabel setText:description];
     [descriptionLabel setNumberOfLines:3];
    [descriptionLabel setTextColor:[UIColor silverColor]];
    [descriptionLabel setFont:[UIFont flatFontOfSize:15.f]];
    [descriptionLabel sizeToFit];
    [descriptionLabel setTextAlignment:NSTextAlignmentJustified];
 
    
    [cell.contentView addSubview:descriptionLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc;
    if (self.isShowFilm) {
        filmCurrent = favoriteList[indexPath.section];
        vc = [[ZPDetailViewController alloc]initWithNibName:@"ZPDetailViewController" bundle:nil withFilmArrs:self.favoriteList andFilm:filmCurrent];
    } else{
        channelCurrent = favoriteList[indexPath.section];
        vc = [[ZPDetailViewController alloc]initWithNibName:@"ZPDetailViewController" bundle:nil withChannelArrs:self.favoriteList andChannel:channelCurrent];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.isShowFilm) {
            filmCurrent = [self.favoriteList objectAtIndex:indexPath.section];
            [self.favoriteList removeObject:filmCurrent];
            [[LibraryAPI sharedInstance]writeArrayWithCustomObjToUserDefaults:kFavouriteFilm withArray:self.favoriteList];
            favoriteList = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteFilm];
            [self reloadTable];
            [self.FavoriteTableView reloadData];
            
        } else{
            channelCurrent = self.favoriteList[indexPath.section];
            [self.favoriteList removeObject:channelCurrent];
            [[LibraryAPI sharedInstance]writeArrayWithCustomObjToUserDefaults:kFavouriteChannel withArray:self.favoriteList];
            favoriteList = [[LibraryAPI sharedInstance]readArrayWithCustomObjFromUserDefaults:kFavouriteChannel];
            [self reloadTable];
            [self.FavoriteTableView reloadData];
        }
    }
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentCtrl.selectedSegmentIndex == 0) {
        return 117;
    }else if (self.segmentCtrl.selectedSegmentIndex == 1){
        return 92;
    }
    return 117;

}
@end
