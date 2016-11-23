//
//  HomeServerInteraction.m
//
//  Created by AnYanbo on 16/6/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "HomeServerInteraction.h"

@implementation HomeServerInteraction

static HomeServerInteraction *SINGLETON = nil;

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

#pragma mark - 获取首页提示数

- (void)getHomePormptNumResponseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    
    [self invokeApi:[AppURL URLWithPath:@"Site" method:@"getHomePormptNum"]
             method:GET
       responseType:RESPONSE_INFO_DATA
          itemClass:[HomePormptInfo class]
             params:param
      responseBlock:responseBlock];
}

@end
