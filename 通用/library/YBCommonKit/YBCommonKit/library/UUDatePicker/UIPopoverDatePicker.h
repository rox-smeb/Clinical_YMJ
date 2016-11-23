//
//  UIPopoverDatePicker.h
//  UUDatePikcer_Max_Min
//
//  Created by AnYanbo on 15/2/14.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUDatePicker.h"

#define POPOVER_DATE_PICKER_ANIMATE_DUR             (0.15f)
#define POPOVER_DATE_PICKER_X_OFFSET                (20)
#define POPOVER_DATE_PICKER_HEIGHT                  (300.0f)

@class UIPopoverDatePicker;

// blocks
typedef void (^PopoverResultBlock)(NSString* date);
typedef void (^PopoverResultChangedBlock)(NSString* date);
typedef void (^PopoverCancleBlock)();

// delegate
@protocol UIPopoverDatePickerDelegate <NSObject>

- (void)datePicker:(UIPopoverDatePicker*)picker didSelectedDate:(NSString*)date;
- (void)datePicker:(UIPopoverDatePicker *)picker didChangedDate:(NSString *)date;
- (void)datePickerCancled:(UIPopoverDatePicker *)picker;

@end

// UIPopoverDatePicker
@interface UIPopoverDatePicker : UIView <UUDatePickerDelegate>
{
    UIView*       _bindView;
    UIControl*    _overlayView;
    UUDatePicker* _datePicker;
}

@property (strong, nonatomic) PopoverResultBlock resultBlock;                   // 选择结果回调
@property (strong, nonatomic) PopoverResultChangedBlock changedBlock;           // 选择发生改变回调
@property (strong, nonatomic) PopoverCancleBlock cancleBlock;                   // 取消回调

@property (assign, nonatomic) BOOL changeTitleWhenDateChanged;                  // 当日期发生改变是否修改标题
@property (strong, nonatomic) NSString* resultDate;                             // 日期时间选择结果

@property (weak, nonatomic) id<UIPopoverDatePickerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPickDateLabel;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;

+ (instancetype)popoverDatePickerStyle:(DateStyle)style;
+ (instancetype)popoverDatePickerStyle:(DateStyle)style withTitle:(NSString*)title;

- (void)show;
- (void)dismiss;
- (void)scrollToNow;
- (void)scrollToDate:(id)date;
- (void)maxLimitDate:(id)date;
- (void)minLimitDate:(id)date;

@end
