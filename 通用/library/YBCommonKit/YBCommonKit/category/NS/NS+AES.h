//
//  Common.h
//  iMessageSenderConsole
//
//  Created by AnYanbo on 14-3-25.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSDataAddtionAES)

// AES
- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;

@end

@interface NSString (NSStringAddtionAES)

// AES
- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;

@end