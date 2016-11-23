//
//  SecondLevelListViewController.m
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/7/4.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "SecondLevelListViewController.h"
#import "CommonSelectTableViewCell.h"
#import "CommonSelectTableSectionHeader.h"

@interface SecondLevelListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id<SecondLevelListViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray* sectionIndexTitles;
@property (strong, nonatomic) NSArray* dataSource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topAllSelectBarHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *subTableViewContainer;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

@end

@implementation SecondLevelListViewController

+ (UINavigationController*)navViewControllerWithTitle:(NSString*)title
                                           dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                                             delegate:(id<SecondLevelListViewControllerDelegate>)delegate
{
    return [[self class] navViewControllerWithTitle:title dataSource:dataSource delegate:delegate showTopAllSelect:YES tag:0];
}

+ (UINavigationController*)navViewControllerWithTitle:(NSString*)title
                                           dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                                             delegate:(id<SecondLevelListViewControllerDelegate>)delegate
                                                  tag:(NSInteger)tag
{
    return [[self class] navViewControllerWithTitle:title dataSource:dataSource delegate:delegate showTopAllSelect:YES tag:tag];
}

+ (UINavigationController*)navViewControllerWithTitle:(NSString*)title
                                           dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                                             delegate:(id<SecondLevelListViewControllerDelegate>)delegate
                                     showTopAllSelect:(BOOL)showTopAllSelectBar
                                                  tag:(NSInteger)tag
{
    SecondLevelListViewController* ctrl = [[self class] viewControllerWithTitle:title
                                                                     dataSource:dataSource
                                                                       delegate:delegate
                                                               showTopAllSelect:showTopAllSelectBar
                                                                            tag:tag];
    
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:ctrl];
    return navi;
}

+ (instancetype)viewControllerWithTitle:(NSString*)title
                             dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                               delegate:(id<SecondLevelListViewControllerDelegate>)delegate
{
    return [[self class] viewControllerWithTitle:title dataSource:dataSource delegate:delegate showTopAllSelect:YES tag:0];
}

+ (instancetype)viewControllerWithTitle:(NSString*)title
                             dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                               delegate:(id<SecondLevelListViewControllerDelegate>)delegate
                                    tag:(NSInteger)tag
{
    return [[self class] viewControllerWithTitle:title dataSource:dataSource delegate:delegate showTopAllSelect:YES tag:tag];
}

+ (instancetype)viewControllerWithTitle:(NSString*)title
                             dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                               delegate:(id<SecondLevelListViewControllerDelegate>)delegate
                       showTopAllSelect:(BOOL)showTopAllSelectBar
                                    tag:(NSInteger)tag
{
    SecondLevelListViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Home"];
    ctrl.title = title;
    ctrl.dataSource = dataSource;
    ctrl.delegate = delegate;
    ctrl.showTopAllSelectBar = showTopAllSelectBar;
    ctrl.tag = tag;
    return ctrl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self mergeData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setup
{
    if (self.showTopAllSelectBar == NO)
    {
        self.topAllSelectBarHeight.constant = 0.0f;
    }
    
    [self.subTableViewContainer setHidden:YES];
    [self.view bringSubviewToFront:self.subTableViewContainer];
    
    self.tableView.sectionIndexColor = RGB(140, 140, 140);
    [self.tableView removeSeperatorBlank];
    [self.tableView removeRedundanceSeperator];
    
    [self.subTableView removeSeperatorBlank];
    [self.subTableView removeRedundanceSeperator];
    
    // cell
    UINib* nib = [UINib nibWithNibName:[CommonSelectTableViewCell className] bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:[CommonSelectTableViewCell className]];
    [self.subTableView registerNib:nib forCellReuseIdentifier:[CommonSelectTableViewCell className]];
    
    // section header
    nib = [UINib nibWithNibName:[CommonSelectTableSectionHeader className] bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:[CommonSelectTableSectionHeader className]];
}

- (void)mergeData
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    for (id<SelectModelProtocol> info in self.dataSource)
    {
        if ([info respondsToSelector:@selector(name)])
        {
            NSString* name = [info name];
            NSString* pinyin = [name toPinYin];
            if (pinyin.length > 0)
            {
                pinyin = [pinyin uppercaseString];
                NSString* letter = [pinyin substringToIndex:1];
                if (letter != nil)
                {
                    NSMutableArray* array = [dict objectForKey:letter];
                    if (array == nil)
                    {
                        array = [NSMutableArray array];
                        [dict setObject:array forKey:letter];
                    }
                    [array addObject:info];
                }
            }
        }
    }
    
    NSArray* allKeys = [dict allKeys];
    
    // 内部排序
    for (NSString* key in allKeys)
    {
        NSArray* value = [dict objectForKey:key];
        NSArray* newValue = [value sortedArrayUsingComparator:^NSComparisonResult(id<SelectModelProtocol> obj1, id<SelectModelProtocol> obj2) {
            
            return [[obj1 name] compare:[obj2 name]];
        }];
        
        if (newValue != nil)
        {
            [dict setObject:newValue forKey:key];
        }
    }
    
    // 整体排序
    NSArray* sortedKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    self.sectionIndexTitles = sortedKeys;
    
    // 整理数据
    NSMutableArray* result = [NSMutableArray array];
    for (NSString* key in sortedKeys)
    {
        NSArray* value = [dict objectForKey:key];
        if (value != nil)
        {
            [result addObject:value];
        }
    }
    
    self.dataSource = result;
}

- (IBAction)onSubTableViewClose:(id)sender
{
    [self.subTableViewContainer setHidden:YES];
    
    NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath != nil)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

// 全部点击
- (IBAction)onAllTouch:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(secondLevelListViewController:didSelectWithInfo:subInfo:)])
    {
        [self.delegate secondLevelListViewController:self didSelectWithInfo:nil subInfo:nil];
    }
    
    // 关闭页面
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)onNavClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return [CommonSelectTableSectionHeader height];
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CommonSelectTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        [self.subTableViewContainer setHidden:NO];
        [self.subTableView reloadData];
    }
    else if (tableView == self.subTableView)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        if ([self.delegate respondsToSelector:@selector(secondLevelListViewController:didSelectWithInfo:subInfo:)])
        {
            NSIndexPath* selectedIndexPath = self.tableView.indexPathForSelectedRow;
            if (selectedIndexPath != nil)
            {
                if (selectedIndexPath.section < [self.dataSource count])
                {
                    NSArray* array = [self.dataSource objectAtIndex:selectedIndexPath.section];
                    if ([array isKindOfClass:[NSArray class]] && selectedIndexPath.row < [array count])
                    {
                        id<SelectModelProtocol> info = [array objectAtIndex:selectedIndexPath.row];
                        if ([info respondsToSelector:@selector(subList)])
                        {
                            NSArray* subList = [info subList];
                            if ([subList isKindOfClass:[NSArray class]] && indexPath.row < [subList count])
                            {
                                id<SelectModelProtocol> subInfo = [subList objectAtIndex:indexPath.row];
                                [self.delegate secondLevelListViewController:self didSelectWithInfo:info subInfo:subInfo];
                                
                                // 关闭页面
                                [self dismissViewControllerAnimated:YES completion:^{
                                    
                                }];
                            }
                        }
                    }
                }
            }
        }
    }
}

- (NSArray<NSString*>*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return self.sectionIndexTitles;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CommonSelectTableSectionHeader* header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[CommonSelectTableSectionHeader className]];
    if (section < [self.dataSource count])
    {
        NSArray* array = [self.dataSource objectAtIndex:section];
        id<SelectModelProtocol> info = [array firstObject];
        if ([info respondsToSelector:@selector(name)])
        {
            NSString* name = [info name];
            NSString* pinyin = [[name toPinYin] uppercaseString];
            if (pinyin.length > 0)
            {
                NSString* title = [pinyin substringToIndex:1];
                [header setupWithName:title];
            }
        }
    }
    return header;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return [self.dataSource count];
    }
    else if (tableView == self.subTableView)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        if (section < [self.dataSource count])
        {
            NSArray* array = [self.dataSource objectAtIndex:section];
            if ([array isKindOfClass:[NSArray class]])
            {
                return [array count];
            }
        }
    }
    else if (tableView == self.subTableView)
    {
        NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
        if (indexPath != nil)
        {
            if (indexPath.section < [self.dataSource count])
            {
                NSArray* array = [self.dataSource objectAtIndex:indexPath.section];
                if ([array isKindOfClass:[NSArray class]] && indexPath.row < [array count])
                {
                    id<SelectModelProtocol> info = [array objectAtIndex:indexPath.row];
                    if ([info respondsToSelector:@selector(subList)])
                    {
                        NSArray* subList = [info subList];
                        if ([subList isKindOfClass:[NSArray class]])
                        {
                            return [subList count];
                        }
                    }
                }
            }
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonSelectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[CommonSelectTableViewCell className] forIndexPath:indexPath];
    [cell removeSeperatorBlank];
    
    if (tableView == self.tableView)                    // 一级cell
    {
        cell.cellType = SECOND_LEVEL_SELECT_CELL_MAIN;
        
        if (indexPath.section < [self.dataSource count])
        {
            NSArray* array = [self.dataSource objectAtIndex:indexPath.section];
            if ([array isKindOfClass:[NSArray class]] && indexPath.row < [array count])
            {
                id<SelectModelProtocol> info = [array objectAtIndex:indexPath.row];
                if ([info respondsToSelector:@selector(name)])
                {
                    NSString* name = [info name];
                    [cell setupWithName:name];
                }
            }
        }
    }
    else if (tableView == self.subTableView)            // 二级cell
    {
        cell.cellType = SECOND_LEVEL_SELECT_CELL_SUB;
        
        NSIndexPath* selectedIndexPath = self.tableView.indexPathForSelectedRow;
        if (selectedIndexPath != nil)
        {
            if (selectedIndexPath.section < [self.dataSource count])
            {
                NSArray* array = [self.dataSource objectAtIndex:selectedIndexPath.section];
                if ([array isKindOfClass:[NSArray class]] && selectedIndexPath.row < [array count])
                {
                    id<SelectModelProtocol> info = [array objectAtIndex:selectedIndexPath.row];
                    if ([info respondsToSelector:@selector(subList)])
                    {
                        NSArray* subList = [info subList];
                        if ([subList isKindOfClass:[NSArray class]] && indexPath.row < [subList count])
                        {
                            id<SelectModelProtocol> subInfo = [subList objectAtIndex:indexPath.row];
                            if ([subInfo respondsToSelector:@selector(name)])
                            {
                                NSString* name = [subInfo name];
                                [cell setupWithName:name];
                            }
                        }
                    }
                }
            }
        }
    }
    return cell;
}

@end
