//
// Created by Eluss on 06/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksOrganizerTableViewDataSource.h"
#import "MCSwipeTableViewCell.h"
#import "TasksDataSource.h"
#import "Task.h"
#import "AppDelegate.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation TasksOrganizerTableViewDataSource {
    RACDisposable *_tasksSubscription;
    TasksDataSource *_tasksDataSource;
    NSArray *_dataArray;
    BOOL _hasNoFileForData;
}

- (instancetype)init {
    self = [super init];
    if (self) {
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
    NSString *key = @"defaultTasks";
    NSString *path = @"~/Documents/";

    path = [path stringByAppendingString:key];
    path = [path stringByExpandingTildeInPath];


    NSMutableDictionary *rootObject = [self loadRootDictionary];
    [rootObject setValue:_dataArray forKey:key];


    [NSKeyedArchiver archiveRootObject:rootObject toFile:path];
}

- (NSMutableDictionary *)loadRootDictionary {
    NSString *key = @"defaultTasks";
    NSString *path = @"~/Documents/";

    path = [path stringByAppendingString:key];
    path = [path stringByExpandingTildeInPath];

    NSMutableDictionary *rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (rootObject == nil) {
        return [NSMutableDictionary dictionary];
    }
    return rootObject;
}

- (void)addCustomRowWithName:(NSString *)name {
    NSMutableArray *array = [_dataArray mutableCopy];
    Task *task = [[Task alloc] initWithName:name isDone:NO];
    [array insertObject:task atIndex:0];
    _dataArray = array;
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

    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.contentView.backgroundColor = UIColorFromRGB(0xC9F6FF);

    UIView *leftSwipeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    leftSwipeView.backgroundColor = UIColorFromRGB(0x66FF6B);

    UIView *rightSwipeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    rightSwipeView.backgroundColor = UIColorFromRGB(0xFF6666);

    Task *cellTask = _dataArray[(NSUInteger) indexPath.row];

    cell.textLabel.text = cellTask.name;

    @weakify(self);
    UIColor *deletionColor = UIColorFromRGB(0xFF6666);
    [cell setSwipeGestureWithView:rightSwipeView color:deletionColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        self->_deletionBlock(cell, state, mode);
    }];

    return cell;
}

@end