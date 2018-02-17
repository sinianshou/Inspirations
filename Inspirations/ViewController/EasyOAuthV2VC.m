//
//  EasyOAuthV2VC.m
//  Inspirations
//
//  Created by Easer on 2018/2/11.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyOAuthV2VC.h"
#import <WebKit/WebKit.h>

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self

@interface EasyOAuthV2VC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation EasyOAuthV2VC

NSString *const EasyOAuthV2ClientId = @"client_id";
NSString *const EasyOAuthV2ClientSecret = @"client_secret";
NSString *const EasyOAuthV2RedirectURLString = @"redirect_uri";
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.authorizeUrlString = @"https://diycode.cc/oauth/authorize";
        self.tokenUrlString = @"https://diycode.cc/oauth/token";
        self.revokeUrlString = @"https://diycode.cc/oauth/revoke";
        self.redirectURLString = @"easyinspirayions://oauth-callback";
        self.ClientId = @"0c8de4fb";
        self.ClientSecret = @"4e9894bec1c922d78455510ba56c49d7daf921a4d7104bbc6474727c50621e6d";
        self.scope = @"public+write+comment+upload";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAuthorizeUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ---OAuth2.0

- (void)loadAuthorizeUrl{
//    NSMutableString *strUrl = [NSMutableString stringWithString:@"https://diycode.cc/oauth/authorize?response_type=code&client_id=0c8de4fb&state=xyz&redirect_uri=EasyInspirayions://oauth-callback"];
    
//    NSMutableString *strUrl = [NSMutableString stringWithString:@"https://www.diycode.cc/"];
    NSMutableString *strUrl = [NSMutableString stringWithString:self.authorizeUrlString];
    NSDictionary *requestParametersDic = @{EasyOAuthV2ClientId:self.ClientId,@"response_type":@"code", @"state@":@"xyz", EasyOAuthV2RedirectURLString:self.redirectURLString};
    [requestParametersDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![requestParametersDic.allKeys indexOfObject:key]) {
            [strUrl appendString:@"?"];
        }
        [strUrl appendFormat:@"%@=%@&&", key, obj];
        if (stop) {
            [strUrl deleteCharactersInRange:NSMakeRange(strUrl.length-1, 1)];
        }
    }];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    //创建一个WKWebView的配置对象
    WKWebViewConfiguration *configur = [[WKWebViewConfiguration alloc] init];
    
    //设置configur对象的preferences属性的信息
    WKPreferences *preferences = [[WKPreferences alloc] init];
    configur.preferences = preferences;
    
    //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
    preferences.javaScriptEnabled = YES;
    //建立webView
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configur];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

#pragma mark ---WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"ROOT是否允许这个导航, url is %@", [webView.URL absoluteString]);
    //easyinspirayions://oauth-callback?code=7e6a2eea0d66ac14d07f1a85bb168ba81d8713bf5b99260038e818e00e82cdfd
    NSString *urlStr = [webView.URL absoluteString];
    if ([urlStr containsString:self.redirectURLString] && ![urlStr containsString:@"redirect_uri="]) {
        NSRange codeStrRange = [urlStr rangeOfString:CodeKeyWordString];
        NSString *codeStr;
        if (codeStrRange.length) {
            codeStr = [urlStr substringFromIndex:NSMaxRange(codeStrRange)+1];
        }
        NSRange andStrRange = [codeStr rangeOfString:@"&"];
        if (andStrRange.length) {
            codeStr = [codeStr substringToIndex:andStrRange.location];
        }
        
        NSDictionary *parametersDic = @{EasyOAuthV2ClientId:self.ClientId, EasyOAuthV2RedirectURLString:self.redirectURLString, CodeKeyWordString:codeStr, @"grant_type":@"authorization_code"};
        
        NSMutableURLRequest *request = [RootSessionDataTask requestWithBaseUrlString:self.tokenUrlString RequestUrlString:nil HTTPMethod:HTTPMethodPost RequestParameters:parametersDic RequestHeader:nil];
        [RootSessionDataTask DataTaskWithRequest:request CompletionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"dic is %@", dic);
            }
            
        }];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
            decisionHandler(WKNavigationActionPolicyAllow);
    }
    
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

#pragma mark ---WKUIDelegate
#pragma mark ---WKScriptMessageHandler
@end
