//
//  CategoryCell.m
//  Inspirations
//
//  Created by Easer on 2018/2/18.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "CategoryCell.h"
#import "SearchListCellModel.h"

@interface CategoryCell()

@property (nonatomic, strong) UIImageView* imgV;
@property (nonatomic, strong) UILabel* label;

@end

@implementation CategoryCell

//-(instancetype)initWithStyle:(Easy3DSemicircleViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//
//    }
//    return self;
//}


- (void)configSubs{
    //初始化内部视图
    _imgV = [[UIImageView alloc] init];
    [self addSubview:_imgV];
    _label = [[UILabel alloc] init];
    _label.textColor = [UIColor blueColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:10];
    _label.numberOfLines = 0;
    [self addSubview:_label];
}
- (void)layoutSubs{
    //布局内部视图
    Easy_WeakSelf(weakSelf);
    [_imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(35, 35));
        make.center.equalTo(weakSelf);
    }];
    [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(weakSelf.height).multipliedBy(0.3);
    }];
}
- (void)refreshSubs{
    //刷新内部视图显示数据
    if (self.model) {
        SearchListCellModel *model = (SearchListCellModel*)self.model;
        self.title = model.title;
//        self.laText = model.foodEnergy;
        NSString *str = [NSString stringWithFormat:@"%@\n%@", model.title, model.foodEnergy];
        NSInteger titleLength = model.title.length;
        NSInteger energyLength = str.length-titleLength;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, titleLength)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, titleLength)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(titleLength, energyLength)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.8 alpha:1] range:NSMakeRange(titleLength, energyLength)];
        self.attrText = attrStr;
        [self.imgV sd_setImageWithURL:model.imgURLString.mj_url placeholderImage:[UIImage imageNamed:@"DefaultLogin"]];
    }
}
- (void)refreshLayout{
    
}
- (void)deallocModel{
    //更换model时需要进行的处理
    self.title = nil;
    self.laText = nil;
    self.imgV.image = nil;
}


-(void)setLaText:(NSString *)laText{
    _laText = laText;
    self.label.text = _laText;
}
-(void)setAttrText:(NSMutableAttributedString *)attrText{
    _attrText = attrText;
    self.label.attributedText = attrText;
}
@end
