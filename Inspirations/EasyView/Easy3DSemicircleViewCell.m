//
//  Easy3DSemicircleViewCell.m
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "Easy3DSemicircleViewCell.h"

@implementation Easy3DSemicircleViewCell

- (instancetype)initWithStyle:(Easy3DSemicircleViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
        self.style = style;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
