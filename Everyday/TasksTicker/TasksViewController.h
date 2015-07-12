//
//  TasksViewController.h
//  Everyday
//
//  Created by Eluss on 04/06/15.
//  Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DataSwiperView.h"
#import "TasksTableView.h"


@protocol TasksViewControllerDelegate

@required
- (void)previousTasksList;
- (void)nextTasksList;

@end

@interface TasksViewController : UIViewController <UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, DataSwiperDelegate, TasksTableViewDelegate>

@property (nonatomic, weak) id <TasksViewControllerDelegate> delegate;

- (instancetype)initWithDate:(NSDate *)date;

- (void)tasksForDate:(NSDate *)date;

- (void)markSwiperIfCurrentDate;

@end
