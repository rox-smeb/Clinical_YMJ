//
//  GarageAbilityItemCollectionViewCell.m
//  车联网-车主端
//
//  Created by AnYanbo on 16/7/26.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "GarageAbilityItemCollectionViewCell.h"

@interface GarageAbilityItemCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GarageAbilityItemCollectionViewCell

+ (CGFloat)height
{
    return 95.0f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //self.bkView.layer.cornerRadius = 5.0f;
}

- (void)setupWithText:(NSString*)text
{
    self.nameLabel.text = text;
}

- (void)setImageViewWithImage:(NSString *)image
{
    [self.imageView setImage:[UIImage imageNamed:image]];
}

@end
