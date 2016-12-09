//
//  FindMyDisputeSubViewController.h
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindMyDisputeViewController.h"

@interface FindMyDisputeSubViewController : UIViewController

@property (nonatomic, assign) NSInteger itemTag;

- (void)setParent:(FindMyDisputeViewController*)parent;

@end
