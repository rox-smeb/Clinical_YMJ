//
//  YMJCommonServerInteraction.h
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YBCommonKit/YBCommonKit.h>\

typedef NS_ENUM(NSInteger, VerificationCodeState)
{
    VERIFICATION_CODE_STATE_REGISTER      = 1,          // 注册
    VERIFICATION_CODE_STATE_FIND_PASSWORD = 2,          // 找回密码
    VERIFICATION_CODE_STATE_LOGIN         = 3,          // 验证码登陆
    VERIFICATION_CODE_STATE_CHECK_MOBILE  = 4,          // 验证手机号码
    VERIFICATION_CODE_STATE_BIND_MOBILE   = 5,          // 验证新的手机号
};

@interface YMJCommonServerInteraction : YBServerInteraction

+ (YMJCommonServerInteraction*)sharedInstance;

#pragma mark - 获取验证码

/**
 *  获取验证码
 *
 *  @param mobile        手机号码
 *  @param state         获取验证码的类型
 *  @param responseBlock 成功回调
 */
- (void)getVerificationCodeToMobile:(NSString*)mobile
                              state:(VerificationCodeState)state
                      responseBlock:(YBResponseBlock)responseBlock;


@end
