//
//  ExpertInfo.h
//  求美者端
//
//  Created by Smeb on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ExpertRecomendInfo : NSObject

@property (strong, nonatomic) NSString* rName;

@end


@interface ExpertInfo : NSObject

@property (strong, nonatomic) NSString* eId;                            // 专家编号
@property (strong, nonatomic) NSString* name;                           // 专家姓名
@property (strong, nonatomic) NSString* title;                          // 专家职称
@property (strong, nonatomic) NSString* address;                        // 职业地点
@property (strong, nonatomic) NSString* best;                           // 擅长
@property (strong, nonatomic) NSString* degree;                         // 满意度
@property (strong, nonatomic) NSString* isAdvice;                       // 是否可咨询 true false
@property (strong, nonatomic) NSString* url;                            // 头像url地址
@property (strong, nonatomic) NSString* bigPath;                        // 大图片
@property (strong, nonatomic) NSString* urlDetails;                     // 医生详情地址
@property (strong, nonatomic) NSMutableArray<ExpertRecomendInfo*>* recommendList;                                                      // 推荐平台列表
@property (strong, nonatomic) NSString* star;                           // 评星
@property (strong, nonatomic) NSString* hxAccount;                      // 环信用户
@property (strong, nonatomic) NSString* sort_id;                        // 分页计数

@end
