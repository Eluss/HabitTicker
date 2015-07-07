//
// Created by Eluss on 09/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksDataSource.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "Task.h"
#import "NSDate+StringFormatter.h"
#import "TasksLoader.h"


@implementation TasksDataSource {

}
- (RACSignal *)tasksForDate:(NSDate *)date {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSArray *tasksArray = [TasksLoader loadTasksForDate:date];
        if ([tasksArray count] == 0) {
            tasksArray = [TasksLoader loadDefaultTasks];
        }
        [subscriber sendNext:tasksArray];
        [subscriber sendCompleted];
        return nil;
    }];
}


- (RACSignal *)defaultTasks {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSArray *tasks = [TasksLoader loadDefaultTasks];
        [subscriber sendNext:tasks];
        [subscriber sendCompleted];
        return nil;
    }];
}

@end