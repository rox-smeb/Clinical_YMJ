//
//  DoctorServerInteraction.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "DoctorServerInteraction.h"

@implementation DoctorServerInteraction

static DoctorServerInteraction *SINGLETON = nil;

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

#pragma mark - 验医生

- (void)verifyDoctorWithProvinceId:(NSString*)provinceId
                              name:(NSString*)name
                           address:(NSString*)address
                     responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:provinceId forKey:@"provinceId"];
    [param addParam:name forKey:@"name"];
    [param addParam:address forKey:@"address"];
    
    [self invokeApi:[AppURL URLWithPath:@"Doctor" method:@"verifyDoctor"]
             method:POST
             params:param
      infoMakeBlock:^id(YBServerResponseInfo *info, BOOL *ret) {
          NSString* url = [info.data objectForKey:@"webUrl"];
          return url;
      } responseBlock:responseBlock];

}


@end
