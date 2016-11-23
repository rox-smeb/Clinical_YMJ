//
//  AppURL.m
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/6/27.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "AppURL.h"

@implementation AppURL

+ (NSString*)URLWithPath:(NSString*)path method:(NSString*)method
{
    NSString* url = [NSString stringWithFormat:@"%@/%@", path, method];
    return url;
}

@end
