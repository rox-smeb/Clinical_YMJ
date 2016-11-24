//
//  ProvincialInfo.h
//  求美者端
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ProvincialCityInfo:NSObject
@property(nonatomic,strong) NSString* pid;
@property(nonatomic,strong) NSString* pName;
@end

@interface ProvincialInfo : NSObject
@property(nonatomic,strong) NSString* cid;
@property(nonatomic,strong) NSString* cname;
@property(nonatomic,strong) NSMutableArray<ProvincialCityInfo*>* province;
@end
