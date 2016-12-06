//
//  AucionProjectViewController.m
//  求美者端
//
//  Created by Smeb on 2016/12/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "AucionProjectViewController.h"
#import "YBCommonKit/KDCycleBannerView.h"
#import "VerDoctorWebTableViewController.h"
#import "VerDoctorWebViewController.h"

#define DEFAULT_SCOLL_IMAGE                   ([UIImage imageNamed:@"topbg"]);

@interface AucionProjectViewController ()<KDCycleBannerViewDataSource,KDCycleBannerViewDelegate>

@property (weak, nonatomic) IBOutlet KDCycleBannerView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *fPrice;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (strong, nonatomic) NSArray* bannerInfoArray;
@property (strong, nonatomic) NSMutableArray* bannerImageURLArray;
@property (strong, nonatomic) NSTimer *countDownTimer;
@property (assign, nonatomic) int secondsCountDown;

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
    [self loadData:self.auctionInfo.urlList];
    self.name.text = self.auctionInfo.name;
    self.price.text = self.auctionInfo.price;
    self.fPrice.text = self.auctionInfo.fPrice;
    
    [self.topImage.layer setCornerRadius:8.0f];
    self.topImage.datasource = self;
    self.topImage.delegate = self;
    self.topImage.autoPlayTimeInterval = 5;
    self.date.text = [self timeFormatted:86400];
    _secondsCountDown = 86400;//60秒倒计时
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];

}

-(void)timeFireMethod{
    _secondsCountDown--;
    self.date.text = [self timeFormatted:_secondsCountDown];
    if(_secondsCountDown==0){
        [_countDownTimer invalidate];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 配置剩余竞拍时间
- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = (totalSeconds / 3600) % 24;
    int days = totalSeconds / (3600*24);
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d:%02d", days,hours, minutes, seconds];
} 

#pragma mark -- 配置轮播图片
- (void)loadData:(NSArray*)bannerInfo
{
    self.bannerInfoArray = bannerInfo;
    
    if (self.bannerImageURLArray == nil)
    {
        self.bannerImageURLArray = [NSMutableArray array];
    }
    else
    {
        [self.bannerImageURLArray removeAllObjects];
    }
    
    // 构建Banner显示的图片列表
    for (AuctionProUrlInfo* info in self.bannerInfoArray)
    {
        if ([info isKindOfClass:[AuctionProUrlInfo class]])
        {
            if (info.url != nil)
            {
                [self.bannerImageURLArray addObject:info.url];
            }
        }
    }
    
    // 设置是否轮播
    if (self.bannerImageURLArray.count > 1)
    {
        [self.topImage setContinuous:YES];
    }
    else
    {
        [self.topImage setContinuous:NO];
    }
    
    // 重新加载数据
    [self.topImage reloadDataWithCompleteBlock:^{
        
    }];
}


#pragma mark -- 查看医生详情响应事件
- (IBAction)doctorDetailsClicked:(UIButton *)sender {
    NSLog(@"查看医生详情");
    VerDoctorWebViewController *vc = [VerDoctorWebViewController viewController];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- KDCycleBannerViewDataSource
- (NSInteger)chinaImageViewWithIndex
{
    return 0;
}

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView
{
    return self.bannerImageURLArray;
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
