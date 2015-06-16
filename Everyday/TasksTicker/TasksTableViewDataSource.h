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

- (void)updateTasksDataForDate:(NSDate *)date;

- (id)initWithDate:(NSDate *)date;

- (void)addCustomRowWithName:(NSString *)name;


- (void)removeDataAtIndexPath:(NSIndexPath *)path;
@end