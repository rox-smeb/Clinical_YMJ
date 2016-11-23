//
//  UITextField+Utility.m
//  昆明团购
//
//  Created by AnYanbo on 15/6/18.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "UITextField+Utility.h"

@implementation UITextField (Utility)

- (void)setPlaceholderColor:(UIColor*)color
{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

@end
