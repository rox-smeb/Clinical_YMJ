//
//  CommonServerInteraction.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "CommonServerInteraction.h"

@implementation CommonServerInteraction

static CommonServerInteraction *SINGLETON = nil;

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

#pragma mark - 获取省份列表
- (void)findProvinceResponseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"findProvince"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[CommonInfo class]
             params:param
      responseBlock:responseBlock];
}

#pragma mark - 获取展示图片
- (void)findDisplayInfoWithType:(NSString*)type
                  responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:type forKey:@"type"];

    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"findDisplayInfo"]
             method:GET
       responseType:RESPONSE_INFO_DATA
          itemClass:[FindDisplayInfo class]
             params:param
      responseBlock:responseBlock];
}

#pragma mark - 获取特约专家列表
-(void) findSpecial:(NSString*)type
      responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param addParam:type forKey:@"isKorea"];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"findSpecial"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[FindSpecialInfo class]
             params:param
      responseBlock:responseBlock];
    
}

#pragma mark - 获取视频列表
- (void)findVideowithSortId:(NSString*)sort_id
                     newset:(NSString*)newset
              responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"findVideo"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[VideoInfo class]
             params:param
      responseBlock:responseBlock];

}

@end
