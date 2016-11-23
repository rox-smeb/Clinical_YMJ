//
//  UIPlaceHolderTextView.h
//  果动校园
//
//  Created by AnYanbo on 15/1/26.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIPlaceHolderTextView;

@protocol UIPlaceHolderTextViewDelegate  <NSObject>

@optional

- (BOOL)placeHolderTextViewShouldBeginEditing:(UIPlaceHolderTextView *)textView;
- (BOOL)placeHolderTextViewShouldEndEditing:(UIPlaceHolderTextView *)textView;

- (void)placeHolderTextViewDidBeginEditing:(UIPlaceHolderTextView *)textView;
- (void)placeHolderTextViewDidEndEditing:(UIPlaceHolderTextView *)textView;

- (BOOL)placeHolderTextView:(UIPlaceHolderTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)placeHolderTextViewDidChange:(UIPlaceHolderTextView *)textView;

- (void)placeHolderTextViewDidChangeSelection:(UIPlaceHolderTextView *)textView;

@end

@interface UIPlaceHolderTextView : UITextView <UITextViewDelegate>
{
    UILabel* _placeHolderLabel;
}

@property (nonatomic, weak) id<UIPlaceHolderTextViewDelegate> delegateEx;
@property (nonatomic, strong) NSString* placeholder;
@property (nonatomic, strong) UIColor* placeholderColor;
@property (nonatomic, strong) UIFont* placeholderFont;

@end
