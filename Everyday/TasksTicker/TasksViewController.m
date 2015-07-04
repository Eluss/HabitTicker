//
//  TasksViewController.m
//  Everyday
//
//  Created by Eluss on 04/06/15.
//  Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//


#import <DateTools/NSDate+DateTools.h>
#import "TasksViewController.h"
#import "ALView+PureLayout.h"
#import "TasksTableViewDataSource.h"
#import "MCSwipeTableViewCell.h"
#import "DataSwiperView.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSignal.h"
#import "RACEXTScope.h"
#import "UIAlertView+RACSignalSupport.h"
#import "AppDelegate.h"
#import "FileChecker.h"

@implementation TasksViewController {
    TasksTableViewDataSource *_source;
    UITableView *_tasksTableView;
    NSString *_taskName;
    DataSwiperView *_dataSwiperView;
    NSDate *_tasksDate;
}

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _tasksDate = date;
        [self setupView];
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupView {

    _tasksTableView = [UITableView new];
    [_tasksTableView registerClass:[MCSwipeTableViewCell class] forCellReuseIdentifier:@"taskCell"];
    _tasksTableView.delegate = self;
//    _tasksTableView.backgroundColor = UIColorFromRGB(0xC9F6FF);
    _tasksTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tasksTableView];

    _source = [[TasksTableViewDataSource alloc] initWithDate:_tasksDate];
    _tasksTableView.dataSource = _source;

    _dataSwiperView = [[DataSwiperView alloc] initWithDate:_tasksDate];
    _dataSwiperView.delegate = self;
    [self.view addSubview:_dataSwiperView];

    [self showMessageIfDateHasNoRecordedData];


    @weakify(self);
    MCSwipeCompletionBlock cellDeletionBlock = ^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        [self deleteCell:cell];
        [self->_source saveArray];
    };

    _source.deletionBlock = cellDeletionBlock;

    [_tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [_tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_dataSwiperView];

    [_dataSwiperView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [_dataSwiperView autoSetDimension:ALDimensionHeight toSize:100];
}

- (void)showMessageIfDateHasNoRecordedData {
    BOOL fileExists = [FileChecker fileExistsForDate:_tasksDate];
    if (fileExists) {
        _tasksTableView.backgroundView = nil;
        [_source showAllCells];
        [_source updateTasksDataForDate:_tasksDate];
        [_tasksTableView reloadData];
    } else {
        [self showMessageOnTableView];
        [_source hideAllCells];
        [_tasksTableView reloadData];
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

    _tasksTableView.backgroundView = messageView;

}

- (void)didTapTableViewBackground {
    if (![_source isShowingCells]) {
        _tasksTableView.backgroundView = nil;
        [_source showAllCells];
        [_source updateTasksDataForDate:_dataSwiperView.swiperDate];
        [_tasksTableView reloadData];
    }
}

- (void)deleteCell:(MCSwipeTableViewCell *)cell {
    [_tasksTableView beginUpdates];
    NSIndexPath *indexPath = [_tasksTableView indexPathForCell:cell];
    [_source removeDataAtIndexPath:indexPath];
    [_tasksTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [_tasksTableView endUpdates];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < -50 && [_source isShowingCells]) {
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
            self->_taskName = [av textFieldAtIndex:0].text;
            if (![self->_taskName isEqualToString:@""]) {
                [self->_tasksTableView beginUpdates];

                [self->_source addCustomRowWithName:_taskName];
                NSArray *paths = @[[NSIndexPath indexPathForRow:0 inSection:0]];
                [self->_tasksTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];

                [self->_tasksTableView endUpdates];
                [self->_source saveArray];
            }

        }
    }];
}

- (void)didMoveToPreviousDate {
    [self.delegate previousTasksList];
}

- (void)didMoveToNextDate {
    [self.delegate nextTasksList];
}


- (void)tasksForDate:(NSDate *)date {
    _tasksDate = date;
    NSLog(@"Tasks for date: %d", date.day);
    [_dataSwiperView updateDate:date];
    [_source updateTasksDataForDate:date];
    [self showMessageIfDateHasNoRecordedData];
    [self.view layoutIfNeeded];
}

@end