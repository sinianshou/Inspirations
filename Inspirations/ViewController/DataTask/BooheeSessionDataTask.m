//
//  BooheeSessionDataTask.m
//  Inspirations
//
//  Created by Easer on 2018/2/15.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "BooheeSessionDataTask.h"

@implementation BooheeSessionDataTask
//需要重写，以获取BaseUrl
+(NSString*_Nullable)baseUrlString{
    return BooheeBaseURLString;
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

@end
