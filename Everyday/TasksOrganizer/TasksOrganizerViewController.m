//
// Created by Eluss on 06/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <MCSwipeTableViewCell/MCSwipeTableViewCell.h>
#import <PureLayout/PureLayoutDefines.h>
#import "TasksOrganizerViewController.h"
#import "ALView+PureLayout.h"
#import "TasksOrganizerTableViewDataSource.h"
#import "TasksTableView.h"


@implementation TasksOrganizerViewController

- (void)loadView {
    [super loadView];
    [self setupView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)setupView {

    [self setupTitle];

    TasksOrganizerTableViewDataSource *tableViewDataSource = [TasksOrganizerTableViewDataSource new];
    TasksTableView *tasksTableView = [[TasksTableView alloc] initWithDataSource:tableViewDataSource date:[NSDate date]];

    [self.view addSubview:tasksTableView];
    [tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:100];
}

- (void)setupTitle {
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];

    titleView.backgroundColor = [UIColor yellowColor];
    [titleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [titleView autoSetDimension:ALDimensionHeight toSize:100];

    UILabel *titleLabel = [UILabel new];
    [titleView addSubview:titleLabel];

    [titleLabel autoCenterInSuperview];

    titleLabel.text = @"Default tasks";
}
@end