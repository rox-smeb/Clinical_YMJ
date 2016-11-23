//
//  UIView+3DEffect.m
//  YBCommonKit
//
//  Created by AnYanbo on 16/6/14.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "UIView+3DEffect.h"

@implementation UIView (UIView_3DEffect)

- (void)threeDimensional
{
    [self threeDimensionalShadowOffset:CGSizeMake(0, 2)
                          shadowRadius:2
                           shadowColor:[UIColor blackColor]
                          shaowOpacity:0.7];
}

- (void)threeDimensionalShadowOffset:(CGSize)offset
                        shadowRadius:(CGFloat)radius
                         shadowColor:(UIColor*)color
                        shaowOpacity:(CGFloat)opacity
{
    self.layer.shadowOffset  = offset;
    self.layer.shadowRadius  = radius;
    self.layer.shadowColor   = color.CGColor;
    self.layer.shadowOpacity = opacity;
}

@end
