//
//  UITableView+Utility.h
//  果动校园
//
//  Created by AnYanbo on 15/3/5.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableView (Utility)

- (void)addLongPressGestrueWithTarget:(id)target action:(SEL)action;
- (void)addLongPressGestrueWithTarget:(id)target action:(SEL)action dur:(CFTimeInterval)dur;

- (void)removeSeperatorBlank;
- (void)removeRedundanceSeperator;

- (void)registerNibName:(NSString*)nibName cellID:(NSString*)cellID;

- (void)scrollToTop;
- (void)scrollToBottom;
- (void)scrollToTopAnimated:(BOOL)animated;
- (void)scrollToBottomanimated:(BOOL)animated;

- (void)solveCrashWithIOS7;

- (void)reloadVisibleRowsAtIndex:(NSInteger)index section:(NSInteger)secion;
- (void)reloadVisibleRowsAtIndex:(NSInteger)index section:(NSInteger)secion withRowAnimation:(UITableViewRowAnimation)animate;

- (void)selectAllRow;
- (void)deselectAllRow;

- (void)selectAllRowInSection:(NSInteger)section;
- (void)deselectAllRowInSection:(NSInteger)section;

- (void)selectAllRowInSection:(NSInteger)section animate:(BOOL)animate;
- (void)deselectAllRowInSection:(NSInteger)section animate:(BOOL)animate;

- (BOOL)isAllRowsSelectedInSection:(NSInteger)section;
- (BOOL)isAllRowsSelected;

- (NSArray<NSIndexPath*>*)indexPathsForSelectedRowsInSection:(NSInteger)section;
- (NSArray<NSIndexPath*>*)indexPathForAllRowInSection:(NSInteger)section;
- (NSArray<NSIndexPath*>*)indexPathForAllRow;

@end

@interface UITableViewCell (Utility)

- (void)removeSeperatorBlank;
- (void)solveCrashWithIOS7;

@end