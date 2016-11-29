//
//  ExpertTableViewCell.m
//  求美者端
//
//  Created by Smeb on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ExpertTableViewCell.h"

#define PROBLEM_LEFT            (15.0f)

@interface ExpertTableViewCell ()
//@property (strong, nonatomic) NSString* eId;                            // 专家编号
//@property (strong, nonatomic) NSString* name;                           // 专家姓名
//@property (strong, nonatomic) NSString* title;                          // 专家职称
//@property (strong, nonatomic) NSString* address;                        // 职业地点
//@property (strong, nonatomic) NSString* best;                           // 擅长
//@property (strong, nonatomic) NSString* degree;                         // 满意度
//@property (strong, nonatomic) NSString* isAdvice;                       // 是否可咨询 true false
//@property (strong, nonatomic) NSString* url;                            // 头像url地址
//@property (strong, nonatomic) NSString* bigPath;                        // 大图片
//@property (strong, nonatomic) NSString* urlDetails;                     // 医生详情地址
//@property (strong, nonatomic) NSMutableArray<ExpertRecomendInfo*>* recommendList;                                                      // 推荐平台列表
//@property (strong, nonatomic) NSString* star;                           // 评星
//@property (strong, nonatomic) NSString* hxAccount;                      // 环信用户
//@property (strong, nonatomic) NSString* sort_id;                        // 分页计数


@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIImageView *url;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *textLabel1;
@property (weak, nonatomic) IBOutlet UIProgressView *pro1;
@property (weak, nonatomic) IBOutlet UILabel *degree;
@property (copy, nonatomic) NSString * labelStr;                                            // 获取的主标题
@property (assign, nonatomic) CGFloat height;

@property (strong, nonatomic) ExpertInfo* expertInfo;
@property (strong, nonatomic) ExpertRecomendInfo* expertRecomendInfo;

@property (strong, nonatomic) NSArray *rNameArr;
@end

@implementation ExpertTableViewCell

+ (CGFloat)height
{
    return 100.0f;
}

+ (CGFloat)heightWihtInfo:(ExpertInfo*)info
{
    CGFloat height = 74.0f + info.recommendList.count * PROBLEM_LEFT;
    return height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.url.layer setCornerRadius:8];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUpWithExpertInfo:(ExpertInfo*)expertInfo
{
    @try
    {
        self.expertInfo = expertInfo;
        
        self.name.text = expertInfo.name;
        self.title.text = expertInfo.title;
        
        
        if (self.expertInfo.degree == nil || [self.expertInfo.degree isEqualToString:@""])
        {
            self.degree.text = @"0%";
            [self.pro1 setProgress:0 animated:YES];
        }
        else
        {
            self.degree.text = [NSString stringWithFormat:@"%@%%",expertInfo.degree];
            [self.pro1 setProgress:[expertInfo.degree floatValue]/100 animated:YES];
        }
        
        NSURL* url = [NSURL URLWithString:expertInfo.url];
        [self.url.layer setMasksToBounds:YES];
        [self.url.layer setCornerRadius:self.url.bounds.size.width/2];
        [self.url sd_setImageWithURL:url placeholderImage:DEFAULT_HEAD_IMAGE];
    }
    @catch (NSException *exception)
    {
        
    }
}

- (void)setupWithInfo:(ExpertInfo*)expertInfo orderInfo:(NSString*)expertRecomendInfo
{
    @try
    {
        self.textLabel1.text = expertRecomendInfo;
    }
    @catch (NSException *exception)
    {
        
    }
}




@end
