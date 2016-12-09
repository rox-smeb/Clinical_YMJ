//
//  FindMyDisputeTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "FindMyDisputeTableViewCell.h"

@interface FindMyDisputeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *did;

@end

@implementation FindMyDisputeTableViewCell

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

-(void)setupWithfindMyDisputeInfo:(FindMyDisputeInfo *)info
{
    @try
    {
        self.content.text=info.content;
        self.did.text=info.dId;
        self.date.text=info.date;
    }
    @catch (NSException *exception)
    {
        
    }
    
}

@end
