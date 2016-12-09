//
//  MineServerInteraction.h
//
//  Created by AnYanbo on 16/6/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>
#import "UserInfo.h"
#import "ExpertInfo.h"
#import "YBCommonKit/YBNetworkEngine.h"
#import "MyDemandInfo.h"
#import "MyAuctionInfo.h"
#import "GetPolicyListInfo.h"
#import "FindMyDisputeInfo.h"

#import "CommonServerInteraction.h"

@interface MineServerInteraction : YBServerInteraction

+ (MineServerInteraction*)sharedInstance;

#pragma mark - 获取用户关注专家列表

/**
 *  我的病历列表
 *
 *  @param uid                          用户编号
 *  @param ukey                         用户秘钥
 *  @param sort_id                      分页计数编号
 *  @param newset                       是否取最新数据；true:最新，false：新数据；
 */
- (void)findFollowExpertWithUid:(NSString*)uid
                           ukey:(NSString*)ukey
                        sort_id:(NSString*)sort_id
                         newset:(NSString*)newset
                  responseBlock:(YBResponseBlock)responseBlock;


#pragma mark - 上传头像

/**
 *  上传图片数据
 *
 *  @param uid                                  用户编号
 *  @param ukey                                 用户秘钥
 *  @param oldPwd                               旧密码
 *  @param newPwd                               新密码
 *  @param name                                 姓名
 *  @param fileList                             上传图片
 *  @param NetEngineProgressChanged             进度回调
 *  @param responseBlock                        成功回调
 */
- (void)InfoEditImageWithUid:(NSString*)uid
                        ukey:(NSString*)ukey
                      oldPwd:(NSString*)oldPwd
                      newPwd:(NSString*)newPwd
                        name:(NSString*)name
                    fileList:(UIImage*)fileList
               progressBlock:(NetEngineProgressChanged)progressBlock
               responseBlock:(YBResponseBlock)responseBlock;


#pragma mark - 获取我的需求列表

/**
 *  我的需求列表
 *
 *  @param uid                                  用户编号
 *  @param ukey                                 用户秘钥
 *  @param sort_id                              分页计数编号
 *  @param newset                               是否取最新数据；true:最新，false：新数据；
 */
- (void)findMyDemandWithUid:(NSString*)uid
                       ukey:(NSString*)ukey
                    sort_id:(NSString*)sort_id
                     newset:(NSString*)newset
              responseBlock:(YBResponseBlock)responseBlock;


#pragma mark - 获取我的竞拍列表

/**
 *  我的竞拍列表
 *
 *  @param uid                                  用户编号
 *  @param ukey                                 用户秘钥
 *  @param state                                竞拍状态 0竞拍中 1已成功 2未成功
 *  @param sort_id                              分页计数编号
 *  @param newset                               是否取最新数据；true:最新，false：新数据；
 */
- (void)findMyAuctionWithUid:(NSString*)uid
                        ukey:(NSString*)ukey
                       state:(NSString*)state
                     sort_id:(NSString*)sort_id
                      newset:(NSString*)newset
               responseBlock:(YBResponseBlock)responseBlock;


#pragma mark - 获取我的保单列表

/**
 *  获取我的保单列表
 *
 *  @param uid                                  用户编号
 *  @param ukey                                 用户秘钥
 *  @param state                                0：待受理 1：待付款 2：进行中 3：已完成 4：已中止 5：未受理
 *  @param sort_id                              分页计数编号
 *  @param newset                               是否取最新数据；true:最新，false：新数据；
 */
- (void)getPolicyListWithUid:(NSString*)uid
                        ukey:(NSString*)ukey
                       state:(NSString*)state
                     sort_id:(NSString*)sort_id
                      newset:(NSString*)newset
               responseBlock:(YBResponseBlock)responseBlock;


#pragma mark - 获取我的纠纷列表

/**
 *  我的纠纷列表
 *
 *  @param uid                                  用户编号
 *  @param ukey                                 用户秘钥
 *  @param state                                纠纷状态 0审核中 1 处理中 2 已完成
 *  @param sort_id                              分页计数编号
 *  @param newset                               是否取最新数据；true:最新，false：新数据；
 */
- (void)findMyDisputeWithUid:(NSString*)uid
                        ukey:(NSString*)ukey
                       state:(NSString*)state
                     sort_id:(NSString*)sort_id
                      newset:(NSString*)newset
               responseBlock:(YBResponseBlock)responseBlock;


@end
