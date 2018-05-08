//
//  BaseModel.m
//  Inspirations
//
//  Created by Easer on 2018/2/10.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+(void)initialize{
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return [self JSONKeyPathsByPropertyKey];
    }];
    
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return [self JSONObjectClassInArrayProperty];
    }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

+ (NSDictionary *)JSONObjectClassInArrayProperty{
    return @{};
}

@end
