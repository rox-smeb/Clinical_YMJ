//
//  MyMedicalRecordListTableViewController.m
//  求美者端
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MyMedicalRecordListTableViewController.h"
#import "MyCaseTableViewCell.h"
#import "UserInfo.h"
#import "MyMedicalRecordListInfo.h"
#import "MyServerInteraction.h"
@interface MyMedicalRecordListTableViewController ()<UITableViewDelegate,
                                                    UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation MyMedicalRecordListTableViewController
+(instancetype)viewController
{
    MyMedicalRecordListTableViewController* ctrl=[[self class] viewControllerWithStoryboardName:@"Mine"];
    return ctrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setup
{
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.navigationController.navigationBar.translucent = NO;
    //self.tabBarController.tabBar.translucent = NO;
    self.dataSource=[NSMutableArray array];
    [self.tableView removeSeperatorBlank];
    [self.tableView removeRedundanceSeperator];
    
    [self.tableView nlHeaderRefreshWithTarget:self action:@selector(loadData)];
    [self.tableView nlFooterRefreshWithTarget:self action:@selector(loadMore)];
    
    [self.tableView registerNibName:[MyCaseTableViewCell className] cellID:[MyCaseTableViewCell className]];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:NOTIFICATION_FAVORITE_STORE_ADD object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteItem:) name:NOTIFICATION_FAVORITE_STORE_DELETE object:nil];
    
    [CommonEmptyListView configTableView:self.tableView emptyText:@"医生还没有为您创建病历"];
}
-(void)loadData
{
    UserInfo* info = [UserInfo currentUser];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<MyMedicalRecordListInfo*>*)
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
    [[MyServerInteraction sharedInstance] myMedicalRecordListSortId:@"0"
                                                                uid:info.uid
                                                               ukey:info.ukey
                                                             newset:@"true"
                                                      responseBlock:block];
}
- (void)loadMore
{
    UserInfo* info = [UserInfo currentUser];
    
    NSString* sortId = @"0";
    MyMedicalRecordListInfo* last = [self.dataSource lastObject];
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
    YB_RESPONSE_BLOCK_EX(block, NSArray<MyMedicalRecordListInfo*>*)
    {
        if ([response isCachedResponse])
        {
            return;
        }
        
        [weakSelf.tableView nlFooterEndRefresh];
        
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
    
    [[MyServerInteraction sharedInstance] myMedicalRecordListSortId:sortId
                                                                uid:info.uid
                                                               ukey:info.ukey
                                                             newset:@"true"
                                                      responseBlock:block];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyCaseTableViewCell height];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCaseTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:[MyCaseTableViewCell className] forIndexPath:indexPath];
    [cell removeSeperatorBlank];
    if(indexPath.row<[self.dataSource count])
    {
        MyMedicalRecordListInfo* info=[self.dataSource objectAtIndex:indexPath.row];
        [cell setupWithInfo:info];
    }
    return cell;
}
@end
