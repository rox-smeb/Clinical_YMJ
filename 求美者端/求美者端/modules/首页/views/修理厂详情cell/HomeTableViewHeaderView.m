//
//  HomeTableViewHeaderView.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/8/31.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "HomeTableViewHeaderView.h"

#define DEFAULT_SCOLL_IMAGE                   ([UIImage imageNamed:@"sidian"]);

@interface HomeTableViewHeaderView()<KDCycleBannerViewDataSource,KDCycleBannerViewDelegate>

@property (weak, nonatomic) IBOutlet KDCycleBannerView *headerView;
@property (nonatomic, strong) NSArray *bannerImageArray;                // 轮播图片

@end

@implementation HomeTableViewHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    UIImage *image0 = [UIImage imageNamed:@"topbg"];
    UIImage *image1 = [UIImage imageNamed:@"sidian"];
    UIImage *image2 = [UIImage imageNamed:@"kobe"];
    
    self.bannerImageArray = @[image0, image1, image2];
    
    self.headerView.datasource = self;
    self.headerView.delegate = self;
    self.headerView.autoPlayTimeInterval = 5;
}

+ (CGFloat)height
{
    return 248.0f;
}

+ (instancetype)create
{

    NSString* name = NSStringFromClass([HomeTableViewHeaderView class]);
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
    return [nib firstObject];
    
}

#pragma mark -- KDCycleBannerViewDataSource
- (NSInteger)chinaImageViewWithIndex
{
    return 0;
}

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView
{
    return self.bannerImageArray;
}

- (UIImage *)placeHolderImageOfBannerView:(KDCycleBannerView *)bannerView atIndex:(NSUInteger)index
{
    return DEFAULT_SCOLL_IMAGE;
}

- (UIViewContentMode)contentModeForImage:(UIImageView *)imageView atIndex:(NSUInteger)index
{
    imageView.clipsToBounds = YES;
    return UIViewContentModeScaleToFill;
}

- (UIImage *)placeHolderImageOfZeroBannerView
{
    return DEFAULT_SCOLL_IMAGE;
}

#pragma mark -- KDCycleBannerViewDelegate
- (BOOL)showPageControlWhenOnlyOnePage
{
    return YES;
}

- (void)configPageControl:(UIPageControl *)pageControl
{
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = RGB(246, 207, 5);
}

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didScrollToIndex:(NSUInteger)index
{
    
}

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index
{
    
}

@end
