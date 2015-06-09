//
// Created by Eluss on 09/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;


@interface TasksDataSource : NSObject

- (RACSignal *)tasksForDate:(NSDate *)date;

@end