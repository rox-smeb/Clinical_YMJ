//
//  YBUtility.m
//  YBCommonKit
//
//  Created by AnYanbo on 14/12/29.
//  Copyright (c) 2014年 GDSchool. All rights reserved.
//

#import "YBUtility.h"
#import "YBNetworkEngine.h"

#import <mach/mach_time.h>

@implementation TelWebView

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [webView removeFromSuperview];
}

@end

@implementation YBUtility

+ (BOOL)jumpToSystemAPPSetting
{
    NSURL* url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    return NO;
}

+ (void)clearCacheWithBlock:(ClearCacheBlock)block
{
    // 清理get缓存
    [[YBNetworkEngine sharedInstance] emptyCache];
    
    // 清理图片内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 清理图片磁盘缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        if (block != nil)
        {
            block(YES);
        }
    }];
}

+ (void)callPhone:(NSString *)phoneNumber superView:(UIView *)view
{
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        NSInteger tag = 612345;
        UIWebView *webview = (UIWebView*)[view viewWithTag:tag];
        if ([webview isKindOfClass:[UIWebView class]] == NO)
        {
            webview = [[UIWebView alloc] initWithFrame:CGRectZero];
            webview.tag = tag;
            [view addSubview:webview];
        }
        
        [webview loadRequest:[NSURLRequest requestWithURL:url]];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"当前设备不支持拨打电话"];
    }
}

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
         disableImage:(NSString *)disableImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:highLightImageUrl]
            forState:UIControlStateHighlighted];
    
    [button setImage:[UIImage imageNamed:disableImageUrl]
            forState:UIControlStateDisabled];
}

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:highLightImageUrl]
            forState:UIControlStateHighlighted];
}

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
        selectedImage:(NSString *)selectedImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:selectedImageUrl]
            forState:UIControlStateSelected];
}

+ (BOOL)setNavBackButtonImage:(NSString *)imagename
             andSelectedImage:(NSString *)selImagename
{
    BOOL ret = NO;
    @try
    {
        UIImage* backImage = [[UIImage imageNamed:imagename] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
        UIImage* backImageSel = [[UIImage imageNamed:selImagename] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
        
        if (AboveIOS7)
        {
            [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
            [[UINavigationBar appearance] setBackIndicatorImage:backImage];
            [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImageSel];
        }
        else
        {
            [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage
                                                              forState:UIControlStateNormal
                                                            barMetrics:UIBarMetricsDefault];
            [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImageSel
                                                              forState:UIControlStateHighlighted
                                                            barMetrics:UIBarMetricsDefault];
        }
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, -1000)
                                                             forBarMetrics:UIBarMetricsDefault];
        ret = YES;
    }
    @catch (NSException *exception)
    {
        ret = NO;
    }
    
    return ret;
}

+ (BOOL)setNavBackButtonTitle:(NSString*)title
                  normalImage:(NSString*)imagename
                selectedImage:(NSString*)selectedImagename
                 andContrller:(UIViewController*)controller
{
    BOOL ret = NO;
    @try
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagename]
                forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImagename]
                forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(backToFather:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *mybuttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        controller.navigationItem.leftBarButtonItem = mybuttonItem;
        
        ret = YES;
    }
    @catch (NSException *exception)
    {
        ret = NO;
    }
    
    return ret;
}

+ (void)backToFather:(UIButton *)sender
{
    UINavigationBar *navigationBar = (UINavigationBar *)sender.superview;
    UINavigationController *nc = (UINavigationController *)[self getViewController:navigationBar];
    [nc popViewControllerAnimated:YES];
}

+ (UIViewController*)getViewController:(UIView*)uView
{
    for (UIView* next = [uView superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (CGFloat)systemVersionFloat
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    return systemVersion;
}

+ (NSString*)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString*)appDisplayName
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleDisplayName"];
}

+ (NSString*)appVersion
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*)appBuildVersion
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleVersion"];
}

+ (CGFloat)bnrTimeBlock:(void (^)(void))block
{
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    return (CGFloat)nanos / NSEC_PER_SEC;
}

@end
