//
// Created by Eluss on 06/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TasksTableViewDataSourceProtocol.h"

@interface TasksOrganizerTableViewDataSource : NSObject <TasksTableViewDataSourceProtocol>

@property(nonatomic, copy) MCSwipeCompletionBlock deletionBlock;

@end