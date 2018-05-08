//
//  EasyTableViewCell.m
//  Inspirations
//
//  Created by Easer on 2018/2/14.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyTableViewCell.h"

@implementation EasyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(CGFloat)cellHeight{
    return 0.0;
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
@end
