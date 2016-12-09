//
//  MyQuestionSubViewController.h
//  求美者端
//
//  Created by Smeb on 2016/12/8.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyQuestionViewController.h"

@interface MyQuestionSubViewController : UIViewController

@property (nonatomic, assign) NSInteger itemTag;

- (void)setParent:(MyQuestionViewController*)parent;

@end
