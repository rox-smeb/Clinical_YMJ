//
//  CaseTableViewCell.m
//  求美者端
//
//  Created by apple on 2016/11/26.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "CaseTableViewCell.h"
#import "GetCaseListInfo.h"
#import "CommonServerInteraction.h"

@interface CaseTableViewCell ()
@property (strong, nonatomic) NSArray* caseInfoArray;//案例展示列表

@property (strong, nonatomic) IBOutlet UIImageView *beforeImage;  //之前
@property (strong, nonatomic) IBOutlet UIImageView *afterImage;  //之后
@property (strong, nonatomic) IBOutlet UILabel *contentLable; //内容
@property (strong, nonatomic) IBOutlet UILabel *seeLable;//查看次数
@property (strong, nonatomic) IBOutlet UILabel *collectLable;//收藏数


@end
@implementation CaseTableViewCell

+ (CGFloat)height
{
    return 250.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setupWithCaseInfo:(GetCaseListListInfo*)info
{
    @try
    {
        NSURL* bUrl = [NSURL URLWithString:info.cBeforePic];
        [self.beforeImage sd_setImageWithURL:bUrl];
        NSURL* aUrl = [NSURL URLWithString:info.cAfterPic];
        [self.afterImage sd_setImageWithURL:aUrl];
        
        self.seeLable.text = info.cViewNumber;
        self.contentLable.text = info.cDetails;
    }
    @catch (NSException *exception)
    {
        
    }
}

@end
