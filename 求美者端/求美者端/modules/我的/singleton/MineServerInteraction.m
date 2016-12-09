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


#pragma mark - 上传头像

- (void)InfoEditImageWithUid:(NSString*)uid
                        ukey:(NSString*)ukey
                      oldPwd:(NSString*)oldPwd
                      newPwd:(NSString*)newPwd
                        name:(NSString*)name
                    fileList:(UIImage*)fileList
               progressBlock:(NetEngineProgressChanged)progressBlock
               responseBlock:(YBResponseBlock)responseBlock
{
//    NSString* base64 = [NSData encodeBase64Data:fileList];
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:oldPwd forKey:@"oldPwd"];
    [param addParam:newPwd forKey:@"newPwd"];
    [param addParam:name forKey:@"name"];
    //[param addParam:fileList forKey:@"FileByte"];
    [param setMethod:@"fileList"];

    NetEngineComplete ne_complete = ^(id result, NSError* error)
    {
        if (responseBlock != nil)
        {
            YBServerResponse *response = [YBServerResponse responseWithOperation:result error:error infoBlock:^id(YBServerResponseInfo *info, BOOL *ret) {
                NSString* url = @"";
                @try
                {
                    url = info.data[@"url"];
                }
                @catch (NSException *exception)
                {
                    *ret = NO;
                    url = nil;
                }
                return url;
            }];
            NSString *url = response.i.data[@"url"];
            responseBlock(response, url);
        }
    };
    
    NSData* data = UIImageJPEGRepresentation(fileList, 1.0f);
    [[YBNetworkEngine sharedInstance] postFileTo:[AppURL URLWithPath:@"My" method:@"InfoEdit"]
                                withParams:param
                                  withFile:data
                                   andName:@"imgFile"
                                      type:@"jpg"
                  withProgressChangedBlock:progressBlock
                       withCompletionBlock:ne_complete];

}


#pragma mark - 获取我的需求列表

- (void)findMyDemandWithUid:(NSString*)uid
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
    
    [self invokeApi:[AppURL URLWithPath:@"My" method:@"findMyDemand"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[MyDemandInfo class]
             params:param
      responseBlock:responseBlock];
}


#pragma mark - 获取我的竞拍列表

/**
 *  我的竞拍列表
 *
 *  @param uid                                  用户编号
 *  @param ukey                                 用户秘钥
 *  @param state                                竞拍状态 0竞拍中 1已成功 2未成功
 *  @param sort_id                              分页计数编号
 *  @param newset                               是否取最新数据；true:最新，false：新数据；
 */
- (void)findMyAuctionWithUid:(NSString*)uid
                        ukey:(NSString*)ukey
                       state:(NSString*)state
                     sort_id:(NSString*)sort_id
                      newset:(NSString*)newset
               responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:state forKey:@"state"];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    
    [self invokeApi:[AppURL URLWithPath:@"My" method:@"findMyAuction"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[MyAuctionInfo class]
             params:param
      responseBlock:responseBlock];
}


#pragma mark - 获取我的保单列表

/**
 *  我的竞拍列表
 *
 *  @param uid                                  用户编号
 *  @param ukey                                 用户秘钥
 *  @param state                                0：待受理 1：待付款 2：进行中 3：已完成 4：已中止 5：未受理
 *  @param sort_id                              分页计数编号
 *  @param newset                               是否取最新数据；true:最新，false：新数据；
 */
- (void)getPolicyListWithUid:(NSString*)uid
                        ukey:(NSString*)ukey
                       state:(NSString*)state
                     sort_id:(NSString*)sort_id
                      newset:(NSString*)newset
               responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:state forKey:@"state"];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    
    [self invokeApi:[AppURL URLWithPath:@"My" method:@"getPolicyList"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[GetPolicyListInfo class]
             params:param
      responseBlock:responseBlock];
}

#pragma mark - 获取我的纠纷列表

/**
 *  我的纠纷列表
 *
 *  @param uid                                  用户编号
 *  @param ukey                                 用户秘钥
 *  @param state                                纠纷状态 0审核中 1 处理中 2 已完成
 *  @param sort_id                              分页计数编号
 *  @param newset                               是否取最新数据；true:最新，false：新数据；
 */
- (void)findMyDisputeWithUid:(NSString*)uid
                        ukey:(NSString*)ukey
                       state:(NSString*)state
                     sort_id:(NSString*)sort_id
                      newset:(NSString*)newset
               responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:state forKey:@"state"];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    
    [self invokeApi:[AppURL URLWithPath:@"My" method:@"findMyDispute"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[FindMyDisputeInfo class]
             params:param
      responseBlock:responseBlock];
}

@end
