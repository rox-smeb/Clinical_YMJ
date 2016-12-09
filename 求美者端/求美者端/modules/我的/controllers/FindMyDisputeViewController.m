//
//  FindMyDisputeViewController.m
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "FindMyDisputeViewController.h"
#import "FindMyDisputeSubViewController.h"

#define ITEM_HEIGHT                 (40.0f)
#define ITEM_FONT_SIZE              (15.0f)
#define ITEM_WIDTH_OFFSET           (20.0f)

@interface FindMyDisputeViewController ()

@property (weak, nonatomic) IBOutlet DLCustomSlideView *customSlideView;
@property (strong, nonatomic) NSArray* tabedData;

@end

@implementation FindMyDisputeViewController

+ (instancetype)viewController
{
    FindMyDisputeViewController* ctrl=[[self class] viewControllerWithStoryboardName:@"Mine"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCustomSlideView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 配置子页面
- (void)setupCustomSlideView
{
    self.tabedData = @[@"审核中",
                       @"处理中",
                       @"已完成"];
    
    // 计算平均item的宽度
    CGFloat perItemWidth = [UIScreen screenWidth] / [self.tabedData count];
    
    DLLRUCache* cache            = [[DLLRUCache alloc] initWithCount:self.tabedData.count];
    DLScrollTabbarView *tabbar   = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ITEM_HEIGHT)];
    tabbar.tabItemNormalColor    = COMMON_TEXT_COLOR;
    tabbar.tabItemSelectedColor  = COMMON_COLOR;
    tabbar.tabItemNormalFontSize = ITEM_FONT_SIZE;
    tabbar.trackColor            = COMMON_COLOR;
    tabbar.scrollBounces         = YES;
    tabbar.showSeparator         = YES;
    tabbar.separatorWidth        = 1.0f;
    tabbar.separatorColor        = UIColorMake(220, 220, 220);
    
    NSMutableArray* tabbarItems = [NSMutableArray array];
    for (NSString* title in self.tabedData)
    {
        // 计算每个item宽度
        CGFloat itemWith = 0.0f;
        CGSize size = [title calculateSize:CGSizeMake(0.0f, ITEM_HEIGHT) font:[UIFont systemFontOfSize:ITEM_FONT_SIZE]];
        itemWith = size.width + ITEM_WIDTH_OFFSET;
        if (itemWith < perItemWidth)
        {
            itemWith = perItemWidth;
        }
        
        DLScrollTabbarItem *item = [DLScrollTabbarItem itemWithTitle:title width:itemWith];
        item.showSeparator       = YES;
        item.separatorWidth      = 1.0f;
        item.separatorInsets     = UIEdgeInsetsMake(12.0f, 0.0f, 12.0f, 0.0f);
        item.separatorColor      = UIColorMake(220, 220, 220);
        [tabbarItems addObject:item];
    }
    tabbar.tabbarItems = tabbarItems;
    
    self.customSlideView.tabbar              = tabbar;
    self.customSlideView.cache               = cache;
    self.customSlideView.transitionDur       = 0.2f;
    self.customSlideView.transitonOptions    = UIViewAnimationOptionTransitionNone;
    self.customSlideView.tabbarBottomSpacing = 0.0f;
    self.customSlideView.baseViewController  = self;
    [self.customSlideView setup];
    self.customSlideView.selectedIndex = 0;
}

#pragma mark - DLCustomSlideViewDelegate

- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender
{
    return [self.tabedData count];
}

- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index
{
    FindMyDisputeSubViewController* sub = [self.storyboard instantiateViewControllerWithIdentifier:[FindMyDisputeSubViewController className]];
    sub.itemTag =  index;
    [sub setParent:self];
    return sub;
}

@end
