//
//  NSMutableArray+InsertArray.m
//  果动校园
//
//  Created by AnYanbo on 15/3/27.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "NSMutableArray+InsertArray.h"

@implementation NSArray (InsertArray)

- (BOOL)isCached
{
    id obj = objc_getAssociatedObject(self, @"isCached");
    if ([obj respondsToSelector:@selector(boolValue)])
    {
        return [obj boolValue];
    }
    return NO;
}

- (void)setIsCached:(BOOL)isCached
{
    objc_setAssociatedObject(self, @"isCached", @(isCached), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)frontInsertArray:(NSArray *)newAdditions
{
    if ([self isKindOfClass:[NSArray class]])
    {
        return NO;
    }
    return YES;
}

- (BOOL)backInsertArray:(NSArray*)newAdditions
{
    if ([self isKindOfClass:[NSArray class]])
    {
        return NO;
    }
    return YES;
}

@end

@implementation NSMutableArray (InsertArray)

- (BOOL)insertArray:(NSArray *)newAdditions atIndex:(NSUInteger)index
{
    if (newAdditions == nil || index > [self count])
    {
        return NO;
    }
    
    if ([newAdditions isKindOfClass:[NSArray class]] == NO)
    {
        return NO;
    }
    
    if ([newAdditions count] == 0)
    {
        return NO;
    }
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    for(NSUInteger i = index; i < newAdditions.count + index; i++)
    {
        [indexes addIndex:i];
    }
    [self insertObjects:newAdditions atIndexes:indexes];
    
    return YES;
}

- (BOOL)frontInsertArray:(NSArray *)newAdditions cache:(BOOL)cache
{
    // 列表为空,加入数据并设置缓存状态
    if ([self count] == 0)
    {
        [self setIsCached:cache];
        return [self insertArray:newAdditions atIndex:0];
    }
    
    // 当前列表已是缓存列表并且将要加入非缓存数据
    if (self.isCached && cache == NO)
    {
        [self removeAllObjects];
        [self setIsCached:cache];
        BOOL ret = [self insertArray:newAdditions atIndex:0];
        if ([newAdditions isKindOfClass:[NSArray class]] && [newAdditions count] == 0)
        {
            ret = YES;
        }
        return ret;
    }
    
    // 当前列表不是缓存列表并且加入非缓存数据
    if (self.isCached == NO && cache == NO)
    {
        return [self insertArray:newAdditions atIndex:0];
    }
    
    return NO;
}

- (BOOL)backInsertArray:(NSArray *)newAdditions cache:(BOOL)cache
{
    // 列表为空,加入数据并设置缓存状态
    if ([self count] == 0)
    {
        [self setIsCached:cache];
        return [self insertArray:newAdditions atIndex:self.count];
    }
    
    // 当前列表已是缓存列表并且将要加入非缓存数据
    if (self.isCached && cache == NO)
    {
        [self removeAllObjects];
        [self setIsCached:cache];
        return [self insertArray:newAdditions atIndex:self.count];
    }
    
    // 当前列表不是缓存列表并且加入非缓存数据
    if (self.isCached == NO && cache == NO)
    {
        return [self insertArray:newAdditions atIndex:self.count];
    }
    
    return NO;
}

- (BOOL)frontInsertArray:(NSArray *)newAdditions
{
    return [self insertArray:newAdditions atIndex:0];
}

- (BOOL)backInsertArray:(NSArray*)newAdditions
{
    return [self insertArray:newAdditions atIndex:self.count];
}

- (void)removeFirstObject
{
    NSObject* first = [self firstObject];
    if (first != nil)
    {
        [self removeObject:first];
    }
}

@end
