//
//  MineHeaderView.m
//  美游时代
//
//  Created by AnYanbo on 16/5/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView* bkImageView;
@property (weak, nonatomic) IBOutlet UIImageView* userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel* userNickLabel;
@property (weak, nonatomic) UIScrollView* scrollView;
@property (assign, nonatomic) CGFloat expandHeight;

@end

@implementation MineHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self.userHeadImageView circleImage];
    
    // 添加头像点击事件
    [self.userHeadImageView addNormalTapGestureWithTarget:self atction:@selector(onHeadTap:)];
}

- (void)expandWithScrollView:(UIScrollView*)scrollView
{
    self.expandHeight = [self height];
    
    self.scrollView = scrollView;
    self.scrollView.contentInset = UIEdgeInsetsMake(self.expandHeight, 0, 0, 0);
    [self.scrollView insertSubview:self atIndex:0];
    [self.scrollView setContentOffset:CGPointMake(0, self.expandHeight * -1)];
    
    [self reSizeView];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < self.expandHeight * -1)
    {
        CGRect currentFrame = self.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1 * offsetY;
        self.frame = currentFrame;
    }
}

- (void)reSizeView
{
    [self setFrame:CGRectMake(0, -1 * self.expandHeight, CGRectGetWidth(self.scrollView.frame), self.expandHeight)];
}

- (void)updateWithHeadURL:(NSString*)url name:(NSString*)name
{
    NSURL* headUrl = [NSURL URLWithString:url];
    [self.userHeadImageView sd_setImageWithURL:headUrl placeholderImage:DEFAULT_HEAD_IMAGE];
    self.userNickLabel.text = name;
}

// 头像点击
- (void)onHeadTap:(UITapGestureRecognizer*)tap
{
    if ([self.delegate respondsToSelector:@selector(header:didClickHeadImageView:)])
    {
        [self.delegate header:self didClickHeadImageView:tap.view];
    }
}

@end
