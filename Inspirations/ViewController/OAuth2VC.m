//
//  OAuth2VC.m
//  Inspirations
//
//  Created by Easer on 2018/2/9.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "OAuth2VC.h"
#import "RootSessionDataTask.h"
#import "RootWebView.h"
#import "RootWebViewConfiguration.h"

@interface OAuth2VC ()

@end

@implementation OAuth2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableString *strUrl = [NSMutableString stringWithString:DribbbleOAuthV2AuthorizeURLString];
    NSDictionary *requestParametersDic = @{ClientIdKeyWordString:DribbbleOAuthV2ClientIdString,ScopeKeyWordString:ScopeValueKeyWordString};
    NSMutableURLRequest *request = [RootSessionDataTask requestWithBaseUrlString:strUrl RequestUrlString:nil HTTPMethod:HTTPMethodGet RequestParameters:requestParametersDic RequestHeader:nil];

    //创建一个WKWebView的配置对象
    RootWebViewConfiguration *configur = [[RootWebViewConfiguration alloc] init];
    //建立webView
    RootWebView *webView = [[RootWebView alloc]initWithFrame:self.view.bounds configuration:configur];
    [self.view addSubview:webView];
    [webView loadRequest:request];
    Easy_WeakSelf(weakSelf);
    webView.didGetAccessTokenBlock = ^(BOOL success) {
        if (success) {
            Easy_AsyncMainQueue([weakSelf.navigationController popViewControllerAnimated:YES];);
        }
    };
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
