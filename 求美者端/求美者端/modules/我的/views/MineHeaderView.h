//
//  MineHeaderView.h
//  美游时代
//
//  Created by AnYanbo on 16/5/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MineHeaderView;

@protocol MineHeaderViewDelegate <NSObject>

- (void)header:(MineHeaderView*)header didClickHeadImageView:(UIView*)head;

@end

@interface MineHeaderView : UIView
{
    
}

@property (nonatomic, weak) id<MineHeaderViewDelegate> delegate;

- (void)expandWithScrollView:(UIScrollView*)scrollView;
- (void)scrollViewDidScroll:(UIScrollView*)scrollView;
- (void)updateWithHeadURL:(NSString*)url name:(NSString*)name;

@end
