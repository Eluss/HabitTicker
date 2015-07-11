//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "StatisticsTableView.h"
#import "StatisticsTableViewDataSource.h"


@implementation StatisticsTableView {

    StatisticsTableViewDataSource *_dataSource;
}
- (instancetype)initWithDataSource:(StatisticsTableViewDataSource *)source {
    self = [super init];
    if (self) {
        _dataSource = source;
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.dataSource = _dataSource;
    self.delegate = self;
    self.rowHeight = 60;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
@end