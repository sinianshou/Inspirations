//
//  EasySessionDataTask.m
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasySessionDataTask.h"

@implementation EasySessionDataTask


#pragma mark ---- 需要重写
//需要重写，以获取BaseUrl
+(NSString*)baseUrlString{
    return nil;
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
    return nil;
}
//可以重写更换值，默认为GET
+(HTTPMethod)httpMethod{
    return HTTPMethodGet;
}



#pragma mark ---- DataTaskMethods
+(void)DataTaskWithCompletionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    NSMutableURLRequest *urlRequest = [self request];
    [self DataTaskWithRequest:urlRequest CompletionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data, response, error);
    }];
}
+(void)DataTaskWithRequest:(NSURLRequest*)request CompletionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data, response, error);
    }];
    [dataTask resume];
}

#pragma mark ---- NSMutableURLRequestMethods

+(NSMutableURLRequest*)request{
    NSMutableURLRequest *urlRequest = [self requestWithBaseUrlString:[self baseUrlString] RequestUrlString:[self requestUrlString] HTTPMethod:[self httpMethod] RequestParameters:[self requestParameters] RequestHeader:[self requestHeader]];
    return urlRequest;
}

+(NSMutableURLRequest*)requestWithRequestUrlString:(NSString* _Nullable) requestUrlStr{
    NSMutableURLRequest *urlRequest = [self requestWithBaseUrlString:[self baseUrlString] RequestUrlString:requestUrlStr HTTPMethod:[self httpMethod] RequestParameters:[self requestParameters] RequestHeader:[self requestHeader]];
    return urlRequest;
}
+(NSMutableURLRequest*)requestWithRequestUrlString:(NSString* _Nullable) requestUrlStr HTTPMethod:(HTTPMethod)httpMethod RequestParameters:(NSDictionary*)requestParameters{
    NSMutableURLRequest *urlRequest = [self requestWithBaseUrlString:[self baseUrlString] RequestUrlString:requestUrlStr HTTPMethod:httpMethod RequestParameters:requestParameters RequestHeader:[self requestHeader]];
    return urlRequest;
}
+(NSMutableURLRequest*)requestWithBaseUrlString:(NSString* _Nullable) baseUrlStr RequestUrlString:(NSString* _Nullable) requestUrlStr HTTPMethod:(HTTPMethod)httpMethod RequestParameters:(NSDictionary*)requestParameters RequestHeader:(NSDictionary*)requestHeaderDic{
    NSMutableString *stringUrl = [NSMutableString string];;
    if (baseUrlStr.length>0) {
        [stringUrl appendString:baseUrlStr];
    }
    
    if (requestUrlStr.length>0) {
        [stringUrl appendString:requestUrlStr];
    }
    NSURL * url;
    NSMutableURLRequest *urlRequest;
    
    if (httpMethod == HTTPMethodGet) {
        [requestParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (![requestParameters.allKeys indexOfObject:key]) {
                [stringUrl appendString:@"?"];
            }
            [stringUrl appendFormat:@"%@=%@&&", key, obj];
            if (stop) {
                [stringUrl deleteCharactersInRange:NSMakeRange(stringUrl.length-1, 1)];
            }
        }];
    }
    url = [NSURL URLWithString:[stringUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    urlRequest = [[NSMutableURLRequest alloc]initWithURL:url];
    switch (httpMethod) {
        case HTTPMethodGet:
            urlRequest.HTTPMethod = @"GET";
            break;
            case HTTPMethodPut:
            urlRequest.HTTPMethod = @"PUT";
            break;
        case HTTPMethodPost:
            urlRequest.HTTPMethod = @"POST";
            break;
        case HTTPMethodDelete:
            urlRequest.HTTPMethod = @"DELETE";
            break;
    }
    switch (httpMethod) {
        case HTTPMethodGet:
            break;
        case HTTPMethodPut:
        case HTTPMethodPost:
        case HTTPMethodDelete:{
            if (requestParameters!=nil) {
                if (![urlRequest valueForHTTPHeaderField:@"Content-Type"]) {
                    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                }
                urlRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParameters options:0 error:nil];
            }
            break;
        }
    }
    
    if (requestHeaderDic!=nil) {
        NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
        [headerFields addEntriesFromDictionary:requestHeaderDic];
        urlRequest.allHTTPHeaderFields = headerFields;
    }
    return urlRequest;
}
@end
