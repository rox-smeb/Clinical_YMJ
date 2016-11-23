//
//  CommonSelectTableSectionHeader.m
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/7/4.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "CommonSelectTableSectionHeader.h"

@interface CommonSelectTableSectionHeader ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation CommonSelectTableSectionHeader

+ (CGFloat)height
{
    return 30.0f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setupWithName:(NSString*)name
{
    self.name.text = name;
}

@end
