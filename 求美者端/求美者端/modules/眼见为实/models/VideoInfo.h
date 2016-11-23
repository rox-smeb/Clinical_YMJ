//
//  VideoInfo.h
//  求美者端
//
//  Created by Smeb on 2016/11/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoInfo : NSObject

@property (strong, nonatomic) NSString* vId;                            // 视频主键
@property (strong, nonatomic) NSString* name;                           // 名称
@property (strong, nonatomic) NSString* url;                            // 视频地址
@property (strong, nonatomic) NSString* dId;                            // 关联医生主键
@property (strong, nonatomic) NSString* details;                        // 文件描述
@property (strong, nonatomic) NSString* sort_id;                        // 分页计数

@end
