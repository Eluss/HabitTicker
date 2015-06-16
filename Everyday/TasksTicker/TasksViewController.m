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

@implementation TasksViewController {
    TasksTableViewDataSource *_source;
    UITableView *_tasksTableView;
    UIRefreshControl *_refreshView;
    NSString *_taskName;
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


    DataSwiperView *dataSwiperView = [DataSwiperView new];
    @weakify(self);
    [RACObserve(dataSwiperView, swiperDate) subscribeNext:^(NSDate *date) {
        @strongify(self);
        [self->_source updateTasksDataForDate:date];
        [_tasksTableView reloadData];
    }];
    [self.view addSubview:dataSwiperView];

    _tasksTableView.delegate = self;
    _source = [[TasksTableViewDataSource alloc] initWithDate:dataSwiperView.swiperDate];
    _tasksTableView.dataSource = _source;

    MCSwipeCompletionBlock block = ^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        [self deleteCell:cell];
    };

    _source.deletionBlock = block;

    [_tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeTop];
    [_tasksTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:dataSwiperView];

    [dataSwiperView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [dataSwiperView autoSetDimension:ALDimensionHeight toSize:100];
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
    NSLog(@"scroll %f", yOffset);
    if (yOffset < -50) {
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
            }

        }
    }];
}


@end