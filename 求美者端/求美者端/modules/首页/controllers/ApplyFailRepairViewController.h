//
//  ApplyFailRepairViewController.h
//  求美者端
//
//  Created by apple on 2016/11/26.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ApplyFailRepairViewController;

@protocol ApplyFailRepairViewControllerDelegate <NSObject>

- (void)userFooterView:(ApplyFailRepairViewController *)vc;

@end

@interface ApplyFailRepairViewController : UIViewController
@property (weak, nonatomic) id<ApplyFailRepairViewControllerDelegate> delegate;

+(instancetype)viewController;
@end
