//
//  NSString+CaclSize.h
//  果动校园
//
//  Created by AnYanbo on 15/3/17.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CaclSize)

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font lineBreakMode:(NSLineBreakMode)mode;

@end
