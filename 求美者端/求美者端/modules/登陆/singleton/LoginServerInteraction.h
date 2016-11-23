//
//  LoginServerInteraction.h
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>
#import "UserInfo.h"

@interface LoginServerInteraction : YBServerInteraction

+ (LoginServerInteraction*)sharedInstance;

#pragma mark - 用户注册

/**
 *  用户注册
 *
 *  @param mobile        注册手机号
 *  @param code          验证码
 *  @param password      登陆密码
 *  @param name          用户姓名
 *  @param inviteCode    邀请码
 *  @param responseBlock 成功回调 (UserInfo)
 */
- (void)registerWithMobile:(NSString*)mobile
                      code:(NSString*)code
                  password:(NSString*)password
                      name:(NSString*)name
                inviteCode:(NSString*)inviteCode
             responseBlock:(YBResponseBlock)responseBlock;

#pragma mark - 用户登陆

/**
 *  用户登陆
 *
 *  @param mobile        手机号
 *  @param passsword     登陆密码
 *  @param responseBlock 成功回调 (UserInfo)
 */
- (void)loginWithMobile:(NSString*)mobile
               password:(NSString*)passsword
          responseBlock:(YBResponseBlock)responseBlock;

@end
