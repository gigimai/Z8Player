//
//  ZPFavoriteViewController.h
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/26/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "BaseViewController.h"
#import "FUISegmentedControl.h"
#import "FilmModel.h"
#import "ChannelModel.h"

@interface ZPFavoriteViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentCtrl;
- (IBAction)changeSegment:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *FavoriteTableView;
@property (assign, nonatomic) BOOL isShowFilm;
@property (strong, nonatomic) IBOutlet UIImageView *placeHolderImage;
@property (strong,nonatomic) NSMutableArray *favoriteList;

@property (nonatomic, strong) NSMutableArray *favChannelArr;
@property (nonatomic, strong) NSMutableArray *favFilmArr;

@property (nonatomic, strong) FilmModel *filmCurrent;
@property (nonatomic, strong) ChannelModel *channelCurrent;
@end
