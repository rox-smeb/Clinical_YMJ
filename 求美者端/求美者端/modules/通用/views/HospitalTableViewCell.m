//
//  HospitalTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "HospitalTableViewCell.h"

@interface HospitalTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *type;             // 机构性质
@property (weak, nonatomic) IBOutlet UILabel *name;             // 机构名称
@property (weak, nonatomic) IBOutlet UIImageView *url;          // 机构图片

@property (strong, nonatomic) AgencyInfo* agencyInfo;
@property (strong, nonatomic) AgencyRecomendInfo* agencyRecomendInfo;

@end

@implementation HospitalTableViewCell

+ (CGFloat)height
{
    return 80.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setUpWithAgencyInfo:(AgencyInfo*)agencyInfo
{
    @try
    {
        self.agencyInfo = agencyInfo;
        
        self.name.text = agencyInfo.name;
        self.type.text = agencyInfo.type;
        
        NSURL* url = [NSURL URLWithString:agencyInfo.url];
        [self.url sd_setImageWithURL:url placeholderImage:DEFAULT_IMAGE];
    }
    @catch (NSException *exception)
    {
        
    }
}

- (void)setupWithInfo:(AgencyInfo*)agencyInfo orderInfo:(AgencyRecomendInfo*)agencyRecomendInfo
{
    @try
    {
        self.agencyInfo = agencyInfo;
        self.agencyRecomendInfo = agencyRecomendInfo;
        
        self.name.text = agencyInfo.name;
        self.type.text = agencyInfo.type;
        
        NSURL* url = [NSURL URLWithString:agencyInfo.url];
        [self.url sd_setImageWithURL:url placeholderImage:DEFAULT_IMAGE];
    }
    @catch (NSException *exception)
    {
        
    }
}

@end
