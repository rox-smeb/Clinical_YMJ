//
//  GetPolicySubViewController.m
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "GetPolicySubViewController.h"
#import "MineServerInteraction.h"
#import "GetPolicyTableViewCell.h"

@interface GetPolicySubViewController ()

@property (weak, nonatomic) GetPolicyViewController *parentVC;
@property (weak, nonatomic) IBOutlet UITableView *questionTableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation GetPolicySubViewController

- (void)setParent:(GetPolicyViewController*)parent
{
    _parentVC = parent;
}

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
    self.dataSource=[NSMutableArray array];
    [self.questionTableView removeSeperatorBlank];
    [self.questionTableView removeRedundanceSeperator];
    
    [self.questionTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.questionTableView removeRedundanceSeperator];         // 删除 多余的线
    
    [self.questionTableView nlHeaderRefreshWithTarget:self action:@selector(loadData)];
    [self.questionTableView nlFooterRefreshWithTarget:self action:@selector(loadMore)];
    
    [self.questionTableView registerNibName:[GetPolicyTableViewCell className] cellID:[GetPolicyTableViewCell className]];
    
    [CommonEmptyListView configTableView:self.questionTableView emptyText:@"暂无保单信息"];
    
}

- (void)loadData
{
    UserInfo* info = [UserInfo currentUser];
    NSString *state = [NSString stringWithFormat:@"%ld", (long)self.itemTag];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<GetPolicyListInfo*>*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.questionTableView animated:YES];
        [weakSelf.questionTableView nlHeaderEndRefresh];
        
        if ([response success])
        {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.dataSource frontInsertArray:dataOrList];
            [weakSelf.questionTableView reloadData];
        }
        else
        {
            [response showHUD];
        }
    };
    
    if ([self.questionTableView nlHeaderIsRefresh] == NO)
    {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.questionTableView animated:YES];
        hud.labelText = STRING_LOADING;
    }
    
    [[MineServerInteraction sharedInstance] getPolicyListWithUid:info.uid
                                                            ukey:info.ukey
                                                           state:state
                                                         sort_id:@"0"
                                                          newset:@"true"
                                                   responseBlock:block];
}

- (void)loadMore
{
    UserInfo* info = [UserInfo currentUser];
    NSString *state = [NSString stringWithFormat:@"%ld", (long)self.itemTag];
    
    NSString* sortId = @"0";
    MyDemandInfo* last = [self.dataSource lastObject];
    if (last == nil)
    {
        [self.questionTableView nlFooterEndRefresh];
        return;
    }
    else
    {
        sortId = [NSString stringWithFormat:@"-%@",last.sort_id];
    }
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<GetPolicyListInfo*>*)
    {
        [weakSelf.questionTableView nlFooterEndRefresh];
        
        if ([response isCachedResponse])
        {
            return;
        }
        
        if ([response success])
        {
            [weakSelf.dataSource backInsertArray:dataOrList];
            [weakSelf.questionTableView reloadData];
        }
        else
        {
            [response showHUD];
        }
    };
    
    [[MineServerInteraction sharedInstance] getPolicyListWithUid:info.uid
                                                            ukey:info.ukey
                                                           state:state
                                                         sort_id:sortId
                                                          newset:@"true"
                                                   responseBlock:block];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GetPolicyTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count != 0)
    {
        return [self.dataSource count];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetPolicyTableViewCell *getPoCell = [tableView dequeueReusableCellWithIdentifier:[GetPolicyTableViewCell className] forIndexPath:indexPath];
    if(indexPath.row<[self.dataSource count])
    {
        GetPolicyListInfo* info=[self.dataSource objectAtIndex:indexPath.row];
        [getPoCell setupWithGetPolicyInfo:info];
    }
    [getPoCell solveCrashWithIOS7];
    [getPoCell removeSeperatorBlank];
    return getPoCell;
}

@end
