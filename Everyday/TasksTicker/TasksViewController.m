//
//  TasksViewController.m
//  Everyday
//
//  Created by Eluss on 04/06/15.
//  Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//


#import <DateTools/NSDate+DateTools.h>
#import "TasksViewController.h"
#import "ALView+PureLayout.h"
#import "TasksTableViewDataSource.h"
#import "TasksTableView.h"
#import "UIColor+Additions.h"

@implementation TasksViewController {
    DataSwiperView *_dataSwiperView;
    NSDate *_tasksDate;
    TasksTableView *_tasksTableView;
}

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _tasksDate = date;
        [self setupView];
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor backgroundColor];

    TasksTableViewDataSource *source = [[TasksTableViewDataSource alloc] initWithDate:_tasksDate];
    _tasksTableView = [[TasksTableView alloc] initWithDataSource:source date:_tasksDate];
    _tasksTableView.backgroundColor = [UIColor backgroundColor];
    _tasksTableView.swiperDelegate = self;
    [self.view addSubview:_tasksTableView];

    _dataSwiperView = [[DataSwiperView alloc] initWithDate:_tasksDate];
    _dataSwiperView.delegate = self;
    [self.view addSubview:_dataSwiperView];

    UIView *stripe = [UIView new];
    [_dataSwiperView addSubview:stripe];
    stripe.backgroundColor = [UIColor blackColor];

    [stripe autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [stripe autoSetDimension:ALDimensionHeight toSize:1];

    [_tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [_tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_dataSwiperView];
    _tasksTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);

    [_dataSwiperView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [_dataSwiperView autoSetDimension:ALDimensionHeight toSize:100];
}



- (void)tasksForDate:(NSDate *)date {
    _tasksDate = date;
    [_dataSwiperView updateDate:date];
    [_tasksTableView updateTasksForDate:date];
    [self.view layoutIfNeeded];
}

- (void)didMoveToPreviousDate {
    [self.delegate previousTasksList];
}
- (void)didMoveToNextDate {
    [self.delegate nextTasksList];
}



@end