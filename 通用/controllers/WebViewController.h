//
//  WebViewController.h
//  昆明团购
//
//  Created by AnYanbo on 15/5/21.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WebPageType)
{
    WEB_PAGE_TYPE_NET = 0,
    WEB_PAGE_TYPE_LOCAL
};

@interface WebViewController : UIViewController <UIWebViewDelegate>
{
    
}

@property (assign, nonatomic) WebPageType type;
@property (strong, nonatomic) NSURL* url;
@property (strong, nonatomic) NSString* htmlPath;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

+ (instancetype)viewController;

@end
