//
//  UIViewController+utility.h
//  昆明团购
//
//  Created by AnYanbo on 15/5/9.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (utility)

+ (instancetype)viewControllerWithStoryboardName:(NSString*)stroyboard;
+ (instancetype)viewControllerWithStoryboardName:(NSString*)stroyboard stroyboardID:(NSString*)stroyboardID;

- (void)hideKeyboard;
- (void)hideStatusBar;

- (void)setNavigationBarAlpha:(CGFloat)alpha;

@end
