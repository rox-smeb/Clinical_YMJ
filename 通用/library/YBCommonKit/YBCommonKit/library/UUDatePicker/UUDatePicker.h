//
//  UUDatePicker.h
//
//  Created by shake on 14-7-24.
//  Modifyed by AnYanbo on 15/2/6.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UUDatePicker;

typedef enum
{
    UUDateStyle_YearMonthDayHourMinute = 0,
    UUDateStyle_YearMonthDay,
    UUDateStyle_MonthDayHourMinute,
    UUDateStyle_HourMinute
} DateStyle;

typedef void (^FinishBlock)(NSString * year,
                            NSString * month,
                            NSString * day,
                            NSString * hour,
                            NSString * minute,
                            NSString * weekDay);


@protocol UUDatePickerDelegate <NSObject>

- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay;

@end


@interface UUDatePicker : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, assign) id <UUDatePickerDelegate> delegate;
@property (nonatomic, assign) DateStyle datePickerStyle;
@property (nonatomic, copy) FinishBlock finishBlock;

@property (nonatomic, strong) NSDate *scrollToDate;                     // 滚到指定日期
@property (nonatomic, strong) NSDate *maxLimitDate;                     // 限制最大时间（没有设置默认2049）
@property (nonatomic, strong) NSDate *minLimitDate;                     // 限制最小时间（没有设置默认1970）

- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
- (id)initWithframe:(CGRect)frame Delegate:(id<UUDatePickerDelegate>)delegate PickerStyle:(DateStyle)uuDateStyle;
- (id)initWithframe:(CGRect)frame PickerStyle:(DateStyle)uuDateStyle didSelected:(FinishBlock)finishBlock;

@end
