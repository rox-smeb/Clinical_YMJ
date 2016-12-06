//
//  DoctorDetailsHeaderView.h
//  求美者端
//
//  Created by Smeb on 2016/12/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetDoctorDetailsInfo.h"

@class DoctorDetailsHeaderView;

@protocol DoctorDetailsHeaderViewDelegate <NSObject>

- (void)detailsHeaderView:(DoctorDetailsHeaderView *)header didClickLookAllWithInfo:(GetDoctorDetailsInfo*)info withType:(BOOL)type;

@end

@interface DoctorDetailsHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<DoctorDetailsHeaderViewDelegate> delegate;

+ (CGFloat)height;
+ (instancetype)create;

- (void)setupWithGetDoctorDetailsInfo:(GetDoctorDetailsInfo *)info;

@end
