//
//  Easy3DSemicircleView.h
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Easy3DSemicircleViewProtocol.h"

@interface Easy3DSemicircleView : UIView

@property (nonatomic, weak) id<Easy3DSemicircleViewDataSource> dataSource;
@property (nonatomic, weak) id<Easy3DSemicircleViewDelegate> delegate;


@property (nonatomic, assign) NSUInteger numberOfRows;
@end
