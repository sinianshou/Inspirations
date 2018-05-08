//
//  EasyTableViewController.h
//  Inspirations
//
//  Created by Easer on 2018/2/14.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TableCellAnimationType) {
    TableCellAnimationTypeNone,//默认从0开始
    TableCellAnimationTypeInsertion,
};

@interface EasyTableViewController : UITableViewController

@property (nonatomic, strong) NSString * reuseIdentifier;

@property (nonatomic, strong) NSMutableArray * dataSource_MutableArr;
@property (nonatomic, strong) NSMutableDictionary * dataSource_MutableDic;

@property (nonatomic, strong) id tempCell;
@property (nonatomic, assign) TableCellAnimationType CellAnimationType;

@end
