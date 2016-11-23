//
//  InputAccessoryView.m
//  昆明团购
//
//  Created by AnYanbo on 15/7/9.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "InputAccessoryView.h"

@interface InputAccessoryView ()

@property (nonatomic, weak) id inputView;

@end

@implementation InputAccessoryView

+ (instancetype)createWithInputView:(id)inputView
{
    InputAccessoryView* view = [[self class] create];
    view.inputView = inputView;
    return view;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (void)setInputView:(id)inputView
{
    if (_inputView != inputView)
    {
        _inputView = inputView;
        if ([_inputView respondsToSelector:@selector(setInputAccessoryView:)])
        {
            [_inputView setInputAccessoryView:self];
        }
    }
}

- (IBAction)onHideKeyboard:(UIButton *)sender
{
    if ([self.inputView respondsToSelector:@selector(resignFirstResponder)])
    {
        [self.inputView resignFirstResponder];
    }
}

@end
