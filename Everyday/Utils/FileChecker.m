//
// Created by Eluss on 18/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "FileChecker.h"


@implementation FileChecker {

}
+ (BOOL)fileExistsForDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    NSString *key = [dateFormatter stringFromDate:date];

    NSString *path = @"~/Documents/";
    path = [path stringByAppendingString:key];
    path = [path stringByExpandingTildeInPath];

    NSFileManager *fileManager = [NSFileManager new];
    BOOL exists = [fileManager fileExistsAtPath:path];
    return exists;
}

+ (BOOL)fileForDefaultTasksExists {

    NSString *key = @"defaultTasks";
    NSString *path = @"~/Documents/";
    path = [path stringByAppendingString:key];
    path = [path stringByExpandingTildeInPath];

    NSFileManager *fileManager = [NSFileManager new];
    BOOL exists = [fileManager fileExistsAtPath:path];
    return exists;
}

@end