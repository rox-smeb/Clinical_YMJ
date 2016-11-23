//
//  LoginServerInteraction.m
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "LoginServerInteraction.h"

@implementation LoginServerInteraction

static LoginServerInteraction *SINGLETON = nil;

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SINGLETON = [[super alloc] init];
    });
    
    return SINGLETON;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


#pragma mark - 用户注册

- (void)registerWithMobile:(NSString*)mobile
                      code:(NSString*)code
                  password:(NSString*)password
                      name:(NSString*)name
                inviteCode:(NSString*)inviteCode
             responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:mobile forKey:@"phone"];
    [param addParam:code forKey:@"code"];
    [param addParam:password forKey:@"pwd"];
    [param addParam:name forKey:@"name"];
    [param addParam:inviteCode forKey:@"inviteCode"];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"userRegister"]
             method:POST
       responseType:RESPONSE_INFO_DATA
          itemClass:[UserInfo class]
             params:param
      responseBlock:responseBlock];
}

#pragma mark - 用户登陆

- (void)loginWithMobile:(NSString*)mobile
               password:(NSString*)passsword
          responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:mobile forKey:@"phone"];
    [param addParam:passsword forKey:@"pwd"];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"userLogin"]
             method:POST
       responseType:RESPONSE_INFO_DATA
          itemClass:[UserInfo class]
             params:param
      responseBlock:responseBlock];
}

@end
