//
//  UIViewxx.m
//  果动校园
//
//  Created by AnYanbo on 15/1/30.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "UIView+YBClass.h"

@implementation UIView (YBClass)

+ (instancetype)create
{
    return [self viewWithXIB:[self className]];
}

+ (instancetype)viewWithXIB:(NSString*)xib
{
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:xib owner:self options:nil];
    return [nib firstObject];
}

- (UIView*)firstResponder
{
    UIView* ret = nil;
    
    for (UIView* view in [self subviews])
    {
        UIView* focus = [self firstResponderOfView:view];
        if (focus != nil)
        {
            ret = focus;
            break;
        }
    }
    
    return ret;
}

- (UIView*)firstResponderOfView:(UIView*)view
{
    if (view != nil && [view isFirstResponder])
    {
        return view;
    }
        
    for (UIView* subView in [view subviews])
    {
        UIView* focus = [self firstResponderOfView:subView];
    
        if (focus != nil && [focus isFirstResponder])
        {
            return focus;
        }
    }
    
    return nil;
}

- (BOOL)becomeFirstResponderWithSubView
{
    for (UIView* subView in [self subviews])
    {
        if ([subView isKindOfClass:[UITextField class]])
        {
            UITextField* textField = (UITextField*)subView;
            return [textField becomeFirstResponder];
        }
        
        if ([subView isKindOfClass:[UITextView class]])
        {
            UITextView* textView = (UITextView*)subView;
            return [textView becomeFirstResponder];
        }
    }
    
    return NO;
}

- (BOOL)resignFirstResponderWithSubView
{
    for (UIView* subView in [self subviews])
    {
        if ([subView isKindOfClass:[UITextField class]])
        {
            UITextField* textField = (UITextField*)subView;
            return [textField resignFirstResponder];
        }
        
        if ([subView isKindOfClass:[UITextView class]])
        {
            UITextView* textView = (UITextView*)subView;
            return [textView resignFirstResponder];
        }
    }
    
    return NO;
}

- (BOOL)isFirstResponderWithSubView
{
    for (UIView* subView in [self subviews])
    {
        if ([subView isKindOfClass:[UITextField class]])
        {
            UITextField* textField = (UITextField*)subView;
            return [textField isFirstResponder];
        }
        
        if ([subView isKindOfClass:[UITextView class]])
        {
            UITextView* textView = (UITextView*)subView;
            return [textView isFirstResponder];
        }
    }
    
    return NO;
}

- (NSString*)textOfSubView
{
    for (UIView* subView in [self subviews])
    {
        if ([subView isKindOfClass:[UITextField class]])
        {
            UITextField* textField = (UITextField*)subView;
            return textField.text;
        }
        
        if ([subView isKindOfClass:[UITextView class]])
        {
            UITextView* textView = (UITextView*)subView;
            return textView.text;
        }
    }
    
    return @"";
}

- (void)setSubViewText:(NSString*)text
{
    for (UIView* subView in [self subviews])
    {
        if ([subView isKindOfClass:[UITextField class]])
        {
            UITextField* textField = (UITextField*)subView;
            textField.text = text;
            break;
        }
        
        if ([subView isKindOfClass:[UITextView class]])
        {
            UITextView* textView = (UITextView*)subView;
            textView.text = text;
            break;
        }
    }
}

- (void)addNormalTapGestureWithTarget:(id)target atction:(SEL)selector
{
    if ([target respondsToSelector:selector])
    {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
        tap.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:tap];
    }
}

- (void)roundBorder
{
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = YES;
    
    self.layer.borderColor = [UIColor colorWithWhite:0.863 alpha:1.000].CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void)hideKeyboard
{
    [self endEditing:YES];
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
}

- (void)setPoint:(CGPoint)p
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(p.x, p.y, frame.size.width, frame.size.height);
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height);
}

@end
