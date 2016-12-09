//
//  MyDamandTableViewController.m
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MyDamandTableViewController.h"
#import "DamandTableViewCell.h"
#import "MineServerInteraction.h"


@interface MyDamandTableViewController ()<UITableViewDelegate,
                                          UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *damandTableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation MyDamandTableViewController

+ (instancetype)viewController
{
    MyDamandTableViewController* ctrl=[[self class] viewControllerWithStoryboardName:@"Mine"];
    return ctrl;
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
    [self.tableView removeSeperatorBlank];
    [self.tableView removeRedundanceSeperator];
    
    [self.tableView nlHeaderRefreshWithTarget:self action:@selector(loadData)];
    [self.tableView nlFooterRefreshWithTarget:self action:@selector(loadMore)];
    
    [self.tableView registerNibName:[DamandTableViewCell className] cellID:[DamandTableViewCell className]];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:NOTIFICATION_FAVORITE_STORE_ADD object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteItem:) name:NOTIFICATION_FAVORITE_STORE_DELETE object:nil];
    
    [CommonEmptyListView configTableView:self.tableView emptyText:@"您还未发布需求"];
}

-(void)loadData
{
    UserInfo* info = [UserInfo currentUser];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<MyDemandInfo*>*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.tableView animated:YES];
        [weakSelf.tableView nlHeaderEndRefresh];
        
        if ([response success])
        {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.dataSource frontInsertArray:dataOrList];
            [weakSelf.tableView reloadData];
        }
        else
        {
            [response showHUD];
        }
    };
    
    if ([self.tableView nlHeaderIsRefresh] == NO)
    {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        hud.labelText = STRING_LOADING;
    }
    
    [[MineServerInteraction sharedInstance] findMyDemandWithUid:info.uid
                                                           ukey:info.ukey
                                                        sort_id:@"0"
                                                         newset:@"true"
                                                  responseBlock:block];
}
- (void)loadMore
{
    UserInfo* info = [UserInfo currentUser];
    
    NSString* sortId = @"0";
    MyDemandInfo* last = [self.dataSource lastObject];
    if (last == nil)
    {
        [self.tableView nlFooterEndRefresh];
        return;
    }
    else
    {
        sortId = [NSString stringWithFormat:@"-%@",last.sort_id];
    }
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<MyDemandInfo*>*)
    {
        [weakSelf.tableView nlFooterEndRefresh];

        if ([response isCachedResponse])
        {
            return;
        }
                
        if ([response success])
        {
            [weakSelf.dataSource backInsertArray:dataOrList];
            [weakSelf.tableView reloadData];
        }
        else
        {
            [response showHUD];
        }
    };
    
    [[MineServerInteraction sharedInstance] findMyDemandWithUid:info.uid
                                                           ukey:info.ukey
                                                        sort_id:sortId
                                                         newset:@"true"
                                                  responseBlock:block];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DamandTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row < [self.expertData count])
//    {
//        ExpertInfo *info = [self.expertData objectAtIndex:indexPath.row];
//        VerDoctorWebViewController *verVC = [VerDoctorWebViewController viewControllerWithDid:info.eId];
//        [self.navigationController pushViewController:verVC animated:YES];
//    }
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
    DamandTableViewCell *damandCell = [tableView dequeueReusableCellWithIdentifier:[DamandTableViewCell className] forIndexPath:indexPath];
    if(indexPath.row<[self.dataSource count])
    {
        MyDemandInfo* info=[self.dataSource objectAtIndex:indexPath.row];
        [damandCell setupWithDemandInfo:info];
    }
    [damandCell solveCrashWithIOS7];
    [damandCell removeSeperatorBlank];
    return damandCell;
}

@end
