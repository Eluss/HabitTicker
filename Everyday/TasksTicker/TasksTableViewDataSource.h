//
// Created by Eluss on 04/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MCSwipeTableViewCell/MCSwipeTableViewCell.h>
#import "UIKit/UIKit.h"
#import "MCSwipeTableViewCell.h"
#import "TasksTableViewDataSourceProtocol.h"

@interface TasksTableViewDataSource : NSObject <TasksTableViewDataSourceProtocol>

@property(nonatomic, copy) MCSwipeCompletionBlock deletionBlock;

@property(nonatomic, strong) TasksTableView *tableView;

- (id)initWithDate:(NSDate *)date;
@end