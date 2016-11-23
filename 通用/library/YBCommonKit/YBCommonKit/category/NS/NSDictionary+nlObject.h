//
//  NSDictionary+nlObject.h
//  昆明团购
//
//  Created by AnYanbo on 15/5/18.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (nlObject)

- (id)nlObjectForKey:(NSString*)key;
- (NSString*)strObjectForKey:(NSString*)key;
- (BOOL)boolForKey:(NSString*)key;

@end
