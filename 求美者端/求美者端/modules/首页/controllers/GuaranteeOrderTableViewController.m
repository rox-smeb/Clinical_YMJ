//
//  GuaranteeOrderTableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "GuaranteeOrderTableViewController.h"
#import "InputAccessoryView.h"
#import "SegmentedControlConfiger.h"
#import "MirrorServerInteraction.h"
#import "CommonServerInteraction.h"
#import "NotificationsDefine.h"
#import "UserInfo.h"
#import "FindDisplayInfo.h"
#import "GuaranteeOrderViewController.h"

@interface GuaranteeOrderTableViewController () <UITextFieldDelegate,
                                                 GuaranteeOrderViewControllerDelegate>
@property (weak, nonatomic) GuaranteeOrderViewController *parentVC;

@property (weak, nonatomic) IBOutlet UIImageView *topImage;                                 // 图片
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;                                    // 主标题
@property (weak, nonatomic) IBOutlet UILabel *subTitle;                                     // 副标题
@property (weak, nonatomic) IBOutlet UILabel *Introduction;                                 // 介绍

@property (weak, nonatomic) IBOutlet UISegmentedControl *nationsSegmentedControl;           // 国家名
@property (weak, nonatomic) IBOutlet UITextField *projectTextField;                         // 手术项目
@property (weak, nonatomic) IBOutlet UITextField *doctorTextField;                          // 医生
@property (weak, nonatomic) IBOutlet UITextField *doctorPhoneTextField;                     // 医生电话
@property (weak, nonatomic) IBOutlet UITextField *agencyTextField;                          // 医疗机构
@property (weak, nonatomic) IBOutlet UITextField *agencyPersonTextField;                    // 医疗机构联系人
@property (weak, nonatomic) IBOutlet UITextField *agencyPhoneTextField;                     // 医疗机构联系电话
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;                           // 手术金额
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;                        // 患者姓名

@property (copy, nonatomic) NSString * labelStr;                                            // 获取的主标题
@end

@implementation GuaranteeOrderTableViewController

//+ (instancetype)viewController
//{
//    GuaranteeOrderTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
//    return ctrl;
//}

- (void)setParent:(GuaranteeOrderViewController*)parent
{
    _parentVC = parent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _parentVC.delegate = self;
//    UINib* footerNib = [UINib nibWithNibName:[GuaranteeFooterView className] bundle:nil];
//    [self.tableView registerNib:footerNib forHeaderFooterViewReuseIdentifier:[GuaranteeFooterView className]];
    

    [self loadData];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 加载数据
- (void)loadData
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, FindDisplayInfo*)
    {
        if ([response success])
        {
            if (!([dataOrList.title isEqualToString:@""] || dataOrList.title == nil))
            {
                _mainTitle.text = dataOrList.title;
            }
            if (!([dataOrList.subTitle isEqualToString:@""] || dataOrList.subTitle == nil))
            {
                _subTitle.text = dataOrList.subTitle;
            }
            if (!([dataOrList.details isEqualToString:@""] || dataOrList.details == nil))
            {
                _labelStr = dataOrList.details;
                CGSize labelSize = {0, 0};
                
                labelSize = [_labelStr sizeWithFont:[UIFont systemFontOfSize:14]
                             
                                  constrainedToSize:CGSizeMake(self.Introduction.frame.size.width, 5000)
                             
                                      lineBreakMode:UILineBreakModeWordWrap];
                weakSelf.Introduction.text = _labelStr;
                weakSelf.Introduction.numberOfLines = 0;
                weakSelf.Introduction.lineBreakMode = UILineBreakModeCharacterWrap;
                weakSelf.Introduction.frame = CGRectMake(self.Introduction.frame.origin.x, self.Introduction.frame.origin.y, self.Introduction.frame.size.width, labelSize.height);
            }
            if (!([dataOrList.url isEqualToString:@""] || dataOrList.url == nil))
            {
                NSURL* url = [NSURL URLWithString:dataOrList.url];
                [self.topImage sd_setImageWithURL:url];
            }
        }
    };
    
    [[CommonServerInteraction sharedInstance] findDisplayInfoWithType:@"5"
                                                        responseBlock:block];
}

- (void)setup
{
    [self.tableView solveCrashWithIOS7];
    [self.tableView removeSeperatorBlank];
    
    [InputAccessoryView createWithInputView:self.priceTextField];
    [SegmentedControlConfiger configSegmentedControl:self.nationsSegmentedControl];
}

- (void)close
{
    [self hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
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
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    UIView* textField = [cell viewWithTag:1000];
    if ([textField respondsToSelector:@selector(becomeFirstResponder)])
    {
        [textField becomeFirstResponder];
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell solveCrashWithIOS7];
    return cell;
}

#pragma mark - SubmitDelegate

-(void)userFooterView:(GuaranteeOrderViewController *)vc
{
    LOGIN_CHECK;
    
    NSString* nationsName  = self.nationsSegmentedControl.selectedSegmentIndex == 0 ? @"中国" : @"韩国";
    NSString* project      = self.projectTextField.text;
    NSString* doctor       = self.doctorTextField.text;
    NSString* doctorPhone  = self.doctorPhoneTextField.text;
    NSString* agency       = self.agencyTextField.text;
    NSString* agencyPerson = self.agencyPersonTextField.text;
    NSString* agencyPhone  = self.agencyPhoneTextField.text;
    NSString* price        = self.priceTextField.text;
    NSString* userName     = self.userNameTextField.text;
    
    ShowHudAndReturnIfInputNotAvailable(userName, @"请输入患者姓名");
    ShowHudAndReturnIfInputNotAvailable(project, @"请输入手术项目");
    ShowHudAndReturnIfInputNotAvailable(doctor, @"请输入医生姓名");
    ShowHudAndReturnIfInputNotAvailable(doctorPhone, @"请输入医生电话");
    ShowHudAndReturnIfInputNotAvailable(agency, @"请输入医疗机构");
    ShowHudAndReturnIfInputNotAvailable(agencyPerson, @"请输入医疗机构联系人");
    ShowHudAndReturnIfInputNotAvailable(agencyPhone, @"请输入医疗机构联系电话");
    ShowHudAndReturnIfInputNotAvailable(price, @"请输入手术金额");
    
    UserInfo* info = [UserInfo currentUser];
    
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSObject*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view.superview animated:YES];
        //[sender setEnabled:YES];
        [response showHUD];
        
        if ([response success])
        {
            // 发送委托保单提交成功消息
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GUARANTEE_ORDER_SUBMIT_SUCCESS object:nil];
            
            [weakSelf close];
        }
    };
    
    [self hideKeyboard];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
    hud.labelText = STRING_PROCESSING;
   // [sender setEnabled:NO];
    
    [[MirrorServerInteraction sharedInstance] authorizedGuaranteeOrderWithNationsName:nationsName
                                                                                  uid:info.uid
                                                                                 ukey:info.ukey
                                                                              project:project
                                                                               doctor:doctor
                                                                          doctorPhone:doctorPhone
                                                                               agency:agency
                                                                         agencyPerson:agencyPerson
                                                                          agencyPhone:agencyPhone
                                                                                price:price
                                                                             userName:userName
                                                                        responseBlock:block];

}

@end


