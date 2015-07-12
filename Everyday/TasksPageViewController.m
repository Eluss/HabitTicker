//
// Created by Eliasz Sawicki on 04/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <DateTools/NSDate+DateTools.h>
#import "TasksPageViewController.h"
#import "TasksViewController.h"


@implementation TasksPageViewController {
    NSDate *_tasksDate;
    NSArray *_controllers;
    NSInteger _controllerIndex;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _controllerIndex = 0;
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPage];

}

- (void)setupPage {
    _tasksDate = [NSDate new];
    TasksViewController *tasksViewController1 = [[TasksViewController alloc] initWithDate:_tasksDate];
    tasksViewController1.delegate = self;

    TasksViewController *tasksViewController2 = [[TasksViewController alloc] initWithDate:_tasksDate];
    tasksViewController2.delegate = self;


    _controllers = @[tasksViewController1, tasksViewController2];
    NSArray *controller = [self chooseAnotherViewControllerToPresent];
    [self setViewControllers:controller direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];


}

- (void)previousTasksList {
    _tasksDate = [_tasksDate dateByAddingDays:-1];
    [self updateControllerIndex];

    NSArray *controllers = [self chooseAnotherViewControllerToPresent];
    [self setViewControllers:controllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (void)nextTasksList {
    _tasksDate = [_tasksDate dateByAddingDays:1];
    [self updateControllerIndex];

    NSArray *controllers = [self chooseAnotherViewControllerToPresent];
    [self setViewControllers:controllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)updateControllerIndex {
    _controllerIndex = (_controllerIndex + 1) % 2;
}

- (NSArray *)chooseAnotherViewControllerToPresent {
    TasksViewController *viewController = _controllers[(NSUInteger) _controllerIndex];
    [viewController tasksForDate:_tasksDate];
    NSArray *viewControllerArray = @[viewController];
    [viewController markSwiperIfCurrentDate];
    return viewControllerArray;
}

@end