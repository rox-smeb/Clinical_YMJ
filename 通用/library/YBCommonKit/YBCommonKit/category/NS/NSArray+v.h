//
//  NSArray+v.h
//  昆明团购
//
//  Created by AnYanbo on 15/6/2.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (v)

@property (nonatomic, strong) NSString* v;

- (NSString*)v;
- (void)setV:(NSString*)v;
- (id)objectAtIndexEx:(NSUInteger)index;

@end

@interface NSMutableArray (v)

- (void)addObjectEx:(id)anObject;

@end
