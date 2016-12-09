//
//  MyMedicalRecordListInfo.h
//  求美者端
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMedicalRecordListInfo : NSObject

@property(nonatomic,strong)NSString* rId;   //病历编号
@property(nonatomic,strong)NSString* time;  //手术时间
@property(nonatomic,strong)NSString* project;//手术项目
@property(nonatomic,strong)NSString* doctor;//手术医生
@property(nonatomic,strong)NSString* agency;//医疗机构
@property(nonatomic,strong)NSString* sort_id;//分页计数

@end
