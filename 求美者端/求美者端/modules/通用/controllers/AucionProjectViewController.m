//
//  AucionProjectViewController.m
//  求美者端
//
//  Created by Smeb on 2016/12/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "AucionProjectViewController.h"
#import "YBCommonKit/KDCycleBannerView.h"

#define DEFAULT_SCOLL_IMAGE                   ([UIImage imageNamed:@"sidian"]);

@interface AucionProjectViewController ()<KDCycleBannerViewDataSource,KDCycleBannerViewDelegate>

@property (weak, nonatomic) IBOutlet KDCycleBannerView *topImage;
@property (nonatomic, strong) NSArray *bannerImageArray;                // 轮播图片

@end

@implementation AucionProjectViewController

+ (instancetype)viewController
{
    AucionProjectViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Share"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)setup
{
    UIImage *image0 = [UIImage imageNamed:@"topbg"];
    UIImage *image1 = [UIImage imageNamed:@"sidian"];
    UIImage *image2 = [UIImage imageNamed:@"kobe"];
    
    self.bannerImageArray = @[image0, image1, image2];
    
    [self.topImage.layer setCornerRadius:8.0f];
    self.topImage.datasource = self;
    self.topImage.delegate = self;
    self.topImage.autoPlayTimeInterval = 5;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 查看医生详情响应事件
- (IBAction)doctorDetailsClicked:(UIButton *)sender {
    NSLog(@"查看医生详情");
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
