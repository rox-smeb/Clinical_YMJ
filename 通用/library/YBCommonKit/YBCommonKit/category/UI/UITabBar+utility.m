//
//  UITabBar+utility.m
//  TabbarSeparator
//
//  Created by AnYanbo on 15/6/4.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "UITabBar+utility.h"

@implementation UITabBar (utility)

- (void)addSeparatorWithInset:(UIEdgeInsets)inset color:(UIColor*)color width:(CGFloat)width
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    NSInteger count = [self.items count];
    
    if (count == 0)
        return;
    
    CGFloat itemWidth = frame.size.width / count;
    CGFloat height = self.frame.size.height;
    CGFloat offset = inset.left + inset.right;
    
    [self.items enumerateObjectsUsingBlock:^(UITabBarItem* item, NSUInteger idx, BOOL *stop) {

        idx++;
        if (idx < count)
        {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(itemWidth * idx + offset, inset.top, width, height - inset.top - inset.bottom)];
            view.backgroundColor = color;
            [self addSubview:view];
        }
    }];
}

- (void)setTitleFont:(UIFont*)font
{
    if (font == nil)
    {
        return;
    }
    
    NSMutableDictionary* attr = [NSMutableDictionary dictionary];
    [attr setObject:font forKey:NSFontAttributeName];
    
    [self.items enumerateObjectsUsingBlock:^(UITabBarItem* item, NSUInteger idx, BOOL *stop) {
    
        [item setTitleTextAttributes:attr forState:UIControlStateNormal];
        [item setTitleTextAttributes:attr forState:UIControlStateHighlighted];
    }];
}

- (void)setBadgeValue:(NSString*)val atTabIndex:(NSInteger)index
{
    if (index < [[self items] count])
    {
        UITabBarItem* tab = [[self items] objectAtIndex:index];
        
        if ([val integerValue] <= 0)
        {
            tab.badgeValue = nil;
        }
        else
        {
            tab.badgeValue = val;
        }
    }
}

- (NSString*)getBadgeValueAtIndex:(int)index
{
    if (index < [[self items] count])
    {
        UITabBarItem* tab = [[self items] objectAtIndex:index];
        return tab.badgeValue;
    }
    return 0;
    
}

- (void)setShadowLineHidden:(BOOL)hidden
{
    [self setValue:@(hidden) forKeyPath:@"_hidesShadow"];
}

@end
