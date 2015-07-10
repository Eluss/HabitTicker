//
// Created by Eliasz Sawicki on 10/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TaskStatisticsProvider : NSObject


+ (NSArray *)statisticsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
@end