//
//  UIScrollView+Refresh.m
//  果动校园
//
//  Created by AnYanbo on 15/4/13.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)

static NSArray* g_idleImages       = nil;
static NSArray* g_pullingImages    = nil;
static NSArray* g_refreshingImages = nil;

+ (void)setIdleImages:(NSArray*)images
{
    g_idleImages = images;
}

+ (void)setPullingImages:(NSArray*)images
{
    g_pullingImages = images;
}

+ (void)setRefreshingImages:(NSArray*)images
{
    g_refreshingImages = images;
}

- (void)nlHeaderRefreshWithTarget:(id)target action:(SEL)action
{
    MJRefreshGifHeader* header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    
    // 设置普通状态的动画图片
    [header setImages:g_idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:g_pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:g_refreshingImages forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    self.header = header;
}

- (void)nlFooterRefreshWithTarget:(id)target action:(SEL)action
{
//    self.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    
    MJRefreshBackGifFooter* footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:target refreshingAction:action];
    // 设置普通状态的动画图片
    [footer setImages:g_idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [footer setImages:g_pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [footer setImages:g_refreshingImages forState:MJRefreshStateRefreshing];
    self.footer = footer;
}

- (BOOL)nlHeaderIsRefresh
{
    return [self.header isRefreshing];
}

- (void)nlHeaderBeginRefresh
{
    [self.header beginRefreshing];
}

- (void)nlHeaderEndRefresh
{
    if ([self nlHeaderIsRefresh])
    {
        [self.header endRefreshing];
    }
}

- (BOOL)nlFooterIsRefresh
{
    return [self.footer isRefreshing];
}

- (void)nlFooterBeginRefresh
{
    [self.footer beginRefreshing];
}

- (void)nlFooterEndRefresh
{
    if ([self nlFooterIsRefresh])
    {
        [self.footer endRefreshing];
    }
}

@end
