//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TasksSaver : NSObject
+ (void)saveTasks:(NSArray *)tasks ForDate:(NSDate *)date;

+ (void)saveDefaultTasks:(NSArray *)tasks;
@end