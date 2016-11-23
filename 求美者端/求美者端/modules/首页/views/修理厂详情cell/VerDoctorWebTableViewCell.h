//
//  VerDoctorWebTableViewCell.h
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerDoctorWebTableViewCell : UITableViewCell

+ (CGFloat)height;
+ (CGFloat)heightWithFrame:(CGFloat)high;

- (void)loadURL:(NSString*)url;

@end
