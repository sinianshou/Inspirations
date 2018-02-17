//
//  UrlsManager.h
//  Inspirations
//
//  Created by Easer on 2018/2/8.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlsManager : NSObject
@end


extern NSString *const DribbbleBaseURLString;
#pragma mark ---- OAuthV2相关
extern NSString *const DribbbleOAuthV2AuthorizeURLString;
extern NSString *const DribbbleOAuthV2TokenURLString;
extern NSString *const DribbbleOAuthV2ClientIdString;
extern NSString *const DribbbleOAuthV2ClientSecretString;

#pragma mark ---- User相关
extern NSString *const DribbbleGetCurrentUserURLString;

#pragma mark ---- 薄荷食物热量
extern NSString *const BooheeBaseURLString;
extern NSString *const BooheeFoodURLString;
extern NSString *const BooheeFoodSearchURLString;
