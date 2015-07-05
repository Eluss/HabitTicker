//
// Created by Eliasz Sawicki on 05/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <MCSwipeTableViewCell/MCSwipeTableViewCell.h>
#import "TasksTableView.h"
#import "FileChecker.h"
#import "RACEXTScope.h"
#import "TasksTableViewDataSourceProtocol.h"
#import "RACSignal.h"
#import <PureLayout/PureLayout.h>
#import <ReactiveCocoa/UIAlertView+RACSignalSupport.h>

@implementation TasksTableView {
    id <TasksTableViewDataSourceProtocol> _tableViewDataSource;
    NSDate *_tasksDate;
}

- (instancetype)initWithDataSource:(id <TasksTableViewDataSourceProtocol>)dataSource date:(NSDate *)date {
    self = [super init];
    if (self) {
        _tableViewDataSource = dataSource;
        _tasksDate = date;
        
        [self setupView];
    }

    return self;
}

- (void)setupView {
    [self registerClass:[MCSwipeTableViewCell class] forCellReuseIdentifier:@"taskCell"];
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataSource = _tableViewDataSource;

    @weakify(self);
    MCSwipeCompletionBlock cellDeletionBlock = ^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        [self deleteCell:cell];
        [self->_tableViewDataSource saveArray];
    };

    _tableViewDataSource.deletionBlock = cellDeletionBlock;

    [self showMessageIfDateHasNoRecordedData];
}

- (void)deleteCell:(MCSwipeTableViewCell *)cell {
    [self beginUpdates];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    [_tableViewDataSource removeDataAtIndexPath:indexPath];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
}

- (void)showMessageIfDateHasNoRecordedData {
    BOOL fileExists = [FileChecker fileExistsForDate:_tasksDate];
    if (fileExists) {
        self.backgroundView = nil;
        [_tableViewDataSource showAllCells];
        [_tableViewDataSource updateTasksDataForDate:_tasksDate];
        [self reloadData];
    } else {
        [self showMessageOnTableView];
        [_tableViewDataSource hideAllCells];
        [self reloadData];
    }
}

- (void)showMessageOnTableView {
    UIView *messageView = [UIView new];
    UILabel *messageLabel = [UILabel new];

    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.numberOfLines = 0;

    messageLabel.text = @"tap the screen to add this day to statistics";
    [messageView addSubview:messageLabel];

    [messageLabel autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTableViewBackground)];
    [messageView addGestureRecognizer:gestureRecognizer];

    self.backgroundView = messageView;

}

- (void)didTapTableViewBackground {
    if (![_tableViewDataSource isShowingCells]) {
        self.backgroundView = nil;
        [_tableViewDataSource showAllCells];
        [_tableViewDataSource updateTasksDataForDate:_tasksDate];
        [self reloadData];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < -50 && [_tableViewDataSource isShowingCells]) {
        [self showTextFieldAlert];
    }
}

- (void)showTextFieldAlert {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"New task" message:@"Add task" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av textFieldAtIndex:0].delegate = self;
    [av show];
    @weakify(self);
    [[av rac_buttonClickedSignal] subscribeNext:^(NSNumber *buttonIndex) {
        @strongify(self);
        if (buttonIndex.integerValue == 1) {
            NSString *taskName = [av textFieldAtIndex:0].text;
            [self updateTableWithTaskName:taskName];
        }
    }];
}

- (void)updateTableWithTaskName:(NSString *)task {
    if (![task isEqualToString:@""]) {
        [self beginUpdates];

        [_tableViewDataSource addCustomRowWithName:task];
        NSArray *paths = @[[NSIndexPath indexPathForRow:0 inSection:0]];
        [self insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];

        [self endUpdates];
        [_tableViewDataSource saveArray];
    }
}

- (void)updateTasksForDate:(NSDate *)date {
    _tasksDate = date;
    [_tableViewDataSource updateTasksDataForDate:date];
    [self showMessageIfDateHasNoRecordedData];
    [self reloadData];
}
@end