//
//  ToKoreaViewController.m
//  求美者端
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ToKoreaViewController.h"
#import "CommonServerInteraction.h"
#import "KoreaDoctorTableViewCell.h"
@interface ToKoreaViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *topImage;                                 // 图片
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;                                    // 主标题
@property (weak, nonatomic) IBOutlet UILabel *subTitle;                                     // 副标题
@property (weak, nonatomic) IBOutlet UILabel *Introduction;                                 // 介绍
@property (copy, nonatomic) NSString * labelStr;                                            // 获取的主标题
@property (strong, nonatomic) IBOutlet UITableView *doctorTableView;
@property (strong, nonatomic) NSMutableArray* dataSource;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (strong, nonatomic) IBOutlet UIButton *btnsubmit;
@property (strong, nonatomic) IBOutlet UIView *viewtop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewTopHeight;

@end

@implementation ToKoreaViewController
+(instancetype)viewController
{
    ToKoreaViewController* ctrl=[[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
    [self loadFindSpecial];
    // Do any additional setup after loading the view.
}
-(void)setup
{
    UIColor *colorOne = [UIColor colorWithRed:(53/255.0)  green:(136/255.0)  blue:(240/255.0)  alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(53/255.0)  green:(136/255.0)  blue:(240/255.0)  alpha:0.5];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    //gradient.startPoint = CGPointMake(0, 0);
    //gradient.endPoint = CGPointMake(1, 0);
    gradient.colors = colors;
    CGRect rect = [[UIScreen mainScreen] bounds];
    gradient.frame = CGRectMake(0, 0, rect.size.width, 50);
    // [self.submitButton.layerinsertSublayer:gradient atIndex:0];
    [self.btnsubmit.layer addSublayer:gradient];

    [self.doctorTableView removeSeperatorBlank];
    [self.doctorTableView removeRedundanceSeperator];

    self.dataSource = [NSMutableArray array];
    self.doctorTableView.dataSource=self;
    self.doctorTableView.delegate=self;
    [self.doctorTableView registerNib:[UINib nibWithNibName:[KoreaDoctorTableViewCell className] bundle:nil] forCellReuseIdentifier:[KoreaDoctorTableViewCell className]];
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
                weakSelf.viewTopHeight.constant=440+labelSize.height;
            }
            if (!([dataOrList.url isEqualToString:@""] || dataOrList.url == nil))
            {
                NSURL* url = [NSURL URLWithString:dataOrList.url];
                [self.topImage sd_setImageWithURL:url];
            }
        }
    };
    
    [[CommonServerInteraction sharedInstance] findDisplayInfoWithType:@"4"
                                                        responseBlock:block];
}
-(void)loadFindSpecial
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<FindSpecialInfo*>*)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if ([response success])
        {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.dataSource frontInsertArray:dataOrList];
            [weakSelf.doctorTableView reloadData];
            [weakSelf setScrollHeight];
        }
        else
        {
            [response showHUD];
        }
    };
    
    
    [[CommonServerInteraction sharedInstance] findSpecial:@"0" responseBlock:block];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setScrollHeight
{
    self.scrollViewHeight.constant=self.doctorTableView.contentSize.height+self.viewtop.bounds.size.height;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count])
    {
        FindDisplayInfo* info = [self.dataSource objectAtIndex:indexPath.row];
        return [KoreaDoctorTableViewCell heightWithInfo:info];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row < [self.dataSource count])
    {
//        SpecialDoctorInfo* info = [self.dataSource objectAtIndex:indexPath.row];
//        RequirmentDetailViewController* ctrl = [RequirmentDetailViewController viewControllerWithInfo:info];
//        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = [KoreaDoctorTableViewCell className];
    KoreaDoctorTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell removeSeperatorBlank];
    if (indexPath.row < [self.dataSource count])
    {
        FindDisplayInfo* info = [self.dataSource objectAtIndex:indexPath.row];
        [cell setupWithInfo:info];
    }
    return cell;
}

@end
