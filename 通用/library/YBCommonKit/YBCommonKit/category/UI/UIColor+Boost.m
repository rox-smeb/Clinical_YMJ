//
//  UIColor+Boost.m
//  CotactsBook
//
//  Created by AnYanbo on 14-7-27.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import "UIColor+Boost.h"

@implementation UIColor (Boost)

+ (UIColor*)colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    CGFloat fRed   = (CGFloat)red;
    CGFloat fGreen = (CGFloat)green;
    CGFloat fBlue  = (CGFloat)blue;
    
    UIColor* color = [UIColor colorWithRed:fRed / 255.0 green:fGreen / 255.0 blue:fBlue / 255.0 alpha:alpha];
    
    return color;
}

+ (UIColor*)colorWithHex:(long)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8)  & 0xFF;
    int b = hex & 0xFF;
    
    return [UIColor colorWithIntegerRed:r green:g blue:b alpha:1.0];
}

+ (UIColor*)colorWithHexStr:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if (cString == nil || [cString isEqualToString:@""])
    {
        return [UIColor blackColor];
    }
    
    // 去掉头
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    
    // 去头非十六进制，返回白色
    if ([cString length] != 6 && [cString length] != 8)
    {
        return [UIColor blackColor];
    }
    
    // 分别取RGB的值
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // 有alpha
    NSString *aString = nil;
    if ([cString length] == 8)
    {
        range.location = 6;
        aString = [cString substringWithRange:range];
    }
    
    unsigned int r = 255;
    unsigned int g = 255;
    unsigned int b = 255;
    unsigned int a = 255;
    
    //NSScanner把扫描出的制定的字符串转换成Int类型
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    if (aString != nil)
    {
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
    }
    
    //转换为UIColor
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:((float)a / 255.0f)];
}

@end