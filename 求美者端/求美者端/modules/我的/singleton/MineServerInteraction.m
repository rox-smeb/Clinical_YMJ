//
//  MineServerInteraction.m
//
//  Created by AnYanbo on 16/6/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MineServerInteraction.h"

@implementation MineServerInteraction

static MineServerInteraction *SINGLETON = nil;

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
