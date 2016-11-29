//
//  HospitalTableViewCell.h
//  求美者端
//
//  Created by Smeb on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgencyInfo.h"

@interface HospitalTableViewCell : UITableViewCell

+ (CGFloat)height;

- (void)setUpWithAgencyInfo:(AgencyInfo*)agencyInfo;
- (void)setupWithInfo:(AgencyInfo*)agencyInfo orderInfo:(AgencyRecomendInfo*)agencyRecomendInfo;

@end
