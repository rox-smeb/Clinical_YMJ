//
//  VerDoctorWebViewController.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "VerDoctorWebViewController.h"
#import "VerDoctorFooterView.h"
#import "VerDoctorWebTableViewCell.h"
#import "DoctorDetailsHeaderView.h"
#import "BeautyServerInteraction.h"
#import "ProjectTableViewCell.h"
#import "CaseTableViewCell.h"

#define TABLEVIEW_HEADER_HEIGHT_0            (690.0f)
#define TABLEVIEW_HEADER_HEIGHT_1            (540.0f)
#define TABLEVIEW_HEADER_HEIGHT_2            (1130.0f)

@interface VerDoctorWebViewController ()<UITableViewDataSource,
                                         UITableViewDelegate,
                                         DoctorDetailsHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *webTabelview;
@property (strong, nonatomic) GetDoctorDetailsInfo *getInfo;
@property (strong, nonatomic) NSMutableArray *projectCount;

@property (strong, nonatomic) DoctorDetailsHeaderView *tableHeader;
@property (copy, nonatomic) NSString *did;

@end

@implementation VerDoctorWebViewController

+ (instancetype)viewController
{
    VerDoctorWebViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}

+ (instancetype)viewControllerWithDid:(NSString *)did
{
    VerDoctorWebViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
    ctrl.did = did;
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self loadData];
}

- (void)setup
{
    [self.webTabelview solveCrashWithIOS7];                 // 静态cell的tableview 在ios7上用约束 会闪退
    [self.webTabelview removeSeperatorBlank];               // 删除 前面的 空白
    [self.webTabelview removeRedundanceSeperator];          // 删除 多余的线
    self.webTabelview.separatorStyle = NO;                  // 隐藏 分割线

    
    self.tableHeader = [DoctorDetailsHeaderView create];
    self.tableHeader.delegate = self;
    self.webTabelview.tableHeaderView = self.tableHeader;
    self.webTabelview.tableHeaderView.height = TABLEVIEW_HEADER_HEIGHT_2;

    [self.webTabelview registerNibName:[ProjectTableViewCell className] cellID:[ProjectTableViewCell className]];
    [self.webTabelview registerNibName:[CaseTableViewCell className] cellID:[CaseTableViewCell className]];
    
}

- (void)loadData
{
    UserInfo* userInfo = [UserInfo currentUser];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, GetDoctorDetailsInfo*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        [weakSelf.webTabelview nlHeaderEndRefresh];
        
        if ([response success])
        {
            [response showHUD];
            NSLog(@"%@", dataOrList);
            [weakSelf.tableHeader setupWithGetDoctorDetailsInfo:dataOrList];
            // 如果医生详情介绍为空
            if ([dataOrList.details isEqualToString:@""]) {
                weakSelf.tableHeader.height = TABLEVIEW_HEADER_HEIGHT_1;
                [weakSelf.webTabelview beginUpdates];
                [weakSelf.webTabelview setTableHeaderView: self.tableHeader];
                [weakSelf.webTabelview endUpdates];
            }
            weakSelf.getInfo = dataOrList;
            [weakSelf.webTabelview reloadData];
        }
        else
        {
            [response showHUD];
        }
    };
    
//    if ([self.webTabelview nlHeaderIsRefresh] == NO)
//    {
//        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.labelText = STRING_LOADING;
//    }
    
    [[BeautyServerInteraction sharedInstance] getDoctorDetailsWithdId:_did
                                                                  uid:userInfo.uid
                                                                 ukey:userInfo.ukey
                                                        responseBlock:block];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - DoctorDetailsHeaderViewDelegate
- (void)detailsHeaderView:(DoctorDetailsHeaderView *)header didClickLookAllWithInfo:(GetDoctorDetailsInfo *)info withType:(BOOL)type
{
    if (type == YES)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width-16, 70)];
        
        CGSize titleSize = [info.details sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        if (titleSize.height-50) {
            self.tableHeader.height = TABLEVIEW_HEADER_HEIGHT_0-50+titleSize.height;
            [self.webTabelview beginUpdates];
            [self.webTabelview setTableHeaderView: self.tableHeader];
            [self.webTabelview endUpdates];
        }
    }
    else
    {
        self.tableHeader.height = TABLEVIEW_HEADER_HEIGHT_0;
        [self.webTabelview beginUpdates];
        [self.webTabelview setTableHeaderView: self.tableHeader];
        [self.webTabelview endUpdates];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [ProjectTableViewCell height];
    }
    else if (indexPath.section == 1)
    {
        return [CaseTableViewCell height];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if ([self.getInfo.projectList isKindOfClass:[NSArray class]] )
        {
            self.projectCount = self.getInfo.projectList;
            if (_projectCount.count != 0)
            {
                return [_projectCount count];
            }
        }
    }
    else if (section == 1)
    {
        if ([self.getInfo.caseList isKindOfClass:[NSArray class]] )
        {
            if (self.getInfo.caseList.count != 0)
            {
                return [self.getInfo.caseList count];
            }
        }
    }

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProjectTableViewCell className] forIndexPath:indexPath];
        if ([self.getInfo.projectList isKindOfClass:[NSArray class]] )
        {
            if (self.getInfo.projectList.count != 0)
            {
                [cell setupWithProjectInfo:[self.getInfo.projectList objectAtIndex:indexPath.row]];
            }
        }
        //cell.delegate = self;
        [cell solveCrashWithIOS7];
        [cell removeSeperatorBlank];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        CaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CaseTableViewCell className] forIndexPath:indexPath];
        if ([self.getInfo.caseList isKindOfClass:[NSArray class]] )
        {
            if (self.getInfo.caseList.count != 0)
            {
                [cell setupWithCaseInfo:[self.getInfo.caseList objectAtIndex:indexPath.row]];
            }
        }
        //cell.delegate = self;
        [cell solveCrashWithIOS7];
        [cell removeSeperatorBlank];
        
        return cell;
    }
    return nil;
}

@end
