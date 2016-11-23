//
//  NSString+JID.m
//  EnjoyDQ
//
//  Created by AnYanbo on 14-6-26.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import "NSString+JID.h"

@implementation NSString (JID)

+ (NSString*)deviceTokenWithData:(NSData*)data
{
    NSString* token = nil;
    @try
    {
        token = [[data description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    @catch (NSException *exception)
    {
        token = @"";
    }
    
    return token;
}

- (NSString*)stringWithOutJID
{
    NSString* newString = @"";
    NSArray* array = [self componentsSeparatedByString:@"@"];
    if ([array count] > 1)
    {
        newString = [array objectAtIndex:0];
        return newString;
    }
    
    return self;
}

- (NSString*)stringWithJID
{
    NSArray* array = [self componentsSeparatedByString:@"@"];
    if ([array count] > 1)
    {
        return self;
    }
    else
    {
        NSString* newString = [NSString stringWithFormat:@"%@@youdro", self];
        return newString;
    }
}

@end
