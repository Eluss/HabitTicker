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
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _fakeTasksDataSource = [TasksDataSource new];
        [self updateTasksData];
    }

    return self;
}

- (void)updateTasksData {
    @weakify(self);
    _tasksSubscription = [[_fakeTasksDataSource tasksForDate:nil] subscribeNext:^(NSArray *tasks) {
        @strongify(self);
        self->_dataArray = tasks;
    }];
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
}

- (void)dealloc {
    [_tasksSubscription dispose];
}

//- (void)saveArray {
//    if (_dataArray != nil) {
//        [self createDataPath];
//        NSString *dataPath = [@"dataPath" stringByAppendingPathComponent:@"file"];
//        NSMutableData *data = [NSMutableData new];
//        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:_dataArray];
//        [archiver encodeObject:_dataArray forKey:@"Data"];
//        [archiver finishEncoding];
//        [data writeToFile:dataPath atomically:YES];
//    }
//}
//
//- (BOOL)createDataPath {
//
//    NSError *error;
//    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:@"dataPath" withIntermediateDirectories:YES attributes:nil error:&error];
//    if (!success) {
//        NSLog(@"Error creating data path: %@", [error localizedDescription]);
//    }
//    return success;
//
//}

@end