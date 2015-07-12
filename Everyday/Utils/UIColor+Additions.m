//
// Created by Eliasz Sawicki on 11/07/15.
// Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//

#import "UIColor+Additions.h"
#import "AppDelegate.h"


@implementation UIColor (Additions)

+ (UIColor *)headerColor {
//    return [UIColor whiteColor];
    return UIColorFromRGB(0xFFEEEE);
}

+ (UIColor *)backgroundColor {
//    return UIColorFromRGB(0xFFDFCB);
    return [UIColor whiteColor];
}

+ (UIColor *)everydayGreenColor {
    return UIColorFromRGB(0xCBFFB8);
}

+ (UIColor *)everydayRedColor {
    return UIColorFromRGB(0xFFB8C3);
}

+ (UIColor *)doneColor {
    return UIColorFromRGB(0x539700);
}

+ (UIColor *)notDoneColor {
    return UIColorFromRGB(0xA0000F);
}


@end