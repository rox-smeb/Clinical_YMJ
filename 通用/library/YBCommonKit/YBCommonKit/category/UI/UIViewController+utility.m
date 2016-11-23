//
//  UIViewController+utility.m
//  昆明团购
//
//  Created by AnYanbo on 15/5/9.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "UIViewController+utility.h"

@implementation UIViewController (utility)

+ (instancetype)viewControllerWithStoryboardName:(NSString*)stroyboard
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:stroyboard bundle:nil];
    id ret = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    return ret;
}

+ (instancetype)viewControllerWithStoryboardName:(NSString*)stroyboard stroyboardID:(NSString*)stroyboardID
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:stroyboard bundle:nil];
    id ret = [storyboard instantiateViewControllerWithIdentifier:stroyboardID];
    return ret;
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)hideStatusBar
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (void)setNavigationBarAlpha:(CGFloat)alpha
{
    alpha = alpha < 0.0f ? 0.0f : alpha;
    alpha = alpha > 1.0f ? 1.0f : alpha;
    
    [[[self.navigationController.navigationBar subviews] firstObject] setAlpha:alpha];
}

@end
