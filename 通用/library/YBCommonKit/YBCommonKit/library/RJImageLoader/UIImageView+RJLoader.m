//
//  UIImageView+RJLoader.m
//  ImageLoaderAnimation
//
//  Created by Rounak Jain on 28/12/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "UIImageView+RJLoader.h"
#import "RJCircularLoaderView.h"

#define LOADER_VIEW_TAG                 (10000)

@implementation UIImageView (RJLoader)

- (RJCircularLoaderView*)rj_circularLoaderView
{
    RJCircularLoaderView *loaderView = objc_getAssociatedObject(self, @selector(rj_circularLoaderView));
    if (loaderView == nil)
    {
        loaderView = [RJCircularLoaderView new];
        loaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        objc_setAssociatedObject(self, @selector(rj_circularLoaderView), loaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return loaderView;
}

- (void)updateImageDownloadProgress:(CGFloat)progress
{
    self.rj_circularLoaderView.progress = progress;
}

- (void)startLoader
{
    RJCircularLoaderView* loaderView = (RJCircularLoaderView*)[self viewWithTag:LOADER_VIEW_TAG];
    
    if (loaderView == nil)
    {
        loaderView = self.rj_circularLoaderView;
        loaderView.tag = LOADER_VIEW_TAG;
        [self addSubview:loaderView];
    }
    
    loaderView.frame = self.bounds;
    loaderView.progress = 0;
}

- (void)startLoaderWithTintColor:(UIColor *)color
{
    [self startLoader];
    self.rj_circularLoaderView.tintColor = color;
}

- (void)reveal
{
    [self.rj_circularLoaderView reveal];
}

@end
