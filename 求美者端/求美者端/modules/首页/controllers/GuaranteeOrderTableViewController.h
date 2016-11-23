//
//  GuaranteeOrderTableViewController.h
//  求美者端
//
//  Created by AnYanbo on 16/8/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuaranteeOrderViewController.h"

@interface GuaranteeOrderTableViewController : UITableViewController

- (void)setParent:(GuaranteeOrderViewController*)parent;

+ (instancetype)viewController;

@end
