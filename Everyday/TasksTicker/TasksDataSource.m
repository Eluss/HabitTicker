//
// Created by Eluss on 04/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TasksDataSource.h"


@implementation TasksDataSource {

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
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    tableViewCell.textLabel.text = _dataArray[(NSUInteger) indexPath.row];


    return tableViewCell;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [_dataArray removeObjectAtIndex:indexPath.row];
    [tableView endUpdates];
}


@end