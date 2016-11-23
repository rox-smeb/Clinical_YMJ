//
//  FunctionTableViewCell.h
//  求美者端
//
//  Created by Smeb on 2016/11/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FunctionTableViewCell;

@protocol FunctionTableViewCellDelegate <NSObject>

- (void)didSelectWantPretty;
- (void)didSelectSurgeryRepair;
- (void)didSelectGoToKorea;
- (void)didSelectExpertAdvisory;
- (void)didSelectConsultationCenter;
- (void)didSelectConsignProtection;
- (void)didSelectDisputeMediation;

@end



@interface FunctionTableViewCell : UITableViewCell

@property (nonatomic, weak) id<FunctionTableViewCellDelegate> delegate;

+ (CGFloat)height;

@end
