//
//  CommonInfo.h
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectModelProtocol.h"

@interface ProvinceInfo : NSObject <SelectModelProtocol>

@property (strong, nonatomic) NSString* pid;                    // 省id
@property (strong, nonatomic) NSString* pName;                  // 省名字

@end


@interface CommonInfo : NSObject <SelectModelProtocol>

@property (strong, nonatomic) NSString* cid;                    // 国家id
@property (strong, nonatomic) NSString* cname;                  // 国家名字
@property (strong, nonatomic) NSMutableArray<ProvinceInfo*>* province;                // 省名字数组

@end


