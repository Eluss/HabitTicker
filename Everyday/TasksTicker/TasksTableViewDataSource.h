//
// Created by Eluss on 04/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MCSwipeTableViewCell/MCSwipeTableViewCell.h>
#import "UIKit/UIKit.h"
#import "MCSwipeTableViewCell.h"

@interface TasksTableViewDataSource : NSObject <UITableViewDataSource>
@property(nonatomic, copy) MCSwipeCompletionBlock deletionBlock;

- (void)updateTasksDataForCurrentDate;

- (void)updateTasksDataForDate:(NSDate *)date;

- (id)initWithDate:(NSDate *)date;

- (void)saveArray;

- (void)addCustomRowWithName:(NSString *)name;


- (void)removeDataAtIndexPath:(NSIndexPath *)path;

- (void)hideAllCells;

- (void)showAllCells;

- (BOOL)isShowingCells;
@end