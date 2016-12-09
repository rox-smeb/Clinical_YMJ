//
//  GetPolicySubViewController.h
//  求美者端
//
//  Created by Smeb on 2016/12/9.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetPolicyViewController.h"

@interface GetPolicySubViewController : UIViewController

@property (nonatomic, assign) NSInteger itemTag;

- (void)setParent:(GetPolicyViewController*)parent;

@end
