//
//  CommonServerInteraction.h
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>
#import "CommonInfo.h"
#import "FindDisplayInfo.h"
#import "FindSpecialInfo.h"
@interface CommonServerInteraction : YBServerInteraction

+ (CommonServerInteraction*)sharedInstance;

#pragma mark - 获取省份列表

/**
 *  获取省份列表
 *
 *  @param responseBlock 成功回调 (CommonInfo)
 */
- (void)findProvinceResponseBlock:(YBResponseBlock)responseBlock;

#pragma mark - 获取展示图片

/**
 *  获取省份列表
 *
 *  @param responseBlock 成功回调 (FindDisplayInfo)
 */
- (void)findDisplayInfoWithType:(NSString*)type
                  responseBlock:(YBResponseBlock)responseBlock;
-(void) findSpecial:(NSString*)type
      responseBlock:(YBResponseBlock)responseBlock;
@end
