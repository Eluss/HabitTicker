//
// Created by Eliasz Sawicki on 09/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TaskStatistics : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic) NSInteger doneCounter;

@property (nonatomic) NSInteger notDoneCounter;

- (instancetype)initWithName:(NSString *)name doneCounter:(NSInteger)doneCounter notDoneCounter:(NSInteger)notDoneCounter;

+ (instancetype)statisticsWithName:(NSString *)name doneCounter:(NSInteger)doneCounter notDoneCounter:(NSInteger)notDoneCounter;


@end