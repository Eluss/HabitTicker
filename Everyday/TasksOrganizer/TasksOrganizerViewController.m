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
#import "Fonts.h"
#import "UIColor+Additions.h"


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
    tasksTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}

- (void)setupTitle {
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];
    titleView.backgroundColor = [UIColor headerColor];

    [titleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [titleView autoSetDimension:ALDimensionHeight toSize:100];

    UILabel *titleLabel = [UILabel new];
    [titleView addSubview:titleLabel];

    [titleLabel autoCenterInSuperview];

    titleLabel.text = @"Default tasks";
    titleLabel.font = [Fonts headerFont];

    UIView *stripe = [UIView new];
    [titleView addSubview:stripe];
    stripe.backgroundColor = [UIColor blackColor];

    [stripe autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [stripe autoSetDimension:ALDimensionHeight toSize:1];
}
@end