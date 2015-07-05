//
// Created by Eliasz Sawicki on 05/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCSwipeTableViewCell.h"

@protocol TasksTableViewDataSourceProtocol <UITableViewDataSource>

@property(nonatomic, copy) MCSwipeCompletionBlock deletionBlock;

- (void)updateTasksDataForDate:(NSDate *)date;

- (void)saveArray;

- (void)addCustomRowWithName:(NSString *)name;

- (void)removeDataAtIndexPath:(NSIndexPath *)path;

- (void)hideAllCells;

- (void)showAllCells;

- (BOOL)isShowingCells;


@end