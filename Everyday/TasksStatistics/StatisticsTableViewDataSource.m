//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <DateTools/NSDate+DateTools.h>
#import "StatisticsTableViewDataSource.h"
#import "TasksLoader.h"
#import "Task.h"
#import "TaskStatistics.h"


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
    fromDate = [fromDate dateByAddingDays:-3];
    NSDate *toDate = [NSDate date];

    NSMutableArray *tasksDaysArray = [NSMutableArray new];
    while (fromDate.day <= toDate.day) {
        NSArray *tasks = [TasksLoader loadTasksForDate:fromDate];
        if (tasks != nil) {
            [tasksDaysArray addObject:tasks];
        }
        fromDate = [fromDate dateByAddingDays:1];
    }

    NSMutableDictionary *doneDictionary = [NSMutableDictionary new];
    NSMutableDictionary *notDoneDictionary = [NSMutableDictionary new];
    for (NSArray *array in tasksDaysArray) {
        for (Task *task in array) {
            if (task.isDone) {
                NSNumber *taskCount = doneDictionary[task.name];
                doneDictionary[task.name] = @(taskCount.integerValue + 1);
            } else {
                NSNumber *taskCount = notDoneDictionary[task.name];
                notDoneDictionary[task.name] = @(taskCount.integerValue + 1);
            }
        }
    }
    NSArray *doneKeys = [NSArray new];
    NSArray *notDoneKeys = [NSArray new];
    doneKeys = [doneDictionary allKeys];
    notDoneKeys = [notDoneDictionary allKeys];

    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSString *key in doneKeys) {
        NSInteger doneCount = [doneDictionary[key] integerValue];
        NSInteger notDoneCount = [notDoneDictionary[key] integerValue];

        TaskStatistics *taskStatistics = [TaskStatistics statisticsWithName:key doneCounter:doneCount notDoneCounter:notDoneCount];
        [resultArray addObject:taskStatistics];
    }

    for (NSString *key in notDoneKeys) {
        if (![doneKeys containsObject:key]) {
            NSInteger doneCount = [doneDictionary[key] integerValue];
            NSInteger notDoneCount = [notDoneDictionary[key] integerValue];

            TaskStatistics *taskStatistics = [TaskStatistics statisticsWithName:key doneCounter:doneCount notDoneCounter:notDoneCount];
            [resultArray addObject:taskStatistics];
        }
    }

    return resultArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"taskCell"];

    TaskStatistics *task = _tasks[(NSUInteger) indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  ---- > done: %d notdone:%d", task.name, task.doneCounter, task.notDoneCounter];

    return cell;
}

@end