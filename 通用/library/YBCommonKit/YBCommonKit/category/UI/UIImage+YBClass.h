//
//  UIImage+YBClass.h
//  TestInput
//
//  Created by AnYanbo on 14-6-25.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (YBClass)

+ (UIImage*)imageWithColor:(UIColor*)color Size:(CGSize)size;
+ (UIImage*)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage*)imageNamed:(NSString*)name bundleName:(NSString*)bundleName;
+ (UIImage*)qrCodeWithString:(NSString*)str size:(CGFloat)size;

- (UIImage*)getLimitImage:(CGSize)size;             // 按原图比例返回限定大小的图片（未剪切）
- (UIImage*)getClickImage:(CGSize)size;             // 按原图比例返回限定大小的图片（剪切）
- (UIImage*)scaleToSize:(CGSize)size;
- (UIImage*)imageTransparentWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
