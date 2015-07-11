//
// Created by Eliasz Sawicki on 11/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "UIColor+Additions.h"
#import "AppDelegate.h"


@implementation UIColor (Additions)

+ (UIColor *)headerColor {
    return UIColorFromRGB(0xFFFF00);
}

+ (UIColor *)backgroundColor {
//    return UIColorFromRGB(0x518FB4);
    return [UIColor whiteColor];
}

+ (UIColor *)everydayGreenColor {
    return UIColorFromRGB(0x0CAB5A);
}

+ (UIColor *)everydayRedColor {
    return UIColorFromRGB(0xF34812);
}

@end