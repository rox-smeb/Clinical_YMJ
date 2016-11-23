//
//  UIScrollView+Refresh.h
//  果动校园
//
//  Created by AnYanbo on 15/4/13.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)

+ (void)setIdleImages:(NSArray*)images;
+ (void)setPullingImages:(NSArray*)images;
+ (void)setRefreshingImages:(NSArray*)images;

- (void)nlHeaderRefreshWithTarget:(id)target action:(SEL)action;
- (void)nlFooterRefreshWithTarget:(id)target action:(SEL)action;

- (BOOL)nlHeaderIsRefresh;
- (void)nlHeaderBeginRefresh;
- (void)nlHeaderEndRefresh;

- (BOOL)nlFooterIsRefresh;
- (void)nlFooterBeginRefresh;
- (void)nlFooterEndRefresh;

@end
