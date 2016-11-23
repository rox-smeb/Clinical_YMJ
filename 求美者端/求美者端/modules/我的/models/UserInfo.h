//
//  UserInfo.h
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/6/17.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* ukey;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* url;
@property (nonatomic,strong) NSString* hxAccount;

+ (instancetype)currentUser;
+ (BOOL)isLogin;
+ (void)logout;
+ (NSString*)lastLoginUserImageURL;

- (void)login;
- (void)setupAlias;
- (void)updateCurrentUser;
- (BOOL)updateHeadURL:(NSString*)url;

- (NSString*)userAlias;

@end
