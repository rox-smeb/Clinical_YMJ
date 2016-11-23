
//
//  NSStringx.m
//  果动校园
//
//  Created by AnYanbo on 15/3/3.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

- (BOOL)isIntValue
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isFloatValue
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)onlySpace
{
    if ([self isEqualToString:@""])
    {
        return NO;
    }
    
    NSString* tmp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (tmp == nil || [tmp isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isMobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|7[06-8]|8[0125-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,178,182,187,188
     12         */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,176,185,186
     17         */
    NSString *CU = @"^1(3[0-2]|5[256]|76|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString *CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , CT];
    
    return [regextestmobile evaluateWithObject:self]  ||
           [regextestcm evaluateWithObject:self]      ||
           [regextestct evaluateWithObject:self]      ||
           [regextestcu evaluateWithObject:self];
}

- (BOOL)isAvailability
{
    if ([self isEqualToString:@""])
    {
        return NO;
    }
    return YES;
}

- (NSString*)encryptMobileWithString:(NSString*)str
{
    if ([str isAvailability] == NO)
    {
        str = @"*";
    }
    
    NSInteger len = [self length];
    if (len > 6)
    {
        NSRange range = NSMakeRange(3, len - 6);
        
        NSMutableString* replace = [NSMutableString string];
        for (int i = 0; i < len - 6; i++)
        {
            [replace appendString:str];
        }
        
        NSString* ret = [self stringByReplacingCharactersInRange:range withString:replace];
        if ([ret isAvailability])
        {
            return ret;
        }
    }
    return self;
}

@end
