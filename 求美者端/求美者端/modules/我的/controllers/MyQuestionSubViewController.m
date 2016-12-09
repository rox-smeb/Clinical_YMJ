//
//  MyQuestionSubViewController.m
//  求美者端
//
//  Created by Smeb on 2016/12/8.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MyQuestionSubViewController.h"

@interface MyQuestionSubViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) MyQuestionViewController *parentVC;
@property (weak, nonatomic) IBOutlet UITableView *questionTableView;
@property (strong, nonatomic) NSMutableArray *queDataSource;

@end

@implementation MyQuestionSubViewController

- (void)setParent:(MyQuestionViewController*)parent
{
    _parentVC = parent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    self.queDataSource = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self.questionTableView removeSeperatorBlank];              // 删除 前面的 空白
    [self.questionTableView removeRedundanceSeperator];         // 删除 多余的线
    
    [CommonEmptyListView configTableView:self.questionTableView emptyText:@"暂无相关信息"];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}

@end
