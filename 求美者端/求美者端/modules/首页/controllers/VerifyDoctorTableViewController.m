//
//  VerifyDoctorTableViewController.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "VerifyDoctorTableViewController.h"
#import "CommonServerInteraction.h"
#import "SecondLevelListViewController.h"
#import "DoctorServerInteraction.h"
#import "VerDoctorWebViewController.h"

@interface VerifyDoctorTableViewController ()<SecondLevelListViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *proTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *hospitalTextField;
@property (weak, nonatomic) IBOutlet UIButton *putBtn;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) CommonInfo *pInfo;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *proId;

@end

@implementation VerifyDoctorTableViewController

+ (instancetype)viewController
{
    VerifyDoctorTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    [self.putBtn.layer setCornerRadius:5.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 选择省份
- (IBAction)provinceClicked:(UIButton *)sender {
    [self province];
}

// 提交
- (IBAction)putClicked:(UIButton *)sender {
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSObject*)
    {
        if ([response success])
        {
            VerDoctorWebViewController *webTVC = [VerDoctorWebViewController viewController];
            webTVC.url = dataOrList;
            [self.navigationController pushViewController:webTVC animated:YES];
        }
        else
        {
            [response showHUD];
        }
    };
    [[DoctorServerInteraction sharedInstance] verifyDoctorWithProvinceId:self.proId
                                                                    name:self.nameTextField.text
                                                                 address:self.hospitalTextField.text
                                                           responseBlock:block];
}

#pragma mark - 获取省份
- (void)province{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, CommonInfo*)
    {
        //[weakSelf.homeTableView nlHeaderEndRefresh];
        NSMutableArray *list = [NSMutableArray array];
        if ([response success])
        {
            weakSelf.dataSource = response.i.list;
            for (NSDictionary* dict in weakSelf.dataSource)
            {
                NSObject* info = [[CommonInfo alloc] initWithJSON:dict];
                if (info != nil)
                {
                    [list addObject:info];
                }
            }
            NSLog(@"%@", list);
            UIViewController* ctrl = [SecondLevelListViewController navViewControllerWithTitle:@"选择省市"
                                                                                    dataSource:list
                                                                                      delegate:self
                                                                              showTopAllSelect:NO
                                                                                           tag:1];
            
            [self presentViewController:ctrl animated:YES completion:^{
                
            }];
        }
    };
    [[CommonServerInteraction sharedInstance] findProvinceResponseBlock:block];
}

#pragma mark - SecondLevelListViewControllerDelegate
- (void)secondLevelListViewController:(SecondLevelListViewController *)ctrl didSelectWithInfo:(id<SelectModelProtocol>)info subInfo:(id<SelectModelProtocol>)subInfo
{
    if ([info isKindOfClass:[CommonInfo class]])
    {
        _pInfo = (CommonInfo*)info;
    }
    if ([subInfo isKindOfClass:[ProvinceInfo class]]) {
        ProvinceInfo *modelInfo = (ProvinceInfo*)subInfo;
        self.proName = modelInfo.pName;
        self.proId = modelInfo.pid;
        [self.proTextField setText:self.proName];
    }
}


@end
