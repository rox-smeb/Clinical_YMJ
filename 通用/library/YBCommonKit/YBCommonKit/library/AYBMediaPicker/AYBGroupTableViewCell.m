//
//  AYBGroupTableViewCell.m
//  果动校园
//
//  Created by AnYanbo on 15/2/10.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "AYBGroupTableViewCell.h"

#define kThumbnailLength                        (80.0f)

@implementation AYBGroupTableViewCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        self.accessoryView.hidden = NO;
    }
    else
    {
        self.accessoryView.hidden = YES;
    }
}

- (void)applyData:(ALAssetsGroup *)assetsGroup
{
    self.assetsGroup           = assetsGroup;

    CGImageRef posterImage     = assetsGroup.posterImage;
    size_t height              = CGImageGetHeight(posterImage);
    float scale                = height / kThumbnailLength;

    self.assetsImageView.image = [UIImage imageWithCGImage:posterImage scale:scale orientation:UIImageOrientationUp];
    self.assetsNameLabel.text  = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.assetsCountLabel.text = [NSString stringWithFormat:@"%ld", (long)[assetsGroup numberOfAssets]];
}

@end
