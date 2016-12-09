//
//  GetPolicyListInfo.h
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetPolicyListInfo : NSObject

@property(nonatomic,strong)NSString* gId;                               // 保单编号
@property(nonatomic,strong)NSString* nationsName;                       // 国家
@property(nonatomic,strong)NSString* project;                           // 手术项目
@property(nonatomic,strong)NSString* doctor;                            // 医生名
@property(nonatomic,strong)NSString* doctorPhone;                       // 医生电话
@property(nonatomic,strong)NSString* agency;                            // 医疗机构
@property(nonatomic,strong)NSString* agencyPerson;                      // 医疗机构联系人
@property(nonatomic,strong)NSString* agencyPhone;                       // 医疗机构联系电话
@property(nonatomic,strong)NSString* price;                             // 手术金额
@property(nonatomic,strong)NSString* userName;                          // 患者姓名
@property(nonatomic,strong)NSString* date;                              // 下单日期
@property(nonatomic,strong)NSString* cause;                             // 审核原因
@property(nonatomic,strong)NSString* sort_id;                           // 排序

@end
