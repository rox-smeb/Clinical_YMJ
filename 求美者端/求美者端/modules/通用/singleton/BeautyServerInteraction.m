//
//  BeautyServerInteraction.m
//  求美者端
//
//  Created by Smeb on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "BeautyServerInteraction.h"

@implementation BeautyServerInteraction

static BeautyServerInteraction *SINGLETON = nil;

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

#pragma mark - 获取项目拍卖列表
- (void)findAuctionProjectWithSort_id:(NSString*)sort_id
                               newset:(NSString*)newset
                           classifyId:(NSString*)classifyId
                            countryId:(NSString*)countryId
                           provinceId:(NSString*)provinceId
                                isHot:(NSString*)isHot
                              keyWord:(NSString*)keyWord
                        responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    [param addParam:classifyId forKey:@"classifyId"];
    [param addParam:countryId forKey:@"countryId"];
    [param addParam:provinceId forKey:@"provinceId"];
    [param addParam:isHot forKey:@"isHot"];
    [param addParam:keyWord forKey:@"keyWord"];
    
    [self invokeApi:[AppURL URLWithPath:@"Beauty" method:@"findAuctionProject"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[AuctionProjectInfo class]
             params:param
      responseBlock:responseBlock];
}

#pragma mark - 获取专家列表

- (void)findExpertWithSort_id:(NSString*)sort_id
                       newset:(NSString*)newset
                   classifyId:(NSString*)classifyId
                    projectId:(NSString*)projectId
                    countryId:(NSString*)countryId
                   provinceId:(NSString*)provinceId
                    queryType:(NSString*)queryType
                      keyWord:(NSString*)keyWord
                responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    [param addParam:classifyId forKey:@"classifyId"];
    [param addParam:projectId forKey:@"projectId"];
    [param addParam:countryId forKey:@"countryId"];
    [param addParam:provinceId forKey:@"provinceId"];
    [param addParam:queryType forKey:@"queryType"];
    [param addParam:keyWord forKey:@"keyWord"];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"findExpert"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[ExpertInfo class]
             params:param
      responseBlock:responseBlock];
}

#pragma mark - 获取机构列表

- (void)findAgencyWithSort_id:(NSString*)sort_id
                       newset:(NSString*)newset
                   classifyId:(NSString*)classifyId
                    countryId:(NSString*)countryId
                   provinceId:(NSString*)provinceId
                      keyWord:(NSString*)keyWord
                responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    [param addParam:classifyId forKey:@"classifyId"];
    [param addParam:countryId forKey:@"countryId"];
    [param addParam:provinceId forKey:@"provinceId"];
    [param addParam:keyWord forKey:@"keyWord"];
    
    [self invokeApi:[AppURL URLWithPath:@"Common" method:@"findAgency"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[AgencyInfo class]
             params:param
      responseBlock:responseBlock];
}



@end






