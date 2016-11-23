//
//  FindDisplayInfo.h
//  求美者端
//
//  Created by Smeb on 2016/11/14.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindDisplayInfo : NSObject

@property (strong, nonatomic) NSString* pId;                        // 图片Id
@property (strong, nonatomic) NSString* url;                        // 地址
@property (strong, nonatomic) NSString* title;                      // 标题
@property (strong, nonatomic) NSString* subTitle;                   // 副标题
@property (strong, nonatomic) NSString* details;                    // 详情

@end
