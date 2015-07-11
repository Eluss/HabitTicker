//
// Created by Eluss on 06/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "DataSwiperView.h"
#import "NSDate+DateTools.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "AppDelegate.h"
#import "Fonts.h"
#import "UIColor+Additions.h"


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

    self.backgroundColor = [UIColor headerColor];
    UIButton *leftButton = [UIButton new];
    UIImage *previousImage = [UIImage imageNamed:@"Previous"];
    [leftButton setImage:previousImage forState:UIControlStateNormal];
    [self addSubview:leftButton];
    [leftButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [leftButton autoSetDimension:ALDimensionWidth toSize:50];
    [leftButton addTarget:self action:@selector(previousDate) forControlEvents:UIControlEventTouchUpInside];

    UIButton *rightButton = [UIButton new];
    UIImage *nextImage = [UIImage imageNamed:@"Next"];
    [rightButton setImage:nextImage forState:UIControlStateNormal];
    [self addSubview:rightButton];
    [rightButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [rightButton autoSetDimension:ALDimensionWidth toSize:50];
    [rightButton addTarget:self action:@selector(nextDate) forControlEvents:UIControlEventTouchUpInside];

    _dataLabel = [UILabel new];
    [self addSubview:_dataLabel];
    _dataLabel.textAlignment = NSTextAlignmentCenter;
    _dataLabel.font = [Fonts headerFont];

    [_dataLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:leftButton];
    [_dataLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:rightButton];
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