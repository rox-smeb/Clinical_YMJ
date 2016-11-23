//
//  UIView+3DEffect.h
//  YBCommonKit
//
//  Created by AnYanbo on 16/6/14.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIView_3DEffect)

- (void)threeDimensional;
- (void)threeDimensionalShadowOffset:(CGSize)offset
                        shadowRadius:(CGFloat)radius
                         shadowColor:(UIColor*)color
                        shaowOpacity:(CGFloat)opacity;
@end
