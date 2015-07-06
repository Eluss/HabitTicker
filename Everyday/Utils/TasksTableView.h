//
// Created by Eliasz Sawicki on 05/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TasksDataSource.h"

@protocol TasksTableViewDataSourceProtocol;

@interface TasksTableView : UITableView <UITableViewDelegate>

- (instancetype)initWithDataSource:(id <TasksTableViewDataSourceProtocol>)dataSource date:(NSDate *)date;

@property(nonatomic, strong) TasksTableView *tableView;

- (void)showTextFieldAlert;

- (void)updateTasksForDate:(NSDate *)date;
@end