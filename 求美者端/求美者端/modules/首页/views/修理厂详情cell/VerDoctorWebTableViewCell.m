//
//  VerDoctorWebTableViewCell.m
//  求美者端
//
//  Created by iiiiiiiiiimp on 16/9/5.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "VerDoctorWebTableViewCell.h"

@interface VerDoctorWebTableViewCell ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation VerDoctorWebTableViewCell

+ (CGFloat)height
{
    return 568.0f;
}
+ (CGFloat)heightWithFrame:(CGFloat)high
{
    return high;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.webView.scrollView setScrollEnabled:NO];
    [self.webView.scrollView setBounces:NO];
    
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dealloc
{
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentSize"])
//    {
//        NSNumber* value = change[NSKeyValueChangeNewKey];
//        CGSize size = [value CGSizeValue];
//        
//        if ([self.delegate respondsToSelector:@selector(commodityWebTableViewCell:didChangeHeight:)])
//        {
//            [self.delegate commodityWebTableViewCell:self didChangeHeight:size.height];
//        }
//    }
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//}

- (void)loadURL:(NSString*)url
{
    url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    
    NSURL* URL = [NSURL URLWithString:url];
    NSURLRequest* request = [NSURLRequest requestWithURL:URL];
    
    [self.webView loadRequest:request];
}

- (void)loadErrorHtml
{
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"error" withExtension:@"html"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [self.progress startAnimating];
//    [self.progressLabel setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [self.progress stopAnimating];
//    [self.progressLabel setHidden:YES];
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
//{
////    [self.progress stopAnimating];
////    [self.progressLabel setHidden:YES];
//    
//    [self loadErrorHtml];
//}

@end
