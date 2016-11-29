//
//  BeautyServerInteraction.h
//  求美者端
//
//  Created by Smeb on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>
#import "AuctionProjectInfo.h"
#import "ExpertInfo.h"
#import "AgencyInfo.h"

@interface BeautyServerInteraction : YBServerInteraction

+ (BeautyServerInteraction*)sharedInstance;


#pragma mark - 获取项目拍卖列表

/**
 *  获取项目拍卖列表
 *
 *  @param sort_id              分页计数编号
 *  @param newset               是否取最新数据
 *  @param classifyId           分类编号
 *  @param countryId            国家编号
 *  @param provinceId           省份编号
 *  @param isHot                是否为热门项目
 *  @param keyWord              模糊查询
 *  @param responseBlock        成功回调
 */
- (void)findAuctionProjectWithSort_id:(NSString*)sort_id
                               newset:(NSString*)newset
                           classifyId:(NSString*)classifyId
                            countryId:(NSString*)countryId
                           provinceId:(NSString*)provinceId
                                isHot:(NSString*)isHot
                              keyWord:(NSString*)keyWord
                        responseBlock:(YBResponseBlock)responseBlock;

#pragma mark - 获取专家列表

/**
 *  获取专家列表
 *
 *  @param sort_id              分页计数编号
 *  @param newset               是否取最新数据
 *  @param classifyId           分类编号
 *  @param projectId            项目编号
 *  @param countryId            国家编号
 *  @param provinceId           省份编号
 *  @param queryType            查询类型;0：智能 1：好评 2：可咨询
 *  @param keyWord              模糊查询
 *  @param responseBlock        成功回调
 */
- (void)findExpertWithSort_id:(NSString*)sort_id
                       newset:(NSString*)newset
                   classifyId:(NSString*)classifyId
                    projectId:(NSString*)projectId
                    countryId:(NSString*)countryId
                   provinceId:(NSString*)provinceId
                    queryType:(NSString*)queryType
                      keyWord:(NSString*)keyWord
                responseBlock:(YBResponseBlock)responseBlock;


#pragma mark - 获取机构列表

/**
 *  获取机构列表
 *
 *  @param sort_id              分页计数编号
 *  @param newset               是否取最新数据
 *  @param classifyId           分类编号
 *  @param countryId            国家编号
 *  @param provinceId           省份编号
 *  @param keyWord              模糊查询
 *  @param responseBlock        成功回调
 */
- (void)findAgencyWithSort_id:(NSString*)sort_id
                       newset:(NSString*)newset
                   classifyId:(NSString*)classifyId
                    countryId:(NSString*)countryId
                   provinceId:(NSString*)provinceId
                      keyWord:(NSString*)keyWord
                responseBlock:(YBResponseBlock)responseBlock;


@end
