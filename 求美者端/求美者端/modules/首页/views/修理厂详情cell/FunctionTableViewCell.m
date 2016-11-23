//
//  FunctionTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/11/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "FunctionTableViewCell.h"

@implementation FunctionTableViewCell

+ (CGFloat)height
{
    return 290.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}

#pragma mark -- 功能响应事件
// 我要求美
- (IBAction)wantPretty:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectWantPretty)]) {
        [self.delegate didSelectWantPretty];
    }
}

// 失败手术修复
- (IBAction)surgeryRepair:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectSurgeryRepair)]) {
        [self.delegate didSelectSurgeryRepair];
    }
}

// 直通韩国
- (IBAction)goToKorea:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectGoToKorea)]) {
        [self.delegate didSelectGoToKorea];
    }
}

// 专家咨询
- (IBAction)expertAdvisory:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectExpertAdvisory)]) {
        [self.delegate didSelectExpertAdvisory];
    }
}

// 会诊中心
- (IBAction)consultationCenter:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectConsultationCenter)]) {
        [self.delegate didSelectConsultationCenter];
    }
}

// 委托保障
- (IBAction)consignProtection:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectConsignProtection)]) {
        [self.delegate didSelectConsignProtection];
    }
}

// 争议调解
- (IBAction)disputeMediation:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectDisputeMediation)]) {
        [self.delegate didSelectDisputeMediation];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
