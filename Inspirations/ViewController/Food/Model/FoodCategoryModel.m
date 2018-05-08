//
//  FoodCategoryModel.m
//  Inspirations
//
//  Created by Easer on 2018/2/15.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "FoodCategoryModel.h"

@implementation FoodCategoryModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _subtitles = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
