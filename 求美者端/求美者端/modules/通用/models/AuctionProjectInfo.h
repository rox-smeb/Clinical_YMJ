//
//  AuctionProjectInfo.h
//  求美者端
//
//  Created by Smeb on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuctionProUrlInfo : NSObject

@property (strong, nonatomic) NSString* url;                        

@end


@interface AuctionProjectInfo : NSObject

@property (strong, nonatomic) NSString* apId;                       // 拍卖项目编号
@property (strong, nonatomic) NSString* name;                       // 拍卖项目名称
@property (strong, nonatomic) NSString* price;                      // 当前价格
@property (strong, nonatomic) NSString* fPrice;                     // 一口价
@property (strong, nonatomic) NSString* date;                       // 剩余时间小时数
@property (strong, nonatomic) NSString* aName;                      // 机构名称
@property (strong, nonatomic) NSString* aType;                      // 机构经营性质
@property (strong, nonatomic) NSString* dId;                        // 医生ID
@property (strong, nonatomic) NSMutableArray<AuctionProUrlInfo*>* urlList;                     // 项目图片列表
@property (strong, nonatomic) NSString* sort_id;                    // 分页计数编号

@end
