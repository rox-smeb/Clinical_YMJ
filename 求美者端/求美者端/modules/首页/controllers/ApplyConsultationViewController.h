//
//  ApplyConsultationViewController.h
//  求美者端
//
//  Created by apple on 2016/11/18.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyConsultationViewController : UIViewController
@property (assign, nonatomic) int mType; //0专家会诊 1公益会诊

+(instancetype)viewController;
@end
