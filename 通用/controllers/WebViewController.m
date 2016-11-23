//
//  WebViewController.m
//  昆明团购
//
//  Created by AnYanbo on 15/6/25.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@end

@implementation WebViewController

+ (instancetype)viewController
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Common" bundle:[NSBundle mainBundle]];
    WebViewController* ctrl = [storyboard instantiateViewControllerWithIdentifier:[self className]];
    return ctrl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.type == WEB_PAGE_TYPE_NET)
    {
        [self.webView.scrollView nlHeaderRefreshWithTarget:self action:@selector(loadRequest)];
    }
    
    [self loadRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadRequest
{
    if (self.url == nil)
    {
        self.url = [NSURL URLWithString:self.htmlPath];
    }
    NSURLRequest* request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
}

- (void)loadErrorHtml
{
    self.url = [[NSBundle mainBundle] URLForResource:@"error" withExtension:@"html"];
    NSURLRequest* request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([self.webView.scrollView.header isRefreshing] == NO)
    {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
        hud.labelText = STRING_LOADING;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
    [webView.scrollView nlHeaderEndRefresh];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
    
    [self loadErrorHtml];
}

@end
