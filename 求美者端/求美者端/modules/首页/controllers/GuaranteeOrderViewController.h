//
//  GuaranteeOrderViewController.h
//  求美者端
//
//  Created by apple on 2016/11/15.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class GuaranteeOrderViewController;

@protocol GuaranteeOrderViewControllerDelegate <NSObject>

- (void)userFooterView:(GuaranteeOrderViewController *)vc;

@end


@interface GuaranteeOrderViewController : UIViewController

@property (weak, nonatomic) id<GuaranteeOrderViewControllerDelegate> delegate;

+ (instancetype)viewController;

@end
