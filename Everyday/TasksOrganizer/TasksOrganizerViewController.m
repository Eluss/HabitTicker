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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}


- (void)setupView {
    self.view.backgroundColor = [UIColor redColor];

    TasksOrganizerTableViewDataSource *tableViewDataSource = [TasksOrganizerTableViewDataSource new];
    TasksTableView *tasksTableView = [[TasksTableView alloc] initWithDataSource:tableViewDataSource date:[NSDate date]];

    [self.view addSubview:tasksTableView];
    [tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:100];
}
@end