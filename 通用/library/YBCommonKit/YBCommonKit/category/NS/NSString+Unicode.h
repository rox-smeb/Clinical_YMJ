//
//  NSString+Unicode.h
//  昆明团购
//
//  Created by AnYanbo on 15/5/14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Unicode)

- (NSString*)unicode2utf8;
- (NSString*)urlUnicode2utf8;

- (NSString*)urlDecode;
- (NSString*)urlEncode;

@end
