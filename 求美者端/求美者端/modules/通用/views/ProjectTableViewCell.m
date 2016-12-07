//
//  ProjectTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/12/7.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ProjectTableViewCell.h"

@interface ProjectTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end

@implementation ProjectTableViewCell

+ (CGFloat)height
{
    return 165.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setupWithProjectInfo:(GetProjectListInfo*)getInfo
{
    @try
    {
        self.title.text = getInfo.title;
        self.subTitle.text = getInfo.subTitle;
        self.number.text = [NSString stringWithFormat:@"%ld人已经预约", (long)[getInfo.number integerValue]];
        
        if ([getInfo.priceStyle isEqualToString:@"0"])
        {
            self.price.text = [NSString stringWithFormat:@"¥%.2f", [getInfo.price floatValue]];
        }
        else
        {
            self.price.text = [NSString stringWithFormat:@"¥%.2f起", [getInfo.minPrice floatValue]];
        }
    }
    @catch (NSException *exception)
    {
        
    }
}

@end
