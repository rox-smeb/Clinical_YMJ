//
//  MainTabBarController.m
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/6/6.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MainTabBarController.h"
#import "LoginTableViewController.h"
#import "CommonServerInteraction.h"
#import "NotificationsDefine.h"
#import "DataManager.h"
#import "TabBarCenterView.h"
#import "UserInfo.h"

@interface MainTabBarController ()
{
}

@end

@implementation MainTabBarController

+ (instancetype)viewController
{
    return [[self class] viewControllerWithStoryboardName:@"Main"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    //[self customTabBarItem];
    [self setupTabContoller];
}

- (void)viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    self.delegate = self;
    
    // 判断APP是否已经使用
    BOOL used = [[NSUserDefaults standardUserDefaults] boolForKey:IS_APP_USED];
    if (used == NO)
    {
#if USE_ANIMATE_FROM_INTRO_TO_MAIN
        self.view.alpha = 0.2f;
        [UIView animateWithDuration:0.1f animations:^{
            self.view.alpha = 1.0f;
        }];
#endif
        // 设置已经使用
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_APP_USED];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginIllegality:) name:NOTIFICATION_LOGIN_ILLEGALITY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLogout:) name:NOTIFICATION_USER_LOGOUT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popLoginViewController) name:NOTIFICATION_USER_NEED_LOGIN object:nil];
}

- (void)customTabBarItem
{
    // 隐藏Tabbar顶部1px的黑线
    [self.tabBar setShadowLineHidden:YES];
    
    // Tabbar添加中间的装饰
    [TabBarCenterView addToTabbar:self.tabBar];
    
    [self setSelectedIndex:0];
    [self.tabBar setSelectedImageTintColor:COMMON_COLOR];
    
    for (int i = 0; i < self.tabBar.items.count; i++)
    {
        // 忽略中间item
        if (i == 1)
        {
            continue;
        }
     
        UITabBarItem* item = [self.tabBar.items objectAtIndex:i];
        NSString* path = [NSString stringWithFormat:@"TabItem%d_sel", i + 1];
        item.selectedImage = [UIImage imageNamed:path];
    }
}

- (void)setupTabContoller
{
    for (UINavigationController* navController in self.viewControllers)
    {
        NSString* className = [navController restorationIdentifier];
        
        // 首页 | 想去 | 我的
        if (className != nil && [className isEqualToString:@""] == NO)
        {
            Class class = NSClassFromString(className);
            UIViewController* subController = [class viewController];
            if (subController != nil)
            {
                navController.viewControllers = @[subController];
            }
        }
    }
}

- (void)popLoginViewController
{
    [LoginTableViewController jumpToViewController:self];
}

- (void)onLogout:(NSNotification*)notifi
{
    [self setSelectedIndex:0];
}

// 用户登录信息过期
- (void)onLoginIllegality:(NSNotification*)notifi
{
    [UserInfo logout];
    
    // 跳转首页
    [self onLogout:notifi];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewControlle
{
    // 未登录状态不能进入我的
    if ([viewControlle.restorationIdentifier isEqualToString:@"MineTableViewController"])
    {
        if ([UserInfo isLogin])
        {
            return YES;
        }
        else
        {
            [self popLoginViewController];
            return NO;
        }
    }
    else if ([viewControlle.restorationIdentifier isEqualToString:@"AboutViewController"])
    {
        return NO;
    }
    
    return YES;
}

@end
