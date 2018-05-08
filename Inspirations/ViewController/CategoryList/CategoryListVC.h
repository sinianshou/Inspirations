//
//  CategoryListVC.h
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "RootViewController.h"

@class CategoryListModel;

@interface CategoryListVC : RootViewController

@property (nonatomic, strong) CategoryListModel *model;
@property (nonatomic, strong) NSString *requestURLString;

@end
