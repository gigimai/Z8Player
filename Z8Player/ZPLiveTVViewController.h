//
//  ZPLiveTVViewController.h
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/11/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ZPLiveTVViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *channelArr;
@property (nonatomic, strong) NSMutableArray *linkArr;
@end
