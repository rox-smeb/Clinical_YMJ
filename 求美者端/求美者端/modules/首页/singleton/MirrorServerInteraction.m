//
//  MirrorServerInteraction.m
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MirrorServerInteraction.h"

@implementation MirrorServerInteraction

static MirrorServerInteraction *SINGLETON = nil;

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

#pragma mark - 委托担保预订单

- (void)authorizedGuaranteeOrderWithNationsName:(NSString*)nationsName
                                            uid:(NSString*)uid
                                           ukey:(NSString*)ukey
                                        project:(NSString*)project
                                         doctor:(NSString*)doctor
                                    doctorPhone:(NSString*)doctorPhone
                                         agency:(NSString*)agency
                                   agencyPerson:(NSString*)agencyPerson
                                    agencyPhone:(NSString*)agencyPhone
                                          price:(NSString*)price
                                       userName:(NSString*)userName
                                  responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:nationsName forKey:@"nationsName"];
    [param addParam:project forKey:@"project"];
    [param addParam:doctor forKey:@"doctor"];
    [param addParam:doctorPhone forKey:@"doctorPhone"];
    [param addParam:agency forKey:@"agency"];
    [param addParam:agencyPerson forKey:@"agencyPerson"];
    [param addParam:agencyPhone forKey:@"agencyPhone"];
    [param addParam:price forKey:@"price"];
    [param addParam:userName forKey:@"userName"];
    
    [self invokeApi:[AppURL URLWithPath:@"Mirror" method:@"authorizedGuaranteeOrder"]
             method:POST
             params:param
      infoMakeBlock:^id(YBServerResponseInfo *info, BOOL *ret) {
          
          return info;
      }
      responseBlock:responseBlock];
}

#pragma mark - 纠纷调节

- (void)disputeResolveWithCountry:(NSString*)country
                              uid:(NSString*)uid
                             ukey:(NSString*)ukey
                        applyName:(NSString*)applyName
                          address:(NSString*)address
                      legalPerson:(NSString*)legalPerson
                          contact:(NSString*)contact
                       bApplyName:(NSString*)bApplyName
                         bAddress:(NSString*)bAddress
                     bLegalPerson:(NSString*)bLegalPerson
                         bContact:(NSString*)bContact
                   requestContent:(NSString*)requestContent
                    reasonContent:(NSString*)reasonContent
                         fileList:(NSArray<UIImage*>*)fileList
                    progressBlock:(ProgressUpdateBlock)progressBlock
                    responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:country forKey:@"country"];
    [param addParam:applyName forKey:@"applyName"];
    [param addParam:address forKey:@"address"];
    [param addParam:legalPerson forKey:@"legalPerson"];
    [param addParam:contact forKey:@"contact"];
    [param addParam:bApplyName forKey:@"bApplyName"];
    [param addParam:bAddress forKey:@"bAddress"];
    [param addParam:bLegalPerson forKey:@"bLegalPerson"];
    [param addParam:bContact forKey:@"bContact"];
    [param addParam:requestContent forKey:@"requestContent"];
    [param addParam:reasonContent forKey:@"reasonContent"];
    
    for (UIImage* image in fileList)
    {
        if ([image isKindOfClass:[UIImage class]])
        {
            NSData* data = UIImageJPEGRepresentation(image, 0.8f);
            [param addUploadData:data named:@"file" type:@"jpeg"];
        }
    }
    
    [self invokeApi:[AppURL URLWithPath:@"Mirror" method:@"disputeResolve"]
             method:UPLOAD
             params:param
      infoMakeBlock:^id(YBServerResponseInfo *info, BOOL *ret) {
          
          return info;
      }
      progressBlock:progressBlock
      responseBlock:responseBlock];
}

#pragma mark - 申请会诊
-(void)applyConsultationWithCountry:(NSString*)country
                                uid:(NSString*)uid
                                ukey:(NSString*)ukey
                            content:(NSString*)content
                         doctorList:(NSString*)doctorList
                           fileList:(NSArray<UIImage*>*)fileList
                      progressBlock:(ProgressUpdateBlock)progressBlock
                      responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:country forKey:@"country"];
    [param addParam:content forKey:@"content"];
    [param addParam:doctorList forKey:@"doctorList"];
    for (UIImage* image in fileList)
    {
        if ([image isKindOfClass:[UIImage class]])
        {
            NSData* data = UIImageJPEGRepresentation(image, 0.8f);
            [param addUploadData:data named:@"file" type:@"jpeg"];
        }
    }
    
    [self invokeApi:[AppURL URLWithPath:@"Mirror" method:@"applyConsultation"]
             method:UPLOAD
             params:param
      infoMakeBlock:^id(YBServerResponseInfo *info, BOOL *ret) {
          
          return info;
      }
      progressBlock:progressBlock
      responseBlock:responseBlock];

}
#pragma mark - 申请公益会诊
-(void)publicWelfareConsultationWithCountry:(NSString*)country
                                uid:(NSString*)uid
                               ukey:(NSString*)ukey
                            content:(NSString*)content
                           fileList:(NSArray<UIImage*>*)fileList
                      progressBlock:(ProgressUpdateBlock)progressBlock
                      responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:country forKey:@"country"];
    [param addParam:content forKey:@"content"];
    for (UIImage* image in fileList)
    {
        if ([image isKindOfClass:[UIImage class]])
        {
            NSData* data = UIImageJPEGRepresentation(image, 0.8f);
            [param addUploadData:data named:@"file" type:@"jpeg"];
        }
    }
    
    [self invokeApi:[AppURL URLWithPath:@"Mirror" method:@"publicWelfareConsultation"]
             method:UPLOAD
             params:param
      infoMakeBlock:^id(YBServerResponseInfo *info, BOOL *ret) {
          
          return info;
      }
      progressBlock:progressBlock
      responseBlock:responseBlock];
    
}
//申请失败手术修复
-(void)applyFailRepairWithuid:(NSString*)uid
                         ukey:(NSString*)ukey
                      project:(NSString*)project
                   doctorName:(NSString*)doctorName
                  doctorPhone:(NSString*)doctorPhone
                       agency:(NSString*)agency
                      contact:(NSString*)contact
                 contactPhone:(NSString*)contactPhone
                      content:(NSString*)content
                     fileList:(NSArray<UIImage*>*)fileList
                progressBlock:(ProgressUpdateBlock)progressBlock
                responseBlock:(YBResponseBlock)responseBlock
{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param addParam:uid forKey:@"uid"];
    [param addParam:ukey forKey:@"ukey"];
    [param addParam:project forKey:@"project"];
    [param addParam:doctorName forKey:@"doctorName"];
    [param addParam:doctorPhone forKey:@"doctorName"];
    [param addParam:agency forKey:@"agency"];
    [param addParam:contact forKey:@"contact"];
    [param addParam:contactPhone forKey:@"contactPhone"];
    [param addParam:content forKey:@"content"];
    for (UIImage* image in fileList)
    {
        if ([image isKindOfClass:[UIImage class]])
        {
            NSData* data = UIImageJPEGRepresentation(image, 0.8f);
            [param addUploadData:data named:@"file" type:@"jpeg"];
        }
    }
    
    [self invokeApi:[AppURL URLWithPath:@"Mirror" method:@"applyFailRepair"]
             method:UPLOAD
             params:param
      infoMakeBlock:^id(YBServerResponseInfo *info, BOOL *ret) {
          
          return info;
      }
      progressBlock:progressBlock
      responseBlock:responseBlock];

}
@end
