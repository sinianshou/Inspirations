//
//  FoodTableViewCell.h
//  Inspirations
//
//  Created by Easer on 2018/2/14.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "RootTableCell.h"

@class FoodCategoryModel;

@interface FoodTableViewCell : RootTableCell

@property (nonatomic, copy) void(^subtitleBlock)(NSString* str);

@end
