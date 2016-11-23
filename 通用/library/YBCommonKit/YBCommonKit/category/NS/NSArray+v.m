//
//  NSArray+v.m
//  昆明团购
//
//  Created by AnYanbo on 15/6/2.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "NSArray+v.h"

@implementation NSArray (v)

- (NSString*)v
{
    return (NSString*)objc_getAssociatedObject(self, @"v");
}

- (void)setV:(NSString*)v
{
    objc_setAssociatedObject(self, @"v", v, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)objectAtIndexEx:(NSUInteger)index
{
    if (index < self.count)
    {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end

@implementation NSMutableArray (v)

- (void)addObjectEx:(id)anObject
{
    if (anObject == nil)
    {
        return;
    }
    [self addObject:anObject];
}

@end