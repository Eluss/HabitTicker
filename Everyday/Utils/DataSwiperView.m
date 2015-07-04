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


    UILabel *_dataLabel;
}

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _swiperDate = date;
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

    _dataLabel = [UILabel new];
    [self addSubview:_dataLabel];
    _dataLabel.textAlignment = NSTextAlignmentCenter;

    [_dataLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:leftButton];
    [_dataLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:rightbutton];
    [_dataLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];

    if (self.swiperDate == nil) {
        self.swiperDate = [NSDate new];
    }

    [self setupLabelDate];
    [self addSwipeGestures];
}

- (void)setupLabelDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    _dataLabel.text = [dateFormatter stringFromDate:self.swiperDate];
}

- (void)addSwipeGestures {
    UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextDate)];
    swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeGestureRecognizerLeft];

    UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousDate)];
    swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeGestureRecognizerRight];


}

- (void)nextDate {
    self.swiperDate = [self.swiperDate dateByAddingDays:1];
    [self.delegate didMoveToNextDate];
}

- (void)previousDate {
    self.swiperDate = [self.swiperDate dateByAddingDays:-1];
    [self.delegate didMoveToPreviousDate];
}


- (void)updateDate:(NSDate *)date {
    self.swiperDate = date;
    [self setupLabelDate];
}
@end