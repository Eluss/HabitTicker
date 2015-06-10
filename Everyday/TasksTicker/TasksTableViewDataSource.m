//
// Created by Eluss on 04/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksTableViewDataSource.h"
#import "MCSwipeTableViewCell.h"
#import "RACEXTScope.h"
#import "TasksDataSource.h"
#import "RACSignal.h"
#import "RACDisposable.h"
#import "Task.h"

@implementation TasksTableViewDataSource {

    NSArray *_dataArray;
    RACDisposable *_tasksSubscription;
    TasksDataSource *_fakeTasksDataSource;
    NSDate *_tasksDate;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _fakeTasksDataSource = [TasksDataSource new];
        [self updateTasksDataForDate:nil];
    }

    return self;
}

- (void)updateTasksDataForDate:(NSDate *)date {
    @weakify(self);
    [_tasksSubscription dispose];
    _tasksSubscription = [[_fakeTasksDataSource tasksForDate:date] subscribeNext:^(NSArray *tasks) {
        @strongify(self);
        self->_tasksDate = date;
        self->_dataArray = tasks;
    }];
}

- (id)initWithDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _tasksDate = date;
        _fakeTasksDataSource = [TasksDataSource new];
        [self updateTasksDataForDate:date];
    }

    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"taskCell";
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.contentView.backgroundColor = [UIColor whiteColor];

    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    blueView.backgroundColor = [UIColor blueColor];

    Task *cellTask = _dataArray[(NSUInteger) indexPath.row];
    cell.textLabel.text = cellTask.name;

    UIColor *color = [UIColor greenColor];
    @weakify(self);
    [cell setSwipeGestureWithView:blueView color:color mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        [cellTask changeState];
        [self updateCell:cell forTask:cellTask];
    }];

    [self updateCell:cell forTask:cellTask];

    return cell;
}

- (void)updateCell:(MCSwipeTableViewCell *)cell forTask:(Task *)task {
    if (task.isDone) {
        cell.contentView.backgroundColor = [UIColor greenColor];
        cell.textLabel.textColor = [UIColor grayColor];
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }

    [self saveArray];
}

- (void)dealloc {
    [_tasksSubscription dispose];
}

- (void)saveArray {
    NSString *path = @"~/Documents/data";
    path = [path stringByExpandingTildeInPath];

    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    NSString *key = [dateFormatter stringFromDate:_tasksDate];

    NSMutableDictionary *rootObject = [self loadRootDictionary];
    NSLog(@"saving for date %@", key);
    [rootObject setValue:_dataArray forKey:key];


    [NSKeyedArchiver archiveRootObject:rootObject toFile:path];
}

- (NSMutableDictionary *)loadRootDictionary {
    NSString *path = @"~/Documents/data";
    path = [path stringByExpandingTildeInPath];
    NSMutableDictionary *rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return rootObject;
}

@end