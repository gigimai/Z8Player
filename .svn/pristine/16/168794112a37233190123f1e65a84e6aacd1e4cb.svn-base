//
//  AppDelegate.m
//  Z8Player
//
//  Created by HieuSE on 8/6/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "AppDelegate.h"
#import "FFEngine.framework/Headers/FFEngine.h"
#import <AVFoundation/AVFoundation.h>
#import "ZPHomeViewController.h"
#import "UIColor+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import <MediaPlayer/MediaPlayer.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.mainViewController = [[ZPHomeViewController alloc]initWithNibName:@"ZPHomeViewController" bundle:nil];
    //self.mainViewController = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    self.navController = [[UINavigationController alloc]initWithRootViewController:self.mainViewController];
    [self.window setRootViewController:self.navController];
 
    [self setupAppearance];
    
    //[[LibraryAPI sharedInstance]initDemoData];
    
    [self.window makeKeyAndVisible];
    RegisterFFEngine(@"yQ2oiBQRbXoo35veDico9ggF4ARFxRdjq3yiIvBltwIPe/SgphrthjEVCzt6mtAfejcyM1fkbDdY+wE8j7oeJLK+u1KEO7IgfEDQ+KrnsNc=");
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)setupAppearance
{
  
  //  [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:113.0f/255.0f green:198.0f/255.0f blue:113.0f/255.0f alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor turquoiseColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UIButton appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTintColor:[UIColor turquoiseColor]];
  //  [[UIBarButtonItem appearance] configureFlatButtonWithColor:[UIColor emerlandColor] highlightedColor:[UIColor greenSeaColor] cornerRadius:3];
  //  [[UIBarButtonItem appearance] setTitle:@"Back"];
                                                            
}


@end
