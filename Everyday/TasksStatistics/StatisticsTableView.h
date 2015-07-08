//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class StatisticsTableViewDataSource;


@interface StatisticsTableView : UITableView
- (instancetype)initWithDataSource:(StatisticsTableViewDataSource *)source;
@end