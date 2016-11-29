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
#import "VideoInfo.h"
#import "FindClassifyInfo.h"
#import "GetCaseListInfo.h"
@interface CommonServerInteraction : YBServerInteraction

+ (CommonServerInteraction*)sharedInstance;

#pragma mark - 获取省份列表

/**
 *  获取省份列表
 *
 *  @param responseBlock 成功回调 (CommonInfo)
 */
- (void)findProvinceResponseBlock:(YBResponseBlock)responseBlock;

#pragma mark - 获取项目分类列表

/**
 *  获取项目分类列表
 *  @param responseBlock 成功回调 (CommonInfo)
 */
-(void)findClassifyResponseBlock:(YBResponseBlock)responseBlock;

#pragma mark - 获取展示图片

/**
 *  获取展示图片
 *
 *  @param responseBlock 成功回调 (FindDisplayInfo)
 */
- (void)findDisplayInfoWithType:(NSString*)type
                  responseBlock:(YBResponseBlock)responseBlock;


- (void)findSpecial:(NSString*)type
      responseBlock:(YBResponseBlock)responseBlock;


#pragma mark - 获取视频列表

/**
 *  获取视频列表
 *
 *  @param sort_id                  分页计数编号
 *  @param newset                   是否取最新数据
 */
- (void)findVideowithSortId:(NSString*)sort_id
                     newset:(NSString*)newset
              responseBlock:(YBResponseBlock)responseBlock;

#pragma mark - 获取案例展示列表

/**
 *  获取案例展示列表
 *
 *  @param responseBlock 成功回调 (CommonInfo)
 */
- (void)getCaseListResponseBlock:(YBResponseBlock)responseBlock;

@end
