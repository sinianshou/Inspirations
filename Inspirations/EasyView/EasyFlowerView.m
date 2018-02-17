//
//  EasyFlowerView.m
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyFlowerView.h"
#import "EasyFlowerViewCell.h"
@interface EasyFlowerView ()
@end
@implementation EasyFlowerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)didMoveToSuperview{
    NSLog(@"Please Complete %s", __func__);
    if (self.dataSource) {
        self.numberOfRows = [self.dataSource numberOfRowsInEasyFlowerView:self];
    }
    switch (self.numberOfRows) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            [self aaa];
            break;
        default:
            break;
    }
}
-(void)didMoveToWindow{
    NSLog(@"Please Complete %s", __func__);
}
-(void)reloadInputViews{
    NSLog(@"Please Complete %s", __func__);
}
- (void)configCells{
    if (self.dataSource) {
        CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGPoint point1 = CGPointMake(centerPoint.x, 0);
        CGPoint point2 = CGPointMake(centerPoint.x, 0);
//        CGPoint point1 = CGPointMake(0, 0);
//        CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
//        CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
//        CGPoint point4 = CGPointMake(viewWidth, topSpace);
//        CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
//        CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
//        CGPoint point7 = CGPointMake(0, viewHeight);
        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:point1];
//        [path addLineToPoint:point2];
//        [path addLineToPoint:point3];
//        [path addLineToPoint:point4];
//        [path addLineToPoint:point5];
//        [path addLineToPoint:point6];
//        [path addLineToPoint:point7];
        [path closePath];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        
    }
}
-(void)aaa{
    __weak __typeof(&*self)weakSelf = self;
    CGFloat radius = sqrtf(powf(self.bounds.size.width, 2)+powf(self.bounds.size.height, 2))/2;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    NSMutableArray <NSValue *>*pointArrM = [NSMutableArray array];
    for (int i=0; i<self.numberOfRows; ++i) {
        CGPoint point = CGPointMake(center.x+radius*cosf(-M_PI/2+2*M_PI/self.numberOfRows*i), center.y+radius*sinf(-M_PI/2+2*M_PI/self.numberOfRows*i));
        [pointArrM addObject:@(point)];
    }
    NSMutableArray *shapeLayerArrM = [NSMutableArray array];
    [pointArrM enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point01 = obj.CGPointValue;
        CGPoint point02;
        if (idx<pointArrM.count-1) {
            point02 = pointArrM[idx+1].CGPointValue;
        }else{
            point02 = pointArrM.firstObject.CGPointValue;
        }
        //创建CGMutablePathRef
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, center.x, center.y);
        CGPathAddLineToPoint(path, NULL, point01.x, point01.y);
        CGPathAddArcToPoint(path, NULL,  center.x, center.y, point02.x, point02.y, radius);
        CGPathCloseSubpath(path);
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path;
        [shapeLayerArrM addObject:layer];
        if (weakSelf.dataSource) {
            EasyFlowerViewCell *cell = [weakSelf.dataSource easyFlowerView:self cellForRow:idx];
            cell.layer.mask = layer;
            cell.frame = self.bounds;
            [self addSubview:cell];
        }
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
