//
//  CategoryCell.m
//  Inspirations
//
//  Created by Easer on 2018/2/18.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell()

@property (nonatomic, strong) UILabel* label;

@end

@implementation CategoryCell

-(instancetype)initWithStyle:(Easy3DSemicircleViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.frame = self.bounds;
        _label.textColor = [UIColor blueColor];
        [self addSubview:_label];
    }
    return self;
}
-(void)setLaText:(NSString *)laText{
    _laText = laText;
    self.label.text = _laText;
}
@end
