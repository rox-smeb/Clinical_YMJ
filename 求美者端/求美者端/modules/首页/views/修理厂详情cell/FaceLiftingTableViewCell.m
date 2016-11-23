//
//  FaceLiftingTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/11/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "FaceLiftingTableViewCell.h"

#define DEFAULT_SCOLL_IMAGE                   ([UIImage imageNamed:@"sidian"]);

@interface FaceLiftingTableViewCell ()<KDCycleBannerViewDataSource,KDCycleBannerViewDelegate>

@property (weak, nonatomic) IBOutlet KDCycleBannerView *showView;
@property (weak, nonatomic) IBOutlet UIImageView *chinaIamge;
@property (nonatomic, strong) NSArray *bannerImageArray;                // 轮播图片

@end

@implementation FaceLiftingTableViewCell

+ (CGFloat)height
{
    return 200.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //[self.showView insertSubview:self.chinaIamge atIndex:0];
    [self.showView addSubview:self.chinaIamge];
    [self.showView bringSubviewToFront:self.chinaIamge];
    
    UIImage *image0 = [UIImage imageNamed:@"topbg"];
    UIImage *image1 = [UIImage imageNamed:@"sidian"];
    UIImage *image2 = [UIImage imageNamed:@"kobe"];
    
    self.bannerImageArray = @[image0, image1, image2];
    
    [self.showView.layer setCornerRadius:8.0f];
    self.showView.datasource = self;
    self.showView.delegate = self;
    self.showView.autoPlayTimeInterval = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- KDCycleBannerViewDataSource
- (NSInteger)chinaImageViewWithIndex
{
    return 1;
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
