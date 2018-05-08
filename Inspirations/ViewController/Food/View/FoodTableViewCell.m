//
//  FoodTableViewCell.m
//  Inspirations
//
//  Created by Easer on 2018/2/14.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "FoodTableViewCell.h"
#import "FoodCategoryModel.h"
@interface FoodTableViewCell ()

@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) NSMutableArray <UIButton*>*subtitleButtonsArrM;

@end
@implementation FoodTableViewCell

-(void)configSubs{
    _imgV = [[UIImageView alloc] init];
    _title = [[UILabel alloc] init];
    _subtitleButtonsArrM = [NSMutableArray array];
    
    [self addSubview:_imgV];
    [self addSubview:_title];
}
-(void)layoutSubs{
    Easy_WeakSelf(weakSelf);
    [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(55, 55));
        make.left.equalTo(20);
        make.centerY.equalTo(0);
    }];
    [self.title remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(weakSelf.imgV.right).offset(15);
        make.right.equalTo(-20);
        make.height.equalTo(weakSelf.imgV.height).multipliedBy(0.4);
    }];
    
    [self layoutIfNeeded];
    [self refreshLayout];
}
- (void)refreshSubs{
    FoodCategoryModel* mode = self.model;
    [self.imgV sd_setImageWithURL:mode.imgURLString.easy_ResponseURL placeholderImage:PlaceHolderImage];
    self.title.text = mode.categoryTitle;
    [mode.subtitles enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        UIButton *bn = [[UIButton alloc] init];
        [bn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        bn.titleLabel.font = [UIFont systemFontOfSize:13];
        [bn setTitle:obj forState:UIControlStateNormal];
        [bn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:bn];
        [self.subtitleButtonsArrM addObject:bn];
    }];
}
- (void)refreshLayout{
    Easy_WeakSelf(weakSelf);
    UIView __block *mark = self.title;
    
    [self.subtitleButtonsArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj sizeToFit];
        if (idx) {
            obj.frame = CGRectMake(CGRectGetMaxX(mark.frame)+5, mark.mj_y, obj.mj_w+10, obj.mj_h);
            if (CGRectGetMaxX(obj.frame)>CGRectGetMaxX(weakSelf.title.frame)) {
                obj.mj_origin = CGPointMake(CGRectGetMinX(weakSelf.title.frame), CGRectGetMaxY(mark.frame));
            }
        }else{
            obj.frame = CGRectMake(CGRectGetMinX(weakSelf.title.frame), CGRectGetMaxY(weakSelf.title.frame), obj.mj_w+10, obj.mj_h);
        }
        mark = obj;
    }];
}
- (void)deallocModel{
    if (self.subtitleButtonsArrM.count>0) {
        Easy_WeakSelf(weakSelf);
        [self.subtitleButtonsArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [weakSelf.subtitleButtonsArrM removeAllObjects];
    }
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
    UIButton *bn = self.subtitleButtonsArrM.lastObject;
    return CGRectGetMaxY(bn.frame)+20;
}

#pragma mark ---- setter
#pragma mark ---- getter
#pragma mark ---- buttons clicked actions
- (void)buttonClicked:(UIButton*)button{
    FoodCategoryModel* mode = self.model;
    if (_subtitleBlock!=nil && [mode.subtitles.allValues containsObject:button.currentTitle]) {
        [mode.subtitles enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:button.currentTitle]) {
                _subtitleBlock(key);
                *stop = YES;
            }
        }];
    }
}

@end
