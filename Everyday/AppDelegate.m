//
//  AppDelegate.m
//  Everyday
//
//  Created by Eluss on 04/06/15.
//  Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//


#import "AppDelegate.h"
#import "TasksViewController.h"
#import "TasksOrganizerTableViewDataSource.h"
#import "TasksOrganizerViewController.h"
#import "TasksPageViewController.h"
#import "StatisticsViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    UITabBarController *tabBarController = [UITabBarController new];
    self.window.rootViewController = tabBarController;

    TasksPageViewController *tasksPageViewController = [[TasksPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                                        options:nil];

    tasksPageViewController.title = @"Everyday ticker swiper";

    TasksViewController *tickerViewController = [TasksViewController new];
    tickerViewController.title = @"Everyday Ticker";

    TasksOrganizerViewController *organizerViewController = [TasksOrganizerViewController new];
    organizerViewController.title = @"Everyday Organizer";

    StatisticsViewController *statisticsViewController = [StatisticsViewController new];
    statisticsViewController.title = @"Statistics";

    [tabBarController addChildViewController:tasksPageViewController];
    [tabBarController addChildViewController:organizerViewController];
    [tabBarController addChildViewController:statisticsViewController];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end