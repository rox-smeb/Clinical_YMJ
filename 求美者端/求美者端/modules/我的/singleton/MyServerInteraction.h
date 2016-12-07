//
//  MyServerInteraction.h
//  求美者端
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>
#import "MyMedicalRecordListInfo.h"

@interface MyServerInteraction : YBServerInteraction


+ (MyServerInteraction*)sharedInstance;

#pragma mark - 我的病历列表

/**
 *  我的病历列表
 *
 *  @param sort_id                  分页计数编号
 *  @param newset                   是否取最新数据
 */
- (void)myMedicalRecordListSortId:(NSString*)sort_id
                              uid:(NSString*)uid
                             ukey:(NSString*)ukey
                     newset:(NSString*)newset
              responseBlock:(YBResponseBlock)responseBlock;
@end
