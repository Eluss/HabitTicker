//
//  TasksViewController.m
//  Everyday
//
//  Created by Eluss on 04/06/15.
//  Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//


#import "TasksViewController.h"
#import "ALView+PureLayout.h"
#import "TasksTableViewDataSource.h"
#import "MCSwipeTableViewCell.h"


@interface TasksViewController ()

@end

@implementation TasksViewController {
    TasksTableViewDataSource *_source;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor redColor];
    UITableView *tasksTableView = [UITableView new];
    [tasksTableView registerClass:[MCSwipeTableViewCell class] forCellReuseIdentifier:@"taskCell"];

    tasksTableView.delegate = self;
    _source = [TasksTableViewDataSource new];
    tasksTableView.dataSource = _source;

    [self.view addSubview:tasksTableView];
    [tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];
}




@end