//
// Created by Eluss on 09/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksDataSource.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "Task.h"


@implementation TasksDataSource {

}
- (RACSignal *)tasksForDate:(NSDate *)date {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSArray *tasks = [self createTasks];
        [subscriber sendNext:tasks];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (NSArray *)createTasks {
    Task *homeworkTask = [[Task alloc] initWithName:@"Homework" isDone:NO];
    Task *pianoTask = [[Task alloc] initWithName:@"Piano Lesson" isDone:YES];
    return @[homeworkTask, pianoTask];
}

@end