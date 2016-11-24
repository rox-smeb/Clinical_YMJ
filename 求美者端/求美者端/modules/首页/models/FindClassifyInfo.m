//
//  FindClassifyInfo.m
//  求美者端
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "FindClassifyInfo.h"
@implementation ClassifyChildInfo

@end
@implementation FindClassifyInfo
- (NSDictionary*)objectPropertys
{
    return @{@"cList" : [ClassifyChildInfo class]};
}
@end
