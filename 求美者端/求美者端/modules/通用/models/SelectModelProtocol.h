//
//  SelectModelProtocol.h
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/7/8.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectModelProtocol <NSObject>

@required

- (NSString*)name;

@optional

- (NSArray<id<SelectModelProtocol>>*)subList;

@end