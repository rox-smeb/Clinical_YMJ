//
//  UIViewxx.h
//  果动校园
//
//  Created by AnYanbo on 15/1/30.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YBClass)

+ (instancetype)create;
+ (instancetype)viewWithXIB:(NSString*)xib;

/**
 *  获取view中
 *
 *  @return view中的第一响应者
 */
- (UIView*)firstResponder;

/**
 *  当前view中得第一个UITextField成为焦点
 *
 *  @return 是否成功
 */
- (BOOL)becomeFirstResponderWithSubView;

/**
 *  当前view中得第一个UITextField失去焦点
 *
 *  @return 是否成功
 */
- (BOOL)resignFirstResponderWithSubView;

/**
 *  当前view中得第一个UITextField是否处于焦点状态
 *
 *  @return 是否处于焦点状态
 */
- (BOOL)isFirstResponderWithSubView;

/**
 *  当前view中得第一个UITextField的内容
 *
 *  @return NSString
 */
- (NSString*)textOfSubView;

/**
 *  设置当前view中得第一个UITextField的内容
 */
- (void)setSubViewText:(NSString*)text;

/**
 *  添加点击手势
 *
 *  @param target   目标
 *  @param selector 响应函数
 */
- (void)addNormalTapGestureWithTarget:(id)target atction:(SEL)selector;

- (void)roundBorder;

/**
 *  隐藏键盘
 */
- (void)hideKeyboard;

/**
 *  设置x坐标
 *
 *  @param x x坐标
 */
- (void)setX:(CGFloat)x;

/**
 *  设置y坐标
 *
 *  @param y y坐标
 */
- (void)setY:(CGFloat)y;

/**
 *  设置XY坐标
 *
 *  @param p xy坐标
 */
- (void)setPoint:(CGPoint)p;

/**
 *  设置宽度
 */
- (void)setWidth:(CGFloat)width;

/**
 *  设置高度
 */
- (void)setHeight:(CGFloat)height;

/**
 *  设置宽高
 *
 *  @param size (width, height)
 */
- (void)setSize:(CGSize)size;

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;

@end
