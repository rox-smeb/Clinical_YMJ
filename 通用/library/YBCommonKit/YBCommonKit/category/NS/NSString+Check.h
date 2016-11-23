//
//  NSStringx.h
//  果动校园
//
//  Created by AnYanbo on 15/3/3.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

- (BOOL)onlySpace;

- (BOOL)isIntValue;
- (BOOL)isFloatValue;
- (BOOL)isMobileNumber;
- (BOOL)isAvailability;
- (NSString*)encryptMobileWithString:(NSString*)str;

@end
