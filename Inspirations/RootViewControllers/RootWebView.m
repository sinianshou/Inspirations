//
//  RootWebView.m
//  Inspirations
//
//  Created by Easer on 2018/2/8.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "RootWebView.h"
#import "RootSessionDataTask.h"

@implementation RootWebView

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"ROOT是否允许这个导航, url is %@", [webView.URL absoluteString]);
    //easyinspirayions://oauth-callback?code=7e6a2eea0d66ac14d07f1a85bb168ba81d8713bf5b99260038e818e00e82cdfd
    NSString *urlStr = [webView.URL absoluteString];
    if ([urlStr containsString:CodeKeyWordString]) {
        NSRange codeStrRange = [urlStr rangeOfString:CodeKeyWordString];
        NSString *codeStr = [urlStr substringFromIndex:NSMaxRange(codeStrRange)+1];
        
        NSDictionary *parametersDic = @{ClientIdKeyWordString:DribbbleOAuthV2ClientIdString, ClientSecretKeyWordString:DribbbleOAuthV2ClientSecretString, CodeKeyWordString:codeStr};
        
        NSMutableURLRequest *request = [RootSessionDataTask requestWithBaseUrlString:DribbbleOAuthV2TokenURLString RequestUrlString:nil HTTPMethod:HTTPMethodPost RequestParameters:parametersDic RequestHeader:nil];
        [RootSessionDataTask DataTaskWithRequest:request CompletionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"dic is %@", dic);
                if ([dic.allKeys containsObject:AccessTokenKeyWordString]) {
                    Easy_UserDefaults(userDefaults);
                    [userDefaults setObject:dic forKey:AccessTokenKeyWordString];
                    [userDefaults synchronize];
                    if (_didGetAccessTokenBlock != nil) {
                        _didGetAccessTokenBlock(YES);
                    }
                }
            }
            
        }];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
