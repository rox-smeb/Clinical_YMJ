//
//  LoginTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/11.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "LoginTableViewController.h"
#import "InputAccessoryView.h"
#import "LoginServerInteraction.h"

@interface LoginTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginTableViewController

+ (instancetype)viewController
{
    LoginTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Login"];
    return ctrl;
}

+ (instancetype)jumpToViewController:(UIViewController*)viewController
{
    LoginTableViewController* ctrl = [[self class] viewController];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
    if ([viewController isKindOfClass:[UIViewController class]])
    {
        [viewController presentViewController:nav animated:YES completion:^{
            
        }];
    }
    return ctrl;
}

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
    
    self.loginButton.layer.cornerRadius = 4.0f;
    
    [InputAccessoryView createWithInputView:self.mobileTextField];
}

- (void)close
{
    [self hideKeyboard];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)onNavClose:(id)sender
{
    [self close];
}

- (IBAction)onLoginTouch:(UIButton *)sender
{
    NSString* mobile = self.mobileTextField.text;
    NSString* password = self.passwordTextField.text;
    
    ShowHudAndReturnIfInputNotAvailable(mobile, @"请输入登陆手机号");
    ShowHudAndReturnIfInputNotAvailable(password, @"请输入登陆密码");
    
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
        }
    };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = @"正在登陆...";
    [sender setEnabled:NO];
    
    [[LoginServerInteraction sharedInstance] loginWithMobile:mobile
                                                    password:password
                                               responseBlock:block];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self.mobileTextField becomeFirstResponder];
    }
    else if (indexPath.row == 1)
    {
        [self.passwordTextField becomeFirstResponder];
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell solveCrashWithIOS7];
    return cell;
}

@end
