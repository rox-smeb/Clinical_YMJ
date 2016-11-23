//
//  NSDictionary+nlObject.m
//  昆明团购
//
//  Created by AnYanbo on 15/5/18.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "NSDictionary+nlObject.h"

@implementation NSDictionary (nlObject)

- (id)nlObjectForKey:(NSString*)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]])
    {
        obj = nil;
    }
    return obj;
}

- (BOOL)boolForKey:(NSString*)key
{
    if (key == nil)
    {
        return NO;
    }
    id obj = [self objectForKey:key];
    if (obj == nil || [obj isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    
    if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])
    {
        if ([obj respondsToSelector:@selector(boolValue)])
        {
            return [obj boolValue];
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

- (NSString*)strObjectForKey:(NSString*)key
{
    if (key == nil)
    {
        return @"";
    }
    
    id obj = [self objectForKey:key];
    if (obj == nil || [obj isKindOfClass:[NSNull class]])
    {
        return @"";
    }

    if ([obj isKindOfClass:[NSNumber class]])
    {
        if ([obj respondsToSelector:@selector(stringValue)])
        {
            return [obj stringValue];
        }
        else
        {
            return @"";
        }
    }
    
    if ([obj isKindOfClass:[NSString class]] == NO)
    {
        if ([obj respondsToSelector:@selector(description)])
        {
            return [obj description];
        }
        else
        {
            return @"";
        }
    }
    
    if ([obj isKindOfClass:[NSString class]])
    {
        if ([(NSString*)obj isEqualToString:@"<null>"])
        {
            return @"";
        }
    }
    return obj;
}

@end
