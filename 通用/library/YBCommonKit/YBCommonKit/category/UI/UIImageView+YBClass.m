//

//  UIImageEx.m
//  果动校园
//
//  Created by AnYanbo on 15/1/12.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "UIImageView+YBClass.h"

@implementation UIImageView (YBClass)

- (void)circleImage
{
    CGRect frame = self.frame;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = frame.size.width / 2.0;
    
    [self setContentMode:UIViewContentModeScaleAspectFill];
    [self setClipsToBounds:YES];
    
    [self setNeedsDisplay];
}

@end
