//
//  RootSessionDataTask.h
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasySessionDataTask.h"

@interface RootSessionDataTask : EasySessionDataTask
+(NSMutableURLRequest*_Nullable)requestWithRequestUrlString:(NSString* _Nullable) requestUrlStr HTTPMethod:(HTTPMethod)httpMethod RequestParameters:(NSDictionary*_Nullable)requestParameters;

@end
