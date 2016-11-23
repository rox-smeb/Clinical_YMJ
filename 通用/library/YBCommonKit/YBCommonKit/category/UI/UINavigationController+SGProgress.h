//
//  UINavigationController+SGProgress.h
//  NavigationProgress
//
//  Created by Shawn Gryschuk on 2013-09-19.
//  Modify  by An Yanbo on 2015-04-24.
//
//  Copyright (c) 2013 Shawn Gryschuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SGProgress)

// Modify by AnYanbo
@property (nonatomic, strong) NSString* oldTitle;
@property (nonatomic, strong) NSString* changedTitle;

- (void)showSGProgress;
- (void)showSGProgressWithDuration:(float)duration;
- (void)showSGProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor;
- (void)showSGProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor andTitle:(NSString *)title;
- (void)showSGProgressWithMaskAndDuration:(float)duration;
- (void)showSGProgressWithMaskAndDuration:(float)duration andTitle:(NSString *) title;

- (void)setSGProgressPercentage:(float)percentage;
- (void)setSGProgressPercentage:(float)percentage andTitle:(NSString *)title;
- (void)setSGProgressPercentage:(float)percentage andTintColor:(UIColor *)tintColor;
- (void)setSGProgressMaskWithPercentage:(float)percentage;
- (void)setSGProgressMaskWithPercentage:(float)percentage andTitle:(NSString *)title;

- (void)resetTitle;
- (void)changeSGProgressWithTitle:(NSString *)title;

- (void)finishSGProgress;
- (void)cancelSGProgress;

- (void)setSlidePopEnable:(BOOL)enable;

@end
