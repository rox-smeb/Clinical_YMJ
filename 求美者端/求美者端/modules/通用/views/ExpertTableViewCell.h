//
//  ExpertTableViewCell.h
//  求美者端
//
//  Created by Smeb on 2016/11/25.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpertInfo.h"

@interface ExpertTableViewCell : UITableViewCell

+ (CGFloat)height;
+ (CGFloat)heightWihtInfo:(ExpertInfo*)info;

- (void)setUpWithExpertInfo:(ExpertInfo*)expertInfo;
- (void)setupWithInfo:(ExpertInfo*)expertInfo orderInfo:(NSString*)expertRecomendInfo;

@end
