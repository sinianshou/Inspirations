//
//  EasyFlowerView.h
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyFlowerViewProtocol.h"

@interface EasyFlowerView : UIView

@property (nonatomic, weak) id<EasyFlowerViewDataSource> dataSource;
@property (nonatomic, weak) id<EasyFlowerViewDelegate> delegate;


@property (nonatomic, assign) NSUInteger numberOfRows;
@end
