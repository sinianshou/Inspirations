//
//  FoodCategoryModel.h
//  Inspirations
//
//  Created by Easer on 2018/2/15.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "BaseModel.h"


@interface FoodCategoryModel : BaseModel

@property (nonatomic, strong) NSString* imgURLString;
@property (nonatomic, strong) NSString* detailURLString;
@property (nonatomic, strong) NSString* categoryTitle;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSString*>* subtitles;


@end
