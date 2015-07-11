//
// Created by Eliasz Sawicki on 05/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TasksDataSource.h"

@protocol TasksTableViewDataSourceProtocol;

@protocol TasksTableViewDelegate

@required
- (void)didMoveToPreviousDate;

- (void)didMoveToNextDate;

@end

@interface TasksTableView : UITableView <UITableViewDelegate>

- (instancetype)initWithDataSource:(id <TasksTableViewDataSourceProtocol>)dataSource date:(NSDate *)date;

@property(nonatomic, weak) id <TasksTableViewDelegate> swiperDelegate;

- (void)showTextFieldAlert;

- (void)updateTasksForDate:(NSDate *)date;
@end