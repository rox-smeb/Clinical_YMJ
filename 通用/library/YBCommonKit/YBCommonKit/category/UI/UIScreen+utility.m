//
//  UIScreen+utility.m
//  昆明团购
//
//  Created by AnYanbo on 15/6/15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "UIScreen+utility.h"

@implementation UIScreen (utility)

+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

@end
