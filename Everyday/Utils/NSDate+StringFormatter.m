//
// Created by Eliasz Sawicki on 08/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "NSDate+StringFormatter.h"


@implementation NSDate (StringFormatter)
- (NSString *)sringWithddMMYYYYFormat {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    NSString *key = [dateFormatter stringFromDate:self];

    return key;
}

@end