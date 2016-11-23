//
//  NSString+Unicode.m
//  昆明团购
//
//  Created by AnYanbo on 15/5/14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "NSString+Unicode.h"

@implementation NSString (Unicode)

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (NSString*)urlUnicode2utf8
{
    NSString* tmp = [self stringByReplacingOccurrencesOfString:@"%u" withString:@"\\u"];
    return [NSString replaceUnicode:tmp];
}

- (NSString*)unicode2utf8
{
    return [NSString replaceUnicode:self];
}

- (NSString*)urlDecode
{
    @try
    {
        NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                         (__bridge CFStringRef)self,
                                                                                                                         CFSTR(""),
                                                                                                                         CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        
        return decodedString;
    }
    @catch (NSException *exception)
    {
        return nil;
    }
}

- (NSString*)urlEncode
{
    @try
    {
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                        (CFStringRef)self,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                        kCFStringEncodingUTF8));
        return encodedString;
    }
    @catch (NSException *exception)
    {
        return nil;
    }
}

@end
