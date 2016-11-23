//
//  NSObject+Utility.m
//  昆明团购
//
//  Created by AnYanbo on 15/6/24.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "NSObject+Utility.h"

@implementation NSObject (Utility)

+ (NSString*)className
{
    return NSStringFromClass([self class]);
}

@end
