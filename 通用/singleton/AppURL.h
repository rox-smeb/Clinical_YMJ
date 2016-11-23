//
//  AppURL.h
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/6/27.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppURL : NSObject

+ (NSString*)URLWithPath:(NSString*)path method:(NSString*)method;

@end
