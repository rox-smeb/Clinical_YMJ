//
//  FindMyDisputeInfo.h
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindMyDisputeInfo : NSObject

@property(nonatomic,strong)NSString* dId;                               // 纠纷编号
@property(nonatomic,strong)NSString* date;                              // 申请日期
@property(nonatomic,strong)NSString* content;                           // 调节需求内容
@property(nonatomic,strong)NSString* state;                             // 纠纷状态
@property(nonatomic,strong)NSString* sort_id;                           // 排序

@end
