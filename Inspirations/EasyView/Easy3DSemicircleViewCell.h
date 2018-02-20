//
//  Easy3DSemicircleViewCell.h
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Easy3DSemicircleViewCellStyle) {
    Easy3DSemicircleViewCellStyleNone = 0,
};

@interface Easy3DSemicircleViewCell : UIView

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* reuseIdentifier;
@property (nonatomic, assign) Easy3DSemicircleViewCellStyle style;

@property (nonatomic, strong) id model;

- (instancetype)initWithStyle:(Easy3DSemicircleViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
