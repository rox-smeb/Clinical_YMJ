//
//  ImageAddCollectionViewCell.m
//  果动校园
//
//  Created by AnYanbo on 15/4/19.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "ImageAddCollectionViewCell.h"

@interface ImageAddCollectionViewCell ()

@property (strong, nonatomic) id asset;
@property (strong, nonatomic) NSIndexPath* indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation ImageAddCollectionViewCell

+ (CGSize)sizeWithWidth:(CGFloat)width
{
    return CGSizeMake(width, width);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setupWithRes:(id)res indexPath:(NSIndexPath*)indexPath
{
    self.asset = res;
    self.indexPath = indexPath;
    
    if (res == nil)
    {
        self.imageView.image = [UIImage imageNamed:@"添加图片按钮"];
        self.deleteButton.hidden = YES;
    }
    else if ([res isKindOfClass:[ALAsset class]])            // ALAsset资源
    {
        ALAsset* asset = (ALAsset*)res;
        if (asset.thumbnail != nil)
        {
            self.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
            self.deleteButton.hidden = NO;
        }
        else
        {
            self.imageView.image = [UIImage imageNamed:@"添加图片按钮"];
            self.deleteButton.hidden = YES;
        }
    }
    else if ([res isKindOfClass:[UIImage class]])           // UIImage资源
    {
        UIImage* image = (UIImage*)res;
        self.imageView.image = image;
        self.deleteButton.hidden = NO;
    }
    else if ([res isKindOfClass:[NSString class]])          // NSString URL资源
    {
        NSURL* url = [NSURL URLWithString:(NSString*)res];
        __weak typeof (self) weakSelf = self;
        [self.imageView sd_setImageWithURL:url
                          placeholderImage:DEFAULT_IMAGE
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     weakSelf.deleteButton.hidden = NO;
                                 }];
    }
    else if ([res isKindOfClass:[NSURL class]])             // NSURL资源
    {
        NSURL* url = (NSURL*)res;
        __weak typeof (self) weakSelf = self;
        [self.imageView sd_setImageWithURL:url
                          placeholderImage:DEFAULT_IMAGE
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     weakSelf.deleteButton.hidden = NO;
                                 }];
    }
}

- (IBAction)onDeleteImage:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(imageAddCell:didDeleteAtIndexPath:withAsset:)])
    {
        [self.delegate imageAddCell:self didDeleteAtIndexPath:self.indexPath withAsset:self.asset];
    }
}

@end
