//
//  NSMutableDictionary+Params.m
//  昆明团购
//
//  Created by AnYanbo on 15/5/13.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "NSMutableDictionary+Params.h"

#import <objc/runtime.h>

@implementation UploadDataInfo

@end

@implementation NSMutableDictionary (Params)

- (NSMutableArray*)uploadDatas
{
    return objc_getAssociatedObject(self, "uploadDatas");
}

- (void)setUploadDatas:(NSMutableArray *)uploadDatas
{
    objc_setAssociatedObject(self, "uploadDatas", uploadDatas, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMethod:(NSString*)method
{
    if (method != nil)
    {
        [self setObject:method forKey:@"method"];
    }
}

- (void)addParam:(id)param forKey:(id<NSCopying>)key
{
    if (param != nil && key != nil)
    {
        [self setObject:param forKey:key];
    }
}

- (void)addUploadData:(NSData*)data named:(NSString*)named;
{
    [self addUploadData:data named:named type:nil];
}

- (void)addUploadData:(NSData*)data named:(NSString*)named type:(NSString*)type
{
    if (self.uploadDatas == nil || [self.uploadDatas isKindOfClass:[NSMutableArray class]] == NO)
    {
        self.uploadDatas = [NSMutableArray array];
    }
    
    UploadDataInfo* info = [[UploadDataInfo alloc] init];
    info.data = data;
    info.name = named;
    info.type = type;
    
    if (info != nil)
    {
        [self.uploadDatas addObject:info];
    }
}

- (void)clearUploadData
{
    if ([self.uploadDatas isKindOfClass:[NSArray class]])
    {
        [self.uploadDatas removeAllObjects];
    }
}

@end
