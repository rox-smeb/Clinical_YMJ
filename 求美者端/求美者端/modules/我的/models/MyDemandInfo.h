//
//  MyDemandInfo.h
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDemandInfo : NSObject

@property(nonatomic,strong)NSString* dId;                   // 需求编号
@property(nonatomic,strong)NSString* date;                  // 发布日期
@property(nonatomic,strong)NSString* endDate;               // 有效日期
@property(nonatomic,strong)NSString* content;               // 需求内容
@property(nonatomic,strong)NSString* detailUrl;             // 详情web地址
@property(nonatomic,strong)NSString* offerUrl;              // 报价web地址
@property(nonatomic,strong)NSString* project;               // 分类名称
@property(nonatomic,strong)NSString* demandState;           // 需求状态 ,0：发布中 1：已回复 2：已完成
@property(nonatomic,strong)NSString* stateName;             // 状态名称
@property(nonatomic,strong)NSString* sort_id;               // 排序序号

@end
