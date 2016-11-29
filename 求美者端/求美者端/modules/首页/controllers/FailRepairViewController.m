//
//  FailRepairViewController.m
//  求美者端
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "FailRepairViewController.h"
#import "FindDisplayInfo.h"
#import "CommonServerInteraction.h"
#import "ApplyFailRepairViewController.h"
@interface FailRepairViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImage;                                 // 图片
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;                                    // 主标题
@property (weak, nonatomic) IBOutlet UILabel *subTitle;                                     // 副标题
@property (weak, nonatomic) IBOutlet UILabel *Introduction;                                 // 介绍
@property (copy, nonatomic) NSString * labelStr;                                            // 获取的主标题
@property (strong, nonatomic) IBOutlet UIButton *btnsubmit;
@property (strong, nonatomic) IBOutlet UIView *scrollImage;
@property (strong, nonatomic) IBOutlet UIView *caseView;


@end

@implementation FailRepairViewController
+(instancetype)viewController
{
    FailRepairViewController* ctrl=[[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
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
    //获得nib视图数组
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FaceLiftingTableViewCell" owner:self options:nil];
    //得到第一个UIView
    UIView *tmpCustomView = [nib objectAtIndex:0];
    //获得屏幕的Frame
    CGRect tmpFrame = [[UIScreen mainScreen] bounds];
    //设置自定义视图的中点为屏幕的中点
    //[tmpCustomView  setCenter:CGPointMake(tmpFrame.size.width / 2, tmpFrame.size.height / 2)];
    [tmpCustomView  setWidth:tmpFrame.size.width];

    //添加视图
    [self.scrollImage addSubview:tmpCustomView];
    
    //添加案例展示试图
    NSArray *caseNib=[[NSBundle mainBundle] loadNibNamed:@"CaseTableViewCell" owner:self options:nil];
    UIView *tmpCaseView=[caseNib objectAtIndex:0];
    [tmpCaseView setWidth:tmpFrame.size.width];
    [self.caseView addSubview:tmpCaseView];
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
                //weakSelf.viewTopHeight.constant=440+labelSize.height;
            }
            if (!([dataOrList.url isEqualToString:@""] || dataOrList.url == nil))
            {
                NSURL* url = [NSURL URLWithString:dataOrList.url];
                [self.topImage sd_setImageWithURL:url];
            }
        }
    };
    
    [[CommonServerInteraction sharedInstance] findDisplayInfoWithType:@"7"
                                                        responseBlock:block];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ApplyRepareTouch:(id)sender {
    ApplyFailRepairViewController * ctrl=[ApplyFailRepairViewController viewController];
    [self.navigationController pushViewController:ctrl animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
