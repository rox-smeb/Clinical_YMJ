//
//  NSJSON+YBClass.m
//  果动校园
//
//  Created by AnYanbo on 15/2/28.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "NSJSON+YBClass.h"

// NSArray
@implementation NSArray (_JSON_)

+ (NSArray*)arrayWithJSON:(NSString*)json
{
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [[self class] arrayWithJSONData:jsonData];
}

+ (NSArray*)arrayWithJSONData:(NSData*)jsonData
{
    NSArray* ret = nil;
    if (jsonData != nil)
    {
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    }
    return ret;
}

- (NSString*)toJSON
{
    NSString* json = @"";
    NSData* ret = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (ret != nil)
    {
        json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
    }
    return json;
}

@end

// NSMutableArray
@implementation NSMutableArray (_JSON_)

+ (NSArray*)arrayWithJSON:(NSString*)json
{
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [[self class] arrayWithJSONData:jsonData];
}

+ (NSMutableArray*)arrayWithJSONData:(NSData*)jsonData
{
    NSMutableArray* ret = nil;
    if (jsonData != nil)
    {
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    }
    return ret;
}

- (NSString*)toJSON
{
    NSString* json = @"";
    NSData* ret = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (ret != nil)
    {
        json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
    }
    return json;
}

@end

// NSDictionary
@implementation NSDictionary (_JSON_)

+ (NSDictionary*)dictWithJSON:(NSString*)json
{
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [[self class] dictWithJSONData:jsonData];
}

+ (NSDictionary*)dictWithJSONData:(NSData*)jsonData
{
    NSDictionary* ret = nil;
    if (jsonData != nil)
    {
        NSError* error = nil;
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
        NSLog(@"1");
    }
    return ret;
}

- (NSString*)toJSON
{
    NSString* json = @"";
    NSData* ret = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (ret != nil)
    {
        json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
    }
    return json;
}

@end

// NSMutableDictionary
@implementation NSMutableDictionary (_JSON_)

+ (NSMutableDictionary*)dictWithJSON:(NSString*)json
{
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [[self class] dictWithJSONData:jsonData];
}

+ (NSMutableDictionary*)dictWithJSONData:(NSData*)jsonData
{
    NSMutableDictionary* ret = nil;
    if (jsonData != nil)
    {
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    }
    return ret;
}

- (NSString*)toJSON
{
    NSString* json = @"";
    NSData* ret = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (ret != nil)
    {
        json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
    }
    return json;
}

@end
