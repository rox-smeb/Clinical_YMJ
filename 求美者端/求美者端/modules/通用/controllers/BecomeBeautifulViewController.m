//
//  BecomeBeautifulViewController.m
//  求美者端
//
//  Created by Smeb on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "BecomeBeautifulViewController.h"
#import "BecomeBeautifulSubViewController.h"
#import "YBCommonKit/DOPDropDownMenu.h"

#define ITEM_HEIGHT                 (40.0f)
#define ITEM_FONT_SIZE              (15.0f)
#define ITEM_WIDTH_OFFSET           (20.0f)

@interface BecomeBeautifulViewController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate>

@property (strong, nonatomic) NSArray* tabedData;
@property (weak, nonatomic) IBOutlet DLCustomSlideView *customSlideView;
@property (weak, nonatomic) IBOutlet UIView *menuAchorView;
@property (strong, nonatomic) DOPDropDownMenu* menu;

@property (strong, nonatomic) NSArray* sortTypes_1;
@property (strong, nonatomic) NSArray* sortTypes_2;
@property (strong, nonatomic) NSArray* sortTypes_3;

@end

@implementation BecomeBeautifulViewController

+ (instancetype)viewController
{
    BecomeBeautifulViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Share"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMenuAchorView];
    [self setupCustomSlideView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 配置菜单选项
//@property (nonatomic, strong) UIColor *indicatorColor;      // 三角指示器颜色
//@property (nonatomic, strong) UIColor *textColor;           // 文字title颜色
//@property (nonatomic, strong) UIColor *textSelectedColor;   // 文字title选中颜色
//@property (nonatomic, strong) UIColor *separatorColor;      // 分割线颜色
//@property (nonatomic, assign) NSInteger fontSize;           // 字体大小
//@property (nonatomic, assign) CGFloat dropMenuHeight;       // 下拉列表高度

- (void)setupMenuAchorView
{
    NSInteger type = 1;
    self.sortTypes_1 = @[@{@"name" : @"项目名称",   @"type" : @(type++)},
                         @{@"name" : @"全部",      @"type" : @(type++)},
                         @{@"name" : @"新海航大厦", @"type" : @(type++)},
                         @{@"name" : @"海南大厦",   @"type" : @(type++)}];
    
    self.sortTypes_2 = @[@{@"name" : @"故障系统",   @"type" : @(type++)},
                         @{@"name" : @"全部",      @"type" : @(type++)},
                         @{@"name" : @"消防系统",   @"type" : @(type++)},
                         @{@"name" : @"周界系统",   @"type" : @(type++)}];
    
    self.sortTypes_3 = @[@{@"name" : @"优先级",     @"type" : @(type++)},
                         @{@"name" : @"全部",      @"type" : @(type++)},
                         @{@"name" : @"高",        @"type" : @(type++)},
                         @{@"name" : @"中",        @"type" : @(type++)},
                         @{@"name" : @"低",        @"type" : @(type++)}];
    
    self.menu = [[DOPDropDownMenu alloc] initWithOrigin:self.menuAchorView.frame.origin andHeight:46];
    self.menu.dataSource = self;
    self.menu.delegate = self;
    self.menu.textSelectedColor = COMMON_COLOR;
    [self.view addSubview:self.menu];

}

#pragma mark - 配置子页面
- (void)setupCustomSlideView
{
    self.tabedData = @[@"项目拍卖行",
                       @"医生",
                       @"机构"];
    
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
//    self.selectedIndex = self.selectedIndex < 0 ? 0 : self.selectedIndex;
//    if (self.selectedIndex < [self.tabedData count])
//    {
//        self.customSlideView.selectedIndex = self.selectedIndex;
//    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

#pragma mark - DLCustomSlideViewDelegate

- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender
{
    return [self.tabedData count];
}

- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index
{
    BecomeBeautifulSubViewController* sub = [self.storyboard instantiateViewControllerWithIdentifier:[BecomeBeautifulSubViewController className]];
    sub.itemTag =  index;
    return sub;
}

#pragma mark - DOPDropDownMenuDataSource
// 返回几个列表
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

// 一级列表返回多少行
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if(column == 0)
    {
        return [self.sortTypes_1 count];
    }
    if(column == 1)
    {
        return [self.sortTypes_2 count];
    }
    if(column == 2)
    {
        return [self.sortTypes_3 count];
    }
    return 0;
}

// 一级列表title
- (NSString*)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row < [self.sortTypes_1 count])
        {
            NSDictionary* dict = [self.sortTypes_1 objectAtIndex:indexPath.row];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                return dict[@"name"];
            }
        }
    }
    if (indexPath.column == 1) {
        if (indexPath.row < [self.sortTypes_2 count])
        {
            NSDictionary* dict = [self.sortTypes_2 objectAtIndex:indexPath.row];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                return dict[@"name"];
            }
        }
    }
    if (indexPath.column == 2) {
        if (indexPath.row < [self.sortTypes_3 count])
        {
            NSDictionary* dict = [self.sortTypes_3 objectAtIndex:indexPath.row];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                return dict[@"name"];
            }
        }
    }
    return @"";
}

// 二级列表返回多少行
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if(column == 0)
    {
        return [self.sortTypes_1 count];
    }
    if(column == 1)
    {
        return [self.sortTypes_2 count];
    }
    if(column == 2)
    {
        return [self.sortTypes_3 count];
    }
    return 0;
}

// 二级列表title
- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row < [self.sortTypes_1 count])
        {
            NSDictionary* dict = [self.sortTypes_1 objectAtIndex:indexPath.row];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                return dict[@"name"];
            }
        }
    }
    if (indexPath.column == 1) {
        if (indexPath.row < [self.sortTypes_2 count])
        {
            NSDictionary* dict = [self.sortTypes_2 objectAtIndex:indexPath.row];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                return dict[@"name"];
            }
        }
    }
    if (indexPath.column == 2) {
        if (indexPath.row < [self.sortTypes_3 count])
        {
            NSDictionary* dict = [self.sortTypes_3 objectAtIndex:indexPath.row];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                return dict[@"name"];
            }
        }
    }
    return @"";
}

#pragma mark - DOPDropDownMenuDelegate

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
}

@end
