//
//  CommonInfo.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "CommonInfo.h"

@implementation ProvinceInfo

#pragma mark - MultiSelectListDataSourceProtocol

- (NSString*)name
{
    return self.pName;
}


@end


@implementation CommonInfo

- (NSDictionary*)objectPropertys
{
    return @{@"province" : [ProvinceInfo class]};
}

#pragma mark - MultiSelectListDataSourceProtocol

- (NSString*)name
{
    return self.cname;
}

- (NSArray<id<SelectModelProtocol>>*)subList
{
    return self.province;
}


@end
