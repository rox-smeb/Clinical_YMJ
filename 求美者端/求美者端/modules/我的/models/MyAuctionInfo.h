//
//  MyAuctionInfo.h
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAuctionInfo : NSObject

@property(nonatomic,strong)NSString* aId;                           // 竞拍编号
@property(nonatomic,strong)NSString* project;                       // 项目
@property(nonatomic,strong)NSString* price;                         // 我的报价
@property(nonatomic,strong)NSString* residualTime;                  // 剩余时间 小时数
@property(nonatomic,strong)NSString* releaseDoctor;                 // 发布医生
@property(nonatomic,strong)NSString* CurrentPrice;                  // 项目当前价格
@property(nonatomic,strong)NSString* sort_id;                       // 排序

@end
