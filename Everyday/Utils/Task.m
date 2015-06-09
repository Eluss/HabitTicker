//
// Created by Eluss on 09/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "Task.h"


@implementation Task {

}
- (instancetype)initWithName:(NSString *)name isDone:(BOOL)isDone {
    self = [super init];
    if (self) {
        self.name = name;
        self.isDone=isDone;
    }

    return self;
}

- (void)changeState {
    self.isDone = !self.isDone;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.name != nil) {
        [coder encodeObject:self.name forKey:@"name"];
    }
    if (self.isDone != nil) {
        [coder encodeObject:@(self.isDone) forKey:@"isDone"];
    }
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self != nil) {
        self.name = [coder decodeObjectForKey:@"name"];
        NSNumber *isDoneNumber = [coder decodeObjectForKey:@"isDone"];
        self.isDone = [isDoneNumber boolValue];
    }

    return self;
}


@end