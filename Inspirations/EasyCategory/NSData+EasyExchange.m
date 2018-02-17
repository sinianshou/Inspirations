//
//  NSData+EasyExchange.m
//  Inspirations
//
//  Created by Easer on 2018/2/15.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "NSData+EasyExchange.h"

@implementation NSData (EasyExchange)
- (NSDictionary*)easy_ResponseDictionary {
    if (self == nil) {
        return nil;
    }
    NSError *error = nil;
    NSDictionary* responseJSONDic = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"%s error is %@", __func__, error.localizedDescription);
        return nil;
    } else {
        return responseJSONDic;
    }
}
- (NSString *)easy_ResponseString {
    if (self == nil) {
        return nil;
    }
    NSString *str = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    
    return str;
}

@end
