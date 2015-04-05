//
//  BaseViewController.m
//  Z8Player
//
//  Created by HieuSE on 8/6/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "BaseViewController.h"
#import "ZPHomeViewController.h"
#import "ZPLiveTVViewController.h"
#import "ZPMoviesViewController.h"
#import "ZPFavoriteViewController.h"
@interface BaseViewController ()
{
    //@property(nonatomic, strong) BTSimpleSideMenu *sidebar;
}
@end
@class ZPHomeViewController;
@implementation BaseViewController
//@synthesize sidebar;
@synthesize optionIndices;

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
    // Do any additional setup after loading the view.
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menuIcon2.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(showSidebar:)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,menuButton,nil]];
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
}

- (void)showSidebar:(id)sender
{
    NSLog(@"Sidebar");
//    [sidebar toggleMenu];
    NSArray *images = @[
                        [UIImage imageNamed:@"homeIcon"],
                        [UIImage imageNamed:@"icon_liveTV"],
                        [UIImage imageNamed:@"icon_movie"],
                        [UIImage imageNamed:@"icon_fav"],
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
     
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %i",index);
    UIViewController *vc;
    if (index == 0)
    {
        vc =  [[ZPHomeViewController alloc]initWithNibName:@"ZPHomeViewController" bundle:nil];
    }
    else if(index == 1)
    {
        vc =  [[ZPLiveTVViewController alloc]initWithNibName:@"ZPLiveTVViewController" bundle:nil];
    }
    else if(index == 2)
    {
        vc = [[ZPMoviesViewController alloc]initWithNibName:@"ZPMoviesViewController" bundle:nil];
    }
    else if(index == 3)
    {
        vc = [[ZPFavoriteViewController alloc]initWithNibName:@"ZPFavoriteViewController" bundle:nil];
    }

    
    if (vc) {
        // Create present to push
        //[self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//        [UIView transitionWithView:self.navigationController.view
//                          duration:0.75
//                           options:UIViewAnimationOptionTransitionFlipFromLeft
//                        animations:^{
//                            //[self.navigationController pushViewController:self.detailViewController animated:NO];
//                       //     [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//                        }
//                        completion:nil];
//        CATransition* transition = [CATransition animation];
//        transition.duration = 1;
//        transition.type = kCATransitionFromLeft;
//        transition.subtype = kCATransitionFromBottom;
//        [self.view.window.layer addAnimation:transition forKey:kCATransition];
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setType:kCATransitionMoveIn];
        [animation setSubtype:kCATransitionFromLeft];
        [animation setDuration:0.3f];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:NO completion:nil];
    }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}
@end
