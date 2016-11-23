//
//  DisputeResolveViewController.h
//  求美者端
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DisputeResolveViewControllerDalegate<NSObject>
-(void)userFooterView;
@end
@interface DisputeResolveViewController : UIViewController
+(instancetype)viewController;
@property(weak,nonatomic) id <DisputeResolveViewControllerDalegate>delegate;
@end
