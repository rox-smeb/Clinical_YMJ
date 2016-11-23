//

//  HomeServerInteraction.h
//
//  Created by AnYanbo on 16/6/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>
#import "HomePormptInfo.h"

@interface HomeServerInteraction : YBServerInteraction

+ (HomeServerInteraction*)sharedInstance;

#pragma mark - 获取首页提示数

/**
 *  获取首页提示数
 *
 *  @param responseBlock 成功回调 (HomePormptInfo)
 */
- (void)getHomePormptNumResponseBlock:(YBResponseBlock)responseBlock;

@end
