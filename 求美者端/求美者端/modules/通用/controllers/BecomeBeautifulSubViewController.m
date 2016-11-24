//
//  BecomeBeautifulSubViewController.m
//  求美者端
//
//  Created by Smeb on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "BecomeBeautifulSubViewController.h"
#import "HospitalTableViewCell.h"

@interface BecomeBeautifulSubViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *beautifulTableView;

@end

@implementation BecomeBeautifulSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    [self.beautifulTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.beautifulTableView removeRedundanceSeperator];         // 删除 多余的线
    
    [self.beautifulTableView registerNibName:[HospitalTableViewCell className] cellID:[HospitalTableViewCell className]];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
    HospitalTableViewCell *hospCell = [tableView dequeueReusableCellWithIdentifier:[HospitalTableViewCell className] forIndexPath:indexPath];
    [hospCell solveCrashWithIOS7];
    [hospCell removeSeperatorBlank];
    return hospCell;
}



@end
