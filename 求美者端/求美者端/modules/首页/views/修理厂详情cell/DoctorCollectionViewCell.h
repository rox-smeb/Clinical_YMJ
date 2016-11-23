//
//  DoctorCollectionViewCell.h
//  求美者端
//
//  Created by apple on 2016/11/17.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindSpecialInfo.h"
@interface DoctorCollectionViewCell : UICollectionViewCell
+(CGSize)sizeWithWidth:(CGFloat)width;
-(void)setupWithInfo:(FindSpecialInfo*)info;
@end
