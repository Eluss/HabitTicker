//
// Created by Eliasz Sawicki on 07/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "StatisticsViewController.h"
#import "StatisticsTableView.h"
#import "StatisticsTableViewDataSource.h"
#import "StatisticsView.h"
#import "Fonts.h"
#import "UIColor+Additions.h"


@implementation StatisticsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)setupView {
    [self setupTitle];


    StatisticsTableViewDataSource *statisticsTableViewDataSource = [StatisticsTableViewDataSource new];
    StatisticsTableView *statisticsTableView = [[StatisticsTableView alloc] initWithDataSource:statisticsTableViewDataSource];
    [statisticsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"statisticsView"];

    [self.view addSubview:statisticsTableView];

    [statisticsTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [statisticsTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:100];
    statisticsTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
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

    titleLabel.text = @"Statistics";
    titleLabel.font = [Fonts headerFont];


    UIView *stripe = [UIView new];
    [titleView addSubview:stripe];
    stripe.backgroundColor = [UIColor blackColor];

    [stripe autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [stripe autoSetDimension:ALDimensionHeight toSize:1];
}
@end
