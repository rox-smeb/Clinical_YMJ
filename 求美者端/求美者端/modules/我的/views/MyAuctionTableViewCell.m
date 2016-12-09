//
//  MyAuctionTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MyAuctionTableViewCell.h"

@interface MyAuctionTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *project;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *CurrentPrice;
@property (weak, nonatomic) IBOutlet UILabel *releaseDoctor;

@end

@implementation MyAuctionTableViewCell

+ (CGFloat)height
{
    return 100.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setupWithAuctionInfo:(MyAuctionInfo *)info
{
    @try
    {
        self.project.text=info.project;
        self.price.text=[NSString stringWithFormat:@"%.2f¥", [info.price floatValue]];
        self.CurrentPrice.text=[NSString stringWithFormat:@"%.2f¥", [info.CurrentPrice floatValue]];
        self.releaseDoctor.text=info.releaseDoctor;
    }
    @catch (NSException *exception)
    {
        
    }
}

@end
