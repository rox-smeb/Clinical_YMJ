//
//  UserInfo.m
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/6/17.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "UserInfo.h"
#import "JPUSHService.h"

#define CURRENT_USER                (@"CURRENT_USER")
#define LAST_LOGIN_USER_HEAD        (@"LAST_LOGIN_USER_HEAD")

@implementation UserInfo

static UserInfo* currentUserInfo;

+ (instancetype)currentUser
{
    if (currentUserInfo == nil)
    {
        currentUserInfo = (UserInfo*)[[TMDiskCache sharedCache] objectForKey:CURRENT_USER];
    }
    
    return currentUserInfo;
}

+ (BOOL)isLogin
{
    UserInfo* info = [[self class] currentUser];
    if (info != nil)
    {
        return YES;
    }
    return NO;
}

+ (void)logout
{
    [[TMDiskCache sharedCache] removeObjectForKey:CURRENT_USER];
    currentUserInfo = nil;
    
    // 取消用户别名
    NSSet* set = [NSSet setWithObject:@"GARAGE"];
    [JPUSHService setTags:set alias:@"Unlogin" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
        NSLog(@"%@", iAlias);
    }];
}

+ (NSString*)lastLoginUserImageURL
{
    NSString* url = (NSString*)[[TMDiskCache sharedCache] objectForKey:LAST_LOGIN_USER_HEAD];
    return url;
}

- (void)login
{
    currentUserInfo = nil;
    [[TMDiskCache sharedCache] setObject:self forKey:CURRENT_USER];
    [[TMDiskCache sharedCache] setObject:self.url forKey:LAST_LOGIN_USER_HEAD];
    
    // 用户登陆 -> 设置别名
    [self setupAlias];
}

- (void)setupAlias
{
    NSString* alias = [self userAlias];
    
    // 设置用户别名
    NSSet* set = [NSSet setWithObject:@"GARAGE"];
    [JPUSHService setTags:set alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
        NSLog(@"%@", iAlias);
    }];
}

- (void)updateCurrentUser
{
    [self login];
}

- (BOOL)updateHeadURL:(NSString*)url
{
    if ([url isKindOfClass:[NSString class]])
    {
        self.url = url;
        [[TMDiskCache sharedCache] setObject:self forKey:CURRENT_USER];
        
        return YES;
    }
    return NO;
}

- (NSString*)userAlias
{
    NSString* alias = nil;
    @try
    {
        alias = [self.uid stringByReplacingOccurrencesOfString:@"-" withString:@""];
        alias = [alias lowercaseString];
    }
    @catch (NSException *exception)
    {
    }
    return alias;
}

@end

