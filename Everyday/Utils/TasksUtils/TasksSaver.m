//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksSaver.h"
#import "TasksLoader.h"
#import "NSDate+StringFormatter.h"

#define DEFAULT_TASKS_KEY @"defaultTasks"

@implementation TasksSaver {

}

+ (void)saveTasks:(NSArray *)tasks ForDate:(NSDate *)date {
    NSString *key = [date sringWithddMMYYYYFormat];

    NSString *path = @"~/Documents/";
    path = [path stringByAppendingString:key];
    path = [path stringByExpandingTildeInPath];

    NSMutableDictionary *rootObject = [TasksLoader loadRootDictForTasksForDate:date];
    [rootObject setValue:tasks forKey:key];

    if ([tasks count] == 0) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    } else {
        [NSKeyedArchiver archiveRootObject:rootObject toFile:path];
    }
}

+ (void)saveDefaultTasks:(NSArray *)tasks {
    NSString *path = @"~/Documents/";

    path = [path stringByAppendingString:DEFAULT_TASKS_KEY];
    path = [path stringByExpandingTildeInPath];

    NSMutableDictionary *rootObject = [TasksLoader loadRootDictForDefaultTasks];
    [rootObject setValue:tasks forKey:DEFAULT_TASKS_KEY];


    [NSKeyedArchiver archiveRootObject:rootObject toFile:path];
}
@end