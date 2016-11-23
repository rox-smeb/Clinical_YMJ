//
//  VerDoctorFooterView.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "VerDoctorFooterView.h"

@implementation VerDoctorFooterView

+ (CGFloat)height
{
    return 45.0f;
}

+ (instancetype)create
{
    NSString* name = NSStringFromClass([VerDoctorFooterView class]);
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
    return [nib firstObject];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}
@end
