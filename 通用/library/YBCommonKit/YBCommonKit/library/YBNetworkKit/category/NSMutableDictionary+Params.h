//
//  NSMutableDictionary+Params.h
//  昆明团购
//
//  Created by AnYanbo on 15/5/13.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadDataInfo : NSObject

@property (nonatomic, strong) NSData* data;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* type;

@end

@interface NSMutableDictionary (Params)
{
    
}

@property (nonatomic, strong) NSMutableArray* uploadDatas;                       // 上传的数据列表

- (void)setMethod:(NSString*)method;
- (void)addParam:(id)param forKey:(id<NSCopying>)key;
- (void)addUploadData:(NSData*)data named:(NSString*)named;
- (void)addUploadData:(NSData*)data named:(NSString*)named type:(NSString*)type;
- (void)clearUploadData;

@end
