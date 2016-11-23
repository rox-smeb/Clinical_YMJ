//
//  NSArray+upload.m
//  果动校园
//
//  Created by AnYanbo on 15/4/19.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "NSArray+upload.h"

@implementation NSArray (upload)

- (BOOL)selectedAssetsDatas:(NSMutableArray**)datas Names:(NSMutableArray**)names
{
    BOOL hasPic = NO;
    if ([self count] > 0)
    {
        hasPic = YES;
    }
    
    // 获取选择图片的Data
    NSMutableArray* picsData = [NSMutableArray array];
    NSMutableArray* picsName = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id asset, NSUInteger index, BOOL *stop) {
        
        UIImage* image = nil;
        NSData* imageData = nil;
        if ([asset isKindOfClass:[ALAsset class]])
        {
            image = [UIImage fullResolutionImageFromALAsset:asset];
            imageData = UIImageJPEGRepresentation(image, 0.3);
        }
        else if ([asset isKindOfClass:[UIImage class]])
        {
            image = asset;
            imageData = UIImageJPEGRepresentation(image, 0.3);
        }
        
        if (imageData != nil)
        {
            [picsData addObject:imageData];
            [picsName addObject:[NSString stringWithFormat:@"pic[%d]", (int)index]];       // pic[0],pic[1]....
        }
    }];
    
    *datas = picsData;
    *names = picsName;
    
    return hasPic;
}

- (BOOL)selectedAssetsDatas:(NSMutableArray**)datas Names:(NSMutableArray**)names URLs:(NSMutableArray**)urls
{
    BOOL hasPic = NO;
    if ([self count] > 0)
    {
        hasPic = YES;
    }
    
    // 获取选择图片的Data
    NSMutableArray* picsData = [NSMutableArray array];
    NSMutableArray* picsName = [NSMutableArray array];
    NSMutableArray* picsURL  = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id asset, NSUInteger index, BOOL *stop) {
        
        UIImage* image    = nil;
        NSData* imageData = nil;
        if ([asset isKindOfClass:[ALAsset class]])
        {
            image = [UIImage fullResolutionImageFromALAsset:asset];
            imageData = UIImageJPEGRepresentation(image, 0.3);
        }
        else if ([asset isKindOfClass:[UIImage class]])
        {
            image = asset;
            imageData = UIImageJPEGRepresentation(image, 0.3);
        }
        else if ([asset isKindOfClass:[NSURL class]])
        {
            [picsURL addObject:((NSURL*)asset).absoluteString];
        }
        else if ([asset isKindOfClass:[NSString class]])
        {
            [picsURL addObject:(NSString*)asset];
        }
        
        if (imageData != nil)
        {
            [picsData addObject:imageData];
            [picsName addObject:[NSString stringWithFormat:@"pic[%d]", (int)index]];       // pic[0],pic[1]....
        }
    }];
    
    if (datas != nil)
    {
        *datas = picsData;
    }
    if (names != nil)
    {
        *names = picsName;
    }
    if (urls != nil)
    {
        *urls = picsURL;
    }
    return hasPic;
}

@end
