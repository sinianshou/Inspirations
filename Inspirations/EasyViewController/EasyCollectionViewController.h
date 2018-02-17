//
//  BaseCollectionViewController.h
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSString * reuseIdentifier;

@property (nonatomic, strong) NSMutableArray * dataSource_MutableArr;
@property (nonatomic, strong) NSMutableDictionary * dataSource_MutableDic;

@end
