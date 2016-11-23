//
//  DoActionSheet+Demo.m
//  TestActionSheet
//
//  Created by Jack Shi on 13/06/2014.
//  Copyright (c) 2014 Dono Air. All rights reserved.
//

#import "DoActionSheet+Demo.h"

@implementation DoActionSheet (Demo)

- (id)init
{
    self = [super init];
    if (self)
    {
        // set default style
        [self setDefaultStyle];
    }
    return self;
}

- (void)setDefaultStyle
{
    [self setStyle1];
}

- (void)setStyle1
{
    // 标题颜色
    self.doTitleTextColor         = DO_RGB(80, 80, 80);
    
    // 按钮背景
    self.doButtonColor            = DO_RGB(240, 102, 18);
    self.doCancelColor            = DO_RGB(250, 250, 250);
    self.doDestructiveColor       = DO_RGB(102, 152, 160);

    // 按钮文字颜色
    self.doButtonTextColor        = DO_RGB(255, 255, 255);
    self.doCancelTextColor        = DO_RGB(80, 80, 80);
    self.doDestructiveTextColor   = DO_RGB(255, 255, 255);

    // 按钮边框颜色
//    self.doButtonBorderColor      = DO_RGB(240, 102, 18);
    self.doCancelBorderColor      = DO_RGB(180, 180, 180);
//    self.doDestructiveBorderColor = DO_RGB(240, 102, 18);

    // 遮罩颜色
    self.doDimmedColor            = DO_RGBA(0, 0, 0, 0.7);

    // 背景颜色
    self.doBackColor              = DO_RGB(235, 235, 235);
    
    // 按钮文字字体
    self.doTitleFont              = [UIFont systemFontOfSize:14];
    self.doButtonFont             = [UIFont systemFontOfSize:15];
    self.doCancelFont             = [UIFont systemFontOfSize:15];

    // 偏移
    self.doTitleInset             = UIEdgeInsetsMake(8, 20, 10, 20);
    self.doButtonInset            = UIEdgeInsetsMake(5, 20, 8, 20);

    // 按钮高度
    self.doButtonHeight           = 40.0f;
    
    // 按钮圆角
    self.dButtonRound             = 4.0f;
}

- (void)setStyle2
{
    self.doBackColor = DO_RGBA(255, 255, 255, 0);
    self.doButtonColor = DO_RGB(113, 208, 243);
    self.doCancelColor = DO_RGB(73, 168, 203);
    self.doDestructiveColor = DO_RGB(235, 15, 93);
    
    self.doTitleTextColor = DO_RGB(209, 247, 247);
    self.doButtonTextColor = DO_RGB(255, 255, 255);
    self.doCancelTextColor = DO_RGB(255, 255, 255);
    self.doDestructiveTextColor = DO_RGB(255, 255, 255);
}

- (void)setStyle3
{
    self.doBackColor = [UIColor clearColor];
    self.doButtonColor = [UIColor whiteColor];
    self.doCancelColor = [UIColor whiteColor];
    self.doDestructiveColor = [UIColor redColor];
    
    self.doTitleTextColor = [UIColor grayColor];
    self.doButtonTextColor = [UIColor purpleColor];
    self.doCancelTextColor = [UIColor orangeColor];
    self.doDestructiveTextColor = [UIColor whiteColor];
    
    self.doTitleFont = [UIFont systemFontOfSize:18];
    self.doButtonFont = [UIFont systemFontOfSize:18];
    self.doCancelFont = [UIFont systemFontOfSize:18];
    self.doButtonHeight = 44.0f;
}

@end
