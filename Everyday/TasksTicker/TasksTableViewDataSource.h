//
// Created by Eluss on 04/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MCSwipeTableViewCell/MCSwipeTableViewCell.h>
#import "UIKit/UIKit.h"
@interface TasksTableViewDataSource : NSObject <UITableViewDataSource>
- (void)updateTasksDataForDate:(NSDate *)date;

- (id)initWithDate:(NSDate *)date;
@end