//
//  GetCaseListInfo.h
//  求美者端
//
//  Created by apple on 2016/11/26.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCaseListInfo : NSObject

@property(nonatomic,strong)NSString* cId;           //案例编号
@property(nonatomic,strong)NSString* dId;           //医生编号
@property(nonatomic,strong)NSString* dName;         //医生名称
@property(nonatomic,strong)NSString* dPic;          //医生头像
@property(nonatomic,strong)NSString* cBeforePic;    //案例before图片
@property(nonatomic,strong)NSString* cAfterPic;     //案例after图片
@property(nonatomic,strong)NSString* cDetails;      //案例详情
@property(nonatomic,strong)NSString* cViewNumber;   //案例查看数

@end
