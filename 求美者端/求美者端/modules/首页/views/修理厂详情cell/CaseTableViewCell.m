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

@interface CaseTableViewCell()
@property (strong, nonatomic) NSArray* caseInfoArray;//案例展示列表

@property (strong, nonatomic) IBOutlet UIImageView *beforeImage;  //之前
@property (strong, nonatomic) IBOutlet UIImageView *afterImage;  //之后
@property (strong, nonatomic) IBOutlet UILabel *contentLable; //内容
@property (strong, nonatomic) IBOutlet UILabel *seeLable;//查看次数
@property (strong, nonatomic) IBOutlet UILabel *collectLable;//收藏数


@end
@implementation CaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadData];
    // Initialization code
}
-(void)loadData
{
    @weakify_self;
    YB_RESPONSE_BLOCK_EX(block, NSArray<GetCaseListInfo*>*)
    {
//        if (weakSelf.caseInfoArray != nil)
//        {
//            return ;
//        }
        
        if ([response success])
        {
            //NSMutableArray* array = [NSMutableArray array];
            //[array backInsertArray:dataOrList];
            if([dataOrList count]>0)
            {
                GetCaseListInfo* info=[dataOrList objectAtIndex:0];
                NSURL* url=[NSURL URLWithString:info.cBeforePic];
                NSURL* url2=[NSURL URLWithString:info.cAfterPic];
                [weakSelf.beforeImage sd_setImageWithURL:url];
                [weakSelf.afterImage sd_setImageWithURL:url2];
                weakSelf.contentLable.text=info.cDetails;
                weakSelf.seeLable.text=info.cViewNumber;
                
            }
            //weakSelf.caseInfoArray = array;
            //[weakSelf.menu reloadData];
        }
    };
    [[CommonServerInteraction sharedInstance] getCaseListResponseBlock:block];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
