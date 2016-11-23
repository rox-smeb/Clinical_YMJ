//
//  NSMutableArray+InsertArray.h
//  果动校园
//
//  Created by AnYanbo on 15/3/27.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^DuplicateBlock)(id obj1, id obj2);

@interface NSArray (InsertArray)

@property (nonatomic, assign) BOOL isCached;

- (BOOL)frontInsertArray:(NSArray *)newAdditions;
- (BOOL)backInsertArray:(NSArray*)newAdditions;

@end

@interface NSMutableArray (InsertArray)

- (void)removeFirstObject;
- (BOOL)frontInsertArray:(NSArray *)newAdditions;
- (BOOL)backInsertArray:(NSArray*)newAdditions;
- (BOOL)frontInsertArray:(NSArray *)newAdditions cache:(BOOL)cache;
- (BOOL)backInsertArray:(NSArray *)newAdditions cache:(BOOL)cache;
- (BOOL)insertArray:(NSArray *)newAdditions atIndex:(NSUInteger)index;

@end
