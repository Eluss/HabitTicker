//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <DateTools/NSDate+DateTools.h>
#import <PureLayout/ALView+PureLayout.h>
#import "StatisticsTableViewDataSource.h"
#import "TasksLoader.h"
#import "Task.h"
#import "TaskStatistics.h"
#import "TaskStatisticsProvider.h"
#import "StatisticsView.h"


@implementation StatisticsTableViewDataSource {
    NSArray *_tasks;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _tasks = [self loadData];
    }
    return self;
}

- (NSArray *)loadData {
    NSDate *fromDate = [NSDate date];
    fromDate = [fromDate dateByAddingDays:-7];
    NSDate *toDate = [NSDate date];

    NSArray *statistics = [TaskStatisticsProvider statisticsFromDate:fromDate toDate:toDate];
    return statistics;


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statisticsView"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    StatisticsView *statisticsView = [[StatisticsView alloc] initWithTaskStatistics:_tasks[(NSUInteger) indexPath.row]];
    [cell.contentView addSubview:statisticsView];

    [statisticsView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];

    return cell;
}

@end