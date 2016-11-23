//
//  SecondLevelListViewController.h
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/7/4.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectModelProtocol.h"

@class SecondLevelListViewController;

@protocol SecondLevelListViewControllerDelegate <NSObject>

- (void)secondLevelListViewController:(SecondLevelListViewController*)ctrl
                    didSelectWithInfo:(id<SelectModelProtocol>)info
                              subInfo:(id<SelectModelProtocol>)subInfo;

@end

/**
 *  二级列表选择
 */
@interface SecondLevelListViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) BOOL showTopAllSelectBar;

+ (UINavigationController*)navViewControllerWithTitle:(NSString*)title
                                           dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                                             delegate:(id<SecondLevelListViewControllerDelegate>)delegate;

+ (UINavigationController*)navViewControllerWithTitle:(NSString*)title
                                           dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                                             delegate:(id<SecondLevelListViewControllerDelegate>)delegate
                                                  tag:(NSInteger)tag;

+ (UINavigationController*)navViewControllerWithTitle:(NSString*)title
                                           dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                                             delegate:(id<SecondLevelListViewControllerDelegate>)delegate
                                     showTopAllSelect:(BOOL)showTopAllSelectBar
                                                  tag:(NSInteger)tag;

+ (instancetype)viewControllerWithTitle:(NSString*)title
                             dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                               delegate:(id<SecondLevelListViewControllerDelegate>)delegate;

+ (instancetype)viewControllerWithTitle:(NSString*)title
                             dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                               delegate:(id<SecondLevelListViewControllerDelegate>)delegate
                                    tag:(NSInteger)tag;

+ (instancetype)viewControllerWithTitle:(NSString*)title
                             dataSource:(NSArray<id<SelectModelProtocol>>*)dataSource
                               delegate:(id<SecondLevelListViewControllerDelegate>)delegate
                       showTopAllSelect:(BOOL)showTopAllSelectBar
                                    tag:(NSInteger)tag;

@end
