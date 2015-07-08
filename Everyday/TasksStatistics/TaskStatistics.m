//
// Created by Eliasz Sawicki on 09/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "TaskStatistics.h"


@implementation TaskStatistics {

}

- (instancetype)initWithName:(NSString *)name doneCounter:(NSInteger)doneCounter notDoneCounter:(NSInteger)notDoneCounter {
    self = [super init];
    if (self) {
        self.name = name;
        self.doneCounter=doneCounter;
        self.notDoneCounter=notDoneCounter;
    }

    return self;
}

+ (instancetype)statisticsWithName:(NSString *)name doneCounter:(NSInteger)doneCounter notDoneCounter:(NSInteger)notDoneCounter {
    return [[self alloc] initWithName:name doneCounter:doneCounter notDoneCounter:notDoneCounter];
}

@end