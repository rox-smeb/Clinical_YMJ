//
//  GarageAbilityCollectionSectionHeader.h
//  车联网-车主端
//
//  Created by AnYanbo on 16/7/26.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GarageAbilityCollectionSectionHeader : UICollectionReusableView

+ (CGFloat)height;
- (void)setupWithText:(NSString*)text;

@end
