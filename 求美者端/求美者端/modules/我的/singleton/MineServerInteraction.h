//
//  MineServerInteraction.h
//
//  Created by AnYanbo on 16/6/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>
#import "UserInfo.h"
#import "ExpertInfo.h"

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

@end
