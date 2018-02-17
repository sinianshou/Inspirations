//
//  EasySessionDataTask.h
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPMethod) {
    HTTPMethodGet = 0,
    HTTPMethodPost,
    HTTPMethodPut,
    HTTPMethodDelete
};

typedef struct DataTaskStruct{
    HTTPMethod httpMethod;
    __unsafe_unretained NSString* _Nullable baseUrlStr;
    __unsafe_unretained NSString* _Nullable requestUrlStr;
}DataTaskStruct;

@interface EasySessionDataTask : NSURLSessionDataTask

//需要重写，以获取BaseUrl
+(NSString*_Nullable)baseUrlString;
//需要重写，以获取requestUrl
+(NSString*_Nullable)requestUrlString;
//需要重写，以获取requestParameters
+(NSDictionary*_Nullable)requestParameters;
//可以重写更换值，默认为GET
+(HTTPMethod)httpMethod;

#pragma mark ---- DataTaskMethods
+(void)DataTaskWithCompletionHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;
+(void)DataTaskWithRequest:(NSURLRequest*_Nullable)request CompletionHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;
#pragma mark ---- NSMutableURLRequestMethods
+(NSMutableURLRequest*_Nullable)request;
+(NSMutableURLRequest*_Nullable)requestWithRequestUrlString:(NSString* _Nullable) requestUrlStr;
+(NSMutableURLRequest*_Nullable)requestWithRequestUrlString:(NSString* _Nullable) requestUrlStr HTTPMethod:(HTTPMethod)httpMethod RequestParameters:(NSDictionary*_Nullable)requestParameters;
+(NSMutableURLRequest*_Nullable)requestWithBaseUrlString:(NSString* _Nullable) baseUrlStr RequestUrlString:(NSString* _Nullable) requestUrlStr HTTPMethod:(HTTPMethod)httpMethod RequestParameters:(NSDictionary* _Nullable)requestParameters RequestHeader:(NSDictionary* _Nullable)requestHeaderDic;
@end
