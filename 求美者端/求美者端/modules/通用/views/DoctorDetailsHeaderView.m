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

@property (strong, nonatomic) GetDoctorDetailsInfo *getInfo;

@property (strong, nonatomic) CWStarRateView *starRateView;

@property (weak, nonatomic) IBOutlet UIImageView *bigPath;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *hospital;
@property (weak, nonatomic) IBOutlet UILabel *physicianLevel;
@property (weak, nonatomic) IBOutlet UILabel *occupationalClass;
@property (weak, nonatomic) IBOutlet UILabel *certificateCode;
@property (weak, nonatomic) IBOutlet UILabel *approvalAuthority;
@property (weak, nonatomic) IBOutlet UILabel *degree;
@property (weak, nonatomic) IBOutlet UIProgressView *proDegree;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UIView *doctorDetailsView;

@property (assign, nonatomic) BOOL type;// 查看全部||收起详情
@property (weak, nonatomic) IBOutlet UIButton *lookAll;
@property (weak, nonatomic) IBOutlet UIImageView *upOrDown;

@end

@implementation DoctorDetailsHeaderView

+ (CGFloat)height
{
    return 1110.0f;
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
    
    [self setup];
}

- (void)setup
{
    // 评价星级展示
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 100, 20) numberOfStars:5];
    self.starRateView.scorePercent = 0;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    [self.starView addSubview:self.starRateView];

    _type = YES;
    // 医院名称
    _hospital.text = @"  机构名称  ";
    [_hospital.layer setCornerRadius:17.5f];
    [_hospital.layer setMasksToBounds:YES];
    
     //医生详情
    _details.text = @"详情介绍";
//    _details.font = [UIFont systemFontOfSize:16];
//    CGSize maximumLabelSize = CGSizeMake(_details.width, 9999);//labelsize的最大值
//    //关键语句
//    CGSize expectSize = [_details sizeThatFits:maximumLabelSize];
//    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
//    //_details.frame = CGRectMake(20, 70, expectSize.width, expectSize.height);
//    _gaodu = expectSize.height;
}

- (void)setupWithGetDoctorDetailsInfo:(GetDoctorDetailsInfo *)info
{
    @try
    {
        _getInfo = info;
        
        NSURL* url = [NSURL URLWithString:info.bigPath];
        [self.bigPath sd_setImageWithURL:url];

        self.name.text = info.name;
        self.title.text = info.title;
        self.starRateView.scorePercent = [info.star intValue]*2/10;
        self.hospital.text = [NSString stringWithFormat:@" %@   ", info.agency];
        self.physicianLevel.text = info.physicianLevel;
        self.occupationalClass.text = info.occupationalClass;
        self.certificateCode.text = info.certificateCode;
        self.approvalAuthority.text = info.approvalAuthority;
        self.details.text = info.details;
        
        if ([info.details isEqualToString:@""]) {
            [self.doctorDetailsView setHidden:YES];
        }
        if (info.degree == nil || [info.degree isEqualToString:@""])
        {
            self.degree.text = @"0%";
            [self.proDegree setProgress:0 animated:YES];
        }
        else
        {
            self.degree.text = [NSString stringWithFormat:@"%.1f%%",[info.degree floatValue]];
            [self.proDegree setProgress:[info.degree floatValue]/100 animated:YES];
        }
        
    }
    @catch (NSException *exception)
    {
        
    }

}

#pragma mark - 查看全部||收起详情
- (IBAction)lookAllClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(detailsHeaderView:didClickLookAllWithInfo:withType:)]) {
        [self.delegate detailsHeaderView:self didClickLookAllWithInfo:self.getInfo withType:_type];
    }
    if (_type == YES) {
        [_lookAll setTitle:@"收起详情" forState:UIControlStateNormal];
        _upOrDown.image = [UIImage imageNamed:@"up"];
        _type = NO;
    }else{
        [_lookAll setTitle:@"查看全部" forState:UIControlStateNormal];
        _upOrDown.image = [UIImage imageNamed:@"down"];
        _type = YES;
    }
}

@end
