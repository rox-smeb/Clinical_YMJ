//
//  AYBGroupPickerView.m
//  果动校园
//
//  Created by AnYanbo on 15/2/10.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "AYBGroupPickerView.h"
#import "AYBGroupTableViewCell.h"

#define BounceAnimationPixel                    (5)
#define NavigationHeight                        (64)

@implementation AYBGroupPickerView

- (id)initWithGroups:(NSMutableArray *)groups
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.hidden = YES;
        self.groups = groups;
        self.isOpen = NO;
        [self setupLayout];
        [self setupTableView];
        [self addObserver:self forKeyPath:@"groups" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"groups"];
}

- (void)setupLayout
{
    // 默认不现实在屏幕上方
    self.frame              = CGRectMake(0,
                                         -[UIScreen mainScreen].bounds.size.height,
                                         [UIScreen mainScreen].bounds.size.width,
                                         [UIScreen mainScreen].bounds.size.height);
    self.layer.cornerRadius = 4;
    self.clipsToBounds      = YES;
    self.backgroundColor    = [UIColor whiteColor];
}

- (void)setupTableView
{
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                    NavigationHeight,
                                                                                    [UIScreen mainScreen].bounds.size.width,
                                                                                    self.bounds.size.height - NavigationHeight)
                                                                   style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.tableView.contentInset     = UIEdgeInsetsMake(1, 0, 0, 0);
    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource       = self;
    self.tableView.delegate         = self;
    
    self.tableView.rowHeight        = 90.0f;
    self.tableView.backgroundColor  = [UIColor whiteColor];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"AYBGroupTableViewCell" bundle:nil] forCellReuseIdentifier:@"AYBGroupTableViewCell"];
    
    [self addSubview:self.tableView];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)show
{
    [self show:YES];
}

- (void)show:(BOOL)animated
{
    if (animated == YES)
    {
        self.hidden = NO;
        [UIView animateWithDuration:0.25f
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.frame = CGRectMake(0, BounceAnimationPixel , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.15f
                                                   delay:0.f
                                                 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                                              animations:^{
                                                  self.frame = CGRectMake(0, 0 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                                              }
                                              completion:^(BOOL finished){
                                                  
                                              }];
                         }];
    }
    else
    {
        self.hidden = NO;
        self.frame = CGRectMake(0, 0 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    self.isOpen = YES;
}

- (void)dismiss:(BOOL)animated
{
    if (animated == YES)
    {
        self.hidden = YES;
        self.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height );
    }
    else
    {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                         }
                         completion:^(BOOL finished) {
                             self.hidden = YES;
                         }];
    }
    self.isOpen = NO;
}

- (void)toggle
{
    if (self.isOpen == NO)
    {
        [self show];
    }
    else
    {
        [self dismiss:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"AYBGroupTableViewCell";
    AYBGroupTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.item < [self.groups count])
    {
        [cell applyData:[self.groups objectAtIndex:indexPath.item]];
    }
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.blockTouchCell)
    {
        self.blockTouchCell(indexPath.row);
    }
}

@end
