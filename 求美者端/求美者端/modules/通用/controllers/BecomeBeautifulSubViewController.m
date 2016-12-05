//
//  BecomeBeautifulSubViewController.m
//  求美者端
//
//  Created by Smeb on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "BecomeBeautifulSubViewController.h"
#import "HospitalTableViewCell.h"
#import "BeautyServerInteraction.h"
#import "HospitalTableViewCell.h"
#import "ExpertTableViewCell.h"
#import "AuctionProjectTableViewCell.h"
#import "AucionProjectViewController.h"

#define ITEM_TAG_AUCTIONPROJECT                 (0)
#define ITEM_TAG_EXPERT                         (1)
#define ITEM_TAG_AGENCY                         (2)


@interface BecomeBeautifulSubViewController ()<UITableViewDelegate, UITableViewDataSource, BecomeBeautifulViewControllerDelegate>

@property (weak, nonatomic) BecomeBeautifulViewController *parentVC;

@property (weak, nonatomic) IBOutlet UITableView *beautifulTableView;

@property (strong, nonatomic) NSMutableArray *auctionProData;
@property (strong, nonatomic) NSMutableArray *expertData;
@property (strong, nonatomic) NSMutableArray *agencyData;

@property (strong, nonatomic) NSString* countryId;                                  // 国家id
@property (strong, nonatomic) NSString* provinceId;                                 // 省id
@property (strong, nonatomic) NSString* projectId;                                  // 项目id
@property (strong, nonatomic) NSString* classifyId;                                 // 具体项目id

@end

@implementation BecomeBeautifulSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setup];
    [self loadData];
}

- (void)setParent:(BecomeBeautifulViewController*)parent
{
    _parentVC = parent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    self.auctionProData = [[NSMutableArray alloc] initWithCapacity:0];
    self.expertData = [[NSMutableArray alloc] initWithCapacity:0];
    self.agencyData = [[NSMutableArray alloc] initWithCapacity:0];
    
    _parentVC.delegate = self;
    
    [self.beautifulTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.beautifulTableView removeRedundanceSeperator];         // 删除 多余的线
    
    [self.beautifulTableView registerNibName:[HospitalTableViewCell className] cellID:[HospitalTableViewCell className]];
    [self.beautifulTableView registerNibName:[ExpertTableViewCell className] cellID:[ExpertTableViewCell className]];
    [self.beautifulTableView registerNibName:[AuctionProjectTableViewCell className] cellID:[AuctionProjectTableViewCell className]];
    
    [CommonEmptyListView configTableView:self.beautifulTableView emptyText:@"暂无相关信息"];

    [self.beautifulTableView nlHeaderRefreshWithTarget:self action:@selector(loadData)];
    [self.beautifulTableView nlFooterRefreshWithTarget:self action:@selector(loadMore)];


}

#pragma mark - 加载数据
- (void)loadData
{
    // 项目竞拍列表
    if (self.itemTag == ITEM_TAG_AUCTIONPROJECT)
    {
        @weakify_self;
        YB_RESPONSE_BLOCK_EX(block, NSArray<AuctionProjectInfo*>*)
        {
            [weakSelf.beautifulTableView nlHeaderEndRefresh];
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

            if ([response success])
            {

                [response showHUD];
                
                [weakSelf.auctionProData removeAllObjects];
                [weakSelf.auctionProData frontInsertArray:dataOrList];
                [weakSelf.beautifulTableView reloadData];

            }
            else
            {
                [response showHUD];
            }
        };
        
        if ([self.beautifulTableView nlHeaderIsRefresh] == NO)
        {
            MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = STRING_LOADING;
        }
        
        [[BeautyServerInteraction sharedInstance] findAuctionProjectWithSort_id:0
                                                                         newset:@"true"
                                                                     classifyId:self.classifyId
                                                                      countryId:self.countryId
                                                                     provinceId:self.provinceId
                                                                          isHot:@""
                                                                        keyWord:@""
                                                                  responseBlock:block];
    }
    
    // 医生列表
    if (self.itemTag == ITEM_TAG_EXPERT)
    {
        @weakify_self;
        YB_RESPONSE_BLOCK_EX(block, NSArray<ExpertInfo*>*)
        {
            if ([response success])
            {
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                [weakSelf.beautifulTableView nlHeaderEndRefresh];
                [response showHUD];
                
                [weakSelf.expertData removeAllObjects];
                [weakSelf.expertData frontInsertArray:dataOrList];
                [weakSelf.beautifulTableView reloadData];
            }
            else
            {
                [response showHUD];
            }
        };
        
        if ([self.beautifulTableView nlHeaderIsRefresh] == NO)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = STRING_LOADING;
        }

        
        [[BeautyServerInteraction sharedInstance] findExpertWithSort_id:0
                                                                 newset:@"true"
                                                             classifyId:_classifyId
                                                              projectId:_projectId
                                                              countryId:_countryId
                                                             provinceId:_provinceId
                                                              queryType:@"0"
                                                                keyWord:@""
                                                          responseBlock:block];
    }
    
    // 机构列表
    if (self.itemTag == ITEM_TAG_AGENCY)
    {
        @weakify_self;
        YB_RESPONSE_BLOCK_EX(block, NSArray<AgencyInfo*>*)
        {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [weakSelf.beautifulTableView nlHeaderEndRefresh];

            if ([response success])
            {
                [response showHUD];
                
                [weakSelf.agencyData removeAllObjects];
                [weakSelf.agencyData frontInsertArray:dataOrList];
                [weakSelf.beautifulTableView reloadData];

            }
            else
            {
                [response showHUD];
            }
        };
        
        if ([self.beautifulTableView nlHeaderIsRefresh] == NO)
        {
            MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = STRING_LOADING;
        }
        
        
        [[BeautyServerInteraction sharedInstance] findAgencyWithSort_id:@"0"
                                                                 newset:@"true"
                                                             classifyId:_classifyId
                                                              countryId:_countryId
                                                             provinceId:_provinceId
                                                                keyWord:@""
                                                          responseBlock:block];
    }
}

- (void)loadMore
{
    // 项目竞拍列表
    if (self.itemTag == ITEM_TAG_AUCTIONPROJECT)
    {
        AuctionProjectInfo* last = [self.auctionProData lastObject];
        if (last == nil || last.sort_id == nil)
        {
            [self.beautifulTableView nlFooterEndRefresh];
            return;
        }
        
        NSString *sort_id = [NSString stringWithFormat:@"-%@", last.sort_id];

        @weakify_self;
        YB_RESPONSE_BLOCK_EX(block, NSArray<AuctionProjectInfo*>*)
        {
            [weakSelf.beautifulTableView nlFooterEndRefresh];
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            
            if ([response isCachedResponse])
            {
                return;
            }

            if ([response success])
            {
                
                if ([weakSelf.auctionProData backInsertArray:dataOrList])
                {
                    [weakSelf.beautifulTableView reloadData];
                }
                [SVProgressHUD showSuccessWithStatus:@"全部数据加载完毕"];
            }
            else
            {
                [response showHUD];
            }
        };
        
        [[BeautyServerInteraction sharedInstance] findAuctionProjectWithSort_id:sort_id
                                                                         newset:@"true"
                                                                     classifyId:self.classifyId
                                                                      countryId:self.countryId
                                                                     provinceId:self.provinceId
                                                                          isHot:@""
                                                                        keyWord:@""
                                                                  responseBlock:block];
    }
    
    // 医生列表
    else if (self.itemTag == ITEM_TAG_EXPERT)
    {
        ExpertInfo* last = [self.expertData lastObject];
        if (last == nil || last.sort_id == nil)
        {
            [self.beautifulTableView nlFooterEndRefresh];
            return;
        }
        
        NSString *sort_id = [NSString stringWithFormat:@"-%@", last.sort_id];

        @weakify_self;
        YB_RESPONSE_BLOCK_EX(block, NSArray<ExpertInfo*>*)
        {
            
            [weakSelf.beautifulTableView nlFooterEndRefresh];
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            
            if ([response isCachedResponse])
            {
                return;
            }

            if ([response success])
            {
                if ([weakSelf.expertData backInsertArray:dataOrList])
                {
                    [weakSelf.beautifulTableView reloadData];
                }
                [SVProgressHUD showSuccessWithStatus:@"全部数据加载完毕"];
            }
            else
            {
                [response showHUD];
            }
        };

        [[BeautyServerInteraction sharedInstance] findExpertWithSort_id:sort_id
                                                                 newset:@"true"
                                                             classifyId:_classifyId
                                                              projectId:_projectId
                                                              countryId:_countryId
                                                             provinceId:_provinceId
                                                              queryType:@"0"
                                                                keyWord:@""
                                                          responseBlock:block];
    }
    
    // 机构列表
    else if (self.itemTag == ITEM_TAG_AGENCY)
    {
        AgencyInfo* last = [self.agencyData lastObject];
        if (last == nil || [last.sort_id isEqualToString: @"0"])
        {
            [self.beautifulTableView nlFooterEndRefresh];
            return;
        }

        @weakify_self;
        YB_RESPONSE_BLOCK_EX(block, NSArray<AgencyInfo*>*)
        {
            [weakSelf.beautifulTableView nlFooterEndRefresh];
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

            if ([response isCachedResponse])
            {
                return;
            }
            
            if ([response success])
            {
                if ([weakSelf.agencyData backInsertArray:dataOrList])
                {
                    [weakSelf.beautifulTableView reloadData];
                }
                [SVProgressHUD showSuccessWithStatus:@"全部数据加载完毕"];
            }
            else
            {
                [response showHUD];
            }
        };

        NSString *sort_id = [NSString stringWithFormat:@"-%@", last.sort_id];
        [[BeautyServerInteraction sharedInstance] findAgencyWithSort_id:sort_id
                                                                 newset:@"true"
                                                             classifyId:_classifyId
                                                              countryId:_countryId
                                                             provinceId:_provinceId
                                                                keyWord:@""
                                                          responseBlock:block];
    }
}

#pragma mark - BecomeBeautifulViewControllerDelegate
- (void)loadCityListWithCid:(NSString *)cid pid:(NSString *)pid
{
    self.countryId = cid;
    self.provinceId = pid;
    [self.beautifulTableView nlHeaderBeginRefresh];
}

- (void)loadProjectListWithFid:(NSString *)fid oid:(NSString *)oid
{
    self.projectId = fid;
    self.classifyId = oid;
    [self.beautifulTableView nlHeaderBeginRefresh];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 项目竞拍列表
    if (self.itemTag == ITEM_TAG_AUCTIONPROJECT)
    {
        return [AuctionProjectTableViewCell height];
    }
    
    // 医生列表
    if (self.itemTag == ITEM_TAG_EXPERT)
    {
        if (indexPath.row < [self.expertData count])
        {
            ExpertInfo* info = [self.expertData objectAtIndex:indexPath.row];
            return [ExpertTableViewCell heightWihtInfo:info];
        }
        return 100.0f;
    }
    
    // 机构列表
    if (self.itemTag == ITEM_TAG_AGENCY)
    {
        return [HospitalTableViewCell height];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // 项目竞拍列表
    if (self.itemTag == ITEM_TAG_AUCTIONPROJECT)
    {
        if (indexPath.row < [self.auctionProData count])
        {
            AuctionProjectInfo *info = [self.auctionProData objectAtIndex:indexPath.row];
            AucionProjectViewController *apVC = [AucionProjectViewController viewController];
            apVC.auctionInfo = info;
            [self.navigationController pushViewController:apVC animated:YES];
        }
    }
    
    // 医生列表
    if (self.itemTag == ITEM_TAG_EXPERT)
    {
    }
    
    // 机构列表
    if (self.itemTag == ITEM_TAG_AGENCY)
    {
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 项目竞拍列表
    if (self.itemTag == ITEM_TAG_AUCTIONPROJECT)
    {
        return [self.auctionProData count];
    }
    
    // 医生列表
    if (self.itemTag == ITEM_TAG_EXPERT)
    {
        return [self.expertData count];
    }
    
    // 机构列表
    if (self.itemTag == ITEM_TAG_AGENCY)
    {
        return [self.agencyData count];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 项目竞拍列表
    if (self.itemTag == ITEM_TAG_AUCTIONPROJECT)
    {
        AuctionProjectTableViewCell *auctionCell = [tableView dequeueReusableCellWithIdentifier:[AuctionProjectTableViewCell className] forIndexPath:indexPath];
        [auctionCell solveCrashWithIOS7];
        [auctionCell removeSeperatorBlank];
        if (indexPath.row < [self.auctionProData count])
        {
            AuctionProjectInfo* info = [self.auctionProData objectAtIndex:indexPath.row];
            [auctionCell setUpWithAuctionProjectInfo:info];
            if ([info.urlList isKindOfClass:[NSArray class]] && indexPath.row < [info.urlList count])
            {
                AuctionProUrlInfo* rInfo = [info.urlList objectAtIndex:indexPath.row];
                [auctionCell setupWithInfo:info orderInfo:rInfo];
            }
        }
        return auctionCell;
    }
    
    // 医生列表
    if (self.itemTag == ITEM_TAG_EXPERT)
    {
        ExpertTableViewCell *doctorCell = [tableView dequeueReusableCellWithIdentifier:[ExpertTableViewCell className] forIndexPath:indexPath];
        [doctorCell solveCrashWithIOS7];
        [doctorCell removeSeperatorBlank];
        if (indexPath.row < [self.expertData count])
        {
            ExpertInfo* info = [self.expertData objectAtIndex:indexPath.row];
            [doctorCell setUpWithExpertInfo:info];
            if ([info.recommendList isKindOfClass:[NSArray class]] )
            {
                NSString* labelStr = @"";
                for (int i = 0; i < [info.recommendList count]; i++) {
                    ExpertRecomendInfo *erInfo = [info.recommendList objectAtIndex:i];
                    NSString *str = erInfo.rName;
                    labelStr = [labelStr stringByAppendingString:[NSString stringWithFormat:@"%@\n", str]];
                }
                [doctorCell setupWithInfo:info orderInfo:labelStr];
            }
        }
        return doctorCell;
    }
    
    // 机构列表
    if (self.itemTag == ITEM_TAG_AGENCY)
    {
        HospitalTableViewCell *hospCell = [tableView dequeueReusableCellWithIdentifier:[HospitalTableViewCell className] forIndexPath:indexPath];
        [hospCell solveCrashWithIOS7];
        [hospCell removeSeperatorBlank];
        if (indexPath.row < [self.agencyData count])
        {
            AgencyInfo* info = [self.agencyData objectAtIndex:indexPath.row];
            [hospCell setUpWithAgencyInfo:info];
            if ([info.recommendList isKindOfClass:[NSArray class]] && indexPath.row < [info.recommendList count])
            {
                AgencyRecomendInfo* rInfo = [info.recommendList objectAtIndex:indexPath.row];
                [hospCell setupWithInfo:info orderInfo:rInfo];
            }
        }
        return hospCell;
    }
    return nil;
}



@end
