//
//  TabBarCenterView.m
//  求美者端
//
//  Created by AnYanbo on 16/8/10.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "TabBarCenterView.h"

@interface TabBarCenterView ()

@property (weak, nonatomic) IBOutlet UIView *colorBK;
@property (weak, nonatomic) IBOutlet UIView *centerItemBK;
@property (weak, nonatomic) IBOutlet UIView *shadowLine;
@property (weak, nonatomic) IBOutlet UIImageView *centerItem;

@end

@implementation TabBarCenterView

+ (instancetype)addToTabbar:(UITabBar*)tabbar
{
    TabBarCenterView* centerView = [TabBarCenterView create];
    [tabbar insertSubview:centerView atIndex:0];
    [centerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    return centerView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.centerItemBK.backgroundColor = self.colorBK.backgroundColor;
    self.centerItemBK.layer.borderWidth = 1.0f;
    self.centerItemBK.layer.borderColor = RGB(220, 220, 220).CGColor;
    self.centerItemBK.layer.cornerRadius = self.centerItemBK.width * 0.5f;
}

@end
