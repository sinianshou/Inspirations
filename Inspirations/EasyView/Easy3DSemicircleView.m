//
//  Easy3DSemicircleView.m
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "Easy3DSemicircleView.h"
#import "Easy3DSemicircleViewCell.h"
#import "EasyCATransform3D.h"

@interface Easy3DSemicircleView ()

@property (nonatomic, strong) CALayer *menuLayer;
@property (nonatomic, assign) CGPoint zeroPoint;
@property (nonatomic, strong) UIView *cellContainer;

@property (nonatomic, strong) CATextLayer *frontTitleLayer;
@property (nonatomic, strong) CATextLayer *rearTitleLayer;
@property (nonatomic, strong) NSMutableDictionary *titleLayerDicM;
@property (nonatomic, strong) NSMutableArray<CATextLayer*> *titleLayerArrM;

@end

@implementation Easy3DSemicircleView

-(void)didMoveToSuperview{
    NSLog(@"Please Complete %s", __func__);
}
-(void)didMoveToWindow{
    NSLog(@"Please Complete %s", __func__);
    if (self.dataSource) {
        
        self.titleLayerDicM = [NSMutableDictionary dictionary];
        self.titleLayerArrM = [NSMutableArray array];
        for (int i=0; i<17; ++i) {
            CATextLayer *titleLayer = [self createTitleLayerWithTransform:CATransform3DMakeRotation(M_PI, 0, 1, 0) rows:-1 title:nil];
            titleLayer.hidden = YES;
            [self.titleLayerArrM addObject:titleLayer];
        }
        self.numberOfRows = [self.dataSource numberOfRowsInEasy3DSemicircleView:self];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewTransformWithPanGestureRecognizer:)];
        [self addGestureRecognizer:panGesture];
        
        for (int i=0; i<8; ++i) {
            Easy3DSemicircleViewCell *cell = [self.dataSource easy3DSemicircleView:self cellForRow:i];
            if (cell) {
                CATransform3D transform = CATransform3DMakeRotation(2*M_PI/24*i, 0, 1, 0);
                CATextLayer *titleLayer = [self createTitleLayerWithTransform:transform rows:i title:cell.title];
                
                if (!self.frontTitleLayer) {
                    self.frontTitleLayer = titleLayer;
                }
                self.rearTitleLayer = titleLayer;
            }
        }
        self.cellContainer;
        
        NSLog(@"frontTitleLayer %@ transform is {%f %f %f %f} {%f %f %f %f} {%f %f %f %f} {%f %f %f %f}", self.frontTitleLayer.string, self.frontTitleLayer.transform.m11, self.frontTitleLayer.transform.m12, self.frontTitleLayer.transform.m13, self.frontTitleLayer.transform.m14, self.frontTitleLayer.transform.m21, self.frontTitleLayer.transform.m22, self.frontTitleLayer.transform.m23, self.frontTitleLayer.transform.m24, self.frontTitleLayer.transform.m31, self.frontTitleLayer.transform.m32, self.frontTitleLayer.transform.m33, self.frontTitleLayer.transform.m34, self.frontTitleLayer.transform.m41, self.frontTitleLayer.transform.m42, self.frontTitleLayer.transform.m43, self.frontTitleLayer.transform.m44);
        NSLog(@"%@ transform is {%f %f %f %f} {%f %f %f %f} {%f %f %f %f} {%f %f %f %f}", self.rearTitleLayer.string, self.rearTitleLayer.transform.m11, self.rearTitleLayer.transform.m12, self.rearTitleLayer.transform.m13, self.rearTitleLayer.transform.m14, self.rearTitleLayer.transform.m21, self.rearTitleLayer.transform.m22, self.rearTitleLayer.transform.m23, self.rearTitleLayer.transform.m24, self.rearTitleLayer.transform.m31, self.rearTitleLayer.transform.m32, self.rearTitleLayer.transform.m33, self.rearTitleLayer.transform.m34, self.rearTitleLayer.transform.m41, self.rearTitleLayer.transform.m42, self.rearTitleLayer.transform.m43, self.rearTitleLayer.transform.m44);

        [self refreshCurrentTitleLayer:self.titleLayerDicM[@"5"]];
    }
    
}
- (void)refreshCurrentTitleLayer:(CATextLayer*)textLayer{
//    CATransform3D currentTransgorm = CATransform3DIdentity;
//    CATransform3D trans = CATransform3DIdentity;
//    trans.m11 = currentTransgorm.m11 - trans.m11;
//    trans.m13 = currentTransgorm.m13 - trans.m13;
//    trans.m31 = currentTransgorm.m31 - trans.m31;
//    trans.m33 = currentTransgorm.m33 - trans.m33;
    CGFloat angle = atanf(textLayer.transform.m13/textLayer.transform.m11);
    Easy_WeakSelf(weakSelf);
    if (@available(iOS 10.0, *)) {
        CGFloat time = 0.80;
        CGFloat interval = 1.00/60.00;
        int counts = time/interval;
        int __block countsCopy = counts;
        [NSTimer scheduledTimerWithTimeInterval:interval repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf viewTransformWithAngle:angle/counts];
            countsCopy--;
            if (countsCopy<=0) {
                [timer invalidate];
            }
        }];
    } else {
        // Fallback on earlier versions
    }
//    NSTimer scheduledTimerWithTimeInterval:durTime/countSta repeats:YES block:^(NSTimer * _Nonnull timer)
//    [UIView animateWithDuration:8 animations:^{
//        [weakSelf.menuLayer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            obj.transform = CATransform3DRotate(obj.transform, angle, 0, 1, 0);
//        }];
//    }];
    
}
-(CATextLayer*)createTitleLayerWithTransform:(CATransform3D) transform rows:(NSInteger) row title:(NSString*)title{
    
    UIFont *font = [UIFont systemFontOfSize:15]; //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    CATextLayer *titleLayer = [CATextLayer layer];
    titleLayer.alignmentMode = kCAAlignmentCenter;
    titleLayer.backgroundColor = Easy_RandomColor.CGColor;
    titleLayer.string = title;
    titleLayer.name = [NSString stringWithFormat:@"%ld", row];
    titleLayer.anchorPoint = CGPointMake(-2, 0.5);
    titleLayer.frame = CGRectMake(self.bounds.size.width*2/3, self.bounds.size.height/2-22, self.bounds.size.width/3, 44);
    titleLayer.wrapped = YES; //choose a font
    titleLayer.font = fontRef;
    titleLayer.fontSize = font.pointSize;
    titleLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.menuLayer addSublayer:titleLayer];
    titleLayer.transform = transform;
    CGFontRelease(fontRef);
    if (row>=0) {
        [self.titleLayerDicM setValue:titleLayer forKey:titleLayer.name];
    }
    return titleLayer;
}
-(void)removeTitleLayer:(CATextLayer*)textLayer{
    NSString *row = textLayer.name;
    [textLayer removeFromSuperlayer];
    [self.titleLayerDicM removeObjectForKey:textLayer.name];
    if ([textLayer isEqual:self.frontTitleLayer]) {
        NSString *nextRow = [NSString stringWithFormat:@"%ld", row.integerValue+1];
        if ([self.titleLayerDicM.allKeys containsObject:nextRow]) {
            self.frontTitleLayer = self.titleLayerDicM[nextRow];
        }
    }else if ([textLayer isEqual:self.rearTitleLayer]){
        NSString *preRow = [NSString stringWithFormat:@"%ld", row.integerValue-1];
        if ([self.titleLayerDicM.allKeys containsObject:preRow]) {
            self.rearTitleLayer = self.titleLayerDicM[preRow];
        }
    }
}
- (void)viewTransformWithPanGestureRecognizer:(UIPanGestureRecognizer*) pan{
    CGPoint point = [pan translationInView:self];
    CGFloat angleX = (point.x-self.zeroPoint.x)/200;
    self.zeroPoint = point;
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.zeroPoint = CGPointZero;
    }
    [self viewTransformWithAngle:angleX];
}
- (void)viewTransformWithAngle:(CGFloat)angleX{
    [self.menuLayer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //缺少模拟重力的翻转量
        obj.transform = CATransform3DRotate(obj.transform, angleX, 0, 1, 0);
    }];
    if (self.frontTitleLayer.transform.m11>0 && self.frontTitleLayer.transform.m13>0 && ![self.frontTitleLayer.name isEqualToString:@"0"]) {
        CATransform3D transform = CATransform3DRotate(self.frontTitleLayer.transform, -2*M_PI/24, 0, 1, 0);
        NSInteger row = self.frontTitleLayer.name.integerValue-1;
        self.frontTitleLayer = [self createTitleLayerWithTransform:transform rows:row title:[NSString stringWithFormat:@"row is %ld", row]];
        NSLog(@"front appear");
    }
    if (self.frontTitleLayer.transform.m11<-0.5 && self.frontTitleLayer.transform.m13>0) {
        NSLog(@"front disappear");
//        [self removeTitleLayer:self.frontTitleLayer];
        self.frontTitleLayer.hidden = YES;
        self.frontTitleLayer = self.titleLayerDicM[[NSString stringWithFormat:@"%d", self.frontTitleLayer.name.intValue+1]];
    }
    
    if (self.rearTitleLayer.transform.m11>0 && self.rearTitleLayer.transform.m13<0 && !(self.numberOfRows-1==self.rearTitleLayer.name.integerValue)) {
        CATransform3D transform = CATransform3DRotate(self.rearTitleLayer.transform, 2*M_PI/24, 0, 1, 0);
        NSInteger row = self.rearTitleLayer.name.integerValue+1;
        if (self.titleLayerArrM.count>0) {
            CATextLayer *titleLayer = self.titleLayerArrM.firstObject;
            [self.titleLayerArrM enumerateObjectsUsingBlock:^(CATextLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.transform = transform;
            }];
//            titleLayer.transform = transform;
            titleLayer.hidden = NO;
            titleLayer.name = [NSString stringWithFormat:@"%ld", row];
            titleLayer.string = [NSString stringWithFormat:@"row is %ld", row];
            [self.titleLayerDicM setObject:titleLayer forKey:titleLayer.name];
            [self.titleLayerArrM removeObject:titleLayer];
            self.rearTitleLayer = titleLayer;

        }else{
            self.rearTitleLayer = [self createTitleLayerWithTransform:transform rows:row title:[NSString stringWithFormat:@"row is %ld", row]];
        }
        NSLog(@"rear appear");
    }
    if (self.rearTitleLayer.transform.m11<-0.5 && self.rearTitleLayer.transform.m13<0) {
        NSLog(@"rear disappear");
        [self removeTitleLayer:self.rearTitleLayer];
    }
    NSLog(@"frontTitleLayer %@ transform is {%f %f %f %f} {%f %f %f %f} {%f %f %f %f} {%f %f %f %f}", self.frontTitleLayer.string, self.frontTitleLayer.transform.m11, self.frontTitleLayer.transform.m12, self.frontTitleLayer.transform.m13, self.frontTitleLayer.transform.m14, self.frontTitleLayer.transform.m21, self.frontTitleLayer.transform.m22, self.frontTitleLayer.transform.m23, self.frontTitleLayer.transform.m24, self.frontTitleLayer.transform.m31, self.frontTitleLayer.transform.m32, self.frontTitleLayer.transform.m33, self.frontTitleLayer.transform.m34, self.frontTitleLayer.transform.m41, self.frontTitleLayer.transform.m42, self.frontTitleLayer.transform.m43, self.frontTitleLayer.transform.m44);
    NSLog(@"rearTitleLayer %@ transform is {%f %f %f %f} {%f %f %f %f} {%f %f %f %f} {%f %f %f %f}", self.rearTitleLayer.string, self.rearTitleLayer.transform.m11, self.rearTitleLayer.transform.m12, self.rearTitleLayer.transform.m13, self.rearTitleLayer.transform.m14, self.rearTitleLayer.transform.m21, self.rearTitleLayer.transform.m22, self.rearTitleLayer.transform.m23, self.rearTitleLayer.transform.m24, self.rearTitleLayer.transform.m31, self.rearTitleLayer.transform.m32, self.rearTitleLayer.transform.m33, self.rearTitleLayer.transform.m34, self.rearTitleLayer.transform.m41, self.rearTitleLayer.transform.m42, self.rearTitleLayer.transform.m43, self.rearTitleLayer.transform.m44);
    NSLog(@" mpi/4 is %f, hudu is %f", M_PI_4, atanf(self.frontTitleLayer.transform.m13/self.frontTitleLayer.transform.m11));
    //    NSLog(@"subs transform is {%f %f %f %f} {%f %f %f %f} {%f %f %f %f} {%f %f %f %f}",self.menuLayer.sublayerTransform.m11, self.menuLayer.sublayerTransform.m12, self.menuLayer.sublayerTransform.m13, self.menuLayer.sublayerTransform.m14, self.menuLayer.sublayerTransform.m21, self.menuLayer.sublayerTransform.m22, self.menuLayer.sublayerTransform.m23, self.menuLayer.sublayerTransform.m24, self.menuLayer.sublayerTransform.m31, self.menuLayer.sublayerTransform.m32, self.menuLayer.sublayerTransform.m33, self.menuLayer.sublayerTransform.m34, self.menuLayer.sublayerTransform.m41, self.menuLayer.sublayerTransform.m42, self.menuLayer.sublayerTransform.m43, self.menuLayer.sublayerTransform.m44);
}
//-(Easy3DSemicircleViewCell*)dequeueReusableCellWithIdentifier:(NSString *)identifier forRow:(NSUInteger)row{
//
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark ---- Setter
#pragma mark ---- Getter
-(CALayer *)menuLayer{
    if (!_menuLayer) {
        _menuLayer = [[CALayer alloc] init];
        _menuLayer.anchorPoint = CGPointMake(0, 0.5);
        _menuLayer.frame = self.layer.bounds;
        CATransform3D mainTrans = CATransform3DIdentity;
        mainTrans.m34 = 1/-500;
        _menuLayer.sublayerTransform = CATransform3DRotate(mainTrans, -M_PI_4, 1, 0, 0);
//        _menuLayer.masksToBounds = YES;
        [self.layer addSublayer:_menuLayer];
    }
    return _menuLayer;
}
-(UIView *)cellContainer{
    if (!_cellContainer) {
        _cellContainer = [[UIView alloc] init];
        _cellContainer.backgroundColor = [UIColor brownColor];
        _cellContainer.frame = CGRectMake(10, CGRectGetHeight(self.bounds)/6, CGRectGetWidth(self.bounds)*0.5, CGRectGetHeight(self.bounds)/2);
        [self addSubview:_cellContainer];
    }
    return _cellContainer;
}
@end
