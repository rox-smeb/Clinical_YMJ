//
//  NSError+HUD.m
//  果动校园
//
//  Created by AnYanbo on 15/3/16.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "NSError+HUD.h"

@implementation NSError (HUD)

- (void)showErrorHUD
{
    if (self.code == NOTIFICATION_LOGIN_ILLEGALITY_CODE)       // 非法登陆
    {
        [SVProgressHUD showErrorWithStatus:self.domain];
        
        // 登陆信息过期
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_ILLEGALITY object:nil];
    }
    if (self.code == NSURLErrorNotConnectedToInternet)         // 网络无连接
    {
        [SVProgressHUD showErrorWithStatus:@"请检查网络连接"];
    }
    else if (self.code == NSURLErrorNetworkConnectionLost)
    {
        [SVProgressHUD showErrorWithStatus:@"网络连接已断开"];
    }
    else if (self.code == NSURLErrorTimedOut)
    {
        [SVProgressHUD showErrorWithStatus:@"网络连接超时"];
    }
    else if (self.code == NSURLErrorCannotFindHost)
    {
        [SVProgressHUD showErrorWithStatus:@"未知服务器"];
    }
    else if (self.code == NSURLErrorCannotConnectToHost)
    {
        [SVProgressHUD showErrorWithStatus:@"无法连接服务器"];
    }
    else if (self.code == NSURLErrorDNSLookupFailed)
    {
        [SVProgressHUD showErrorWithStatus:@"DNS错误"];
    }
    else if (self.code == NSURLErrorBadServerResponse)
    {
        [SVProgressHUD showErrorWithStatus:@"错误服务器应答"];
    }
    else if ([self.domain isEqualToString:@"NSURLErrorDomain"])
    {
        [SVProgressHUD showErrorWithStatus:@"服务器发生异常..."];
    }
    else
    {
        NSString* error = [NSString stringWithFormat:@"%@", self.domain];
        [SVProgressHUD showErrorWithStatus:error];
    }
}

@end
