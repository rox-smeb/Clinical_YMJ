//
//  UITableView+Utility.m
//  果动校园
//
//  Created by AnYanbo on 15/3/5.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "UITableView+Utility.h"

@interface UITableView ()

@property (nonatomic, weak) id longPressTarget;
@property (nonatomic, assign) SEL longPressAction;

@end

@implementation UITableView (Utility)

- (void)addLongPressGestrueWithTarget:(id)target action:(SEL)action
{
    [self addLongPressGestrueWithTarget:target action:action dur:0.5];
}

- (void)addLongPressGestrueWithTarget:(id)target action:(SEL)action dur:(CFTimeInterval)dur
{
    UILongPressGestureRecognizer * ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onTableViewLongPress:)];
    ges.minimumPressDuration = dur;
    [self addGestureRecognizer:ges];
}

- (void)onTableViewLongPress:(UILongPressGestureRecognizer*)ges
{
    if (ges.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [ges locationInView:self];
        NSIndexPath* indexPath = [self indexPathForRowAtPoint:point];
        if (indexPath == nil)
        {
            return;
        }
    }
}

- (void)removeSeperatorBlank
{
    // ios8去掉分割线开始空白
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)removeRedundanceSeperator
{
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

- (void)registerNibName:(NSString*)nibName cellID:(NSString*)cellID
{
    UINib* nib = [UINib nibWithNibName:nibName bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:cellID];
}

- (void)scrollToTop
{
    [self scrollToTopAnimated:YES];
}

- (void)scrollToBottom
{
    [self scrollToBottomanimated:YES];
}

- (void)scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0,0) animated:animated];
}

- (void)scrollToBottomanimated:(BOOL)animated
{
    NSUInteger sectionCount = [self numberOfSections];
    if (sectionCount)
    {
        NSUInteger rowCount = [self numberOfRowsInSection:0];
        if (rowCount)
        {
            NSUInteger ii[2] = {0, rowCount - 1};
            NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        }
    }
}

- (void)solveCrashWithIOS7
{
    if (OnlyIOS7)
    {
        NSInteger sectionNum = [self numberOfSections];
        for (int section = 0; section < sectionNum; section++)
        {
            NSInteger rowsNum = [self numberOfRowsInSection:section];
            for (int row = 0; row < rowsNum; row++)
            {
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                UITableViewCell* cell = [self cellForRowAtIndexPath:indexPath];
                cell.contentView.frame = cell.bounds;
                cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin    |
                                                    UIViewAutoresizingFlexibleWidth         |
                                                    UIViewAutoresizingFlexibleRightMargin   |
                                                    UIViewAutoresizingFlexibleTopMargin     |
                                                    UIViewAutoresizingFlexibleHeight        |
                                                    UIViewAutoresizingFlexibleBottomMargin;
            }
        }
    }
}

- (void)reloadVisibleRowsAtIndex:(NSInteger)index section:(NSInteger)section
{
    [self reloadVisibleRowsAtIndex:index section:section withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadVisibleRowsAtIndex:(NSInteger)index section:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animate
{
    NSMutableArray* array = nil;
    for (NSIndexPath* indexPath in [self indexPathsForVisibleRows])
    {
        if (indexPath.row == index && indexPath.section == section)
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
        [self reloadRowsAtIndexPaths:array withRowAnimation:animate];
    }
}

- (void)selectAllRow
{
    for (int i = 0; i < [self numberOfSections]; i++)
    {
        [self selectAllRowInSection:i];
    }
}

- (void)deselectAllRow
{
    for (int i = 0; i < [self numberOfSections]; i++)
    {
        [self deselectAllRowInSection:i];
    }
}

- (void)selectAllRowInSection:(NSInteger)section
{
    [self selectAllRowInSection:section animate:YES];
}

- (void)deselectAllRowInSection:(NSInteger)section
{
    [self deselectAllRowInSection:section animate:YES];
}

- (void)selectAllRowInSection:(NSInteger)section animate:(BOOL)animate
{
    if (section >= 0 && section < self.numberOfSections)
    {
        for (int i = 0; i < [self numberOfRowsInSection:section]; i++)
        {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [self selectRowAtIndexPath:indexPath animated:animate scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

- (void)deselectAllRowInSection:(NSInteger)section animate:(BOOL)animate
{
    if (section >= 0 && section < self.numberOfSections)
    {
        for (int i = 0; i < [self numberOfRowsInSection:section]; i++)
        {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [self deselectRowAtIndexPath:indexPath animated:animate];
        }
    }
}

- (NSArray<NSIndexPath*>*)indexPathsForSelectedRowsInSection:(NSInteger)section
{
    NSMutableArray* result = [NSMutableArray array];
    NSArray* indexPaths = self.indexPathsForSelectedRows;
    for (NSIndexPath* indexPath in indexPaths)
    {
        if (indexPath.section == section)
        {
            [result addObject:indexPath];
        }
    }
    return result;
}

- (NSArray<NSIndexPath*>*)indexPathForAllRowInSection:(NSInteger)section
{
    NSMutableArray* array = [NSMutableArray array];
    if (section < self.numberOfSections)
    {
        for (NSInteger row = 0; row < [self numberOfRowsInSection:section]; row++)
        {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            if (indexPath != nil)
            {
                [array addObject:indexPath];
            }
        }
    }
    return array;
}

- (NSArray<NSIndexPath*>*)indexPathForAllRow
{
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < self.numberOfSections; i++)
    {
        NSArray* indexPaths = [self indexPathForAllRowInSection:i];
        if ([indexPaths count] > 0)
        {
            [array backInsertArray:indexPaths];
        }
    }
    return array;
}

- (BOOL)isAllRowsSelectedInSection:(NSInteger)section
{
    NSArray* array = [self indexPathsForSelectedRowsInSection:section];
    if ([array count] == [self numberOfRowsInSection:section])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isAllRowsSelected
{
    BOOL ret = YES;
    NSInteger count = 0;
    for (int i = 0; i < self.numberOfSections; i++)
    {
        if ([self numberOfRowsInSection:i] > 0 && [self isAllRowsSelectedInSection:i] == NO)
        {
            ret = NO;
            count++;
            break;
        }
    }
    if (count == 0)
    {
        ret = NO;
    }
    return ret;
}

@end

@implementation UITableViewCell (Utility)

- (void)removeSeperatorBlank
{
    // ios8去掉分割线开始空白
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)solveCrashWithIOS7
{
    if (OnlyIOS7)
    {
        self.contentView.frame = self.bounds;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin    |
                                            UIViewAutoresizingFlexibleWidth         |
                                            UIViewAutoresizingFlexibleRightMargin   |
                                            UIViewAutoresizingFlexibleTopMargin     |
                                            UIViewAutoresizingFlexibleHeight        |
                                            UIViewAutoresizingFlexibleBottomMargin;
    }
}

- (void)registerToTableView:(UITableView*)table cellID:(NSString*)cellID
{
    [table registerClass:[self class] forCellReuseIdentifier:cellID];
}

@end