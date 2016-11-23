//
//  CommonEmptyListView.h
//  昆明团购
//
//  Created by AnYanbo on 15/8/2.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonEmptyListView : UIView

+ (instancetype)configTableView:(UITableView*)tableView emptyText:(NSString*)text;

- (void)setEmptyText:(NSString*)text;
- (void)show;
- (void)hide;

@end
