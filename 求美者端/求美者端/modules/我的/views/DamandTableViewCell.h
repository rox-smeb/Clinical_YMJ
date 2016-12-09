//
//  DamandTableViewCell.h
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDemandInfo.h"

@interface DamandTableViewCell : UITableViewCell

+ (CGFloat)height;

-(void)setupWithDemandInfo:(MyDemandInfo *)info;

@end
