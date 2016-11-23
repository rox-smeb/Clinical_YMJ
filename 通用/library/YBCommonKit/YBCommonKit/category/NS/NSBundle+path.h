//
//  NSBundle+path.h
//  果动校园
//
//  Created by AnYanbo on 15/4/11.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (path)

- (NSString*)documentsPath;
- (NSString*)tmpPath;
- (NSString*)cachePath;

@end
