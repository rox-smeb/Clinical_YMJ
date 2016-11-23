//
//  DataManager.m
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/6/22.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()

@end

@implementation DataManager

static DataManager *SINGLETON = nil;

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

@end
