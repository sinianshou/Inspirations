//
//  NSString+EasyExchange.m
//  Inspirations
//
//  Created by Easer on 2018/2/15.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "NSString+EasyExchange.h"

@implementation NSString (EasyExchange)

- (NSURL *)easy_ResponseURL{
    if (self) {
        return [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }else{
        return nil;
    }
    
}

@end
