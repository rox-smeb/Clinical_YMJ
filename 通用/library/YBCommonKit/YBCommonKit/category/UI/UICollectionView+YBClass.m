//
//  UICollectionView+YBClass.m
//  果动校园
//
//  Created by AnYanbo on 15/4/15.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "UICollectionView+YBClass.h"

@implementation UICollectionView (YBClass)

- (void)reloadVisibleItemAtIndex:(NSInteger)index section:(NSInteger)seciton
{
    NSMutableArray* array = nil;
    for (NSIndexPath* indexPath in [self indexPathsForVisibleItems])
    {
        if (indexPath.item == index && indexPath.section == seciton)
        {
            if (array == nil)
            {
                array = [NSMutableArray array];
            }
            [array addObject:indexPath];
        }
    }
    if ([array count] > 0)
    {
        [self reloadItemsAtIndexPaths:array];
    }
}

@end
