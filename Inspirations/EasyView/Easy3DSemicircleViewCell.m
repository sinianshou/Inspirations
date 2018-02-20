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
        [self configSubs];
        [self layoutSubs];
    }
    return self;
}


- (void)configSubs{
    //初始化内部视图
}
- (void)layoutSubs{
    //布局内部视图
}
- (void)refreshSubs{
    //刷新内部视图显示数据
}
- (void)refreshLayout{
    
}
- (void)deallocModel{
    //更换model时需要进行的处理
}

#pragma mark ---- setter
-(void)setModel:(id)model{
    if (_model) {
        [self deallocModel];
    }
    _model = model;
    if (_model) {
        [self refreshSubs];
        [self refreshLayout];
    }
}
#pragma mark ---- getter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
