//
//  NSString+Chinese2Pinyin.m
//  PinYin4ObjcExample
//
//  Created by apple on 14-6-12.
//  Copyright (c) 2014年 kimziv. All rights reserved.
//

#import "NSString+Chinese2Pinyin.h"

@implementation NSString (Chinese2PinYin)

// (NSString*) ChineseString to (NSString*) loewr_Pinyin
-(NSString *) toPinYin
{
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *nsReturnPinyinString = [PinyinHelper toHanyuPinyinStringWithNSString:self withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    return nsReturnPinyinString;
}

// (NSString*) ChineseString to (NSString*) loewr_Pinyin
+(NSString *) chinese2PinYin:(NSString*) nsChineseString
{
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *nsReturnPinyinString = [PinyinHelper toHanyuPinyinStringWithNSString:nsChineseString withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    return nsReturnPinyinString;
}

+(NSString *) chinese2PinYin:(NSString*) nsChineseString withSplit:(NSString*)split;
{
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *nsReturnPinyinString = [PinyinHelper toHanyuPinyinStringWithNSString:nsChineseString withHanyuPinyinOutputFormat:outputFormat withNSString:split];
    return nsReturnPinyinString;
}

@end
