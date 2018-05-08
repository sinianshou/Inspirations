//
//  NSMutableDictionary+EasyAvoidNil.m
//  Inspirations
//
//  Created by Easer on 2018/2/15.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "NSMutableDictionary+EasyAvoidNil.h"

@implementation NSMutableDictionary (EasyAvoidNil)

-(void)easy_setValue:(id)value forKey:(NSString *)key{
    if (value==nil || key==nil) {
        NSLog(@"key or value is nil");
        return;
    }
    [self setValue:value forKey:key];
}

-(id)easy_valueForKey:(NSString *)key{
    if (key==nil || ![self.allKeys containsObject:key]) {
        NSLog(@"key is nil, or dic.allKeys does not contain key")
        return nil;
    }
    return [self valueForKey:key];
}

@end
