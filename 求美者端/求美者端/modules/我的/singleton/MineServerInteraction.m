//
//  MineServerInteraction.m
//
//  Created by AnYanbo on 16/6/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MineServerInteraction.h"

@implementation MineServerInteraction

static MineServerInteraction *SINGLETON = nil;

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

#pragma mark - 获取用户关注专家列表

- (void)findFollowExpertWithUid:(NSString*)uid
                           ukey:(NSString*)ukey
                        sort_id:(NSString*)sort_id
                         newset:(NSString*)newset
                  responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"findFollowExpert"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[ExpertInfo class]
             params:param
      responseBlock:responseBlock];
}

@end
