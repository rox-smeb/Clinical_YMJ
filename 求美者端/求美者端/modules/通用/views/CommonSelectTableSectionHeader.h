//
//  CommonSelectTableSectionHeader.h
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/7/4.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonSelectTableSectionHeader : UITableViewHeaderFooterView

+ (CGFloat)height;
- (void)setupWithName:(NSString*)name;

@end
