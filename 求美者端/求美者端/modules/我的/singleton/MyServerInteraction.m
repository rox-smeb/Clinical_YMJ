//
//  MyServerInteraction.m
//  求美者端
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MyServerInteraction.h"

@implementation MyServerInteraction
static MyServerInteraction *SINGLETON = nil;

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
#pragma mark - 我的病历列表

/**
 *  我的病历列表
 *
 *  @param sort_id                  分页计数编号
 *  @param newset                   是否取最新数据
 */

-(void)myMedicalRecordListSortId:(NSString *)sort_id uid:(NSString *)uid ukey:(NSString *)ukey newset:(NSString *)newset responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:sort_id forKey:@"sort_id"];
    [param addParam:newset forKey:@"newset"];
    
    [self invokeApi:[AppURL URLWithPath:@"My" method:@"myMedicalRecordList"]
             method:GET
       responseType:RESPONSE_INFO_LIST
          itemClass:[MyMedicalRecordListInfo class]
             params:param
      responseBlock:responseBlock];
}
@end
