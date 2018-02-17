//
//  RootSessionDataTask.m
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "RootSessionDataTask.h"

@implementation RootSessionDataTask
//需要重写，以获取BaseUrl
+(NSString*_Nullable)baseUrlString{
    return DribbbleBaseURLString;
}
//需要重写，以获取requestUrl
+(NSString*)requestUrlString{
    return nil;
}
//需要重写，以获取requestParameters
+(NSDictionary*)requestParameters{
    return nil;
}
//需要重写，以获取requestHeader
+(NSDictionary*)requestHeader{
    Easy_UserDefaults(userDefaults);
    NSDictionary *dic = [userDefaults valueForKey:AccessTokenKeyWordString];
    NSDictionary *requestHeaderDic = nil;
    if (![dic isKindOfClass:[NSNull class]] && [dic.allKeys containsObject:AccessTokenKeyWordString]) {
        requestHeaderDic = @{@"Authorization":[NSString stringWithFormat:@"Bearer %@", [dic objectForKey:AccessTokenKeyWordString]]};
    }
    return requestHeaderDic;
}
//可以重写更换值，默认为GET
+(HTTPMethod)httpMethod{
    return HTTPMethodGet;
}

+(NSMutableURLRequest*_Nullable)requestWithRequestUrlString:(NSString* _Nullable) requestUrlStr HTTPMethod:(HTTPMethod)httpMethod RequestParameters:(NSDictionary*_Nullable)requestParameters{
    NSMutableURLRequest *request = [super requestWithBaseUrlString:[self baseUrlString] RequestUrlString:requestUrlStr HTTPMethod:httpMethod RequestParameters:requestParameters RequestHeader:[self requestHeader]];
    return request;
}

@end
