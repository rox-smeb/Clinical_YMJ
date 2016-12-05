//
//  DoctorDetailsHeaderView.m
//  求美者端
//
//  Created by Smeb on 2016/12/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "DoctorDetailsHeaderView.h"
#import "CWStarRateView.h"

@interface DoctorDetailsHeaderView ()

@property (strong, nonatomic) CWStarRateView *starRateView;
@property (weak, nonatomic) IBOutlet UIView *starView;

@end

@implementation DoctorDetailsHeaderView

+ (CGFloat)height
{
    return 300.0f;
}

+ (instancetype)create
{
    NSString* name = NSStringFromClass([DoctorDetailsHeaderView class]);
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
    return [nib firstObject];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 100, 20) numberOfStars:5];
    self.starRateView.scorePercent = 0.6;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    [self.starView addSubview:self.starRateView];

}

@end
