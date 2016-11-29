//
//  AgencyInfo.h
//  求美者端
//
//  Created by Smeb on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgencyRecomendInfo : NSObject

@property (strong, nonatomic) NSString* rName;

@end


@interface AgencyInfo : NSObject

@property (strong, nonatomic) NSString* aId;                            // 机构编号
@property (strong, nonatomic) NSString* name;                           // 机构名称
@property (strong, nonatomic) NSString* num;                            // 出诊医生数量
@property (strong, nonatomic) NSString* bset;                           // 擅长
@property (strong, nonatomic) NSString* url;                            // 机构图片
@property (strong, nonatomic) NSString* bigPath;                        // 大图片
@property (strong, nonatomic) NSString* contact;                        // 机构联系人
@property (strong, nonatomic) NSString* phone;                          // 机构联系电话
@property (strong, nonatomic) NSMutableArray<AgencyRecomendInfo*>* recommendList;                                                      // 推荐平台列表
@property (strong, nonatomic) NSString* type;                           // 医院经营性质
@property (strong, nonatomic) NSString* sort_id;                        // 分页计数

@end
