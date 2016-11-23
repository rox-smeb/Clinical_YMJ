//
//  MirrorServerInteraction.h
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <YBCommonKit/YBCommonKit.h>

@interface MirrorServerInteraction : YBServerInteraction

+ (MirrorServerInteraction*)sharedInstance;

#pragma mark - 委托担保预订单

/**
 *  委托担保预订单
 *
 *  @param nationsName   国家名
 *  @param uid           uid
 *  @param ukey          ukey
 *  @param project       手术项目
 *  @param doctor        医生
 *  @param doctorPhone   医生电话
 *  @param agency        医疗机构
 *  @param agencyPerson  医疗机构联系人
 *  @param agencyPhone   医疗机构联系电话
 *  @param price         手术金额
 *  @param userName      患者姓名
 *  @param responseBlock 成功回调
 */
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
                                  responseBlock:(YBResponseBlock)responseBlock;

#pragma mark - 纠纷调节

/**
 *  纠纷调节
 *
 *  @param country        国家
 *  @param uid            uid
 *  @param ukey           ukey
 *  @param applyName      申请方名称
 *  @param address        申请方地址
 *  @param legalPerson    法人
 *  @param contact        联系方式
 *  @param bApplyName     被申请方名称
 *  @param bAddress       被申请方地址
 *  @param bLegalPerson   被申请方法人
 *  @param bContact       被申请方联系方式
 *  @param requestContent 调节请求
 *  @param reasonContent  事实与理由
 *  @param fileList       上传图片
 *  @param progressBlock  上传进度回调
 *  @param responseBlock  成功回调
 */
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
                    responseBlock:(YBResponseBlock)responseBlock;
//申请会诊
-(void)applyConsultationWithCountry:(NSString*)country
                                uid:(NSString*)uid
                               ukey:(NSString*)ukey
                            content:(NSString*)content
                         doctorList:(NSString*)doctorList
                           fileList:(NSArray<UIImage*>*)fileList
                      progressBlock:(ProgressUpdateBlock)progressBlock
                      responseBlock:(YBResponseBlock)responseBlock;
//申请公益会诊
-(void)publicWelfareConsultationWithCountry:(NSString*)country
                                        uid:(NSString*)uid
                                       ukey:(NSString*)ukey
                                    content:(NSString*)content
                                   fileList:(NSArray<UIImage*>*)fileList
                              progressBlock:(ProgressUpdateBlock)progressBlock
                              responseBlock:(YBResponseBlock)responseBlock;

@end
