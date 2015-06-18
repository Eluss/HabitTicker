//
//  TasksViewController.m
//  Everyday
//
//  Created by Eluss on 04/06/15.
//  Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//


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
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor redColor];
    _tasksTableView = [UITableView new];
    [_tasksTableView registerClass:[MCSwipeTableViewCell class] forCellReuseIdentifier:@"taskCell"];
    [self.view addSubview:_tasksTableView];


    _dataSwiperView = [DataSwiperView new];
    @weakify(self);
    [RACObserve(_dataSwiperView, swiperDate) subscribeNext:^(NSDate *date) {
        @strongify(self);
        BOOL fileExists = [FileChecker fileExistsForDate:date];
        if (fileExists) {
            _tasksTableView.backgroundView = nil;
            [self->_source showAllCells];
            [self->_source updateTasksDataForDate:date];
            [_tasksTableView reloadData];
        } else {
            [self showMessageOnTableView];
            [self->_source hideAllCells];
            [_tasksTableView reloadData];
        }
    }];
    [self.view addSubview:_dataSwiperView];

    _tasksTableView.delegate = self;
    _source = [[TasksTableViewDataSource alloc] initWithDate:_dataSwiperView.swiperDate];
    _tasksTableView.dataSource = _source;
    _tasksTableView.backgroundColor = UIColorFromRGB(0xC9F6FF);
    _tasksTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    MCSwipeCompletionBlock block = ^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        [self deleteCell:cell];
        [self->_source saveArray];
    };

    _source.deletionBlock = block;

    [_tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [_tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_dataSwiperView];

    [_dataSwiperView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [_dataSwiperView autoSetDimension:ALDimensionHeight toSize:100];
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


@end