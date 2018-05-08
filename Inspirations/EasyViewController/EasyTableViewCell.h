//
//  EasyTableViewCell.h
//  Inspirations
//
//  Created by Easer on 2018/2/14.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyTableViewCell : UITableViewCell

@property (nonatomic, strong) id model;

-(CGFloat)cellHeight;
@end
