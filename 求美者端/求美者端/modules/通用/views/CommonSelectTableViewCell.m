//
//  MultiSelectTableViewCell.m
//  车联网-修理厂端
//
//  Created by AnYanbo on 16/7/4.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "CommonSelectTableViewCell.h"

@interface CommonSelectTableViewCell ()
{
    CGFloat _defaultSelectedIconHeight;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedIconHeight;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;

@end

@implementation CommonSelectTableViewCell

+ (CGFloat)height
{
    return 45.0f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _defaultSelectedIconHeight = self.selectedIconHeight.constant;
    self.selectedIconHeight.constant = 0.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (self.cellType == SECOND_LEVEL_SELECT_CELL_MAIN)
    {
        if (self.isSelected)
        {
            self.selectedIconHeight.constant = _defaultSelectedIconHeight;
        }
        else
        {
            self.selectedIconHeight.constant = 0.0f;
        }
    }
}

- (void)setupWithName:(NSString*)name
{
    self.name.text = name;
}

- (void)setCellType:(SecondLevelListViewType)cellType
{
    _cellType = cellType;
    
    if (cellType == SECOND_LEVEL_SELECT_CELL_MAIN)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.rightArrow setHighlighted:NO];
    }
    else if (cellType == SECOND_LEVEL_SELECT_CELL_SUB)
    {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self.rightArrow setHighlighted:YES];
    }
}

@end
