//
//  KDCycleBannerView.h
//  KDCycleBannerViewDemo
//
//  Created by Kingiol on 14-4-11.
//  Modifyed by AnYanbo on 16-7-7.
//  Copyright (c) 2014年 Kingiol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KDCycleBannerView;

typedef void(^CompleteBlock)(void);

@protocol KDCycleBannerViewDataSource <NSObject>

@required

/**
 *  轮播图片数据
 *
 *  @param bannerView 轮播视图
 *
 *  @return NSArray<UIImage | NSString | NSURL>
 */
- (NSArray*)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView;
- (NSInteger)chinaImageViewWithIndex;
- (UIViewContentMode)contentModeForImage:(UIImageView*)imageView atIndex:(NSUInteger)index;

@optional

- (UIImage *)placeHolderImageOfZeroBannerView;
- (UIImage *)placeHolderImageOfBannerView:(KDCycleBannerView *)bannerView atIndex:(NSUInteger)index;

@end

@protocol KDCycleBannerViewDelegate <NSObject>

@optional

- (BOOL)showPageControlWhenOnlyOnePage;
- (void)configPageControl:(UIPageControl*)pageControl;
- (void)cycleBannerView:(KDCycleBannerView *)bannerView didScrollToIndex:(NSUInteger)index;
- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index;

@end

@interface KDCycleBannerView : UIView

// Delegate and Datasource
@property (weak, nonatomic) IBOutlet id<KDCycleBannerViewDataSource> datasource;
@property (weak, nonatomic) IBOutlet id<KDCycleBannerViewDelegate> delegate;

@property (assign, nonatomic, getter = isContinuous) BOOL continuous;   // if YES, then bannerview will show like a carousel, default is NO
@property (assign, nonatomic) NSUInteger autoPlayTimeInterval;  // if autoPlayTimeInterval more than 0, the bannerView will autoplay with autoPlayTimeInterval value space, default is 0

- (void)reloadDataWithCompleteBlock:(CompleteBlock)competeBlock;
- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end
