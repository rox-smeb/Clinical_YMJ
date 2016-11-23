//
//  NSString+Chinese2Pinyin.h
//  PinYin4ObjcExample
//
//  Created by apple on 14-6-12.
//  Copyright (c) 2014年 kimziv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PinYin4Objc.h"

@interface NSString (Chinese2PinYin)

-(NSString *) toPinYin ;
+(NSString *) chinese2PinYin:(NSString*) nsChineseString;
+(NSString *) chinese2PinYin:(NSString*) nsChineseString withSplit:(NSString*)split;

@end
