//
//  KeyboardManager.h
//  果动校园
//
//  Created by AnYanbo on 15/1/30.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KeyboardManager;

@protocol KeyboardManagerDelegate <NSObject>

@optional

- (void)keyboardManager:(KeyboardManager*)manager keyboardFrame:(CGRect)keyboardRect show:(BOOL)show;

@end

@interface KeyboardManager : NSObject
{
    BOOL      _isKeyboardShow;
    BOOL      _isThirdPartKeyboard;
    NSInteger _keyboardShowTime;
    CGFloat   _defaultConstraint;
    CGFloat   _keyboardAnimateDur;
    CGPoint   _oldOffset;
    CGRect    _keyboardFrame;
}

@property (nonatomic, weak) id<KeyboardManagerDelegate> delegate;
@property (nonatomic, weak) UIView* firstResponder;
@property (nonatomic, weak) UIScrollView* scrollView;
@property (nonatomic, weak) NSLayoutConstraint* modifyConstraint;

+ (instancetype)sharedInstance;
+ (instancetype)manager;
+ (void)purge;

/**
 *  键盘覆盖，修复约束，将覆盖的View上移
 *
 *  @param responder  当前的响应者
 *  @param constraint 通过修改约束进行移动
 */
- (void)offsetFirstResponder:(UIView*)responder modifyConstraint:(NSLayoutConstraint*)constraint;

- (void)offsetWithDelegate:(id<KeyboardManagerDelegate>)delegate;

@end
