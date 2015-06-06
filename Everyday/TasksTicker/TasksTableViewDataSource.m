//
// Created by Eluss on 04/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksTableViewDataSource.h"
#import "MCSwipeTableViewCell.h"
#import "RACEXTScope.h"

@implementation TasksTableViewDataSource {

    NSMutableArray *_dataArray;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _dataArray = [@[@"item1", @"item2", @"item3", @"item4"] mutableCopy];
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
    cell.textLabel.text = _dataArray[(NSUInteger) indexPath.row];

    UIColor *color = [UIColor greenColor];
    @weakify(self);
    [cell setSwipeGestureWithView:blueView color:color mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        @strongify(self);
        [self updateStateForCell:cell];
    }];

    return cell;
}

- (void)updateStateForCell:(MCSwipeTableViewCell *)cell {
    if (cell.contentView.backgroundColor == [UIColor whiteColor]) {
            cell.contentView.backgroundColor = [UIColor purpleColor];
            cell.textLabel.textColor = [UIColor grayColor];
        } else {
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
}


@end