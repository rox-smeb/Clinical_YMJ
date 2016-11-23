//
//  YBNetworkKit.h
//  YBCommonKit
//
//  Created by AnYanbo on 16/6/17.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//
//  Version : 1.2
//

#ifndef YBNetworkKit_h
#define YBNetworkKit_h

#import "YBNetworkEngine.h"
#import "YBServerInteraction.h"
#import "NSMutableDictionary+Params.h"

#define YB_RESPONSE_BLOCK(block)                   YBResponseBlock block = ^(YBServerResponse *response, id dataOrList)
#define YB_RESPONSE_BLOCK_EX(block, type)          YBResponseBlock block = ^(YBServerResponse *response, type dataOrList)

#endif /* YBNetworkKit_h */
