//
// Created by Eliasz Sawicki on 05/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCSwipeTableViewCell.h"

@class TasksTableView;

@protocol TasksTableViewDataSourceProtocol <UITableViewDataSource>

@property(nonatomic, copy) MCSwipeCompletionBlock deletionBlock;

@property(nonatomic, strong) TasksTableView *tableView;

- (void)updateTasksDataForDate:(NSDate *)date;

- (void)saveArray;

- (void)addCustomRowWithName:(NSString *)name;

- (void)removeDataAtIndexPath:(NSIndexPath *)path;

- (void)hideAllCells;

- (void)showAllCells;

- (BOOL)isShowingCells;

- (UIView *)showMessageOnTableView;

- (void)showMessageIfDateHasNoRecordedData;

@end