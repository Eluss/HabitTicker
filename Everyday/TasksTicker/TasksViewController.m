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
#import "NSObject+RACPropertySubscribing.h"
#import "RACSignal.h"
#import "RACEXTScope.h"

@implementation TasksViewController {
    TasksTableViewDataSource *_source;
    UITableView *_tasksTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor redColor];
    _tasksTableView = [UITableView new];
    [_tasksTableView registerClass:[MCSwipeTableViewCell class] forCellReuseIdentifier:@"taskCell"];
    [self.view addSubview:_tasksTableView];



    DataSwiperView *dataSwiperView = [DataSwiperView new];
    @weakify(self);
    [RACObserve(dataSwiperView, swiperDate) subscribeNext:^(NSDate *date) {
        @strongify(self);
        [self->_source updateTasksDataForDate:date];
        [_tasksTableView reloadData];
    }];
    [self.view addSubview:dataSwiperView];

    _tasksTableView.delegate = self;
    _source = [[TasksTableViewDataSource alloc] initWithDate:dataSwiperView.swiperDate];
    _tasksTableView.dataSource = _source;

    [_tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [_tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:dataSwiperView];

    [dataSwiperView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [dataSwiperView autoSetDimension:ALDimensionHeight toSize:100];
}




@end