//
//  Quackwatch110TableViewController.m
//  求美者端
//
//  Created by AnYanbo on 16/8/12.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "Quackwatch110TableViewController.h"

@interface Quackwatch110TableViewController ()

@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIButton *button1;             // 服务举报

@property (weak, nonatomic) IBOutlet UIView *container2;
@property (weak, nonatomic) IBOutlet UIButton *button2;             // 打假举报

@end

@implementation Quackwatch110TableViewController

+ (instancetype)viewController
{
    Quackwatch110TableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
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
    [self.tableView solveCrashWithIOS7];
    [self.tableView removeSeperatorBlank];
    
    CGFloat radius = 3.0f;
    self.container1.layer.cornerRadius = radius;
    self.button1.layer.cornerRadius = radius;
    self.container2.layer.cornerRadius = radius;
    self.button2.layer.cornerRadius = radius;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell solveCrashWithIOS7];
    return cell;
}

@end
