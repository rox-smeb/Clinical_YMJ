//
//  BecomeBeautifulSubViewController.h
//  求美者端
//
//  Created by Smeb on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BecomeBeautifulViewController.h"

@interface BecomeBeautifulSubViewController : UIViewController

@property (nonatomic, assign) NSInteger itemTag;

- (void)setParent:(BecomeBeautifulViewController*)parent;

@end
