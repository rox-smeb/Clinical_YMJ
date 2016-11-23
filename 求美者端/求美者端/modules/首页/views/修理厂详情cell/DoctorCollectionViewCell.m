//
//  DoctorCollectionViewCell.m
//  求美者端
//
//  Created by apple on 2016/11/17.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "DoctorCollectionViewCell.h"
#import "FindSpecialInfo.h"
@interface DoctorCollectionViewCell()
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIImageView *doctorImageView;
@property (strong, nonatomic) IBOutlet UIImageView *labImageView;
@property (strong, nonatomic) IBOutlet UILabel *doctorName;
@property (strong, nonatomic) IBOutlet UILabel *doctorTitle;

@end
@implementation DoctorCollectionViewCell
+(CGSize)sizeWithWidth:(CGFloat)width
{
    return CGSizeMake(width, width);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    CGRect rect = [[UIScreen mainScreen] bounds];
    // Initialization code
    UIColor *colorOne = [UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.5];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    //gradient.startPoint = CGPointMake(0, 0);
    //gradient.endPoint = CGPointMake(1, 0);
    gradient.colors = colors;
    gradient.frame = CGRectMake(0, 0, rect.size.width, 50);
    // [self.submitButton.layerinsertSublayer:gradient atIndex:0];
    [self.bottomView.layer addSublayer:gradient];

}
-(void)setupWithInfo:(FindSpecialInfo*)info
{
    @try {
        NSURL* url=[NSURL URLWithString:info.bigPath];
        [self.doctorImageView sd_setImageWithURL:url];
        self.labImageView.image=[UIImage imageNamed:@"hzzx_04@x3"];
        self.doctorName.text=info.dName;
        self.doctorTitle.text=info.dTtile;
        
    }
    @catch (NSException *exception) {
        
    }
}
@end
