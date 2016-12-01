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
#import "CommonServerInteraction.h"

#define ITEM_HEIGHT                 (40.0f)
#define ITEM_FONT_SIZE              (15.0f)
#define ITEM_WIDTH_OFFSET           (20.0f)

@interface BecomeBeautifulViewController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate>

@property (strong, nonatomic) NSArray* tabedData;
@property (weak, nonatomic) IBOutlet DLCustomSlideView *customSlideView;
@property (weak, nonatomic) IBOutlet UIView *menuAchorView;
@property (strong, nonatomic) DOPDropDownMenu* menu;

@property (strong, nonatomic) NSArray* sortTypes_1;

@property (strong, nonatomic) NSArray* provincialInfoArray;                 // 省市
@property (strong, nonatomic) NSArray* classifyInfoArray;                   // 项目分类


@property (weak, nonatomic) BecomeBeautifulSubViewController *subViewController;

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
    [self loadProvincialInfo];
    [self loadFindClassifyInfo];

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
    self.sortTypes_1 = @[@{@"name" : @"智能推荐", @"type"  : @(type++)},
                         @{@"name" : @"好评专家", @"type"  : @(type++)},
                         @{@"name" : @"在线咨询", @"type"  : @(type++)}];
    
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
//    self.tabedData = @[@"项目拍卖行",
//                       @"医生"];
    
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

#pragma mark - 获取省市区信息
- (void)loadProvincialInfo
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<CommonInfo*>*)
    {
        if (weakSelf.provincialInfoArray != nil)
        {
            return ;
        }
        
        if ([response success])
        {
            NSMutableArray* array = [NSMutableArray array];
            [array backInsertArray:dataOrList];
            for(int i=0;i<array.count;i++)
            {
                CommonInfo* child=[array objectAtIndex:i];
                ProvinceInfo* addChildObject=[[ProvinceInfo alloc]init];
                addChildObject.pid=@"";
                addChildObject.pName = [NSString stringWithFormat:@"%@全部地区",child.cname];
                [child.province insertObject:addChildObject atIndex:0];
            }
            weakSelf.provincialInfoArray = array;
            [weakSelf.menu reloadData];
        }
    };
    [[CommonServerInteraction sharedInstance] findProvinceResponseBlock:block];
    
}

#pragma mark - 获取项目分类列表
- (void)loadFindClassifyInfo
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<FindClassifyInfo*>*)
    {
        if (weakSelf.classifyInfoArray != nil)
        {
            return ;
        }
        
        if ([response success])
        {
            NSMutableArray* array = [NSMutableArray array];
                        
            [array backInsertArray:dataOrList];
            weakSelf.classifyInfoArray = array;
            [weakSelf.menu reloadData];
        }
    };
    [[CommonServerInteraction sharedInstance] findClassifyResponseBlock:block];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.destinationViewController isKindOfClass:[BecomeBeautifulSubViewController class]])
//    {
//        self.subViewController = (BecomeBeautifulSubViewController*)segue.destinationViewController;
//        [self.subViewController setParent:self];
//    }
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
    [sub setParent:self];
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
    if(column == 0 && self.provincialInfoArray != nil)
    {
        return [self.provincialInfoArray count];
    }
    if(column == 1 && self.classifyInfoArray != nil)
    {
        return [self.classifyInfoArray count];
    }
    if(column == 2 )
    {
        return [self.sortTypes_1 count];
    }
    return 0;
}

// 一级列表title
- (NSString*)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row < [self.provincialInfoArray count])
        {
            CommonInfo* info = [self.provincialInfoArray objectAtIndex:indexPath.row];
            if ([info isKindOfClass:[CommonInfo class]])
            {
                return info.cname;
            }
        }
    }
    if (indexPath.column == 1) {
        if (indexPath.row < [self.classifyInfoArray count])
        {
            FindClassifyInfo* info = [self.classifyInfoArray objectAtIndex:indexPath.row];
            if ([info isKindOfClass:[FindClassifyInfo class]])
            {
                return info.pName;
            }
        }
    }
    if (indexPath.column == 2) {
        if (indexPath.row < [self.sortTypes_1 count])
        {
            NSDictionary* dict = [self.sortTypes_1 objectAtIndex:indexPath.row];
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
    if(column == 0 && self.provincialInfoArray != nil)
    {
        CommonInfo* info = [self.provincialInfoArray objectAtIndex:row];
        if ([info isKindOfClass:[CommonInfo class]] && [info.province isKindOfClass:[NSArray class]])
        {
            return [info.province count];
        }
    }
    if(column == 1 && self.classifyInfoArray != nil)
    {
        FindClassifyInfo* info = [self.classifyInfoArray objectAtIndex:row];
        if ([info isKindOfClass:[FindClassifyInfo class]] && [info.cList isKindOfClass:[NSArray class]])
        {
            return [info.cList count];
        }
    }
    return 0;
}

// 二级列表title
- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 && self.provincialInfoArray != nil)
    {
        if (indexPath.row < [self.provincialInfoArray count])
        {
            CommonInfo* info = [self.provincialInfoArray objectAtIndex:indexPath.row];
            if ([info isKindOfClass:[CommonInfo class]]   &&
                [info.province isKindOfClass:[NSArray class]] &&
                indexPath.item < [info.province count])
            {
                ProvinceInfo* cityInfo = [info.province objectAtIndex:indexPath.item];
                if ([cityInfo isKindOfClass:[ProvinceInfo class]])
                {
                    return cityInfo.pName;
                }
            }
        }
    }
    if (indexPath.column == 1 && self.classifyInfoArray != nil)
    {
        if (indexPath.row < [self.classifyInfoArray count])
        {
            FindClassifyInfo* info = [self.classifyInfoArray objectAtIndex:indexPath.row];
            if ([info isKindOfClass:[FindClassifyInfo class]]   &&
                [info.cList isKindOfClass:[NSArray class]] &&
                indexPath.item < [info.cList count])
            {
                ClassifyChildInfo* cityInfo = [info.cList objectAtIndex:indexPath.item];
                if ([cityInfo isKindOfClass:[ClassifyChildInfo class]])
                {
                    return cityInfo.cName;
                }
            }
        }
    }
    
    return @"";
}

#pragma mark - DOPDropDownMenuDelegate

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 && self.provincialInfoArray != nil)
    {
        if (indexPath.item >= 0 && indexPath.row < [self.provincialInfoArray count])
        {
            CommonInfo* info = [self.provincialInfoArray objectAtIndex:indexPath.row];
            self.cid = info.cid;
            if ([info isKindOfClass:[CommonInfo class]]   &&
                [info.province isKindOfClass:[NSArray class]] &&
                indexPath.item < [info.province count])
            {
                ProvinceInfo* cityInfo = [info.province objectAtIndex:indexPath.item];
                self.pid = cityInfo.pid;
                if ([self.delegate respondsToSelector:@selector(loadCityListWithCid:pid:)])
                {
                    NSLog(@"123");
                    [self.delegate loadCityListWithCid:self.cid pid:self.pid];
                }
            }
        }
    }
    if (indexPath.column == 1 && self.classifyInfoArray != nil)
    {
        if (indexPath.row < [self.classifyInfoArray count])
        {
            FindClassifyInfo* info = [self.classifyInfoArray objectAtIndex:indexPath.row];
            self.fid = info.pId;
            if ([info isKindOfClass:[FindClassifyInfo class]]   &&
                [info.cList isKindOfClass:[NSArray class]] &&
                indexPath.item < [info.cList count])
            {
                ClassifyChildInfo* cityInfo = [info.cList objectAtIndex:indexPath.item];
                self.oid = cityInfo.cId;
                if ([self.delegate respondsToSelector:@selector(loadProjectListWithFid:oid:)])
                {
                    [self.delegate loadProjectListWithFid:self.fid oid:self.oid];
                }
            }
        }
    }
}

@end
