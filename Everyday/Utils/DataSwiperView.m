//
// Created by Eluss on 06/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "DataSwiperView.h"
#import "NSDate+DateTools.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "AppDelegate.h"


@implementation DataSwiperView {


}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }

    return self;
}

- (void)setupView {
    self.backgroundColor = UIColorFromRGB(0x6696FF);
    UIButton *leftButton = [UIButton new];
    [leftButton setTitle:@"<" forState:UIControlStateNormal];
    [self addSubview:leftButton];
    [leftButton autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeRight];
    [leftButton autoSetDimension:ALDimensionWidth toSize:50];
    [leftButton addTarget:self action:@selector(previousDate) forControlEvents:UIControlEventTouchUpInside];

    UIButton *rightbutton = [UIButton new];
    [rightbutton setTitle:@">" forState:UIControlStateNormal];
    [self addSubview:rightbutton];
    [rightbutton autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero excludingEdge:ALEdgeLeft];
    [rightbutton autoSetDimension:ALDimensionWidth toSize:50];
    [rightbutton addTarget:self action:@selector(nextDate) forControlEvents:UIControlEventTouchUpInside];

    UILabel *dataLabel = [UILabel new];
    [self addSubview:dataLabel];
    dataLabel.textAlignment = NSTextAlignmentCenter;

    [dataLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:leftButton];
    [dataLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:rightbutton];
    [dataLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];

    RAC(dataLabel, text) = [RACObserve(self, swiperDate) map:^id(NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];

        return [dateFormatter stringFromDate:date];
    }];

    self.swiperDate = [NSDate new];
}

- (void)nextDate {
    self.swiperDate = [self.swiperDate dateByAddingDays:1];
}

- (void)previousDate {
    self.swiperDate = [self.swiperDate dateByAddingDays:-1];
}


@end