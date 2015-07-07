//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TasksLoader : NSObject
+ (NSMutableDictionary *)loadRootDictForTasksForDate:(NSDate *)date;

+ (NSArray *)loadTasksForDate:(NSDate *)date;

+ (NSMutableDictionary *)loadRootDictForDefaultTasks;

+ (NSArray *)loadDefaultTasks;
@end