//
//  UIWebView+utility.m
//  昆明团购
//
//  Created by AnYanbo on 15/7/3.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "UIWebView+utility.h"

@implementation UIWebView (utility)

- (CGSize)cacleSize
{
    CGRect frame = self.frame;
    CGSize size = self.scrollView.contentSize;
    float scrollHeight = [[self stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"] floatValue];
    float offsetHeight = [[self stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    
    float height = MAX(scrollHeight, offsetHeight);
    height = MAX(height, size.height);
    height += 10.0f;
    
    return CGSizeMake(frame.size.width, height);
}

@end
