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
#import "DataSwiperView.h"


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
    [self.view addSubview:tasksTableView];

    tasksTableView.delegate = self;
    _source = [TasksTableViewDataSource new];
    tasksTableView.dataSource = _source;


    DataSwiperView *dataSwiperView = [DataSwiperView new];
    [self.view addSubview:dataSwiperView];


    [tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:dataSwiperView];

    [dataSwiperView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [dataSwiperView autoSetDimension:ALDimensionHeight toSize:100];
}




@end