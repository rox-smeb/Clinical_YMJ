//
//  CommonSelectTableViewCell.h
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/7/4.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SecondLevelListViewType)
{
    SECOND_LEVEL_SELECT_CELL_MAIN = 0,             // 一级cell
    SECOND_LEVEL_SELECT_CELL_SUB  = 1              // 二级cell
};

@interface CommonSelectTableViewCell : UITableViewCell

@property (assign, nonatomic) SecondLevelListViewType cellType;

+ (CGFloat)height;
- (void)setupWithName:(NSString*)name;

@end
