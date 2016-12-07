//
//  CollectionDoctorTableViewController.m
//  求美者端
//
//  Created by Smeb on 2016/12/7.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "CollectionDoctorTableViewController.h"
#import "ExpertTableViewCell.h"
#import "VerDoctorWebViewController.h"
#import "MineServerInteraction.h"

@interface CollectionDoctorTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *CollectionTableView;

@property (strong, nonatomic) NSMutableArray *expertData;

@end

@implementation CollectionDoctorTableViewController

+ (instancetype)viewController
{
    CollectionDoctorTableViewController* ctrl=[[self class] viewControllerWithStoryboardName:@"Mine"];
    return ctrl;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self loadData];
}

- (void)setup
{
    self.expertData = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    [self.CollectionTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.CollectionTableView removeRedundanceSeperator];         // 删除 多余的线
    
    [self.CollectionTableView registerNibName:[ExpertTableViewCell className] cellID:[ExpertTableViewCell className]];
    
    [CommonEmptyListView configTableView:self.CollectionTableView emptyText:@"暂无收藏医生"];
    
    [self.CollectionTableView nlHeaderRefreshWithTarget:self action:@selector(loadData)];
    [self.CollectionTableView nlFooterRefreshWithTarget:self action:@selector(loadMore)];

}

- (void)loadData
{
    UserInfo* userInfo = [UserInfo currentUser];

    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<ExpertInfo*>*)
    {
        if ([response success])
        {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [weakSelf.CollectionTableView nlHeaderEndRefresh];
            [response showHUD];
            
            [weakSelf.expertData removeAllObjects];
            [weakSelf.expertData frontInsertArray:dataOrList];
            [weakSelf.CollectionTableView reloadData];
        }
        else
        {
            [response showHUD];
        }
    };
    
    if ([self.CollectionTableView nlHeaderIsRefresh] == NO)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = STRING_LOADING;
    }
    
    [[MineServerInteraction sharedInstance] findFollowExpertWithUid:userInfo.uid
                                                               ukey:userInfo.ukey
                                                            sort_id:@"0"
                                                             newset:@"true"
                                                      responseBlock:block];
}

- (void)loadMore
{
    UserInfo* userInfo = [UserInfo currentUser];

    ExpertInfo* last = [self.expertData lastObject];
    if (last == nil || last.sort_id == nil)
    {
        [self.CollectionTableView nlFooterEndRefresh];
        return;
    }
    
    NSString *sort_id = [NSString stringWithFormat:@"-%@", last.sort_id];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<ExpertInfo*>*)
    {
        
        [weakSelf.CollectionTableView nlFooterEndRefresh];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if ([response isCachedResponse])
        {
            return;
        }
        
        if ([response success])
        {
            if ([weakSelf.expertData backInsertArray:dataOrList])
            {
                [weakSelf.CollectionTableView reloadData];
            }
            [SVProgressHUD showSuccessWithStatus:@"全部数据加载完毕"];
        }
        else
        {
            [response showHUD];
        }
    };
    
    [[MineServerInteraction sharedInstance] findFollowExpertWithUid:userInfo.uid
                                                               ukey:userInfo.ukey
                                                            sort_id:sort_id
                                                             newset:@"true"
                                                      responseBlock:block];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.expertData count])
    {
        ExpertInfo* info = [self.expertData objectAtIndex:indexPath.row];
        return [ExpertTableViewCell heightWihtInfo:info];
    }
    return 122.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < [self.expertData count])
    {
        ExpertInfo *info = [self.expertData objectAtIndex:indexPath.row];
        VerDoctorWebViewController *verVC = [VerDoctorWebViewController viewControllerWithDid:info.eId];
        [self.navigationController pushViewController:verVC animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.expertData.count != 0)
    {
        return [self.expertData count];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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

@end
