//
// Created by Eluss on 09/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Task : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic) BOOL isDone;

- (instancetype)initWithName:(NSString *)name isDone:(BOOL)isDone;

- (void)changeState;

@end