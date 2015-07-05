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
    TasksTableViewDataSource *source = [[TasksTableViewDataSource alloc] initWithDate:_tasksDate];
    _tasksTableView = [[TasksTableView alloc] initWithDataSource:source date:_tasksDate];
    [self.view addSubview:_tasksTableView];

    _dataSwiperView = [[DataSwiperView alloc] initWithDate:_tasksDate];
    _dataSwiperView.delegate = self;
    [self.view addSubview:_dataSwiperView];

    [_tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [_tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_dataSwiperView];

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