//
//  ProjectTableViewCell.h
//  求美者端
//
//  Created by Smeb on 2016/12/7.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetDoctorDetailsInfo.h"

@interface ProjectTableViewCell : UITableViewCell

+ (CGFloat)height;

- (void)setupWithProjectInfo:(GetProjectListInfo*)getInfo;

@end
