//
//  FindMyDisputeTableViewCell.h
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindMyDisputeInfo.h"

@interface FindMyDisputeTableViewCell : UITableViewCell

+ (CGFloat)height;

-(void)setupWithfindMyDisputeInfo:(FindMyDisputeInfo *)info;

@end
