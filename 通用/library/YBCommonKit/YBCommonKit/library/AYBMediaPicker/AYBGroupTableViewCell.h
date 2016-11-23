//
//  AYBGroupTableViewCell.h
//  果动校园
//
//  Created by AnYanbo on 15/2/10.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AYBGroupTableViewCell : UITableViewCell
{
    
}

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@property (weak, nonatomic) IBOutlet UIImageView *assetsImageView;
@property (weak, nonatomic) IBOutlet UILabel *assetsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *assetsCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImageView;

- (void)applyData:(ALAsset *)asset;

@end
