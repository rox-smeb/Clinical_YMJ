//
//  YBServerInteraction.h
//  YBCommonKit
//
//  Created by AnYanbo on 15/3/18.
//  Copyright (c) 2015年 YBCommonKit. All rights reserved.
//
//  服务端返回数据结构
//  {
//      s : 状态值
//      m : 提示信息
//      v : 接口版本号
//      i : {
//              Data : 对象数据   (可空)
//              List : 数组数据   (可空)
//              v    : 数据版本号
//          }
//  }

#import <Foundation/Foundation.h>

@class YBServerResponseInfo;
@class YBServerResponse;

typedef NS_ENUM(NSInteger, HTTP_METHOD)
{
    GET      = 0,                                                                       // GET请求
    POST     = 1,                                                                       // POST请求
    UPLOAD   = 2,                                                                       // 上传数据
    DOWNLOAD = 3                                                                        // 下载数据
};

typedef NS_ENUM(NSInteger, RESPONSE_INFO_TYPE)
{
    RESPONSE_INFO_NONE = 1,                                                             // 无数据
    RESPONSE_INFO_DATA = 1 << 1,                                                        // Data返回
    RESPONSE_INFO_LIST = 1 << 2                                                         // List返回
};

typedef NS_ENUM(NSInteger, RESPONSE_ERROR_TYPE)
{
    RESPONSE_ERROR_RETURN_WRONG_PARAM  = -100,                                          // 网络引擎返回错误参数
    RESPONSE_ERROR_RETURN_WRONG_DATA   = -101,                                          // 服务器返回错误数据
    RESPONSE_ERROR_RETURN_WRONG_STATE  = -102,                                          // 服务器返回状态码无效
    RESPONSE_ERROR_WRONG_DATA_ANALYSIS = -103                                           // 服务器返回数据格式无法解析
};

typedef void (^YBResponseBlock)(YBServerResponse* response, id dataOrList);             // 结果返回回调
typedef void (^ProgressUpdateBlock)(double progress);                                   // 进度更新回调
typedef id   (^MakeResponseInfoBlock)(YBServerResponseInfo* info, BOOL *ret);           // 构建info回调

/*********************** YBServerResponseInfo **********************/
@interface YBServerResponseInfo : NSObject
{
    
}

@property (strong, nonatomic) NSDictionary * data;                                      // k->v
@property (strong, nonatomic) NSArray      * list;                                      // array
@property (strong, nonatomic) NSString     * v;                                         // 数据版本号

@end

/********************** YBServerResponse *********************/
@interface YBServerResponse : NSObject
{
    
}

@property (assign, nonatomic) NSInteger            s;                                   // 状态值
@property (strong, nonatomic) NSString             * m;                                 // 提示信息
@property (strong, nonatomic) NSString             * v;                                 // 接口版本号
@property (strong, nonatomic) YBServerResponseInfo * i;                                 // 数据

@property (assign, nonatomic) BOOL                 isCachedResponse;                    // 是否为缓存
@property (strong, nonatomic) id                   content;                             // 服务端返回全部内容
@property (strong, nonatomic) id                   userObject;                          // 用户自定义数据
@property (strong, nonatomic) NSError              * error;                             // 错误信息

+ (instancetype)responseWithOperation:(MKNetworkOperation*)operation error:(NSError*)error;
+ (instancetype)responseWithOperation:(MKNetworkOperation*)operation error:(NSError*)error infoBlock:(MakeResponseInfoBlock)block;

- (BOOL)success;
- (void)showHUD;

@end

/******************** YBServerInteraction ********************/
@interface YBServerInteraction : NSObject
{
    
}

+ (YBServerInteraction*)sharedInstance;

/**
 *  调用服务端API
 *
 *  @param api           api地址
 *  @param method        GET | POST
 *  @param params        传入参数
 *  @param infoMakeBlock 通过 YBServerResponseInfo 构造返回数据的回调
 *  @param block         结果回调
 */
- (void)invokeApi:(NSString*)api
           method:(HTTP_METHOD)method
           params:(NSDictionary*)params
    infoMakeBlock:(MakeResponseInfoBlock)infoMakeBlock
    responseBlock:(YBResponseBlock)block;

/**
 *  调用服务端API
 *
 *  @param api           api地址
 *  @param method        GET | POST
 *  @param params        传入参数
 *  @param userObject    用户自定义对象
 *  @param infoMakeBlock 通过 YBServerResponseInfo 构造返回数据的回调
 *  @param block         结果回调
 */
- (void)invokeApi:(NSString*)api
           method:(HTTP_METHOD)method
           params:(NSDictionary*)params
       userObject:(id)userObject
    infoMakeBlock:(MakeResponseInfoBlock)infoMakeBlock
    responseBlock:(YBResponseBlock)block;

/**
 *  调用服务端API
 *
 *  @param api       api地址
 *  @param method    GET | POST
 *  @param infoType  Data字段返回 | List字段返回 | Data,List字段同时返回
 *  @param itemClass 生成数据的对应Class
 *  @param params    传入参数
 *  @param block     结果回调
 */
- (void)invokeApi:(NSString*)api
           method:(HTTP_METHOD)method
     responseType:(RESPONSE_INFO_TYPE)infoType
        itemClass:(Class)itemClass
           params:(NSDictionary*)params
    responseBlock:(YBResponseBlock)block;

/**
 *  调用服务端API
 *
 *  @param api        api地址
 *  @param method     GET | POST
 *  @param infoType   Data字段返回 | List字段返回 | Data,List字段同时返回
 *  @param itemClass  生成数据的对应Class
 *  @param params     传入参数
 *  @param userObject 用户自定义对象
 *  @param block      结果回调
 */
- (void)invokeApi:(NSString*)api
           method:(HTTP_METHOD)method
     responseType:(RESPONSE_INFO_TYPE)infoType
        itemClass:(Class)itemClass
           params:(NSDictionary*)params
       userObject:(id)userObject
    responseBlock:(YBResponseBlock)block;

/**
 *  调用服务端API
 *
 *  @param api           api地址
 *  @param method        GET | POST
 *  @param params        传入参数
 *  @param infoMakeBlock 通过 YBServerResponseInfo 构造返回数据的回调
 *  @param progressBlock 进度回调
 *  @param block         结果回调
 */
- (void)invokeApi:(NSString*)api
           method:(HTTP_METHOD)method
           params:(NSDictionary*)params
    infoMakeBlock:(MakeResponseInfoBlock)infoMakeBlock
    progressBlock:(ProgressUpdateBlock)progressBlock
    responseBlock:(YBResponseBlock)block;

/**
 *  调用服务端API
 *
 *  @param api           api地址
 *  @param method        GET | POST
 *  @param params        传入参数
 *  @param userObject    用户自定义对象
 *  @param infoMakeBlock 通过 YBServerResponseInfo 构造返回数据的回调
 *  @param progressBlock 进度回调
 *  @param block         结果回调
 */
- (void)invokeApi:(NSString*)api
           method:(HTTP_METHOD)method
           params:(NSDictionary*)params
       userObject:(id)userObject
    infoMakeBlock:(MakeResponseInfoBlock)infoMakeBlock
    progressBlock:(ProgressUpdateBlock)progressBlock
    responseBlock:(YBResponseBlock)block;

/**
 *  调用服务端API
 *
 *  @param api           api地址
 *  @param method        GET | POST
 *  @param infoType      Data字段返回 | List字段返回 | Data,List字段同时返回
 *  @param itemClass     生成数据的对应Class
 *  @param params        传入参数
 *  @param progressBlock 进度回调
 *  @param block         结果回调
 */
- (void)invokeApi:(NSString*)api
           method:(HTTP_METHOD)method
     responseType:(RESPONSE_INFO_TYPE)infoType
        itemClass:(Class)itemClass
           params:(NSDictionary*)params
    progressBlock:(ProgressUpdateBlock)progressBlock
    responseBlock:(YBResponseBlock)block;

/**
 *  调用服务端API
 *
 *  @param api           api地址
 *  @param method        GET | POST
 *  @param infoType      Data字段返回 | List字段返回 | Data,List字段同时返回
 *  @param itemClass     生成数据的对应Class
 *  @param params        传入参数
 *  @param userObject    用户自定义对象
 *  @param progressBlock 进度回调
 *  @param block         结果回调
 */
- (void)invokeApi:(NSString*)api
           method:(HTTP_METHOD)method
     responseType:(RESPONSE_INFO_TYPE)infoType
        itemClass:(Class)itemClass
           params:(NSDictionary*)params
       userObject:(id)userObject
    progressBlock:(ProgressUpdateBlock)progressBlock
    responseBlock:(YBResponseBlock)block;

@end
