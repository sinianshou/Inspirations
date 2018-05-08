//
//  EasyWebView.m
//  Inspirations
//
//  Created by Easer on 2018/2/8.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyWebView.h"

@interface EasyWebView ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@end

@implementation EasyWebView

-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        self.UIDelegate = self;
        self.navigationDelegate = self;
    }
    return self;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"是否允许这个导航, url is %@", [webView.URL absoluteString]);
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"知道返回内容之后，是否允许加载，允许加载, url is %@", [webView.URL absoluteString]);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"开始加载, url is %@", [webView.URL absoluteString]);
//    self.progress.alpha  = 1;
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"跳转到其他的服务器, url is %@", [webView.URL absoluteString]);
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"网页由于某些原因加载失败, url is %@", [webView.URL absoluteString]);
//    self.progress.alpha  = 0;
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"网页开始接收网页内容, url is %@", [webView.URL absoluteString]);
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"网页导航加载完毕, url is %@", [webView.URL absoluteString]);
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//
//    self.title = webView.title;
//    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable ss, NSError * _Nullable error) {
//        NSLog(@"----document.title:%@---webView title:%@",ss,webView.title);
//    }];
//    self.progress.alpha  = 0;
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败,失败原因:%@",[error description]);
//    self.progress.alpha = 0;
}
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"网页加载内容进程终止, url is %@", [webView.URL absoluteString]);
}
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//    NSLog(@"receive");
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
