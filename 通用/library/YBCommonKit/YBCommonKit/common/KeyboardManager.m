//
//  KeyboardManager.m
//  果动校园
//
//  Created by AnYanbo on 15/1/30.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "KeyboardManager.h"

@implementation KeyboardManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once      = 0;
    static KeyboardManager* instance = nil;
    
    dispatch_once(&once, ^(){
        instance = [[KeyboardManager alloc] init];
    });
    
    return instance;
}

+ (instancetype)manager
{
    KeyboardManager* pRet = [[KeyboardManager alloc] init];
    return pRet;
}

+ (void)purge
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _isKeyboardShow      = NO;
        _isThirdPartKeyboard = NO;
        _keyboardShowTime    = 0;
        _defaultConstraint   = 0.0f;
        _keyboardAnimateDur  = 0.0f;
        _keyboardFrame       = CGRectZero;
        
        [self initKeyboardObserver];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)offsetWithDelegate:(id<KeyboardManagerDelegate>)delegate
{
    self.delegate = delegate;
    
    if (_isKeyboardShow)                // 键盘已经显示
    {
        [self offsetFirstResponderWithKeyboardFrame:_keyboardFrame animationDur:_keyboardAnimateDur];
    }
}

- (void)offsetFirstResponder:(UIView*)responder modifyConstraint:(NSLayoutConstraint*)constraint
{
    self.modifyConstraint = constraint;
    self.firstResponder   = responder;
    
    if (_isKeyboardShow)                // 键盘已经显示
    {
        [self offsetFirstResponderWithKeyboardFrame:_keyboardFrame animationDur:_keyboardAnimateDur];
    }
}

- (void)offsetFirstResponder:(UIView*)responder modifyConstraint:(NSLayoutConstraint*)constraint scrollView:(UIScrollView*)scrollView
{
    self.scrollView = scrollView;
    [self offsetFirstResponder:responder modifyConstraint:constraint];
}

- (void)offsetFirstResponderWithKeyboardFrame:(CGRect)keyboardRect animationDur:(CGFloat)animationDur
{
    if ([self.delegate respondsToSelector:@selector(keyboardManager:keyboardFrame:show:)])
    {
        [UIView animateWithDuration:animationDur animations:^(){
            
            [self.delegate keyboardManager:self keyboardFrame:keyboardRect show:YES];
            [[[UIApplication sharedApplication] keyWindow] layoutIfNeeded];
        } completion:^(BOOL finised){
   
        }];
    }
    else
    {
        if (self.firstResponder != nil)
        {
            // 转换相对坐标
            UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
            CGRect frame         = [self.firstResponder convertRect:self.firstResponder.frame toView:mainWindow];
            CGFloat maxY         = CGRectGetMaxY(frame);
            
            if (self.scrollView != nil)
            {
                _oldOffset = self.scrollView.contentOffset;
            }
            
            if (self.delegate)
                // 被键盘覆盖，需要整体移动
                if (maxY > keyboardRect.origin.y)
                {
                    CGFloat offset = maxY - keyboardRect.origin.y + 20.0f;
                    [UIView animateWithDuration:animationDur animations:^(){
                        self.modifyConstraint.constant -= offset;
                        [mainWindow layoutIfNeeded];
                    } completion:^(BOOL finised){
                        if (self.scrollView != nil)
                        {
                            self.scrollView.contentOffset = _oldOffset;
                        }
                    }];
                }
        }
    }
}

- (void)setModifyConstraint:(NSLayoutConstraint *)modifyConstraint
{
    if (modifyConstraint != self.modifyConstraint)
    {
        if (modifyConstraint != nil)
        {
            _defaultConstraint = modifyConstraint.constant;
        }
        
        _modifyConstraint = modifyConstraint;
    }
}

#pragma mark - 键盘事件

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSValue* keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyboardBoundsValue CGRectValue];
    
    NSNumber* keyboardAnimationDur = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    float animationDur = [keyboardAnimationDur floatValue];
    
    _keyboardShowTime++;
    
    // 第三方输入法有bug,第一次弹出没有keyboardRect
    if (animationDur > 0.0f && keyboardRect.size.height == 0)
    {
        _isThirdPartKeyboard = YES;
    }
    
    // 第三方输入法,有动画间隔时,没有高度
    if (_isThirdPartKeyboard)
    {
        // 第三次调用keyboardWillShow的时候 键盘完全展开
        if (_keyboardShowTime == 3 && keyboardRect.size.height != 0 && keyboardRect.origin.y != 0)
        {
            _keyboardFrame = keyboardRect;
            [self offsetFirstResponderWithKeyboardFrame:keyboardRect animationDur:animationDur];
        }
        if (animationDur > 0.0)
        {
            _keyboardAnimateDur = animationDur;
        }
    }
    else
    {
        if (animationDur > 0.0)
        {
            _keyboardFrame = keyboardRect;
            _keyboardAnimateDur = animationDur;
            
            [self offsetFirstResponderWithKeyboardFrame:keyboardRect animationDur:animationDur];
        }
    }
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    _isKeyboardShow = YES;
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSNumber* keyboardAnimationDur = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    float animationDur = [keyboardAnimationDur floatValue];
    
    _isThirdPartKeyboard = NO;
    _keyboardShowTime = 0;
    
    if ([self.delegate respondsToSelector:@selector(keyboardManager:keyboardFrame:show:)])
    {
        [UIView animateWithDuration:animationDur animations:^(){
            
            [self.delegate keyboardManager:self keyboardFrame:CGRectZero show:NO];
            [[[UIApplication sharedApplication] keyWindow] layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        if (animationDur > 0.0)
        {
            // 键盘收起恢复之前的约束
            if (self.modifyConstraint.constant != _defaultConstraint)
            {
                [UIView animateWithDuration:animationDur animations:^(){
                    self.modifyConstraint.constant = _defaultConstraint;
                    [[[UIApplication sharedApplication] keyWindow] layoutIfNeeded];
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    _isKeyboardShow = NO;
}

@end
