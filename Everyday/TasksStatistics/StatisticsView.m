//
// Created by Eliasz Sawicki on 10/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "StatisticsView.h"
#import "TaskStatistics.h"

#define HORIZONTAL_SPACING 20

@implementation StatisticsView {
    TaskStatistics *_taskStatistics;
}
- (instancetype)initWithTaskStatistics:(TaskStatistics *)taskStatistics {
    self = [super init];
    if (self) {
        _taskStatistics = taskStatistics;
        [self setupView];
    }

    return self;
}

- (void)setupView {
    UIView *cellView = [UIView new];
    [self addSubview:cellView];

    UILabel *nameLabel = [UILabel new];
    [cellView addSubview:nameLabel];

    nameLabel.text = _taskStatistics.name;

    [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:HORIZONTAL_SPACING];
    [nameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:cellView];

    UILabel *doneLabel = [UILabel new];
    [cellView addSubview:doneLabel];
    doneLabel.text = [NSString stringWithFormat:@"%d", _taskStatistics.doneCounter];
    doneLabel.textColor = [UIColor greenColor];

    UILabel *notDoneLabel = [UILabel new];
    [cellView addSubview:notDoneLabel];
    notDoneLabel.text = [NSString stringWithFormat:@"%d", _taskStatistics.notDoneCounter];
    notDoneLabel.textColor = [UIColor redColor];

    [notDoneLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:HORIZONTAL_SPACING];
    [notDoneLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:cellView];

    [doneLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:notDoneLabel withOffset:-HORIZONTAL_SPACING];
    [doneLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:cellView];

    [cellView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];
}


@end