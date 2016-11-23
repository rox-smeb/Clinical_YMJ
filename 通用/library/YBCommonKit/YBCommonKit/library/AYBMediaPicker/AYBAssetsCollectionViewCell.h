//
//  AYBAssetsCollectionViewCell.h
//  果动校园
//
//  Created by AnYanbo on 15/2/6.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AYBAssetsCollectionViewCell : UICollectionViewCell
{
    
}

@property (strong, nonatomic) ALAsset* asset;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIcon;
@property (weak, nonatomic) IBOutlet UIView *shadeView;

- (void)applyData:(ALAsset *)asset;

@end
