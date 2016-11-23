//
//  YBNetworkEngine.h
//  YBCommonKit
//
//  Created by AnYanbo on 14/12/29.
//  Copyright (c) 2014年 YBCommonKit. All rights reserved.
//

#import "YBNetworkEngine.h"

#define CUSTOM_OBJECT                   (@"CUSTOM_OBJECT")

#ifndef URL_BASE
    #define URL_BASE                    (@"")
#endif

#ifndef URL_PORT_NUM
    #define URL_PORT_NUM                (@"")
#endif

@implementation MKNetworkOperation (NetEngine)

- (NSObject*)customObject
{
    return (NSObject*)objc_getAssociatedObject(self, CUSTOM_OBJECT);
}

- (void)setCustomObject:(NSObject *)customObject
{
    objc_setAssociatedObject(self, CUSTOM_OBJECT, customObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation YBNetworkEngine

__strong static id _sharedObject = nil;

+ (void)setupSharedInstanceWithHost:(NSString*)url portNum:(NSString*)portNum
{
    _sharedObject = [[self class] instanceWithHost:url portNum:portNum];
}

+ (id)sharedInstance
{
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        
        if (_sharedObject == nil)
        {
            _sharedObject = [[self class] instanceWithHost:URL_BASE portNum:URL_PORT_NUM];
        }
    });
    return _sharedObject;
}

+ (id)instanceWithHost:(NSString*)url
{
    return [[self class] instanceWithHost:url portNum:nil];
}

+ (id)instanceWithHost:(NSString*)url portNum:(NSString*)portNum
{
    YBNetworkEngine* instance = [[YBNetworkEngine alloc] initWithHostName:url];
    if (portNum != nil && [portNum isEqualToString:@""] == NO)
    {
        instance.portNumber = [portNum intValue];
    }
    return instance;
}

- (MKNetworkOperation *)getSomethingFrom:(NSString *)apiPath
                              withParams:(NSDictionary *)params
                     withCompletionBlock:(NetEngineComplete)completionBlock
                                  option:(responseState)responseState;
{
    MKNetworkOperation *op = [self operationWithPath:apiPath params:params httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {

        if (completionBlock != nil)
        {
            completionBlock(completedOperation, nil);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        if (completionBlock != nil)
        {
            completionBlock(nil, error);
        }
    }];
    
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)postSomethingTo:(NSString *)apiPath
                             withParams:(NSDictionary *)params
                    withCompletionBlock:(NetEngineComplete)completionBlock
                                 option:(responseState)responseState
{
    MKNetworkOperation *op = [self operationWithPath:apiPath params:params httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {

        if (completionBlock != nil)
        {
            completionBlock(completedOperation, nil);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        if (completionBlock != nil)
        {
            completionBlock(nil, error);
        }
    }];
    
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)postFileTo:(NSString *)apiPath
                        withParams:(NSDictionary *)params
                         withFiles:(NSArray *)fileDatas
                          andNames:(NSArray *)fileNames
               withCompletionBlock:(NetEngineComplete)completionBlock
{
    MKNetworkOperation *op = [self operationWithPath:apiPath params:params httpMethod:@"POST"];
    
    for (int i = 0; i < fileDatas.count && i < fileNames.count; i++)
    {
        [op addData:[fileDatas objectAtIndex:i] forKey:[fileNames objectAtIndex:i]];
    }
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        if (completionBlock != nil)
        {
            completionBlock(completedOperation, nil);
        }

    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        if (completionBlock != nil)
        {
            completionBlock(nil, error);
        }
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

- (MKNetworkOperation *)postFileTo:(NSString *)apiPath
                        withParams:(NSDictionary *)params
                         withFiles:(NSArray *)fileDatas
                          andNames:(NSArray *)fileNames
          withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
               withCompletionBlock:(NetEngineComplete)completionBlock
{
    MKNetworkOperation *op = [self operationWithPath:apiPath params:params httpMethod:@"POST"];
    
    for (int i = 0; i < fileDatas.count && i < fileNames.count; i++)
    {
        [op addData:[fileDatas objectAtIndex:i] forKey:[fileNames objectAtIndex:i]];
    }
    
    if (progressBlock != nil)
    {
        [op onUploadProgressChanged:progressBlock];
    }
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        if (completionBlock != nil)
        {
            completionBlock(completedOperation, nil);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        if (completionBlock != nil)
        {
            completionBlock(nil, error);
        }
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

- (MKNetworkOperation *)postFileTo:(NSString *)apiPath
                        withParams:(NSDictionary *)params
                          withFile:(NSData *)fileData
                           andName:(NSString *)fileName
               withCompletionBlock:(NetEngineComplete)completionBlock
{
    MKNetworkOperation *op = [self operationWithPath:apiPath params:params httpMethod:@"POST"];
    
    [op addData:fileData forKey:fileName];

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {

        if (completionBlock != nil)
        {
            completionBlock(completedOperation, nil);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        if (completionBlock != nil)
        {
            completionBlock(nil, error);
        }
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

- (MKNetworkOperation *)postFileTo:(NSString *)apiPath
                        withParams:(NSDictionary *)params
                          withFile:(NSData *)fileData
                           andName:(NSString *)fileName
          withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
               withCompletionBlock:(NetEngineComplete)completionBlock
{
    return [self postFileTo:apiPath
                 withParams:params
                   withFile:fileData
                    andName:fileName
                       type:@"file"
   withProgressChangedBlock:progressBlock
        withCompletionBlock:completionBlock];
}

- (MKNetworkOperation *)postFileTo:(NSString*)apiPath
                        withParams:(NSDictionary *)params
                          withFile:(NSData*)fileData
                           andName:(NSString*)fileName
                              type:(NSString*)type
          withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
               withCompletionBlock:(NetEngineComplete)completionBlock
{
    MKNetworkOperation *op = [self operationWithPath:apiPath params:params httpMethod:@"POST"];

    [op addData:fileData
         forKey:fileName
       mimeType:@"application/octet-stream"
       fileName:[NSString stringWithFormat:@"%@.%@", fileName, type]];
    
    if (progressBlock != nil)
    {
        [op onUploadProgressChanged:progressBlock];
    }
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        if (completionBlock != nil)
        {
            completionBlock(completedOperation, nil);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        if (completionBlock != nil)
        {
            completionBlock(nil, error);
        }
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

- (MKNetworkOperation*)downloadFileFrom:(NSString*)fileUrl
                               saveName:(NSString*)fileName
                            toDirectory:(NSString*)directory
                      continualTransfer:(BOOL)continual
               withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
                    withCompletionBlock:(NetEngineComplete)completionBlock
{
    return [self downloadFileFrom:fileUrl
                         saveName:fileName
                      toDirectory:directory
              searchPathDirectory:NSCachesDirectory
                continualTransfer:continual
         withProgressChangedBlock:progressBlock
              withCompletionBlock:completionBlock];
}

- (MKNetworkOperation*)downloadFileFrom:(NSString*)fileUrl
                               saveName:(NSString*)fileName
                            toDirectory:(NSString*)directory
                    searchPathDirectory:(NSSearchPathDirectory)searchPathDirectory
                      continualTransfer:(BOOL)continual
               withProgressChangedBlock:(NetEngineProgressChanged)progressBlock
                    withCompletionBlock:(NetEngineComplete)completionBlock;
{
    // 获取文件下载后保存路径
    NSArray* paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES);
    NSString* cachesDirectory = [paths firstObject];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    // 目录不存在->创建目录
    cachesDirectory = [cachesDirectory stringByAppendingPathComponent:directory];
    if (cachesDirectory == nil)
    {
        if (completionBlock != nil)
        {
            NSError* error = [NSError errorWithDomain:@"文件保存目录不存在..." code:-8 userInfo:nil];
            completionBlock(nil, error);
        }
        return nil;
    }
    
    if ([fileManager fileExistsAtPath:cachesDirectory] == NO)
    {
        NSError* error = nil;
        [fileManager createDirectoryAtPath:cachesDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error != nil)
        {
            if (completionBlock != nil)
            {
                NSError* error = [NSError errorWithDomain:@"文件保存目录创建失败..." code:-9 userInfo:nil];
                completionBlock(nil, error);
            }
            return nil;
        }
    }
    
    NSString* downloadPath = [cachesDirectory stringByAppendingPathComponent:fileName];

    // 下载路径生成失败
    if (downloadPath == nil)
    {
        if (completionBlock != nil)
        {
            NSError* error = [NSError errorWithDomain:@"文件保存路径错误..." code:-10 userInfo:nil];
            completionBlock(nil, error);
        }
        return nil;
    }
    
    // 1.文件存在 && 需要断点续传
    // 2.进行断点续传
    NSMutableDictionary* newHeadersDict = [NSMutableDictionary dictionary];
    if (continual && [fileManager fileExistsAtPath:downloadPath])
    {
        NSError* error = nil;
        unsigned long long fileSize = [[fileManager attributesOfItemAtPath:downloadPath error:&error] fileSize];
        
        // 成功获取文件大小->设置下载区域信息
        if (error == nil)
        {
            NSString* headerRange = [NSString stringWithFormat:@"bytes=%llu-", fileSize];
            [newHeadersDict setObject:headerRange forKey:@"Range"];
        }
        else
        {
            continual = NO;
        }
    }
    
    MKNetworkOperation* operation = [self operationWithURLString:fileUrl];
    
    [operation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:downloadPath append:continual]];
    [operation addHeaders:newHeadersDict];
    [operation setCustomObject:downloadPath];
    
    if (progressBlock != nil)
    {
        [operation onDownloadProgressChanged:progressBlock];
    }

    [operation addCompletionHandler:^(MKNetworkOperation* completedRequest) {
        
        if (completionBlock != nil)
        {
            completionBlock(completedRequest, nil);
        }
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error){
         
        if (completionBlock != nil)
        {
            completionBlock(nil, error);
        }
    }];
    
    [self enqueueOperation:operation];
    
    return operation;
}

@end
