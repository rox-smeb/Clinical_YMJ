//
//  ForgetPasswordTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/12.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ForgetPasswordTableViewController.h"
#import "InputAccessoryView.h"

@interface ForgetPasswordTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@end

@implementation ForgetPasswordTableViewController

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
    
    self.submitButton.layer.cornerRadius = 4.0f;
    
    [InputAccessoryView createWithInputView:self.mobileTextField];
    [InputAccessoryView createWithInputView:self.codeTextField];
}

// 获取验证码
- (IBAction)onGetCodeTouch:(UIButton *)sender
{
}

// 注册
- (IBAction)onSubmitTouch:(UIButton *)sender
{
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
