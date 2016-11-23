//
//  NSError+HUD.h
//  果动校园
//
//  Created by AnYanbo on 15/3/16.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOTIFICATION_LOGIN_ILLEGALITY_CODE      (10)
#define NOTIFICATION_LOGIN_ILLEGALITY           (@"NOTIFICATION_LOGIN_ILLEGALITY")

@interface NSError (HUD)

- (void)showErrorHUD;

@end
