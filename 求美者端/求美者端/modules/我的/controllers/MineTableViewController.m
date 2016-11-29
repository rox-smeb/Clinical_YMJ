//
//  MineTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MineTableViewController.h"
#import "MineHeaderView.h"
#import "NotificationsDefine.h"
#import "UserInfo.h"
#import "ImagePickerManager.h"
#import "MyMedicalRecordListTableViewController.h"
#define CAMERA_IMAGE_MAX_SIZE      (400)

@interface MineTableViewController () <UIScrollViewDelegate,
                                       UIActionSheetDelegate,
                                       UIAlertViewDelegate,
                                       UINavigationControllerDelegate,
                                       MineHeaderViewDelegate,
                                       ImagePickerManagerDelegate>

@property (strong, nonatomic) MineHeaderView* tableHeader;
@property (strong, nonatomic) UIView* fakeNavBar;                                   // PUSH新页面需要添加一个假的导航栏(当前页面导航栏透明->跳转页面需要保持有导航栏)
@property (weak, nonatomic) IBOutlet UIButton* logoutBtn;

@end

@implementation MineTableViewController

+ (instancetype)viewController
{
    MineTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Mine"];
    return ctrl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavigationBarAlpha:0.0f];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    if (self.fakeNavBar.superview != nil)
    {
        [self.fakeNavBar removeFromSuperview];
    }
    
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    [self.tableView solveCrashWithIOS7];
    [self.tableView removeSeperatorBlank];
    
    self.logoutBtn.layer.cornerRadius = 4.0f;
    self.logoutBtn.layer.masksToBounds = YES;
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.delegate = self;
    [self setNavigationBarAlpha:0.0f];
    
    // 创建头像表头
    self.tableHeader = [MineHeaderView create];
    self.tableHeader.delegate = self;
    [self.tableHeader expandWithScrollView:self.tableView];
}

- (void)updateUI
{
    UserInfo* info = [UserInfo currentUser];
    if ([info isKindOfClass:[UserInfo class]])
    {
        NSString* nick = @"";
        if ([info.name isAvailability])
        {
            nick = info.name;
        }
        else
        {
            nick = [info.phone encryptMobileWithString:@"*"];
        }
        [self.tableHeader updateWithHeadURL:info.url name:nick];
    }
}

- (IBAction)onLogoutTouch:(UIButton *)sender
{
    LXAlertView* alert = [[LXAlertView alloc] initWithTitle:@"提示" message:@"确认注销当前登录账号?" cancelBtnTitle:@"取消" otherBtnTitle:@"确认" clickIndexBlock:^(NSInteger clickIndex) {
        
        if (clickIndex == 1)
        {
            // 用户登出
            [UserInfo logout];
            
            // 发送登出消息
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGOUT object:nil];
        }
    }];
    [alert showLXAlertView];
}

- (void)uploadImage:(UIImage*)image
{
    NSLog(@"1");
}

#pragma mark - ImagePickerManagerDelegate

- (void)imagePickerManager:(ImagePickerManager*)manager didPickerImages:(NSArray<UIImage*>*)images
{
    UIImage* image = [images firstObject];
    if ([image isKindOfClass:[UIImage class]])
    {
        [self uploadImage:image];
    }
}

#pragma mark - MineHeaderViewDelegate

- (void)header:(MineHeaderView*)header didClickHeadImageView:(UIView*)head
{
    ImagePickerManager* manager = [ImagePickerManager instanceWithDelegate:self];
    [manager pickerImageInViewController:self];
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
                self.fakeNavBar.backgroundColor = COMMON_COLOR;
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableHeader scrollViewDidScroll:scrollView];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell solveCrashWithIOS7];
    
    if ([cell.restorationIdentifier isEqualToString:@"联系平台"])
    {
        [cell removeSeperatorBlank];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell.restorationIdentifier isEqualToString:@"联系平台"])
    {
        [YBUtility callPhone:@"15636140539" superView:self.view];
    }
    else if([cell.restorationIdentifier isEqualToString:@"我的病历"])
    {
        MyMedicalRecordListTableViewController* ctrl=[MyMedicalRecordListTableViewController viewController];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

@end
