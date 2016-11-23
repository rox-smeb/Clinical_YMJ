//
//  GuaranteeOrderViewController.m
//  求美者端
//
//  Created by apple on 2016/11/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "GuaranteeOrderViewController.h"
#import "GuaranteeOrderTableViewController.h"

@interface GuaranteeOrderViewController ()

@property (strong, nonatomic) IBOutlet UIButton *btnsubmit;
@property (weak, nonatomic) GuaranteeOrderTableViewController *subViewController;

@end

@implementation GuaranteeOrderViewController

+ (instancetype)viewController
{
    GuaranteeOrderViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onSubmitTouch:(id)sender {
    if ([self.delegate respondsToSelector:@selector(userFooterView:)]) {
        [self.delegate userFooterView:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[GuaranteeOrderTableViewController class]])
    {
        self.subViewController = (GuaranteeOrderTableViewController*)segue.destinationViewController;
        [self.subViewController setParent:self];
    }
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
