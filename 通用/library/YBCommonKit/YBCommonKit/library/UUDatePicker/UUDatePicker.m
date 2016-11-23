//
//  UUDatePicker.m
//
//  Created by shake on 14-7-24.
//  Modifyed by AnYanbo on 15/2/6.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "UUDatePicker.h"
#import "UUDatePicker_DateModel.h"

#define UUPICKER_MAXDATE                    (2050)
#define UUPICKER_MINDATE                    (1970)

#define UUPICKER_MONTH                      (12)
#define UUPICKER_HOUR                       (24)
#define UUPICKER_MINUTE                     (60)

#define UUPICKER_YEAR_EXT                   (@"年")
#define UUPICKER_MONTH_EXT                  (@"月")
#define UUPICKER_DAY_EXT                    (@"日")
#define UUPICKER_HOUR_EXT                   (@"时")
#define UUPICKER_MINUTE_EXT                 (@"分")

#define UU_GRAY                             ([UIColor redColor]);
#define UU_BLACK                            ([UIColor blackColor]);

#ifndef isIOS7
#define isIOS7  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
#endif

@interface UUDatePicker ()
{
    // 选择控件
    UIPickerView* _myPickerView;
    
    // 日期存储数组
    NSMutableArray* _yearArray;
    NSMutableArray* _monthArray;
    NSMutableArray* _dayArray;
    NSMutableArray* _hourArray;
    NSMutableArray* _minuteArray;
    
    // 限制model
    UUDatePicker_DateModel* _maxDateModel;
    UUDatePicker_DateModel* _minDateModel;
    
    // 记录位置
    NSInteger _yearIndex;
    NSInteger _monthIndex;
    NSInteger _dayIndex;
    NSInteger _hourIndex;
    NSInteger _minuteIndex;
    
    // 执行一次playTheDelegate
    dispatch_once_t oncePlayDelegate;
}

@end

@implementation UUDatePicker

- (id)initWithframe:(CGRect)frame Delegate:(id<UUDatePickerDelegate>)delegate PickerStyle:(DateStyle)uuDateStyle
{
    self = [self initWithFrame:frame];
    if (self != nil)
    {
        self.datePickerStyle = uuDateStyle;
        self.delegate        = delegate;
    }
    return self;
}

- (id)initWithframe:(CGRect)frame PickerStyle:(DateStyle)uuDateStyle didSelected:(FinishBlock)finishBlock
{
    self = [self initWithFrame:frame];
    if (self != nil)
    {
        self.datePickerStyle = uuDateStyle;
        self.finishBlock     = finishBlock;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        self.backgroundColor = [UIColor whiteColor];

    }
    return self;
}

- (void)setup
{
    _yearArray   = [self setupArray:_yearArray];
    _monthArray  = [self setupArray:_monthArray];
    _dayArray    = [self setupArray:_dayArray];
    _hourArray   = [self setupArray:_hourArray];
    _minuteArray = [self setupArray:_minuteArray];
    
    // 赋值
    for (int i=0; i<UUPICKER_MINUTE; i++)
    {
        NSString* num = [NSString stringWithFormat:@"%02d",i];
        if (i > 0 && i <= UUPICKER_MONTH)
            [_monthArray addObject:num];
        if (i<UUPICKER_HOUR)
            [_hourArray addObject:num];
        [_minuteArray addObject:num];
    }
    for (int i = UUPICKER_MINDATE; i < UUPICKER_MAXDATE; i++)
    {
        NSString* num = [NSString stringWithFormat:@"%d",i];
        [_yearArray addObject:num];
    }
    
    // 最大最小限制
    if (self.maxLimitDate)
    {
        _maxDateModel = [[UUDatePicker_DateModel alloc] initWithDate:self.maxLimitDate];
    }
    else
    {
        self.maxLimitDate = [self dateFromString:@"204912312359" withFormat:@"yyyyMMddHHmm"];
        _maxDateModel = [[UUDatePicker_DateModel alloc] initWithDate:self.maxLimitDate];
    }
    
    // 最小限制
    if (self.minLimitDate)
    {
        _minDateModel = [[UUDatePicker_DateModel alloc] initWithDate:self.minLimitDate];
    }
    else
    {
        self.minLimitDate = [self dateFromString:@"197001010000" withFormat:@"yyyyMMddHHmm"];
        _minDateModel = [[UUDatePicker_DateModel alloc] initWithDate:self.minLimitDate];
    }
    
    // 获取当前日期，储存当前时间位置
    NSArray *indexArray = [self getNowDate:self.scrollToDate];
    
    if (_myPickerView == nil)
    {
        CGFloat offsetX = 5;
        _myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(offsetX, 0, self.frame.size.width - offsetX * 2, self.frame.size.height)];
        _myPickerView.showsSelectionIndicator = YES;
        _myPickerView.backgroundColor = [UIColor clearColor];
        _myPickerView.delegate = self;
        _myPickerView.dataSource = self;
        [self addSubview:_myPickerView];
    }
    
    // 调整为现在的时间
    for (int i = 0; i < indexArray.count; i++)
    {
        [_myPickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:NO];
    }

    dispatch_once(&oncePlayDelegate, ^(){
        [self playTheDelegate];
    });
}

- (NSMutableArray *)setupArray:(id)mutableArray
{
    if (mutableArray)
    {
        [mutableArray removeAllObjects];
    }
    else
    {
        mutableArray = [NSMutableArray array];
    }
    return mutableArray;
}

// 进行初始化
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self setup];
}

#pragma mark - 调整颜色

// 获取当前时间解析及位置
- (NSArray *)getNowDate:(NSDate *)date
{
    NSDate* dateShow;
    if (date != nil)
    {
        dateShow = date;
    }
    else
    {
        dateShow = [NSDate date];
    }
    
    UUDatePicker_DateModel *model = [[UUDatePicker_DateModel alloc]initWithDate:dateShow];
    
    [self DaysfromYear:[model.year integerValue] andMonth:[model.month integerValue]];
    
    _yearIndex   = [model.year intValue] - UUPICKER_MINDATE;
    _monthIndex  = [model.month intValue] - 1;
    _dayIndex    = [model.day intValue] - 1;
    _hourIndex   = [model.hour intValue] - 0;
    _minuteIndex = [model.minute intValue] - 0;
    
    NSNumber *year   = [NSNumber numberWithInteger:_yearIndex];
    NSNumber *month  = [NSNumber numberWithInteger:_monthIndex];
    NSNumber *day    = [NSNumber numberWithInteger:_dayIndex];
    NSNumber *hour   = [NSNumber numberWithInteger:_hourIndex];
    NSNumber *minute = [NSNumber numberWithInteger:_minuteIndex];

    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute)
    {
        return @[year,month,day,hour,minute];
    }
    if (self.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        return @[year,month,day];
    }
    if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        return @[month,day,hour,minute];
    }
    if (self.datePickerStyle == UUDateStyle_HourMinute)
    {
        return @[hour,minute];
    }
    return nil;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute)
    {
        return 5;
    }
    if (self.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        return 3;
    }
    if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        return 4;
    }
    if (self.datePickerStyle == UUDateStyle_HourMinute)
    {
        return 2;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute)
    {
        if (component == 0)
            return UUPICKER_MAXDATE - UUPICKER_MINDATE;
        if (component == 1)
            return UUPICKER_MONTH;
        if (component == 2)
            return [self DaysfromYear:[_yearArray[_yearIndex] integerValue] andMonth:[_monthArray[_monthIndex] integerValue]];
        if (component == 3)
            return UUPICKER_HOUR;
        if (component == 4)
            return UUPICKER_MINUTE;
    }
    if (self.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        if (component == 0)
            return UUPICKER_MAXDATE-UUPICKER_MINDATE;
        if (component == 1)
            return UUPICKER_MONTH;
        if (component == 2)
            return [self DaysfromYear:[_yearArray[_yearIndex] integerValue] andMonth:[_monthArray[_monthIndex] integerValue]];
    }
    if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        if (component == 0)
            return UUPICKER_MONTH;
        if (component == 1)
            return [self DaysfromYear:[_yearArray[_yearIndex] integerValue] andMonth:[_monthArray[_monthIndex] integerValue]];
        if (component == 2)
            return UUPICKER_HOUR;
        if (component == 3)
            return UUPICKER_MINUTE;
    }
    if (self.datePickerStyle == UUDateStyle_HourMinute)
    {
        if (component == 0)
            return UUPICKER_HOUR;
        else
            return UUPICKER_MINUTE;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width = pickerView.frame.size.width;
    
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute)
    {
        CGFloat w = (width - 30) / 5;
        if (component==0) return w + 15;
        if (component==1) return w;
        if (component==2) return w;
        if (component==3) return w;
        if (component==4) return w;
    }
    else if (self.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        CGFloat w = width / 3;
        if (component==0) return w;
        if (component==1) return w;
        if (component==2) return w;
    }
    else if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        CGFloat w = width / 4;
        if (component==0) return w;
        if (component==1) return w;
        if (component==2) return w;
        if (component==3) return w;
    }
    else if (self.datePickerStyle == UUDateStyle_HourMinute)
    {
        CGFloat w = width / 2;
        if (component==0) return w;
        if (component==1) return w;
    }

    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (self.datePickerStyle)
    {
        case UUDateStyle_YearMonthDayHourMinute:
        {
            if (component == 0) _yearIndex   = row;
            if (component == 1) _monthIndex  = row;
            if (component == 2) _dayIndex    = row;
            if (component == 3) _hourIndex   = row;
            if (component == 4) _minuteIndex = row;
            if (component == 0 || component == 1 || component == 2)
            {
                [self DaysfromYear:[_yearArray[_yearIndex] integerValue] andMonth:[_monthArray[_monthIndex] integerValue]];
                
                if (_dayIndex >= [_dayArray count])
                {
                    _dayIndex = _dayArray.count - 1;
                }
            }
            break;
        }
        case UUDateStyle_YearMonthDay:
        {
            if (component == 0) _yearIndex  = row;
            if (component == 1) _monthIndex = row;
            if (component == 2) _dayIndex   = row;
            if (component == 0 || component == 1)
            {
                [self DaysfromYear:[_yearArray[_yearIndex] integerValue] andMonth:[_monthArray[_monthIndex] integerValue]];
                if (_dayIndex >= [_dayArray count])
                {
                    _dayIndex = _dayArray.count - 1;
                }
            }
            break;
        }
        case UUDateStyle_MonthDayHourMinute:
        {
            if (component == 1) _dayIndex    = row;
            if (component == 2) _hourIndex   = row;
            if (component == 3) _minuteIndex = row;
            if (component == 0)
            {
                _monthIndex = row;
                if (_dayIndex >= [_dayArray count])
                {
                    _dayIndex = _dayArray.count - 1;
                }
            }
            [self DaysfromYear:[_yearArray[_yearIndex] integerValue] andMonth:[_monthArray[_monthIndex] integerValue]];
            break;
        }
        case UUDateStyle_HourMinute:
        {
            if (component == 3) _hourIndex   = row;
            if (component == 4) _minuteIndex = row;
            break;
        }
        default:
            break;
    }
    [pickerView reloadAllComponents];
    [self playTheDelegate];
}

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* customLabel = (UILabel *)view;
    if (!customLabel)
    {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:16]];
    }
    UIColor* textColor = [UIColor blackColor];
    NSString* title;

    switch (self.datePickerStyle)
    {
        case UUDateStyle_YearMonthDayHourMinute:
        {
            if (component == 0)
            {
                if (row >= [_yearArray count])
                    row = [_yearArray count] - 1;
                
                title = [_yearArray[row] stringByAppendingString:UUPICKER_YEAR_EXT];
                textColor = [self returnYearColorRow:row];
            }
            if (component == 1)
            {
                if (row >= [_monthArray count])
                    row = [_monthArray count] - 1;
                
                title = [_monthArray[row] stringByAppendingString:UUPICKER_MONTH_EXT];
                textColor = [self returnMonthColorRow:row];
            }
            if (component == 2)
            {
                if (row >= [_dayArray count])
                    row = [_dayArray count] - 1;
                
                title = [_dayArray[row] stringByAppendingString:UUPICKER_DAY_EXT];
                textColor = [self returnDayColorRow:row];
            }
            if (component == 3)
            {
                if (row >= [_hourArray count])
                    row = [_hourArray count] - 1;

                title = [_hourArray[row] stringByAppendingString:UUPICKER_HOUR_EXT];
                textColor = [self returnHourColorRow:row];
            }
            if (component == 4)
            {
                if (row >= [_minuteArray count])
                    row = [_minuteArray count] - 1;
                
                title = [_minuteArray[row] stringByAppendingString:UUPICKER_MINUTE_EXT];
                textColor = [self returnMinuteColorRow:row];
            }
            break;
        }
        case UUDateStyle_YearMonthDay:
        {
            if (component == 0)
            {
                if (row >= [_yearArray count])
                    row = [_yearArray count] - 1;
                
                title = [_yearArray[row] stringByAppendingString:UUPICKER_YEAR_EXT];
                textColor = [self returnYearColorRow:row];
            }
            if (component == 1)
            {
                if (row >= [_monthArray count])
                    row = [_monthArray count] - 1;
                
                title = [_monthArray[row] stringByAppendingString:UUPICKER_MONTH_EXT];
                textColor = [self returnMonthColorRow:row];
            }
            if (component == 2)
            {
                if (row >= [_dayArray count])
                    row = [_dayArray count] - 1;
                
                title = [_dayArray[row] stringByAppendingString:UUPICKER_DAY_EXT];
                textColor = [self returnDayColorRow:row];
            }
            break;
        }
        case UUDateStyle_MonthDayHourMinute:
        {
            if (component == 0)
            {
                if (row >= [_monthArray count])
                    row = [_monthArray count] - 1;
                
                title = [_monthArray[row] stringByAppendingString:UUPICKER_MONTH_EXT];
                textColor = [self returnMonthColorRow:row];
            }
            if (component == 1)
            {
                if (row >= [_dayArray count])
                    row = [_dayArray count] - 1;
                
                title = [_dayArray[row] stringByAppendingString:UUPICKER_DAY_EXT];
                textColor = [self returnDayColorRow:row];
            }
            if (component == 2)
            {
                if (row >= [_hourArray count])
                    row = [_hourArray count] - 1;
                
                title = [_hourArray[row] stringByAppendingString:UUPICKER_HOUR_EXT];
                textColor = [self returnHourColorRow:row];
            }
            if (component == 3)
            {
                if (row >= [_minuteArray count])
                    row = [_minuteArray count] - 1;
                
                title = [_minuteArray[row] stringByAppendingString:UUPICKER_MINUTE_EXT];
                textColor = [self returnMinuteColorRow:row];
            }
            break;
        }
        case UUDateStyle_HourMinute:
        {
            if (component == 0)
            {
                if (row >= [_hourArray count])
                    row = [_hourArray count] - 1;
                
                title = [_hourArray[row] stringByAppendingString:UUPICKER_HOUR_EXT];
                textColor = [self returnHourColorRow:row];
            }
            if (component == 1)
            {
                if (row >= [_minuteArray count])
                    row = [_minuteArray count] - 1;
                
                title = [_minuteArray[row] stringByAppendingString:UUPICKER_MINUTE_EXT];
                textColor = [self returnMinuteColorRow:row];
            }
            break;
        }
        default:
            break;
    }
    customLabel.text      = title;
    customLabel.textColor = textColor;
    return customLabel;
}

#pragma mark - 代理回调方法

- (void)playTheDelegate
{
    // 数组下标检测
    if (_yearIndex >= [_yearArray count])
        _yearIndex = _yearArray.count - 1;
    
    if (_monthIndex >= [_monthArray count])
        _monthIndex = _monthArray.count - 1;
    
    if (_dayIndex >= [_dayArray count])
        _dayIndex = _dayArray.count - 1;
    
    if (_hourIndex >= [_hourArray count])
        _hourIndex = _hourArray.count - 1;
    
    if (_minuteIndex >= [_minuteArray count])
        _minuteIndex = _minuteArray.count - 1;
    
    NSString* dateString = [NSString stringWithFormat:@"%@%@%@%@%@",
                            _yearArray[_yearIndex],
                            _monthArray[_monthIndex],
                            _dayArray[_dayIndex],
                            _hourArray[_hourIndex],
                            _minuteArray[_minuteIndex]];
    
    NSDate* date = [self dateFromString:dateString withFormat:@"yyyyMMddHHmm"];
    if ([date compare:self.minLimitDate] == NSOrderedAscending)             // <
    {
        NSArray* array = [self getNowDate:self.minLimitDate];
        for (int i = 0; i < array.count; i++)
        {
            [_myPickerView selectRow:[array[i] integerValue] inComponent:i animated:YES];
        }
    }
    else if ([date compare:self.maxLimitDate] == NSOrderedDescending)       // >
    {
        NSArray* array = [self getNowDate:self.maxLimitDate];
        for (int i = 0; i < array.count; i++)
        {
            [_myPickerView selectRow:[array[i] integerValue] inComponent:i animated:YES];
        }
    }
    
    NSString *strWeekDay = [self getWeekDayWithYear:_yearArray[_yearIndex] month:_monthArray[_monthIndex] day:_dayArray[_dayIndex]];
    
    //block 回调
    if (self.finishBlock != nil)
    {
        self.finishBlock(_yearArray[_yearIndex],
                         _monthArray[_monthIndex],
                         _dayArray[_dayIndex],
                         _hourArray[_hourIndex],
                         _minuteArray[_minuteIndex],
                         strWeekDay);
    }
    //代理回调
    if ([self.delegate respondsToSelector:@selector(uuDatePicker:year:month:day:hour:minute:weekDay:)])
    {
        [self.delegate uuDatePicker:self
                               year:_yearArray[_yearIndex]
                              month:_monthArray[_monthIndex]
                                day:_dayArray[_dayIndex]
                               hour:_hourArray[_hourIndex]
                             minute:_minuteArray[_minuteIndex]
                            weekDay:strWeekDay];
    }
}

#pragma mark - 数据处理

/**
 *  通过日期计算星期
 *
 *  @param year  年
 *  @param month 月
 *  @param day   日
 *
 *  @return 星期一 至 星期日
 */
- (NSString*)getWeekDayWithYear:(NSString*)year month:(NSString*)month day:(NSString*)day
{
    NSInteger yearInt  = [year integerValue];
    NSInteger monthInt = [month integerValue];
    NSInteger dayInt   = [day integerValue];
    int c = 20;                                     //世纪
    int y = (int)yearInt - 1;                       //年
    int d = (int)dayInt;
    int m = (int)monthInt;
    int w = (y + (y / 4) + (c / 4) - 2 * c + (26 * (m + 1) / 10) + d - 1) % 7;
    NSString* weekDay = @"";
    switch (w)
    {
        case 0: weekDay = @"周日"; break;
        case 1: weekDay = @"周一"; break;
        case 2: weekDay = @"周二"; break;
        case 3: weekDay = @"周三"; break;
        case 4: weekDay = @"周四"; break;
        case 5: weekDay = @"周五"; break;
        case 6: weekDay = @"周六"; break;
        default:break;
    }
    return weekDay;
}

/**
 *  根据日期字符串转换NSDate
 *
 *  @param string 日期字符串
 *  @param format 格式化字符串
 *
 *  @return NSDate
 */
- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format
{
    return [string toDateWithFormat:format];
}

/**
 *  通过年月计算天数
 *
 *  @param year  年
 *  @param month 月
 *
 *  @return 天数
 */
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    NSInteger dataCount = 0;
    
    BOOL isLeapYear = num_year % 4 == 0 ? (num_year % 100==0? (num_year % 400 == 0 ? YES : NO) : YES) : NO;
    
    if (num_month == 2)
    {
        if (isLeapYear)
        {
            dataCount = 29;
        }
        else
        {
            dataCount = 28;
        }
    }
    else if (num_month == 4 || num_month == 6 || num_month == 9 || num_month == 11)
    {
        dataCount = 30;
    }
    else
    {
        dataCount = 31;
    }
    
    [self setdayArray:dataCount];
    return dataCount;
}

/**
 *  设置天数数组
 *
 *  @param num 天数
 */
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    for (int i = 1; i <= num; i++)
    {
        [_dayArray addObject:[NSString stringWithFormat:@"%02d", i]];
    }
}

// Modify by AnYanbo fix min ~ max bug.
- (UIColor*)returnYearColorRow:(NSInteger)row
{
    NSString* d = [NSString stringWithFormat:@"%@-01-01 00:00", _yearArray[row]];
    NSDate* date = [d toDate];
    
    NSString* minD = [NSString stringWithFormat:@"%@-01-01 00:00", _minDateModel.year];
    NSDate* minDate = [minD toDate];
    
    NSString* maxD = [NSString stringWithFormat:@"%@-01-01 00:00", _maxDateModel.year];
    NSDate* maxDate = [maxD toDate];
    
    if ([date compare:minDate] == NSOrderedAscending)
    {
        return UU_GRAY;
    }
    else if ([date compare:maxDate] == NSOrderedDescending)
    {
        return UU_GRAY;
    }
    
    return UU_BLACK;
}

// Modify by AnYanbo fix min ~ max bug.
- (UIColor*)returnMonthColorRow:(NSInteger)row
{
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute ||
        self.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        NSString* d = [NSString stringWithFormat:@"%@-%@-01 00:00", _yearArray[_yearIndex], _monthArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"%@-%@-01 00:00", _minDateModel.year, _minDateModel.month];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"%@-%@-01 00:00", _maxDateModel.year, _maxDateModel.month];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    else if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        NSString* d = [NSString stringWithFormat:@"1970-%@-01 00:00", _monthArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"1970-%@-01 00:00", _minDateModel.month];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"1970-%@-01 00:00", _maxDateModel.month];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    
    return UU_BLACK;
}

// Modify by AnYanbo fix min ~ max bug.
- (UIColor*)returnDayColorRow:(NSInteger)row
{
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute ||
        self.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        NSString* d = [NSString stringWithFormat:@"%@-%@-%@ 00:00", _yearArray[_yearIndex], _monthArray[_monthIndex], _dayArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"%@-%@-%@ 00:00", _minDateModel.year, _minDateModel.month, _minDateModel.day];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"%@-%@-%@ 00:00", _maxDateModel.year, _maxDateModel.month, _maxDateModel.day];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    else if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        NSString* d = [NSString stringWithFormat:@"1970-%@-%@ 00:00", _monthArray[_monthIndex], _dayArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"1970-%@-%@ 00:00", _minDateModel.month, _minDateModel.day];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"1970-%@-%@ 00:00", _maxDateModel.month, _maxDateModel.day];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    
    return UU_BLACK;
}

// Modify by AnYanbo fix min ~ max bug.
- (UIColor*)returnHourColorRow:(NSInteger)row
{
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute ||
        self.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        NSString* d = [NSString stringWithFormat:@"%@-%@-%@ %@:00", _yearArray[_yearIndex], _monthArray[_monthIndex], _dayArray[_dayIndex], _hourArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"%@-%@-%@ %@:00", _minDateModel.year, _minDateModel.month, _minDateModel.day, _minDateModel.hour];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"%@-%@-%@ %@:00", _maxDateModel.year, _maxDateModel.month, _maxDateModel.day, _maxDateModel.hour];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    else if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        NSString* d = [NSString stringWithFormat:@"1970-%@-%@ %@:00", _monthArray[_monthIndex], _dayArray[_dayIndex], _hourArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"1970-%@-%@ %@:00", _minDateModel.month, _minDateModel.day, _minDateModel.hour];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"1970-%@-%@ %@:00", _maxDateModel.month, _maxDateModel.day, _maxDateModel.hour];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    else if (self.datePickerStyle == UUDateStyle_HourMinute)
    {
        NSString* d = [NSString stringWithFormat:@"1970-01-01 %@:00", _hourArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"1970-01-01 %@:00", _minDateModel.hour];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"1970-01-01 %@:00", _maxDateModel.hour];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    
    return UU_BLACK;
}

// Modify by AnYanbo fix min ~ max bug.
- (UIColor*)returnMinuteColorRow:(NSInteger)row
{
    if (self.datePickerStyle == UUDateStyle_YearMonthDayHourMinute ||
        self.datePickerStyle == UUDateStyle_YearMonthDay)
    {
        NSString* d = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", _yearArray[_yearIndex], _monthArray[_monthIndex], _dayArray[_dayIndex], _hourArray[_hourIndex], _minuteArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", _minDateModel.year, _minDateModel.month, _minDateModel.day, _minDateModel.hour, _minDateModel.minute];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", _maxDateModel.year, _maxDateModel.month, _maxDateModel.day, _maxDateModel.hour, _maxDateModel.minute];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    else if (self.datePickerStyle == UUDateStyle_MonthDayHourMinute)
    {
        NSString* d = [NSString stringWithFormat:@"1970-%@-%@ %@:%@", _monthArray[_monthIndex], _dayArray[_dayIndex], _hourArray[_hourIndex], _minuteArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"1970-%@-%@ %@:%@", _minDateModel.month, _minDateModel.day, _minDateModel.hour, _minDateModel.minute];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"1970-%@-%@ %@:%@", _maxDateModel.month, _maxDateModel.day, _maxDateModel.hour, _maxDateModel.minute];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    else if (self.datePickerStyle == UUDateStyle_HourMinute)
    {
        NSString* d = [NSString stringWithFormat:@"1970-01-01 %@:%@", _hourArray[_hourIndex], _minuteArray[row]];
        NSDate* date = [d toDate];
        
        NSString* minD = [NSString stringWithFormat:@"1970-01-01 %@:%@", _minDateModel.hour, _minDateModel.minute];
        NSDate* minDate = [minD toDate];
        
        NSString* maxD = [NSString stringWithFormat:@"1970-01-01 %@:%@", _maxDateModel.hour, _maxDateModel.minute];
        NSDate* maxDate = [maxD toDate];
        
        if ([date compare:minDate] == NSOrderedAscending)
        {
            return UU_GRAY;
        }
        else if ([date compare:maxDate] == NSOrderedDescending)
        {
            return UU_GRAY;
        }
    }
    
    return UU_BLACK;
}

@end
