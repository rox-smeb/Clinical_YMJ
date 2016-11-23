//
//  UIColor+Boost.h
//  CotactsBook
//
//  Created by AnYanbo on 14-7-27.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Boost)

+ (UIColor*)colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithHex:(long)hex;
+ (UIColor*)colorWithHexStr:(NSString*)hex;

@end

static inline UIColor* UIColorMakeA(NSInteger r, NSInteger g, NSInteger b, CGFloat a)
{
    return [UIColor colorWithIntegerRed:r green:g blue:b alpha:a];
}

static inline UIColor* UIColorMake(NSInteger r, NSInteger g, NSInteger b)
{
    return UIColorMakeA(r, g, b, 1.0f);
}