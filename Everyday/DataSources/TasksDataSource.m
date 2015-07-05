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
//    NSLog(@"loading for date %@", key);
    if ([rootObject valueForKey:key]) {
        array = [rootObject valueForKey:key];
    }
    if ([array count] == 0) {
        return [self loadDefaultTasks];
    } else {
        return array;
    }
}

- (RACSignal *)defaultTasks {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSArray *tasks = [self loadDefaultTasks];
        [subscriber sendNext:tasks];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (NSArray *)loadDefaultTasks {

    NSString *key = @"defaultTasks";
    NSString *path = @"~/Documents/";

    path = [path stringByAppendingString:key];
    path = [path stringByExpandingTildeInPath];

    NSMutableDictionary *rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    NSArray *array;
    if ([rootObject valueForKey:key]) {
        array = [rootObject valueForKey:key];
    }
    if ([array count] == 0) {
        return [NSArray new];
    } else {
        return array;
    }
}
@end