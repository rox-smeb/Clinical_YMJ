//
//  DoctorServerInteraction.h
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>

@interface DoctorServerInteraction : YBServerInteraction

+ (DoctorServerInteraction*)sharedInstance;

#pragma mark - 验医生

/**
 *  用户注册
 *
 *  @param provinceId           省份
 *  @param name                 医生姓名
 *  @param password             所在医疗机构
 */
- (void)verifyDoctorWithProvinceId:(NSString*)provinceId
                              name:(NSString*)name
                           address:(NSString*)address
                     responseBlock:(YBResponseBlock)responseBlock;

@end
