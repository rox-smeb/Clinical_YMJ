//
//  YBNetworkEngine.h
//  YBCommonKit
//
//  Created by AnYanbo on 14/12/29.
//  Copyright (c) 2014年 YBCommonKit. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^NetEngineComplete)(id param, NSError* error);
typedef void (^NetEngineProgressChanged)(double progress);

typedef enum
{
    responseJsonState   = 1,
    responseStringState = 2,
} responseState;

@interface MKNetworkOperation (NetEngine)

@property (nonatomic, strong) NSObject* customObject;       // 用户自定义数据

@end

@interface YBNetworkEngine : MKNetworkEngine
{
    
}

+ (void)setupSharedInstanceWithHost:(NSString*)url portNum:(NSString*)portNum;
+ (id)sharedInstance;
+ (id)instanceWithHost:(NSString*)url;
+ (id)instanceWithHost:(NSString*)url portNum:(NSString*)portNum;

/**
 *  HTTP GET请求
 *
 *  @param apiPath         服务器API地址
 *  @param params          GET参数
 *  @param completionBlock 成功回调
 *  @param responseState   返回结果属性 (responseJsonState | responseStringState)
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation *)getSomethingFrom:(NSString *)apiPath
                              withParams:(NSDictionary *)params
                     withCompletionBlock:(NetEngineComplete)completionBlock
                                  option:(responseState)responseState;

/**
 *  HTTP POST参数
 *
 *  @param apiPath         服务器API地址
 *  @param params          POST参数
 *  @param completionBlock 成功回调
 *  @param responseState   返回结果属性 (responseJsonState | responseStringState)
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation *)postSomethingTo:(NSString *)apiPath
                             withParams:(NSDictionary *)params
                    withCompletionBlock:(NetEngineComplete)completionBlock
                                 option:(responseState)responseState;

/**
 *  post多个数据
 *
 *  @param apiPath         服务器API地址
 *  @param params          post参数
 *  @param fileDatas       上传数据的数组
 *  @param fileNames       上传数据的key数组
 *  @param completionBlock 完成回调
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation *)postFileTo:(NSString *)apiPath
                        withParams:(NSDictionary *)params
                         withFiles:(NSArray *)fileDatas
                          andNames:(NSArray *)fileNames
               withCompletionBlock:(NetEngineComplete)completionBlock;

/**
 *  post多个数据
 *
 *  @param apiPath         服务器API地址
 *  @param params          post参数
 *  @param fileDatas       上传数据的数组
 *  @param fileNames       上传数据的key数组
 *  @param progressBlock   上传进度回调
 *  @param completionBlock 完成回调
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation *)postFileTo:(NSString *)apiPath
                        withParams:(NSDictionary *)params
                         withFiles:(NSArray *)fileDatas
                          andNames:(NSArray *)fileNames
          withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
               withCompletionBlock:(NetEngineComplete)completionBlock;

/**
 *  post单个文件
 *
 *  @param apiPath         服务器API地址
 *  @param params          post参数
 *  @param fileData        上传文件的数据
 *  @param fileName        上传文件的key
 *  @param completionBlock 完成回调
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation *)postFileTo:(NSString *)apiPath
                        withParams:(NSDictionary *)params
                          withFile:(NSData *)fileData
                           andName:(NSString *)fileName
               withCompletionBlock:(NetEngineComplete)completionBlock;

/**
 *  post单个文件
 *
 *  @param apiPath         服务器API地址
 *  @param params          post参数
 *  @param fileData        上传文件的数据
 *  @param fileName        上传文件的key
 *  @param progressBlock   上传进度回调
 *  @param completionBlock 完成回调
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation *)postFileTo:(NSString*)apiPath
                        withParams:(NSDictionary*)params
                          withFile:(NSData*)fileData
                           andName:(NSString*)fileName
          withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
               withCompletionBlock:(NetEngineComplete)completionBlock;

/**
 *  post单个文件
 *
 *  @param apiPath         服务器API地址
 *  @param params          post参数
 *  @param fileData        上传文件的数据
 *  @param fileName        上传文件的key
 *  @param type            上传文件的类型
 *  @param progressBlock   上传进度回调
 *  @param completionBlock 完成回调
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation *)postFileTo:(NSString*)apiPath
                        withParams:(NSDictionary *)params
                          withFile:(NSData*)fileData
                           andName:(NSString*)fileName
                              type:(NSString*)type
          withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
               withCompletionBlock:(NetEngineComplete)completionBlock;

/**
 *  下载文件
 *
 *  @param fileUrl             下载文件的URL
 *  @param fileName            文件保存名
 *  @param directory           下载文件的存储目录
 *  @param continual           是否断点续传
 *  @param progressBlock       下载进度回调
 *  @param completionBlock     完成回调
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation*)downloadFileFrom:(NSString*)fileUrl
                               saveName:(NSString*)fileName
                            toDirectory:(NSString*)directory
                      continualTransfer:(BOOL)continual
               withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
                    withCompletionBlock:(NetEngineComplete)completionBlock;

/**
 *  下载文件
 *
 *  @param fileUrl             下载文件的URL
 *  @param fileName            文件保存名
 *  @param directory           下载文件的存储目录
 *  @param searchPathDirectory 下载保存的搜索路径
 *  @param continual           是否断点续传
 *  @param progressBlock       下载进度回调
 *  @param completionBlock     完成回调
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation*)downloadFileFrom:(NSString*)fileUrl
                               saveName:(NSString*)fileName
                            toDirectory:(NSString*)directory
                    searchPathDirectory:(NSSearchPathDirectory)searchPathDirectory
                      continualTransfer:(BOOL)continual
               withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
                    withCompletionBlock:(NetEngineComplete)completionBlock;

@end
