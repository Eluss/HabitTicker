//
// Created by Eluss on 06/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksOrganizerTableViewDataSource.h"
#import "TasksDataSource.h"
#import "Task.h"
#import "AppDelegate.h"
#import "TasksTableView.h"
#import "FileChecker.h"
#import "TasksSaver.h"
#import "Fonts.h"
#import "UIColor+Additions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <PureLayout/PureLayoutDefines.h>
#import <PureLayout/ALView+PureLayout.h>


@implementation TasksOrganizerTableViewDataSource {
    RACDisposable *_tasksSubscription;
    TasksDataSource *_tasksDataSource;
    NSArray *_dataArray;
    BOOL _hasNoFileForData;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataArray = [NSArray new];
        _tasksDataSource = [TasksDataSource new];
    }

    return self;
}


- (void)updateTasksDataForDate:(NSDate *)date {
    @weakify(self);
    [_tasksSubscription dispose];
    _tasksSubscription = [[_tasksDataSource defaultTasks] subscribeNext:^(NSArray *tasks) {
        @strongify(self);
        self->_dataArray = tasks;
    }];
}

- (void)saveArray {
    [TasksSaver saveDefaultTasks:_dataArray];
}

- (void)removeDataAtIndexPath:(NSIndexPath *)path {
    NSMutableArray *array = [_dataArray mutableCopy];
    [array removeObjectAtIndex:(NSUInteger) path.row];
    _dataArray = array;
}

- (void)hideAllCells {
    _hasNoFileForData = YES;
}

- (void)showAllCells {
    _hasNoFileForData = NO;
}

- (BOOL)isShowingCells {
    return !_hasNoFileForData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_hasNoFileForData) {
        return 0;
    } else {
        return [_dataArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"taskCell";
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    CGFloat height = 60;
    UIView *rightSwipeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, height)];
    rightSwipeView.backgroundColor = [UIColor everydayRedColor];

    Task *cellTask = _dataArray[(NSUInteger) indexPath.row];

    cell.textLabel.text = cellTask.name;
    cell.textLabel.font = [Fonts cellFont];

    @weakify(self);
    UIColor *deletionColor = [UIColor everydayRedColor];
    [cell setSwipeGestureWithView:rightSwipeView color:deletionColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        self->_deletionBlock(cell, state, mode);
    }];

    return cell;
}

- (UIView *)showMessageOnTableView {
    UIView *messageView = [UIView new];
    UILabel *messageLabel = [UILabel new];

    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.numberOfLines = 0;
    messageLabel.font = [Fonts headerFont];

    messageLabel.text = @"Pull to add new tasks to defaults";
    [messageView addSubview:messageLabel];

    [messageLabel autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];

    return messageView;
}

- (void)showMessageIfDateHasNoRecordedData {
    BOOL fileExists = [FileChecker fileForDefaultTasksExists];
    [self updateTasksDataForDate:nil];
    if (!fileExists || [self noTasksToPresent]) {
        self.tableView.backgroundView = [self showMessageOnTableView];
        [self.tableView reloadData];
    } else {
        self.tableView.backgroundView = nil;
        [self showAllCells];
        [self updateTasksDataForDate:nil];
        [self.tableView reloadData];
    }
}

- (void)addCustomRowWithName:(NSString *)name {
    NSMutableArray *array = [_dataArray mutableCopy];
    if (!array) {
        array = [NSMutableArray new];
    }
    Task *task = [[Task alloc] initWithName:name isDone:NO];
    [array insertObject:task atIndex:0];
    _dataArray = array;
}

- (BOOL)noTasksToPresent {
    return [_dataArray count] == 0;
}

@end