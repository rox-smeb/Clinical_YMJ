//
//  AucionProjectViewController.h
//  求美者端
//
//  Created by Smeb on 2016/12/2.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionProjectInfo.h"

@interface AucionProjectViewController : UIViewController

@property (strong, nonatomic) AuctionProjectInfo *auctionInfo;

+ (instancetype)viewController;

@end
