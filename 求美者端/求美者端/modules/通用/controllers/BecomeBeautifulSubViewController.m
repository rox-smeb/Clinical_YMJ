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

#define ITEM_TAG_AUCTIONPROJECT                 (0)
#define ITEM_TAG_EXPERT                         (1)
#define ITEM_TAG_AGENCY                         (2)


@interface BecomeBeautifulSubViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *beautifulTableView;

@property (strong, nonatomic) NSMutableArray *auctionProData;
@property (strong, nonatomic) NSMutableArray *expertData;
@property (strong, nonatomic) NSMutableArray *agencyData;

@end

@implementation BecomeBeautifulSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    self.auctionProData = [[NSMutableArray alloc] initWithCapacity:0];
    self.expertData = [[NSMutableArray alloc] initWithCapacity:0];
    self.agencyData = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self.beautifulTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.beautifulTableView removeRedundanceSeperator];         // 删除 多余的线
    
    [self.beautifulTableView registerNibName:[HospitalTableViewCell className] cellID:[HospitalTableViewCell className]];
    [self.beautifulTableView registerNibName:[ExpertTableViewCell className] cellID:[ExpertTableViewCell className]];
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
            if ([response success])
            {
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                [response showHUD];
            }
            else
            {
                [response showHUD];
            }
        };
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = STRING_LOADING;
        
        [[BeautyServerInteraction sharedInstance] findAuctionProjectWithSort_id:0
                                                                         newset:@"true"
                                                                     classifyId:@""
                                                                      countryId:@"1"
                                                                     provinceId:@""
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
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = STRING_LOADING;
        
        [[BeautyServerInteraction sharedInstance] findExpertWithSort_id:0
                                                                 newset:@"true"
                                                             classifyId:@""
                                                              projectId:@""
                                                              countryId:@"1"
                                                             provinceId:@""
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
            if ([response success])
            {
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
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
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = STRING_LOADING;
        
        [[BeautyServerInteraction sharedInstance] findAgencyWithSort_id:@"0"
                                                                 newset:@"true"
                                                             classifyId:@""
                                                              countryId:@"1"
                                                             provinceId:@""
                                                                keyWord:@""
                                                          responseBlock:block];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 项目竞拍列表
    if (self.itemTag == ITEM_TAG_AUCTIONPROJECT)
    {
        return [HospitalTableViewCell height];
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
        return 0;
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
