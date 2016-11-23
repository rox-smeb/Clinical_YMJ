//
//  UIPopoverDatePicker.m
//  UUDatePikcer_Max_Min
//
//  Created by AnYanbo on 15/2/14.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "UIPopoverDatePicker.h"

@implementation UIPopoverDatePicker

+ (instancetype)popoverDatePickerStyle:(DateStyle)style
{
    UIPopoverDatePicker* pRet = nil;
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"UIPopoverDatePicker" owner:self options:nil];
    if ([nibs count] > 0)
    {
        pRet = (UIPopoverDatePicker*)[nibs objectAtIndex:0];
        [pRet setupWithStyle:style];
    }
    
    return pRet;
}

+ (instancetype)popoverDatePickerStyle:(DateStyle)style withTitle:(NSString*)title
{
    UIPopoverDatePicker* pRet = [[self class] popoverDatePickerStyle:style];
    [pRet setTitle:title];
    return pRet;
}

- (void)setupWithStyle:(DateStyle)style
{
    self.resultDate                 = @"";
    self.resultBlock                = nil;
    self.changedBlock               = nil;
    self.cancleBlock                = nil;

    self.changeTitleWhenDateChanged = YES;
    
    // 边框圆角
    self.layer.borderColor               = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth               = 1.0f;
    self.layer.cornerRadius              = 4.0f;
    self.clipsToBounds                   = YES;
    
    self.okButton.layer.borderWidth      = 0.0f;
    self.okButton.layer.cornerRadius     = 4.0f;
    self.okButton.clipsToBounds          = YES;

    self.cancleButton.layer.borderWidth  = 0.0f;
    self.cancleButton.layer.cornerRadius = 4.0f;
    self.cancleButton.clipsToBounds      = YES;
    
    // 配置Frame
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat xOffset = POPOVER_DATE_PICKER_X_OFFSET;
    CGFloat xWidth  = appFrame.size.width - xOffset * 2;
    CGFloat yHeight = POPOVER_DATE_PICKER_HEIGHT;
    CGFloat yOffset = (appFrame.size.height - yHeight) * 0.5f;
    CGRect popFrame = CGRectMake(xOffset, yOffset, xWidth, yHeight);
    
    self.frame      = popFrame;
    
    // 背景
    _overlayView                 = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    // DatePicker
    _datePicker = [[UUDatePicker alloc] initWithframe:CGRectMake(0, 0, xWidth, self.datePickerView.frame.size.height)
                                             Delegate:self
                                          PickerStyle:style];
    [self.datePickerView addSubview:_datePicker];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)bindView:(UIView*)view
{
    _bindView = view;
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self fadeIn];
}

- (void)dismiss
{
    [self fadeOut];
}

- (void)scrollToNow
{
    NSDate* now = [NSDate date];
    [_datePicker setScrollToDate:now];
}

- (void)scrollToDate:(id)date
{
    if ([date isKindOfClass:[NSString class]])
    {
        NSDate* dt = [(NSString*)date toDate];
        [_datePicker setScrollToDate:dt];
    }
    else if ([date isKindOfClass:[NSDate class]])
    {
        [_datePicker setScrollToDate:(NSDate*)date];
    }
}

- (void)maxLimitDate:(id)date
{
    if ([date isKindOfClass:[NSString class]])
    {
        NSDate* dt = [(NSString*)date toDate];
        [_datePicker setMaxLimitDate:dt];
    }
    else if ([date isKindOfClass:[NSDate class]])
    {
        [_datePicker setMaxLimitDate:(NSDate*)date];
    }
}

- (void)minLimitDate:(id)date
{
    if ([date isKindOfClass:[NSString class]])
    {
        NSDate* dt = [(NSString*)date toDate];
        [_datePicker setMinLimitDate:dt];
    }
    else if ([date isKindOfClass:[NSDate class]])
    {
        [_datePicker setMinLimitDate:(NSDate*)date];
    }
}

- (IBAction)onOkButtonTouch:(id)sender
{
    // call block
    if (self.resultBlock != nil)
    {
        self.resultBlock(self.resultDate);
    }
    
    // call delegate
    if ([self.delegate respondsToSelector:@selector(datePicker:didSelectedDate:)])
    {
        [self.delegate datePicker:self didSelectedDate:self.resultDate];
    }
    
    [self dismiss];
}

- (IBAction)onCancleButtonTouch:(id)sender
{
    // call block
    if (self.cancleBlock != nil)
    {
        self.cancleBlock();
    }
    
    // call delegate
    if ([self.delegate respondsToSelector:@selector(datePickerCancled:)])
    {
        [self.delegate datePickerCancled:self];
    }
    
    [self dismiss];
}

#pragma mark - animations

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:POPOVER_DATE_PICKER_ANIMATE_DUR animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:POPOVER_DATE_PICKER_ANIMATE_DUR animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [_overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - UITouch

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self onCancleButtonTouch:nil];
}

#pragma mark - UUDatePickerDelegate

- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay
{
    if (_datePicker.datePickerStyle == UUDateStyle_YearMonthDayHourMinute)
    {
        self.resultDate = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", year, month, day, hour, minute];
    }
    else if (_datePicker.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        self.resultDate = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    }
    else if (_datePicker.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        self.resultDate = [NSString stringWithFormat:@"%@-%@ %@:%@", month, day, hour, minute];
    }
    else if (_datePicker.datePickerStyle == UUDateStyle_HourMinute)
    {
        self.resultDate = [NSString stringWithFormat:@"%@:%@", hour, month];
    }

    // 修改标题为当前选择的日期时间
    if (self.changeTitleWhenDateChanged)
    {
        self.titleLabel.text = self.resultDate;
    }
    
    // call block
    if (self.changedBlock != nil)
    {
        self.changedBlock(self.resultDate);
    }

    // call delegate
    if ([self.delegate respondsToSelector:@selector(datePicker:didChangedDate:)])
    {
        [self.delegate datePicker:self didChangedDate:self.resultDate];
    }
}

@end
