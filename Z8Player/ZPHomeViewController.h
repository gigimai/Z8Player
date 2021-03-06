//
//  HomeViewController.h
//  Z8Player
//
//  Created by HieuSE on 8/13/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LibraryAPI.h"
#import "ChannelModel.h"
#import "FilmModel.h"
#import "ORGContainerCell.h"
#import "ZPDetailViewController.h"

@interface ZPHomeViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    
}
@property(nonatomic, strong) IBOutlet UITableView *theTableView;
@property(nonatomic) UILabel *lbl;
@property (strong, nonatomic) ZPDetailViewController *detailViewController;
//@property(nonatomic, strong) NSArray *filmsArr;
//@property (nonatomic, strong) NSArray *chanelsArr;
@property (nonatomic, strong) NSMutableArray *linkFilmArr;
@property (nonatomic, strong) NSMutableArray *linkChannelArr;
@property (strong, nonatomic) NSArray *dataArr;
@property (strong, nonatomic) NSMutableArray *chanelsArr;
@property (strong, nonatomic) NSMutableArray *filmsArr;
@end
