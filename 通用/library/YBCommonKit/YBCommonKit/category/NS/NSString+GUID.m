//
//  NSString+GUID.m
//  TestInput
//
//  Created by AnYanbo on 14-6-25.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import "NSString+GUID.h"

@implementation NSString (GUID)

+ (NSString*)genGUID;
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}

@end
