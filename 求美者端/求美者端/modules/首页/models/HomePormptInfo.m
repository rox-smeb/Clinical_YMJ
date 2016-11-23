//
//  HomePormptInfo.m
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "HomePormptInfo.h"

@implementation HomePormptInfo

- (NSNumber*)sumsCount
{
    NSInteger count = 0;
    if ([_sums isKindOfClass:[NSString class]])
    {
        count = [_sums integerValue];
    }
    return @(count);
}

- (NSString*)chinaSums
{
    NSInteger count = 0;
    if ([_chinaSums isKindOfClass:[NSString class]])
    {
        count = [_chinaSums integerValue];
    }
    return [NSString stringWithFormat:@"%05d", (int)count];
}

- (NSString*)koreaSums
{
    NSInteger count = 0;
    if ([_koreaSums isKindOfClass:[NSString class]])
    {
        count = [_koreaSums integerValue];
    }
    return [NSString stringWithFormat:@"%05d", (int)count];
}

@end
