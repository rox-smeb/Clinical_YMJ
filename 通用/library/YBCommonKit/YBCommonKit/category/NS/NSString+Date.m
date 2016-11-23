//
//  NSString+Date.m
//  EnjoyDQ
//
//  Created by AnYanbo on 14-6-28.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSDate (String)

- (NSString*)toString
{
    return [self toStringWithFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSString*)toStringWithFormat:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [dateFormatter stringFromDate:self];
}

@end

@implementation NSString (NSDate)


/**
 * Given the reference date and return a pretty date string to show
 *
 * @param refrence the date to refrence
 *
 * @return a pretty date string, like "just now", "1 minute ago", "2 weeks ago", etc
 */
- (NSString*)prettyDateString
{
    NSString *suffix = @"前";
    NSDate* interval = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSTimeInterval different = interval.timeIntervalSinceNow;

    different = different < 0.0 ? -different : different;
    
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
    int weeks  = (int)ceil(dayDifferent / 7);
    int months = (int)ceil(dayDifferent / 30);
    int years  = (int)ceil(dayDifferent / 365);
    
    // It belongs to today
    if (dayDifferent <= 0)
    {
        // lower than 60 seconds
        if (different < 60)
        {
            return @"刚刚";
        }
        
        // lower than 120 seconds => one minute and lower than 60 seconds
        if (different < 120) {
            return [NSString stringWithFormat:@"1分钟%@", suffix];
        }
        
        // lower than 60 minutes
        if (different < 60 * 60) {
            return [NSString stringWithFormat:@"%d分钟%@", (int)floor(different / 60), suffix];
        }
        
        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
        if (different < 7200) {
            return [NSString stringWithFormat:@"1小时%@", suffix];
        }
        
        // lower than one day
        if (different < 86400) {
            return [NSString stringWithFormat:@"%d小时%@", (int)floor(different / 3600), suffix];
        }
    }
    // lower than one week
    else if (days < 7) {
        return [NSString stringWithFormat:@"%d天%@", days, suffix];
    }
    // lager than one week but lower than a month
    else if (weeks < 4) {
        return [NSString stringWithFormat:@"%d周%@", weeks, suffix];
    }
    // lager than a month and lower than a year
    else if (months < 12) {
        return [NSString stringWithFormat:@"%d个月%@", months, suffix];
    }
    // lager than a year
    else {
        return [NSString stringWithFormat:@"%d年%@", years, suffix];
    }
    
    return self;
}

- (NSDate*)toDate
{
    return [self toDateWithFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSDate*)toDateWithFormat:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    
    NSDate* date = [formatter dateFromString:self];
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate* localeDate = [date  dateByAddingTimeInterval:interval];
    
    return localeDate;
}

@end