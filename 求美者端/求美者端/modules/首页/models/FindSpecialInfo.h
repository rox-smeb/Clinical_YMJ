//
//  FindSpecialInfo.h
//  求美者端 特约专家
//
//  Created by apple on 2016/11/17.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindSpecialInfo : NSObject
@property(strong,nonatomic) NSString* dId;//医生编号
@property(strong,nonatomic) NSString* dName;//医生姓名
@property(strong,nonatomic) NSString* dTtile;//医生职称
@property(strong,nonatomic) NSString* dSubTitle;//医生简介
@property(strong,nonatomic) NSString* dAgency;//医生所在医疗机构名称
@property(strong,nonatomic) NSString* Path;//图片
@property(strong,nonatomic) NSString* bigPath;//大图片
@property(strong,nonatomic) NSString* best;//擅长
@property(strong,nonatomic) NSString* isKorea;// 是否是韩国专家 0：韩国 1中国
@end
