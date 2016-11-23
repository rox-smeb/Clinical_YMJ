//
//  CategoryUtility.h
//  EnjoyDQ
//
//  Created by AnYanbo on 14-6-30.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import "NSHeader.h"
#import "UIHeader.h"

/**
 *  判断输入是否合法
 *  (注:该方法不是真实函数,不会返回值,会直接结束当前函数)
 *
 *  @param input 输入
 *
 */
#define returnIfInputNotAvailable(input)                               \
do                                                                     \
{                                                                      \
    if ([input respondsToSelector:@selector(isAvailability)])          \
    {                                                                  \
        if ([(NSString*)input isAvailability] == NO)                   \
        {                                                              \
            return;                                                    \
        }                                                              \
    }                                                                  \
    else if (input == nil)                                             \
    {                                                                  \
        return;                                                        \
    }                                                                  \
}while(0)

/**
 *  判断输入是否合法
 *  (注:该方法不是真实函数,不会返回值,会直接结束当前函数)
 *
 *  @param input 输入
 *  @param value 不合法时返回值
 *
 *  @return 不合法时结束当前函数的返回值
 */
#define returnValueIfInputNotAvailable(input, value)                   \
do                                                                     \
{                                                                      \
    if ([input respondsToSelector:@selector(isAvailability)])          \
    {                                                                  \
        if ([(NSString*)input isAvailability] == NO)                   \
        {                                                              \
            return value;                                              \
        }                                                              \
    }                                                                  \
    else if (input == nil)                                             \
    {                                                                  \
        return value;                                                  \
    }                                                                  \
}while(0)

/**
 *  判断输入是否合法
 *  (注:该方法不是真实函数,不会返回值,会直接结束当前函数)
 *
 *  @param input 输入
 *  @param text  不合法时HUD显示内容
 *
 */
#define ShowHudAndReturnIfInputNotAvailable(input, text)               \
do                                                                     \
{                                                                      \
    if ([input respondsToSelector:@selector(isAvailability)])          \
    {                                                                  \
        if ([(NSString*)input isAvailability] == NO)                   \
        {                                                              \
            [SVProgressHUD showErrorWithStatus:text];                  \
            return;                                                    \
        }                                                              \
    }                                                                  \
    else if (input == nil)                                             \
    {                                                                  \
        [SVProgressHUD showErrorWithStatus:text];                      \
        return;                                                        \
    }                                                                  \
}while(0)

/**
 *  判断输入是否合法
 *  (注:该方法不是真实函数,不会返回值,会直接结束当前函数并返回值)
 *
 *  @param input 输入
 *  @param text  不合法时HUD显示内容
 *  @param value 不合法时返回值
 *
 *  @return 不合法时结束当前函数的返回值
 */
#define ShowHudAndReturnValueIfInputNotAvailable(input, text, value)   \
do                                                                     \
{                                                                      \
    if ([input respondsToSelector:@selector(isAvailability)])          \
    {                                                                  \
        if ([(NSString*)input isAvailability] == NO)                   \
        {                                                              \
            [SVProgressHUD showErrorWithStatus:text];                  \
            return value;                                              \
        }                                                              \
    }                                                                  \
    else if (input == nil)                                             \
    {                                                                  \
        [SVProgressHUD showErrorWithStatus:text];                      \
        return value;                                                  \
    }                                                                  \
}while(0)

#define AboveIOS7               ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
#define OnlyIOS7                ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f && \
[[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define NSLog(FORMAT, ...)      printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

#define OBJC_STRINGIFY(x)       @#x
#define encodeObject(x)         [aCoder encodeObject:x forKey:OBJC_STRINGIFY(x)]
#define decodeObject(x)         x = [aDecoder decodeObjectForKey:OBJC_STRINGIFY(x)]

#define RGB(a, b, c)            [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d)        [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]
#define RGB_HEX(h)              [UIColor colorWithHexStr:h]

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 方正黑体简体字体定义
#define FZ_FONT(F)              [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

// 程序的本地化,引用国际化的文件
#define MyLocal(x, ...)         NSLocalizedString(x, nil)

// GCD
#define GCD_BACK(block)         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCD_MAIN(block)         dispatch_async(dispatch_get_main_queue(),block)

// NSUserDefaults 实例化
#define USER_DEFAULT            [NSUserDefaults standardUserDefaults]

// 由角度获取弧度 有弧度获取角度
#define degreesToRadian(x)      (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

// 检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 * 示例：
 * @weakify_self
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef    weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif
#ifndef    strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif

/**
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@weakify(object)`实现弱引用转换，`@strongify(object)`实现强引用转换
 *
 * 示例：
 * @weakify(object)
 * [obj block:^{
 * @strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
#endif
#endif