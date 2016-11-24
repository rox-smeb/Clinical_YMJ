//
//  DoctorViewController.m
//  求美者端
//
//  Created by apple on 2016/11/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "DoctorViewController.h"
#import "YBCommonKit/DOPDropDownMenu.h"
#import "ProvincialInfo.h"
#import "CommonServerInteraction.h"
#import "FindClassifyInfo.h"
@interface DoctorViewController ()<DOPDropDownMenuDataSource,
                                    DOPDropDownMenuDelegate>
@property (strong, nonatomic) DOPDropDownMenu* menu;
@property (assign, nonatomic) NSInteger sortType;                           // 排序方式
@property (strong, nonatomic) NSArray* sortTypes;
@property (strong, nonatomic) NSArray* provincialInfoArray;
@property (strong,nonatomic) NSArray* classifyInfoArray;//项目分类
@property (strong, nonatomic) IBOutlet UIView *menuAchorView;

@end

@implementation DoctorViewController
+(instancetype)viewController
{
    DoctorViewController* ctrl=[[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadProvincialInfo];
    //[self loadFindClassifyInfo];
    // Do any additional setup after loading the view.
}
-(void)setup{
    self.sortType = 1;
    NSInteger type = 1;
    self.sortTypes = @[@{@"name" : @"智能推荐", @"type"  : @(type++)},
                       @{@"name" : @"好评专家", @"type"  : @(type++)},
                       @{@"name" : @"在线咨询", @"type"  : @(type++)}];
    
    self.menu = [[DOPDropDownMenu alloc] initWithOrigin:self.menuAchorView.frame.origin andHeight:40];
    self.menu.dataSource = self;
    self.menu.delegate = self;
    [self.view addSubview:self.menu];

    }
// 获取省市区信息->供配件筛选界面使用
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
            
//            ProvincialInfo* allZone = [[ProvincialInfo alloc] init];
//            allZone.cname = @"全部地区";
//            
//            [array addObject:allZone];

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
            //[weakSelf.menu reloadData];
            [weakSelf loadFindClassifyInfo];
        }
    };
    [[CommonServerInteraction sharedInstance] findProvinceResponseBlock:block];

}
// 获取项目分类列表
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
            
            //            ProvincialInfo* allZone = [[ProvincialInfo alloc] init];
            //            allZone.cname = @"全部地区";
            //
            //            [array addObject:allZone];
            
            [array backInsertArray:dataOrList];
            weakSelf.classifyInfoArray = array;
            [weakSelf.menu reloadData];
        }
    };
    [[CommonServerInteraction sharedInstance] findClassifyResponseBlock:block];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DOPDropDownMenuDataSource

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
//    if (self.provincialInfoArray == nil && self.classifyInfoArray==nil)
//    {
//        return 1;
//    }
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if(column==0)
    {
        return [self.provincialInfoArray count];
    }
    else if(column==1)
    {
        return [self.classifyInfoArray count];
    }
    else if(column==2){
        return [self.sortTypes count];
    }
    return 0;
//    if(column == 1 || self.provincialInfoArray == nil)
//    {
//        return [self.sortTypes count];
//    }
//    return [self.provincialInfoArray count];
}

- (NSString*)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if(indexPath.column==0)
    {
        CommonInfo* info = [self.provincialInfoArray objectAtIndex:indexPath.row];
                if ([info isKindOfClass:[CommonInfo class]])
                {
                    return info.cname;
                }

    }
    if(indexPath.column==1)
    {
        FindClassifyInfo* info = [self.classifyInfoArray objectAtIndex:indexPath.row];
        if ([info isKindOfClass:[FindClassifyInfo class]])
        {
            return info.pName;
        }
    }
    if(indexPath.column==2)
    {
        if (indexPath.row < [self.sortTypes count])
                    {
                        NSDictionary* dict = [self.sortTypes objectAtIndex:indexPath.row];
                        if ([dict isKindOfClass:[NSDictionary class]])
                        {
                            return dict[@"name"];
                        }
                    }

    }
//    if (indexPath.column == 1 || self.provincialInfoArray == nil)
//    {
//        if (indexPath.row < [self.sortTypes count])
//        {
//            NSDictionary* dict = [self.sortTypes objectAtIndex:indexPath.row];
//            if ([dict isKindOfClass:[NSDictionary class]])
//            {
//                return dict[@"name"];
//            }
//        }
//    }
//    
//    if (indexPath.row < [self.provincialInfoArray count])
//    {
//        
//        CommonInfo* info = [self.provincialInfoArray objectAtIndex:indexPath.row];
//        if ([info isKindOfClass:[CommonInfo class]])
//        {
//            return info.cname;
//        }
//    }
    return @"";
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if(column==0)
    {
        CommonInfo* info = [self.provincialInfoArray objectAtIndex:row];
        if ([info isKindOfClass:[CommonInfo class]] && [info.province isKindOfClass:[NSArray class]])
        {
            return [info.province count];
        }

    }
    if(column==1)
    {
        FindClassifyInfo* info = [self.classifyInfoArray objectAtIndex:row];
        if ([info isKindOfClass:[FindClassifyInfo class]] && [info.cList isKindOfClass:[NSArray class]])
        {
            return [info.cList count];
        }

    }
    if(column==2)
    {
        return 0;
    }
//    if (column == 2 || self.provincialInfoArray == nil)
//    {
//        return 0;
//    }
//    if (row < [self.provincialInfoArray count])
//    {
//        CommonInfo* info = [self.provincialInfoArray objectAtIndex:row];
//        if ([info isKindOfClass:[CommonInfo class]] && [info.province isKindOfClass:[NSArray class]])
//        {
//            return [info.province count];
//        }
//    }
    return 0;
}

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



@end
