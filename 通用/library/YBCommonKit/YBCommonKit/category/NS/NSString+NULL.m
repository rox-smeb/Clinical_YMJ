//
//  NSString+NULL.m
//  EnjoyDQ
//
//  Created by AnYanbo on 14-6-27.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import "NSString+NULL.h"

@implementation NSObject (null)

+ (NSString*)fuckNULL:(NSObject*)obj;
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]])
        return @"";
    return obj;
}

+ (NSString*)fuckNULL:(NSObject*)obj Place:(NSString*)obj1
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]])
    {
        if (obj1 == nil || [obj1 isKindOfClass:[NSNull class]])
            return @"";
        else
            return obj1;
    }
    return obj;
}

+ (NSString*)stringWithBOOL:(BOOL)b
{
    NSString* ret = @"false";
    if (b)
    {
        ret = @"true";
    }
    return ret;
}

@end
