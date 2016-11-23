//
//  YMJCommonServerInteraction.m
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "YMJCommonServerInteraction.h"

@implementation YMJCommonServerInteraction

static YMJCommonServerInteraction *SINGLETON = nil;

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

#pragma mark - 获取验证码

- (void)getVerificationCodeToMobile:(NSString*)mobile
                              state:(VerificationCodeState)state
                      responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:mobile forKey:@"phone"];
    [param addParam:@(state) forKey:@"state"];
    [param addParam:[NSString genGUID] forKey:@"uuid"];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"getVerificationCode"]
             method:GET
       responseType:RESPONSE_INFO_NONE
          itemClass:nil
             params:param
      responseBlock:responseBlock];
}

@end
