//
//  MyCaseTableViewCell.h
//  求美者端
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMedicalRecordListInfo.h"
@interface MyCaseTableViewCell : UITableViewCell
+ (CGFloat)height;
-(void)setupWithInfo:(MyMedicalRecordListInfo *)info;

@end
