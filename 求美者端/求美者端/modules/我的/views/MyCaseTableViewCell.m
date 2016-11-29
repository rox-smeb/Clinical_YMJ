//
//  MyCaseTableViewCell.m
//  求美者端
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MyCaseTableViewCell.h"
@interface MyCaseTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *project;
@property (strong, nonatomic) IBOutlet UILabel *doctor;
@property (strong, nonatomic) IBOutlet UILabel *agency;

@end

@implementation MyCaseTableViewCell
+ (CGFloat)height
{
    return 137.0f;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupWithInfo:(MyMedicalRecordListInfo *)info
{
    @try {
        self.time.text=info.time;
        self.project.text=info.project;
        self.doctor.text=info.doctor;
        self.agency.text=info.agency;
    } @catch (NSException *exception) {
        
    }
}

@end
