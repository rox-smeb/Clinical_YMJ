//
//  UUDatePicker_DateModel.m
//
//  Created by shake on 14-9-17.
//  Modifyed by AnYanbo on 15/2/6.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUDatePicker_DateModel.h"

@implementation UUDatePicker_DateModel

- (id)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self)
    {
        NSString* s = [date toStringWithFormat:@"yyyyMMddHHmm"];

        self.year   = [s substringWithRange:NSMakeRange(0, 4)];
        self.month  = [s substringWithRange:NSMakeRange(4, 2)];
        self.day    = [s substringWithRange:NSMakeRange(6, 2)];
        self.hour   = [s substringWithRange:NSMakeRange(8, 2)];
        self.minute = [s substringWithRange:NSMakeRange(10, 2)];
    }
    return self;
}

@end
