//
//  UrlsManager.m
//  Inspirations
//
//  Created by Easer on 2018/2/8.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "UrlsManager.h"

@implementation UrlsManager
@end

#ifdef DEBUG
//测试
NSString *const DribbbleBaseURLString = @"https://api.dribbble.com/v2";
#else
//正式服
NSString *const DribbbleBaseURLString = @"https://api.dribbble.com/v2";
#endif

#pragma mark ---- OAuthV2相关
NSString *const DribbbleOAuthV2AuthorizeURLString = @"https://dribbble.com/oauth/authorize";
NSString *const DribbbleOAuthV2TokenURLString = @"https://dribbble.com/oauth/token";
NSString *const DribbbleOAuthV2ClientIdString = @"6b7cfbbebdeee45195b4638f6a4c501803661c4550f5db5e5e3f12919b4759f6";
NSString *const DribbbleOAuthV2ClientSecretString = @"43d82fda9193341bb5e690ad3c643298745cb4d08dc0a43343684ab73b8b0e1b";

#pragma mark ---- User相关
//Get the authenticated user
NSString *const DribbbleGetCurrentUserURLString = @"/user";


#pragma mark ---- 薄荷食物热量
NSString *const BooheeBaseURLString = @"http://www.boohee.com";
NSString *const BooheeFoodURLString = @"/food";
NSString *const BooheeFoodSearchURLString = @"/food/search?keyword=%@&page=%d";

