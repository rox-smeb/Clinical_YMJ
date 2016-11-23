//
//  AYBAssetsCollectionViewCell.m
//  果动校园
//
//  Created by AnYanbo on 15/2/6.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "AYBAssetsCollectionViewCell.h"

@implementation AYBAssetsCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        if (self.selected)
        {
            self.shadeView.hidden = NO;
        }
        else
        {
            self.shadeView.hidden = YES;
        }
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)applyData:(ALAsset *)asset
{
    self.asset           = asset;
    self.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
//    self.type   = [asset valueForProperty:ALAssetPropertyType];
//    self.title  = [UzysAssetsViewCell getTimeStringOfTimeInterval:[[asset valueForProperty:ALAssetPropertyDuration] doubleValue]];
}

- (void)setSelected:(BOOL)selected
{
    static UIImage* selectedIcon   = nil;
    static UIImage* unselectedIcon = nil;
    
    [super setSelected:selected];
    [self setNeedsDisplay];
    
    if (selected)
    {
        // 缩小动画
        [UIView animateWithDuration:0.1
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn |UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.transform = CGAffineTransformMakeScale(0.97, 0.97);
                         }
                         completion:^(BOOL finished){
                             // 恢复原始状态
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  self.transform = CGAffineTransformIdentity;
                                              }
                                              completion:^(BOOL finished) {
                
                                              }];
                         }];
        
        // 设置选择图标
        if (selectedIcon == nil)
        {
            selectedIcon = [UIImage imageNamed:@"AYBMediaPicker_ico_photo_thumb_check"];
        }
        self.selectedIcon.image = selectedIcon;
        
        // 显示遮罩View
        self.shadeView.hidden = NO;
    }
    else
    {
        // 放大动画
        [UIView animateWithDuration:0.1
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.transform = CGAffineTransformMakeScale(1.03, 1.03);
                         }
                         completion:^(BOOL finished){
                             // 恢复原始装填
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  self.transform = CGAffineTransformIdentity;
                                              }
                                              completion:^(BOOL finished) {
                
                                              }];
                         }];
        
        // 设置未选择图标
        if (unselectedIcon == nil)
        {
            unselectedIcon = [UIImage imageNamed:@"AYBMediaPicker_ico_photo_thumb_uncheck"];
        }
        self.selectedIcon.image = unselectedIcon;
        
        // 隐藏遮罩View
        self.shadeView.hidden = YES;
    }
}

@end
