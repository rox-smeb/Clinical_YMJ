//
//  AppDelegate.m
//  求美者端
//
//  Created by AnYanbo on 16/8/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "WSMovieController.h"
#import "JPUSHService.h"

#import <Bugly/Bugly.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // DEBUG打印app信息
    [self appInfo];
    
    // 配置APP红点
    [self configBadgeNumber];
    
    // 配置Bugly
    [self configBugly];
    
    // 配置蒲公英
    //    [self configPyger];
    
//    // 配置极光推送
//    [self configJPushWithOptions:launchOptions];
//    
//    // 配置微信
//    [self configWX];
    
    // 配置刷新控件
    [self configRefresh];
    
    // 配置导航栏
    [self configNav];
    
    // 配置高德API
//    [self configAMap];
    
    // 配置网络缓存
    [self configNetEngine];
    
    // 初始化程序入口
    [self configRootViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

#pragma mark - 打印基本信息

- (void)appInfo
{
#ifdef DEBUG
    NSLog(@"AppVersion:%@", [YBUtility appVersion]);
    NSLog(@"AppBuildVersion:%@", [YBUtility appBuildVersion]);
    NSLog(@"SystemVersion:%@", [YBUtility systemVersion]);
    NSLog(@"HomeDirectory:%@", NSHomeDirectory());
    NSLog(@"YBCommonKit VersionNumber:%lf Version:%s", YBCommonKitVersionNumber, YBCommonKitVersionString);
#endif
}

#pragma mark - 配置应用红点

- (void)configBadgeNumber
{
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

#pragma mark - 配置Bugly

- (void)configBugly
{
    [Bugly startWithAppId:BUGLY_APP_ID];
}

//#pragma mark - 配置极光推送
//
//- (void)configJPushWithOptions:(NSDictionary *)launchOptions
//{
//    BOOL isProduction = NO;
//#ifdef DEBUG
//    isProduction = NO;
//#else
//    isProduction = YES;
//#endif
//    
//    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APP_KEY channel:JPUSH_CHANNEL apsForProduction:isProduction];
//    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                      UIUserNotificationTypeSound |
//                                                      UIUserNotificationTypeAlert)
//                                          categories:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(onJPushReceiveMessage:)
//                                                 name:kJPFNetworkDidReceiveMessageNotification
//                                               object:nil];
//}

#pragma mark - 配置网络缓存

- (void)configNetEngine
{
    [YBNetworkEngine setupSharedInstanceWithHost:URL_BASE portNum:URL_PORT_NUM];
    [[YBNetworkEngine sharedInstance] useCache];
}

//#pragma mark - 配置微信
//
//- (void)configWX
//{
//    [WXApi registerApp:WECHAT_APP_KEY withDescription:@"车联网-修理厂版"];
//}
//
//#pragma mark - 配置高德地图
//
//- (void)configAMap
//{
//    [AMapLocationServices sharedServices].apiKey = AMAP_APP_KEY;            // 定位SDK
//    [MAMapServices sharedServices].apiKey        = AMAP_APP_KEY;            // 地图SDK
//    [AMapSearchServices sharedServices].apiKey   = AMAP_APP_KEY;            // 搜索SDK
//}

#pragma mark - 配置刷新控件

- (void)configRefresh
{
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray* images = [NSMutableArray array];
    UIImage* image = [UIImage imageNamed:@"start_v2"];
    if (image != nil)
    {
        [images addObject:image];
    }
    [UIScrollView setPullingImages:images];
    
    // 设置空闲状态的动画图片
    images = [NSMutableArray array];
    image = [UIImage imageNamed:@"finish_v2"];
    if (image != nil)
    {
        [images addObject:image];
    }
    [UIScrollView setIdleImages:images];
    
    // 设置正在刷新状态的动画图片
    images = [NSMutableArray array];
    for (int i = 0; i < 7; i++)
    {
        NSString* name = [NSString stringWithFormat:@"Refresh%03d", i];
        UIImage* image = [UIImage imageNamed:name];
        if (image != nil)
        {
            [images addObject:image];
        }
    }
    [UIScrollView setRefreshingImages:images];
}

#pragma mark - 配置导航栏

- (void)configNav
{
    UIColor* color   = [UIColor blackColor];
    UIFont* font     = [UIFont systemFontOfSize:NAV_TITLE_FONT_SIZE];
    NSShadow* shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor clearColor]];
    
    // 设置导航栏标题
    NSMutableDictionary* attr = [NSMutableDictionary dictionary];
    [attr addParam:shadow forKey:NSShadowAttributeName];
    [attr addParam:color forKey:NSForegroundColorAttributeName];
    [attr addParam:font forKey:NSFontAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:attr];
    
    if (AboveIOS7)
    {
        [[UINavigationBar appearance] setBarTintColor:RGB(241, 249, 249)];
    }
    
    
    [YBUtility setNavBackButtonImage:@"返回" andSelectedImage:@"返回"];
    
    if ([YBUtility systemVersionFloat] >= 6.0f)
    {
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
}

#pragma mark - 配置入口点

- (void)configRootViewController
{
    // 设置了storyboard中的 Main Interface
    if (self.window != nil)
    {
        return;
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BOOL used = [[NSUserDefaults standardUserDefaults] boolForKey:IS_APP_USED];
    used = YES;
    if (used == NO)
    {
        
    }
    else
    {
//        MainTabBarController* ctrl = [MainTabBarController viewController];
//        self.window.rootViewController = ctrl;
        WSMovieController *wsCtrl = [[WSMovieController alloc]init];
        wsCtrl.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"media"ofType:@"mp4"]];
        self.window.rootViewController = wsCtrl;

        
    }
    [self.window makeKeyAndVisible];
}

#pragma mark - 进入app播放视频
- (void)configPlayVideo
{
    //    BOOL isFirstLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLogin"] boolValue];
    //    if (!isFirstLogin) {
    //        //是第一次
    //        self.window.rootViewController = [[WSMovieController alloc]init];
    //        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstLogin"];
    //    }else{
    //        //不是首次启动
    //        MainTabBarController *viewCtrl = [MainTabBarController viewController];
    //        self.window.rootViewController = viewCtrl;
    //    }
    
    
    //是第一次
    WSMovieController *wsCtrl = [[WSMovieController alloc]init];
    wsCtrl.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"media"ofType:@"mp4"]];
    self.window.rootViewController = wsCtrl;
    //[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstLogin"];
    
}

@end
