//
//  KoreaDoctorTableViewCell.m
//  求美者端
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "KoreaDoctorTableViewCell.h"
#define CONTENT_TOP              (5.0f)
#define CONTENT_BOTTOM           (245.0f)
#define CONTENT_LEFT             (10.0f)
#define CONTENT_RIGHT            (10.0f)
@interface KoreaDoctorTableViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *imageBigPath;
@property (strong, nonatomic) IBOutlet UILabel *doctorName;
@property (strong, nonatomic) IBOutlet UILabel *dTtile;
@property (strong, nonatomic) IBOutlet UILabel *dAgency;
@property (strong, nonatomic) IBOutlet UILabel *best;


@end
@implementation KoreaDoctorTableViewCell
+(CGFloat)heightWithInfo:(FindSpecialInfo *)info
{
    
        CGFloat height = CONTENT_TOP + CONTENT_BOTTOM;
        CGFloat width = [UIScreen screenWidth] - CONTENT_LEFT - CONTENT_RIGHT;
//        CGSize size = [info.Title calculateSize:CGSizeMake(width, 0.0f) font:[UIFont systemFontOfSize:14.0f] lineBreakMode:NSLineBreakByCharWrapping];
//        height = height + size.height;
        return height;
    
}
-(void)setupWithInfo:(FindSpecialInfo *)info
{
    @try {
        NSURL* url=[NSURL URLWithString:info.bigPath];
        [self.imageBigPath sd_setImageWithURL:url];
        self.doctorName.text=info.dName;
        self.dTtile.text=info.dTtile;
        self.dAgency.text=info.dAgency;
        self.best.text=info.best;
    } @catch (NSException *exception) {
        
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
