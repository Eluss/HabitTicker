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
}

- (instancetype)initWithDataSource:(id <TasksTableViewDataSourceProtocol>)dataSource date:(NSDate *)date {
    self = [super init];
    if (self) {
        _tableViewDataSource = dataSource;
        _tableViewDataSource.tableView = self;
        self.rowHeight = 60;

        [self setupView];
    }

    return self;
}



- (void)setupView {
    [self registerClass:[MCSwipeTableViewCell class] forCellReuseIdentifier:@"taskCell"];
    self.delegate = self;
    self.dataSource = _tableViewDataSource;

    @weakify(self);
    MCSwipeCompletionBlock cellDeletionBlock = ^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        [self deleteCell:cell];
        [self->_tableViewDataSource saveArray];
        [self->_tableViewDataSource showMessageIfDateHasNoRecordedData];
    };

    _tableViewDataSource.deletionBlock = cellDeletionBlock;
    [_tableViewDataSource showMessageIfDateHasNoRecordedData];
    [self addSwipeGestures];
}

- (void)deleteCell:(MCSwipeTableViewCell *)cell {
    [self beginUpdates];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    [_tableViewDataSource removeDataAtIndexPath:indexPath];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < -50 && [_tableViewDataSource isShowingCells]) {
        [self showTextFieldAlert];
    }
}

- (void)showTextFieldAlert {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"New task" message:@"name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
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
        [_tableViewDataSource showMessageIfDateHasNoRecordedData];
    }
}

- (void)updateTasksForDate:(NSDate *)date {
    [_tableViewDataSource updateTasksDataForDate:date];
    [_tableViewDataSource showMessageIfDateHasNoRecordedData];
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)addSwipeGestures {
    UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextDate)];
    swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeGestureRecognizerLeft];

    UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousDate)];
    swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeGestureRecognizerRight];


}

- (void)previousDate {
    [self.swiperDelegate didMoveToPreviousDate];
}

- (void)nextDate {
    [self.swiperDelegate didMoveToNextDate];

}
@end