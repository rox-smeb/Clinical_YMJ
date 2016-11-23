//
//  RegisterSubTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/11.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "RegisterSubTableViewController.h"
#import "InputAccessoryView.h"
#import "YMJCommonServerInteraction.h"
#import "LoginServerInteraction.h"
#import "NotificationsDefine.h"
#import "UserInfo.h"

@interface RegisterSubTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;              // 手机号码
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;                // 验证码
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;                   // 获取验证码按钮
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;            // 用户姓名
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;            // 登陆密码
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;             // 确认登陆密码
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTextField;          // 邀请码
@property (weak, nonatomic) IBOutlet UIButton *registerButton;                  // 注册按钮

@end

@implementation RegisterSubTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    [self.tableView removeSeperatorBlank];
    [self.tableView solveCrashWithIOS7];
    
    self.registerButton.layer.cornerRadius = 4.0f;
    
    [InputAccessoryView createWithInputView:self.mobileTextField];
    [InputAccessoryView createWithInputView:self.codeTextField];
}

- (void)close
{
    [self hideKeyboard];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// 获取验证码
- (IBAction)onGetCodeTouch:(UIButton *)sender
{
    NSString* mobile = self.mobileTextField.text;
    
    ShowHudAndReturnIfInputNotAvailable(mobile, @"请输入手机号码");
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSObject*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [sender setEnabled:YES];
        [response showHUD];
    };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = STRING_PROCESSING;
    [sender setEnabled:NO];
    
    [[YMJCommonServerInteraction sharedInstance] getVerificationCodeToMobile:mobile
                                                                       state:VERIFICATION_CODE_STATE_REGISTER
                                                               responseBlock:block];
}

// 注册
- (IBAction)onRegisterTouch:(UIButton *)sender
{
    NSString* mobile = self.mobileTextField.text;
    NSString* code = self.codeTextField.text;
    NSString* password = self.passwordTextField.text;
    NSString* confirm = self.confirmTextField.text;
    NSString* name = self.userNameTextField.text;
    NSString* inviteCode = self.inviteCodeTextField.text;
    
    ShowHudAndReturnIfInputNotAvailable(mobile, @"请输入手机号码");
    ShowHudAndReturnIfInputNotAvailable(code, @"请输入验证码");
    ShowHudAndReturnIfInputNotAvailable(password, @"请输入登陆密码");
    ShowHudAndReturnIfInputNotAvailable(confirm, @"请确认登陆密码");
    ShowHudAndReturnIfInputNotAvailable(name, @"请输入用户姓名");
    
    if ([confirm isEqualToString:password] == NO)
    {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
        return;
    }
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, UserInfo*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [sender setEnabled:YES];
        [response showHUD];
        
        if ([response success])
        {
            [dataOrList login];
            [weakSelf close];
            
            // 发送注册成功消息
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_REGISTER_SUCCESS object:nil];
        }
    };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = STRING_PROCESSING;
    [sender setEnabled:NO];
    
    [[LoginServerInteraction sharedInstance] registerWithMobile:mobile
                                                           code:code
                                                       password:password
                                                           name:name
                                                     inviteCode:inviteCode
                                                  responseBlock:block];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell solveCrashWithIOS7];
    return cell;
}

@end
