//
//  UITabBar+utility.h
//  TabbarSeparator
//
//  Created by AnYanbo on 15/6/4.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (utility)

- (void)addSeparatorWithInset:(UIEdgeInsets)inset color:(UIColor*)color width:(CGFloat)width;
- (void)setTitleFont:(UIFont*)font;

- (void)setBadgeValue:(NSString*)val atTabIndex:(NSInteger)index;
- (NSString*)getBadgeValueAtIndex:(int)index;

- (void)setShadowLineHidden:(BOOL)hidden;

@end
