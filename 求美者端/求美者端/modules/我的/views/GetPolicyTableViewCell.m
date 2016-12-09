//
//  GetPolicyTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "GetPolicyTableViewCell.h"

@interface GetPolicyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *doctor;
@property (weak, nonatomic) IBOutlet UILabel *project;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation GetPolicyTableViewCell

+ (CGFloat)height
{
    return 120.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setupWithGetPolicyInfo:(GetPolicyListInfo *)info
{
    @try
    {
        self.project.text=info.project;
        self.price.text=[NSString stringWithFormat:@"%.2f¥", [info.price floatValue]];
        self.doctor.text=info.doctor;
        self.date.text=info.date;
    }
    @catch (NSException *exception)
    {
        
    }

}

@end
