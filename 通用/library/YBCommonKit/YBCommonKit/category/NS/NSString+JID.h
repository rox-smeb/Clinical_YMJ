//
//  NSString+JID.h
//  EnjoyDQ
//
//  Created by AnYanbo on 14-6-26.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JID)

+ (NSString*)deviceTokenWithData:(NSData*)data;
- (NSString*)stringWithOutJID;
- (NSString*)stringWithJID;

@end
