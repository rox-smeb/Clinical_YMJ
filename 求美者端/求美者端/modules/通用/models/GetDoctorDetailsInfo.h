//
//  GetDoctorDetailsInfo.h
//  求美者端
//
//  Created by Smeb on 2016/12/6.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCaseListListInfo : NSObject

@property (strong, nonatomic) NSString* cId;                        // 案例编号
@property (strong, nonatomic) NSString* cBeforePic;                 // 案例before图片
@property (strong, nonatomic) NSString* cAfterPic;                  // 案例after图片
@property (strong, nonatomic) NSString* cDetails;                   // 案例详情
@property (strong, nonatomic) NSString* cViewNumber;                // 案例查看数

@end


@interface GetProjectListInfo : NSObject

@property (strong, nonatomic) NSString* pId;                        // 项目编号
@property (strong, nonatomic) NSString* title;                      // 项目名称
@property (strong, nonatomic) NSString* subTitle;                   // 不知道
@property (strong, nonatomic) NSString* number;                     // 不知道
@property (strong, nonatomic) NSString* price;                      // 不知道
@property (strong, nonatomic) NSString* priceStyle;                 // 价格方式，0:定价 1：区间价格
@property (strong, nonatomic) NSString* minPrice;                   // 最低价格
@property (strong, nonatomic) NSString* maxPrice;                   // 最高价格

@end


@interface GetRecommendListInfo : NSObject

@property (strong, nonatomic) NSString* rName;

@end


@interface GetDoctorDetailsInfo : NSObject

@property (strong, nonatomic) NSString* dId;                        // 医生编号
@property (strong, nonatomic) NSString* url;                        // 医生头像路径
@property (strong, nonatomic) NSString* bigPath;                    // 大头像
@property (strong, nonatomic) NSString* name;                       // 医生名称
@property (strong, nonatomic) NSString* title;                      // 医生职称
@property (strong, nonatomic) NSString* agency;                     // 医生所属机构名称
@property (strong, nonatomic) NSString* star;                       // 评星
@property (strong, nonatomic) NSMutableArray<GetRecommendListInfo*>* recommendList;                                                  // 推荐平台列表
@property (strong, nonatomic) NSString* physicianLevel;             // 医师级别
@property (strong, nonatomic) NSString* occupationalClass;          // 职业类型
@property (strong, nonatomic) NSString* certificateCode;            // 职业证书编号
@property (strong, nonatomic) NSString* approvalAuthority;          // 批准机关
@property (strong, nonatomic) NSString* degree;                     // 满意度
@property (strong, nonatomic) NSString* details;                    // 医生详情
@property (strong, nonatomic) NSString* projectNumber;              // 医生项目数
@property (strong, nonatomic) NSMutableArray<GetProjectListInfo*>* projectList;                // 医生项目列表
@property (strong, nonatomic) NSMutableArray<GetCaseListListInfo*>* caseList;                // 案例列表
@property (strong, nonatomic) NSString* modbile;                    // 手机号
@property (strong, nonatomic) NSString* hxAccount;                  // 环信账号
@property (strong, nonatomic) NSString* IsQuery;                    // 是否可咨询，1：是 0：否
@property (strong, nonatomic) NSString* IsFollow;                   // 是否已关注，1：是 0：否
@property (strong, nonatomic) NSString* best;                       // 擅长

@end
