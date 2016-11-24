//
//  VerifyFrameWorkTableViewController.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/6.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "VerifyFrameWorkTableViewController.h"
#import "CommonServerInteraction.h"
#import "SecondLevelListViewController.h"

@interface VerifyFrameWorkTableViewController ()<SecondLevelListViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *proTextField;
@property (weak, nonatomic) IBOutlet UITextField *fWorkTextField;
@property (weak, nonatomic) IBOutlet UIButton *putOnBtn;


@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) CommonInfo *pInfo;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *proId;

@end

@implementation VerifyFrameWorkTableViewController

+ (instancetype)viewController
{
    VerifyFrameWorkTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    [self.putOnBtn.layer setCornerRadius:5.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 选择省份
- (IBAction)provinceClickedBtn:(UIButton *)sender {
    [self province];
}

// 提交
- (IBAction)putOnBtnClicked:(UIButton *)sender {
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
                CommonInfo* info = [[CommonInfo alloc] initWithJSON:dict];
                if (info != nil)
                {
                    NSArray *arr = info.province;
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
