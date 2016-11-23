//
//  NSString+Date.h
//  EnjoyDQ
//
//  Created by AnYanbo on 14-6-28.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

// NDate category
@interface NSDate (String)

- (NSString*)toString;
- (NSString*)toStringWithFormat:(NSString*)format;

@end

// NSString category
@interface NSString (NSDate)

- (NSString*)prettyDateString;
- (NSDate*)toDate;
- (NSDate*)toDateWithFormat:(NSString*)format;

@end
