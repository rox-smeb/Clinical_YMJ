//
//  GarageAbilityCollectionSectionHeader.m
//  车联网-车主端
//
//  Created by zm on 16/7/26.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "GarageAbilityCollectionSectionHeader.h"

@interface GarageAbilityCollectionSectionHeader ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation GarageAbilityCollectionSectionHeader

+ (CGFloat)height
{
    return 12.0f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setupWithText:(NSString*)text
{
    self.nameLabel.text = text;
}

@end
