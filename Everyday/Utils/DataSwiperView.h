//
// Created by Eluss on 06/06/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DataSwiperDelegate

@required
- (void)didMoveToPreviousDate;
- (void)didMoveToNextDate;

@end

@interface DataSwiperView : UIView

@property (nonatomic, strong) NSDate *swiperDate;
@property (nonatomic, weak) id <DataSwiperDelegate> delegate;

- (instancetype)initWithDate:(NSDate *)date;

- (void)markIfCurrentDate;

- (void)updateDate:(NSDate *)date;
@end