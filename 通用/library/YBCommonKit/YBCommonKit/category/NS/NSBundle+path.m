//
//  NSBundle+path.m
//  果动校园
//
//  Created by AnYanbo on 15/4/11.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "NSBundle+path.h"

@implementation NSBundle (path)

- (NSString*)documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = @"";
    if ([paths count] > 0)
    {
        docDir = [paths objectAtIndex:0];
    }
    return docDir;
}

- (NSString*)tmpPath
{
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}

- (NSString*)cachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = @"";
    if ([paths count] > 0)
    {
        cachesDir = [paths objectAtIndex:0];
    }
    return cachesDir;
}

@end
