//
//  ImageAddCollectionViewCell.h
//  果动校园
//
//  Created by AnYanbo on 15/4/19.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageAddCollectionViewCell;

@protocol ImageAddCollectionViewCellDelegate <NSObject>

- (void)imageAddCell:(ImageAddCollectionViewCell*)cell
didDeleteAtIndexPath:(NSIndexPath*)indexPath
           withAsset:(id)asset;

@end

@interface ImageAddCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<ImageAddCollectionViewCellDelegate> delegate;

+ (CGSize)sizeWithWidth:(CGFloat)width;
- (void)setupWithRes:(id)res indexPath:(NSIndexPath*)indexPath;

@end
