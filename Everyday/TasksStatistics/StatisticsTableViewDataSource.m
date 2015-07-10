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

    return [self statisticsFromDate:fromDate toDate:toDate];


}

- (NSArray *)statisticsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSMutableArray *tasksDaysArray = [self tasksFromDate:fromDate toDate:toDate];

    NSMutableDictionary *notDoneDictionary = [self notDoneDictionaryFromTasks:tasksDaysArray];
    NSMutableDictionary *doneDictionary = [self doneDictionaryFromTasks:tasksDaysArray];

    NSMutableArray *resultArray = [self tasksStatisticsWithNotDoneDictionary:notDoneDictionary doneDictionary:doneDictionary];

    return resultArray;
}

- (NSMutableArray *)tasksStatisticsWithNotDoneDictionary:(NSMutableDictionary *)notDoneDictionary doneDictionary:(NSMutableDictionary *)doneDictionary {
    NSArray *doneKeys = [doneDictionary allKeys];
    NSArray *notDoneKeys = [notDoneDictionary allKeys];

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

- (NSMutableDictionary *)notDoneDictionaryFromTasks:(NSMutableArray *)tasksDaysArray {
    NSMutableDictionary *notDoneDictionary = [NSMutableDictionary new];
    for (NSArray *array in tasksDaysArray) {
        for (Task *task in array) {
            if (task.isDone) {
                NSNumber *taskCount = notDoneDictionary[task.name];
                notDoneDictionary[task.name] = @(taskCount.integerValue + 1);
            }
        }
    }
    return notDoneDictionary;
}

- (NSMutableDictionary *)doneDictionaryFromTasks:(NSMutableArray *)tasksDaysArray {
    NSMutableDictionary *doneDictionary = [NSMutableDictionary new];
    for (NSArray *array in tasksDaysArray) {
        for (Task *task in array) {
            if (task.isDone) {
                NSNumber *taskCount = doneDictionary[task.name];
                doneDictionary[task.name] = @(taskCount.integerValue + 1);
            }
        }
    }
    return doneDictionary;
}

- (NSMutableArray *)tasksFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSMutableArray *tasksDaysArray = [NSMutableArray new];
    while (fromDate.day <= toDate.day) {
        NSArray *tasks = [TasksLoader loadTasksForDate:fromDate];
        if (tasks != nil) {
            [tasksDaysArray addObject:tasks];
        }
        fromDate = [fromDate dateByAddingDays:1];
    }
    return tasksDaysArray;
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