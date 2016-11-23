//
//  VerDoctorWebTableViewController.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "VerDoctorWebTableViewController.h"
#import "VerDoctorFooterView.h"
#import "VerDoctorWebTableViewCell.h"

@interface VerDoctorWebTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *webTableView;

@property (strong, nonatomic) VerDoctorFooterView *tableFooter;

@end

@implementation VerDoctorWebTableViewController

+ (instancetype)viewController
{
    VerDoctorWebTableViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup
{
    [self.webTableView solveCrashWithIOS7];                // 静态cell的tableview 在ios7上用约束 会闪退
    [self.webTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.webTableView removeRedundanceSeperator];         // 删除 多余的线
    
    self.tableFooter = [VerDoctorFooterView create];
    //self.tableHeader.delegate = self;
    self.webTableView.tableFooterView = self.tableFooter;
    self.webTableView.tableFooterView.height = [VerDoctorFooterView height];

    [self.webTableView registerNibName:[VerDoctorWebTableViewCell className] cellID:[VerDoctorWebTableViewCell className]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [VerDoctorWebTableViewCell height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VerDoctorWebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VerDoctorWebTableViewCell className] forIndexPath:indexPath];
    //cell.delegate = self;
    [cell solveCrashWithIOS7];
    [cell removeSeperatorBlank];
    
    return cell;
}



@end
