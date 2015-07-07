//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksLoader.h"
#import "NSDate+StringFormatter.h"
#define DEFAULT_TASKS_KEY @"defaultTasks"

@implementation TasksLoader {

}

+ (NSMutableDictionary *)loadRootDictForTasksForDate:(NSDate *)date {
    NSString *key = [date sringWithddMMYYYYFormat];

    NSString *path = @"~/Documents/";
    path = [path stringByAppendingString:key];
    path = [path stringByExpandingTildeInPath];
    NSMutableDictionary *rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (rootObject == nil) {
        return [NSMutableDictionary dictionary];
    }
    return rootObject;
}

+ (NSArray *)loadTasksForDate:(NSDate *)date {
    NSString *key = [date sringWithddMMYYYYFormat];

    NSDictionary *dictionary = [self loadRootDictForTasksForDate:date];
    NSArray *tasks = [dictionary valueForKey:key];

    return tasks;
}

+ (NSMutableDictionary *)loadRootDictForDefaultTasks {
    NSString *path = @"~/Documents/";

    path = [path stringByAppendingString:DEFAULT_TASKS_KEY];
    path = [path stringByExpandingTildeInPath];

    NSMutableDictionary *rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (rootObject == nil) {
        return [NSMutableDictionary dictionary];
    }
    return rootObject;
}

+ (NSArray *)loadDefaultTasks {
    NSDictionary *dictionary = [self loadRootDictForDefaultTasks];
    NSArray *tasks = [dictionary valueForKey:DEFAULT_TASKS_KEY];

    return tasks;
}

@end