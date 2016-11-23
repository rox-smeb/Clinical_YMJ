//
//  HomePormptInfo.h
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePormptInfo : NSObject

@property (strong, nonatomic) NSString* sums;                   // 总人次
@property (strong, nonatomic) NSString* chinaSums;              // 中国人次
@property (strong, nonatomic) NSString* koreaSums;              // 韩国人次

- (NSNumber*)sumsCount;
- (NSString*)chinaSums;
- (NSString*)koreaSums;

@end
