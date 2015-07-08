//
// Created by Eliasz Sawicki on 07/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "StatisticsViewController.h"
#import "StatisticsTableView.h"
#import "StatisticsTableViewDataSource.h"


@implementation StatisticsViewController


- (void)loadView {
    [super loadView];
    [self setupView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}


- (void)setupView {
    StatisticsTableViewDataSource *statisticsTableViewDataSource = [StatisticsTableViewDataSource new];
    StatisticsTableView *statisticsTableView = [[StatisticsTableView alloc] initWithDataSource:statisticsTableViewDataSource];

    [self.view addSubview:statisticsTableView];

    [statisticsTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}
@end