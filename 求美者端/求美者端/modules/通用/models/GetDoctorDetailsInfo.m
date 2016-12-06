//
//  GetDoctorDetailsInfo.m
//  求美者端
//
//  Created by Smeb on 2016/12/6.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "GetDoctorDetailsInfo.h"

@implementation GetCaseListListInfo


@end

@implementation GetProjectListInfo


@end

@implementation GetRecommendListInfo


@end

@implementation GetDoctorDetailsInfo

- (NSDictionary*)objectPropertys
{
    return @{@"recommendList" : [GetRecommendListInfo class],
             @"projectList" : [GetProjectListInfo class],
             @"caseList" : [GetCaseListListInfo class]};
}

@end
