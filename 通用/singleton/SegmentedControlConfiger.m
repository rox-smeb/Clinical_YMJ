//
//  SegmentedControlConfiger.m
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "SegmentedControlConfiger.h"

@implementation SegmentedControlConfiger

+ (void)configSegmentedControl:(UISegmentedControl*)segmentedControl
{
    @try
    {
        UIImage* norBackImage = [UIImage imageWithColor:RGB(245, 245, 245)];
        UIImage* selBackImage = [UIImage imageWithColor:RGB(255, 255, 255)];
        
        [segmentedControl setBackgroundImage:norBackImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedControl setBackgroundImage:selBackImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(120, 120, 120)} forState:UIControlStateNormal];
        [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(246, 141, 70)} forState:UIControlStateSelected];
        
        segmentedControl.layer.masksToBounds = YES;
        segmentedControl.layer.cornerRadius = 4.0f;
        segmentedControl.layer.borderWidth = 1.0f;
        segmentedControl.layer.borderColor = RGB(246, 141, 70).CGColor;
    }
    @catch (NSException *exception)
    {
        
    }
}

@end
