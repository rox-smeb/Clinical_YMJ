//
//  ConsultationViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/11.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ConsultationViewController.h"

@interface ConsultationViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) UIView* preFakeNavBar;                                // PUSH新页面需要添加一个假的导航栏(当前页面导航栏透明->跳转页面需要保持有导航栏)
@property (strong, nonatomic) UIView* fakeNavBar;                                   // PUSH新页面需要添加一个假的导航栏(当前页面导航栏透明->跳转页面需要保持有导航栏)

@end

@implementation ConsultationViewController

+ (instancetype)viewController
{
    ConsultationViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
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
 
    // 保证Home页面的导航栏不会出现空白
    [self setupPreFakeBar];
    // 导航栏透明
    [self setNavigationBarAlpha:0.0f];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 移除导航栏FakeBar
    if (self.fakeNavBar.superview != nil)
    {
        [self.fakeNavBar removeFromSuperview];
    }
    
    // 禁用返回手势
    [self.navigationController setSlidePopEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setNavigationBarAlpha:1.0f];
    
    // 移除Home页面的导航栏FakeBar
    if (self.preFakeNavBar.superview != nil)
    {
        [self.preFakeNavBar removeFromSuperview];
    }
    
    // 开启返回手势
    [self.navigationController setSlidePopEnable:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupPreFakeBar
{
    UIViewController* home = [self.navigationController.childViewControllers firstObject];
    if (self.preFakeNavBar == nil)
    {
        CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat width = [self.navigationController.navigationBar width];
        CGFloat height = statusHeight + [self.navigationController.navigationBar height];
        self.preFakeNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, -height, width, height)];
        self.preFakeNavBar.backgroundColor = RGB(241, 249, 249);
    }
    if (self.preFakeNavBar.superview != nil)
    {
        [self.preFakeNavBar removeFromSuperview];
    }
    [home.view addSubview:self.preFakeNavBar];
}

- (void)setup
{
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.delegate = self;
    [self setNavigationBarAlpha:0.0f];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isAvailability])
    {
        [segue.destinationViewController setTitle:segue.identifier];
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != self)
    {
        if (navigationController.viewControllers.count == 3)
        {
            if (self.fakeNavBar == nil)
            {
                CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
                CGFloat width = [self.navigationController.navigationBar width];
                CGFloat height = statusHeight + [self.navigationController.navigationBar height];
                self.fakeNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, -height, width, height)];
                self.fakeNavBar.backgroundColor = RGB(241, 249, 249);
                self.fakeNavBar.tag = 10000;
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
        if (navigationController.viewControllers.count == 3)
        {
            [self.fakeNavBar setHidden:YES];
        }
    }
}

@end
