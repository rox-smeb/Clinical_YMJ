//
//  UUDatePicker_DateModel.h
//
//  Created by shake on 14-9-17.
//  Modifyed by AnYanbo on 15/2/6.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUDatePicker_DateModel : NSObject
{
    
}

@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *minute;

- (id)initWithDate:(NSDate *)date;

@end
