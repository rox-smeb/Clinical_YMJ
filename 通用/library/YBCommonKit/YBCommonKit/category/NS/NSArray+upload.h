//
//  NSArray+upload.h
//  果动校园
//
//  Created by AnYanbo on 15/4/19.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (upload)

- (BOOL)selectedAssetsDatas:(NSMutableArray**)datas Names:(NSMutableArray**)names;
- (BOOL)selectedAssetsDatas:(NSMutableArray**)datas Names:(NSMutableArray**)names URLs:(NSMutableArray**)urls;

@end
