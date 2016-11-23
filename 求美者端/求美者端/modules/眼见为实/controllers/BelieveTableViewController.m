//
//  BelieveTableViewController.m
//  求美者端
//
//  Created by Smeb on 2016/11/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "BelieveTableViewController.h"
#import "VideoTableViewCell.h"
#import "CommonServerInteraction.h"
#import "VideoInfo.h"
#import "PlayVideoViewController.h"

@interface BelieveTableViewController ()<UITableViewDelegate,
                                         UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *videoTableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation BelieveTableViewController
// 视频播放
+ (instancetype)viewController
{
    BelieveTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Believe"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setup];
    
}

- (void)setup
{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self.videoTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.videoTableView removeRedundanceSeperator];         // 删除 多余的线
    
    [self.videoTableView registerNibName:[VideoTableViewCell className] cellID:[VideoTableViewCell className]];


}

- (void)loadData
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<VideoInfo*>*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [response showHUD];
        
        if ([response success])
        {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.dataSource frontInsertArray:dataOrList];
            [weakSelf.tableView reloadData];
        }
    };
    
    [[CommonServerInteraction sharedInstance] findVideowithSortId:@"0"
                                                           newset:@"true"
                                                    responseBlock:block];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [VideoTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayVideoViewController *playVC = [PlayVideoViewController viewController];
    VideoInfo *info = [self.dataSource objectAtIndex:indexPath.row];
    playVC.videoUrl = info.url;
    [self.navigationController pushViewController:playVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VideoTableViewCell className] forIndexPath:indexPath];
    [cell solveCrashWithIOS7];
    [cell removeSeperatorBlank];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
