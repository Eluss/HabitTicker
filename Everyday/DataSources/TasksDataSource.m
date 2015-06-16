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
        NSArray *tasks = [self loadDataFromDiskForDate:date];
        [subscriber sendNext:tasks];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (NSArray *)loadDataFromDiskForDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    NSString *key = [dateFormatter stringFromDate:date];

    NSString *path = @"~/Documents/";
    path = [path stringByAppendingString:key];
    path = [path stringByExpandingTildeInPath];

    NSMutableDictionary *rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    NSArray *array;
    NSLog(@"loading for date %@", key);
    if ([rootObject valueForKey:key]) {
        array = [rootObject valueForKey:key];
    }
    if ([array count] == 0) {
        return [self createTasks];
    } else {
        return array;
    }
}

- (NSArray *)createTasks {
//    NSMutableArray *array = [NSMutableArray new];
//    for (NSInteger i = 0; i < 20; i++) {
//        NSString *string = [NSString stringWithFormat:@"Object nr %d", i];
//        Task *homeworkTask = [[Task alloc] initWithName:string isDone:NO];
//        [array addObject:homeworkTask];
//    }
//    return array;

    Task *homeworkTask = [[Task alloc] initWithName:@"Homework" isDone:NO];
    Task *pianoTask = [[Task alloc] initWithName:@"Piano Lesson" isDone:YES];
    return @[homeworkTask, pianoTask];
}

@end