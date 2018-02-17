//
//  EasyCollectionViewFlowLayout.m
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyCollectionViewFlowLayout.h"

@implementation EasyCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(88, 88);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

@end
