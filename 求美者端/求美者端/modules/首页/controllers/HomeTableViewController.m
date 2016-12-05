//
//  HomeTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/10.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "HomeTableViewController.h"
#import "ConsultationViewController.h"
#import "HomeServerInteraction.h"
#import "NotificationsDefine.h"
#import "GarageAbilityTableViewCell.h"
#import "FunctionTableViewCell.h"
#import "FaceLiftingTableViewCell.h"
#import "HomeTableViewHeaderView.h"
#import "Quackwatch110TableViewController.h"
#import "GuaranteeOrderViewController.h"
#import "ConsultationViewController.h"
#import "DisputeResolveTableViewController.h"
#import "VerifyDoctorTableViewController.h"
#import "VerifyFrameWorkTableViewController.h"
#import "DisputeResolveViewController.h"
#import "ConsultationCollectionViewController.h"
#import "BecomeBeautifulViewController.h"
#import "ToKoreaViewController.h"
#import "FailRepairViewController.h"
@interface HomeTableViewController ()<UITableViewDelegate,
                                      UITableViewDataSource,
                                      UINavigationControllerDelegate,
                                      GarageAbilityTableViewCellDelegate,
                                      FunctionTableViewCellDelegate>
{
    dispatch_once_t _onceStartCountLabelAnimate;
}

@property (nonatomic, strong) UIView* fakeNavBar;                       // PUSH新页面需要添加一个假的导航栏(当前页面导航栏透明->跳转页面需要保持有导航栏)

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (strong, nonatomic) HomeTableViewHeaderView *tableHeader;

@property (weak, nonatomic) IBOutlet UIView *container1;                // 我们已经为
@property (weak, nonatomic) IBOutlet UILabel *chinaCount;               // 中国人次
@property (weak, nonatomic) IBOutlet UILabel *koreaCount;               // 韩国人次
@property (weak, nonatomic) IBOutlet JTNumberScrollAnimatedView *totalCountLabel;

/************************** 医 **************************/
@property (weak, nonatomic) IBOutlet UIButton *button1;                 // 验医生
@property (weak, nonatomic) IBOutlet UIButton *button2;                 // 验机构
@property (weak, nonatomic) IBOutlet UIButton *button3;                 // 验用材
@property (weak, nonatomic) IBOutlet UIButton *button4;                 // 问专家
@property (weak, nonatomic) IBOutlet UIButton *button5;                 // 查病历

/************************** 美 **************************/
@property (weak, nonatomic) IBOutlet UIButton *button6;                 // 我要求美
@property (weak, nonatomic) IBOutlet UIButton *button7;                 // 直通韩国

/************************** 镜 **************************/
@property (weak, nonatomic) IBOutlet UIButton *button8;                 // 委托担保
@property (weak, nonatomic) IBOutlet UIButton *button9;                 // 专家会诊
@property (weak, nonatomic) IBOutlet UIButton *button10;                // 争议调解

@property (nonatomic, strong) NSArray *titleName;                       // 标签名字

@end

@implementation HomeTableViewController

+ (instancetype)viewController
{
    HomeTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 保证JTNumberScrollAnimatedView正确的layout
    dispatch_once(&_onceStartCountLabelAnimate, ^{
        
        [self.totalCountLabel startAnimation];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup
{
    [self.homeTableView solveCrashWithIOS7];                // 静态cell的tableview 在ios7上用约束 会闪退
    [self.homeTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.homeTableView removeRedundanceSeperator];         // 删除 多余的线
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.delegate = self;
    //[self setNavigationBarAlpha:0.0f];

    self.tableHeader = [HomeTableViewHeaderView create];
    //self.tableHeader.delegate = self;
    self.homeTableView.tableHeaderView = self.tableHeader;
    self.homeTableView.tableHeaderView.height = [HomeTableViewHeaderView height];
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 50, 0);
    self.homeTableView.contentInset = edgeInsets;

    [self.homeTableView registerNibName:[FunctionTableViewCell className] cellID:[FunctionTableViewCell className]];
    [self.homeTableView registerNibName:[FaceLiftingTableViewCell className] cellID:[FaceLiftingTableViewCell className]];

    
    self.totalCountLabel.textColor = RGB(13, 109, 178);
    self.totalCountLabel.font = [UIFont systemFontOfSize:30.0f];
    self.totalCountLabel.minLength = 7;
    self.totalCountLabel.duration = 0.45f;
    [self.totalCountLabel setValue:@(0)];
    
    self.container1.layer.borderColor = RGB(4, 99, 171).CGColor;
    self.container1.layer.borderWidth = 0.5f;
    self.container1.layer.cornerRadius = 1.0f;
    
    CGFloat radius = 4.0f;
    self.button1.layer.cornerRadius = radius;
    self.button2.layer.cornerRadius = radius;
    self.button3.layer.cornerRadius = radius;
    self.button4.layer.cornerRadius = radius;
    self.button5.layer.cornerRadius = radius;
    self.button6.layer.cornerRadius = radius;
    self.button7.layer.cornerRadius = radius;
    self.button8.layer.cornerRadius = radius;
    self.button9.layer.cornerRadius = radius;
    self.button10.layer.cornerRadius = radius;
    
    [self.homeTableView nlHeaderRefreshWithTarget:self action:@selector(loadData)];
    
    // 注册成功->更新首页数字
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:NOTIFICATION_USER_REGISTER_SUCCESS object:nil];
}

- (void)loadData
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, HomePormptInfo*)
    {
        [weakSelf.homeTableView nlHeaderEndRefresh];
        
        if ([response success])
        {
            weakSelf.chinaCount.text = [dataOrList chinaSums];
            weakSelf.koreaCount.text = [dataOrList koreaSums];
            
            NSNumber* sums = [dataOrList sumsCount];
            if ([weakSelf.totalCountLabel.value isEqualToNumber:sums] == NO)
            {
                [weakSelf.totalCountLabel setValue:sums];
                [weakSelf.totalCountLabel startAnimation];
            }
        }
    };
    [[HomeServerInteraction sharedInstance] getHomePormptNumResponseBlock:block];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != self)
    {
        if (navigationController.viewControllers.count == 2)
        {
            if (self.fakeNavBar == nil)
            {
                CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
                CGFloat width = [self.navigationController.navigationBar width];
                CGFloat height = statusHeight + [self.navigationController.navigationBar height];
                self.fakeNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, -height, width, height)];
                self.fakeNavBar.backgroundColor = RGB(241, 249, 249);
            }
            
            if (self.fakeNavBar.superview != nil)
            {
                [self.fakeNavBar removeFromSuperview];
            }
            
            [viewController.view addSubview:self.fakeNavBar];
        }
    }
    else
    {
        if (self.fakeNavBar != nil)
        {
            [self.fakeNavBar setHidden:NO];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != self)
    {
        if (navigationController.viewControllers.count == 2)
        {
            [self.fakeNavBar setHidden:YES];
        }
    }
}

#pragma mark - GarageAbilityTableViewCellDelegate

- (void)header:(GarageAbilityTableViewCell*)header didSelectItemAtIndex:(NSInteger)index
{
    [self.navigationController.navigationBar setHidden:NO];
    NSLog(@"%ld", (long)index);
    if (index == 11)
    {
        Quackwatch110TableViewController *quackTVC = [Quackwatch110TableViewController viewController];
        [self.navigationController pushViewController:quackTVC animated:YES];
    }
    else if (index == 0)
    {
        VerifyDoctorTableViewController *doctorTVC = [VerifyDoctorTableViewController viewController];
        [self.navigationController pushViewController:doctorTVC animated:YES];
    }
    else if (index == 1)
    {
        VerifyFrameWorkTableViewController *fWorkTVC = [VerifyFrameWorkTableViewController viewController];
        [self.navigationController pushViewController:fWorkTVC animated:YES];
    }
    else if (index == 7)
    {
        GuaranteeOrderViewController *guaranteeTVC = [GuaranteeOrderViewController viewController];
        [self.navigationController pushViewController:guaranteeTVC animated:YES];
    }
    else if (index == 8)
    {
        ConsultationViewController *consultationVC = [ConsultationViewController viewController];
        [self.navigationController pushViewController:consultationVC animated:YES];
    }
    else if (index == 9)
    {
        DisputeResolveViewController *disputeTVC = [DisputeResolveViewController viewController];
        [self.navigationController pushViewController:disputeTVC animated:YES];
    }
}

#pragma mark - FunctionTableViewCellDelegate
// 我要求美
- (void)didSelectWantPretty
{
    [self.navigationController.navigationBar setHidden:NO];
    BecomeBeautifulViewController *becomeVC = [BecomeBeautifulViewController viewController];
    [self.navigationController pushViewController:becomeVC animated:YES];
}

// 失败手术修复
- (void)didSelectSurgeryRepair
{
    [self.navigationController.navigationBar setHidden:NO];
    FailRepairViewController* ctrl=[FailRepairViewController viewController];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

// 直通韩国
- (void)didSelectGoToKorea
{
    [self.navigationController.navigationBar setHidden:NO];
    ToKoreaViewController* ctrl=[ToKoreaViewController viewController];
    [self.navigationController pushViewController:ctrl animated:YES];
}

// 专家咨询
- (void)didSelectExpertAdvisory
{
    
}

// 会诊中心
- (void)didSelectConsultationCenter
{
    [self.navigationController.navigationBar setHidden:NO];
    ConsultationCollectionViewController *consulationVC=[ConsultationCollectionViewController viewController];
    [self.navigationController pushViewController:consulationVC animated:YES];
}

// 委托保障
- (void)didSelectConsignProtection
{
    [self.navigationController.navigationBar setHidden:NO];
    GuaranteeOrderViewController *guaranteeTVC = [GuaranteeOrderViewController viewController];
    [self.navigationController pushViewController:guaranteeTVC animated:YES];
}

// 争议调解
- (void)didSelectDisputeMediation
{
    [self.navigationController.navigationBar setHidden:NO];
    DisputeResolveViewController *disputeVC=[DisputeResolveViewController viewController];
    [self.navigationController pushViewController:disputeVC animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [FunctionTableViewCell height];
    }
    else if (indexPath.section == 1)
    {
        return [FaceLiftingTableViewCell height];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        FunctionTableViewCell *funCell = [tableView dequeueReusableCellWithIdentifier:[FunctionTableViewCell className] forIndexPath:indexPath];
        funCell.delegate = self;
        [funCell solveCrashWithIOS7];
        [funCell removeSeperatorBlank];
        return funCell;
    }
    else if (indexPath.section == 1)
    {
        FaceLiftingTableViewCell *faceCell = [tableView dequeueReusableCellWithIdentifier:[FaceLiftingTableViewCell className] forIndexPath:indexPath];
        [faceCell solveCrashWithIOS7];
        [faceCell removeSeperatorBlank];
        return faceCell;
    }
    return nil;
}

@end
