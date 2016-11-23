//
//  VideoTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/11/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "VideoTableViewCell.h"

@interface VideoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;

@end

@implementation VideoTableViewCell

+ (CGFloat)height
{
    return 250.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    _videoImage.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _videoImage.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _videoImage.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    _videoImage.layer.shadowRadius = 4;//阴影半径，默认3

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
