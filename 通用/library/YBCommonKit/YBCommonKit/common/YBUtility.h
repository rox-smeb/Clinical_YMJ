//
//  YBUtility.h
//  YBCommonKit
//
//  Created by AnYanbo on 14/12/29.
//  Copyright (c) 2014年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ClearCacheBlock)(BOOL ret);

@interface TelWebView : UIWebView <UIWebViewDelegate>

@end

@interface YBUtility : NSObject

/**
 *  跳转至系统APP设置
 *
 *  @return 是否跳转成功
 */
+ (BOOL)jumpToSystemAPPSetting;

/**
 *  清楚缓存
 *
 *  @param block 结果回调
 */
+ (void)clearCacheWithBlock:(ClearCacheBlock)block;

/**
 *	@brief	给应用提供统一的返回按钮样式
 *
 *  图片尺寸是 40*40 80*80
 *	@param 	imagename 	正常状态时的图片名称
 *	@param 	selImagename 	高亮时候的状态名称
 */
+ (void)setNavBackButtonImage:(NSString *)imagename
             andSelectedImage:(NSString *)selImagename;

+ (BOOL)setNavBackButtonTitle:(NSString*)title
                  normalImage:(NSString*)imagename
                selectedImage:(NSString*)selectedImagename
                 andContrller:(UIViewController*)controller;

/**
 *	@brief	在应用内拨打电话
 *
 *	@param 	phoneNumber 	电话号码
 *	@param 	view 	调用controller的view
 */
+ (void)callPhone:(NSString *)phoneNumber superView:(UIView *)view;

/**
 *	@brief	设置按钮的image或者backgroundImage
 *
 *	@param 	button 	按钮
 *	@param 	imageUrl 	正常状态的图片名称
 *	@param 	highLightImageUrl 	高亮状态的图片名称
 */
+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl;

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
         disableImage:(NSString *)disableImageUrl;

/**
 *	@brief	判断应用运行在什么系统版本上
 *
 *	@return	返回系统版本 ：7.0     6.0     6.1等
 */
+ (CGFloat)systemVersionFloat;

/**
 *	@brief	判断应用运行在什么系统版本上
 *
 *	@return	返回系统版本 ：7.0     6.0     6.1等
 */
+ (NSString*)systemVersion;

/**
 *  @brief	APP的显示名称
 *
 *  @return APP名称
 */
+ (NSString*)appDisplayName;

/**
 *	@brief	判断应用的版本
 *
 *	@return	返回版本号
 */
+ (NSString*)appVersion;

/**
 *	@brief	判断应用的build版本
 *
 *	@return	返回版本号
 */
+ (NSString*)appBuildVersion;

/**
 *  计算block执行时间
 *
 *  @param block 运行的代码块
 *
 *  @return 执行时间
 */
+ (CGFloat)bnrTimeBlock:(void (^)(void))block;

@end
