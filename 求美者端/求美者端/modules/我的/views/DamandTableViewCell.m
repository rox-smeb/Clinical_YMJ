//
//  DamandTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "DamandTableViewCell.h"

@interface DamandTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *url;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *project;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *stateName;

@end

@implementation DamandTableViewCell

+ (CGFloat)height
{
    return 120.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cancelBtn.layer.cornerRadius = 4.0f;
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.cancelBtn.layer.borderWidth = 1.0f;
    
    [self.url.layer setMasksToBounds:YES];
    [self.url.layer setCornerRadius:40];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setupWithDemandInfo:(MyDemandInfo *)info
{
    @try
    {
        self.date.text=info.date;
        self.project.text=info.project;
        self.endDate.text=info.endDate;
        self.content.text=info.content;
        self.stateName.text=info.stateName;
    }
    @catch (NSException *exception)
    {
        
    }
}

#pragma mark - 撤销按钮响应
- (IBAction)cancelBtnClicked:(UIButton *)sender {
}

@end
