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

typedef struct Easy3DSemicircleViewCellNode {
    __unsafe_unretained Easy3DSemicircleViewCell *cell;
    NSInteger row;
    __unsafe_unretained NSString *reuseIdentifier;
}Easy3DSemicircleViewCellNode;

@interface Easy3DSemicircleView ()

@property (nonatomic, strong) CALayer *menuLayer;
@property (nonatomic, assign) CGPoint zeroPoint;
@property (nonatomic, strong) UIView *cellContainer;
@property (nonatomic, strong) NSMutableDictionary <NSString*, Easy3DSemicircleViewCell*>*cellQueueDicM;
@property (nonatomic, strong) Easy3DSemicircleViewCell *currentCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *leftCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *rightCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *behindCell;

@property (nonatomic, strong) CATextLayer *frontTitleLayer;
@property (nonatomic, strong) CATextLayer *currentTitleLayer;
@property (nonatomic, strong) CATextLayer *rearTitleLayer;
@property (nonatomic, strong) NSMutableArray<CATextLayer*> *titleLayerArrM;

@end

@implementation Easy3DSemicircleView

-(void)didMoveToSuperview{
    NSLog(@"Please Complete %s", __func__);
    
}
-(void)didMoveToWindow{
    NSLog(@"Please Complete %s", __func__);
    if (self.dataSource) {
        self.cellQueueDicM = [NSMutableDictionary dictionary];
        self.titleLayerArrM = [NSMutableArray array];
        for (int i=0; i<24; ++i) {
            CATransform3D transform = CATransform3DMakeRotation(2*M_PI/24*i, 0, 1, 0);
            CATextLayer *titleLayer = [self createTitleLayerWithTransform:transform];
            [self.titleLayerArrM addObject:titleLayer];
        }
        self.numberOfRows = [self.dataSource numberOfRowsInEasy3DSemicircleView:self];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewTransformWithPanGestureRecognizer:)];
        [self addGestureRecognizer:panGesture];
        
        for (int i=0; i<self.numberOfRows; ++i) {
            Easy3DSemicircleViewCell *cell = [self.dataSource easy3DSemicircleView:self cellForRow:i];
            if (cell) {
                CATextLayer *titleLayer = [self.titleLayerArrM objectAtIndex:i];
                [self configTitleLayer:titleLayer InRow:i];
                if (!self.frontTitleLayer) {
                    self.frontTitleLayer = titleLayer;
                    self.currentTitleLayer = self.frontTitleLayer;
                }
                
                self.rearTitleLayer = titleLayer;
                titleLayer.hidden = NO;
                if ([self shouldRearTitleLayerDisappear]) {
                    break;
                }
            }
        }
        [self refreshCellContainerWithAngle:0];
        [self logFrontAndRearTitleTransform];
    }
    
}
-(BOOL)isFrontTitleLayerAppear{
    return self.frontTitleLayer.transform.m11>0 && self.frontTitleLayer.transform.m13>0;
}
-(BOOL)shouldFrontTitleLayerDisappear{
    return self.frontTitleLayer.transform.m11<-0.5 && self.frontTitleLayer.transform.m13>0;
}
-(BOOL)isFrontTitleLayerTheFirstElement{
    NSInteger frontRow = self.frontTitleLayer.name.integerValue;
    BOOL isTheFirstRow = frontRow==0;
    return isTheFirstRow;
}
-(BOOL)isRearTitleLayerAppear{
    return self.rearTitleLayer.transform.m11>0 && self.rearTitleLayer.transform.m13<0;
}
-(BOOL)shouldRearTitleLayerDisappear{
    return self.rearTitleLayer.transform.m11<-0.5 && self.rearTitleLayer.transform.m13<0;
}
-(BOOL)isRearTitleLayerTheLastElement{
    NSInteger rearRow = self.rearTitleLayer.name.integerValue;
    NSInteger lastRow = (self.numberOfRows-1);
    BOOL isTheLastRow = rearRow >= lastRow;
    return isTheLastRow;
}

int timerCounts;
- (void)changeCurrentTitleLayerTo:(CATextLayer*)textLayer{
    CGFloat angle = atanf(textLayer.transform.m13/textLayer.transform.m11);
    CGFloat time = 0.20;
    CGFloat interval = 1.00/60.00;
    timerCounts = time/interval;
    CGFloat angleX = angle/timerCounts;
    [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(scrollWithTimer:) userInfo:@(angleX) repeats:YES];}
- (void)scrollWithTimer:(NSTimer*)timer{
    CGFloat angleX = ((NSNumber*)timer.userInfo).floatValue;
    [self viewTransformWithAngle:angleX];
    timerCounts--;
    if (timerCounts<=0) {
        [timer invalidate];
    }
}
- (void)refreshFrontTitleLayerIndex{
    if ([self isFrontTitleLayerAppear] && ![self isFrontTitleLayerTheFirstElement]) {
        NSInteger row = self.frontTitleLayer.name.integerValue-1;
        NSInteger index = [self.titleLayerArrM indexOfObject:self.frontTitleLayer]-1;
        index = (index==-1)?(self.titleLayerArrM.count-1):index;
        self.frontTitleLayer = [self.titleLayerArrM objectAtIndex:index];
        self.frontTitleLayer.hidden = NO;
        [self configTitleLayer:self.frontTitleLayer InRow:row];
        NSLog(@"front appear");
    }
    if ([self shouldFrontTitleLayerDisappear]) {
        NSLog(@"front disappear");
        NSInteger index = [self.titleLayerArrM indexOfObject:self.frontTitleLayer]+1;
        index = index%self.titleLayerArrM.count;
        self.frontTitleLayer.hidden = YES;
        self.frontTitleLayer = [self.titleLayerArrM objectAtIndex:index];
    }
}
- (void)refreshCurrentTitleLayer{
    NSInteger frontIndex = [self.titleLayerArrM indexOfObject:self.frontTitleLayer];
    NSInteger rearIndex = [self.titleLayerArrM indexOfObject:self.rearTitleLayer];
    if (rearIndex>=frontIndex) {
        for (NSInteger i=frontIndex; i<=rearIndex; i++) {
            CATextLayer *titleLayer = [self.titleLayerArrM objectAtIndex:i];
            [self checkIfCurrentTitleLayer:titleLayer];
        }
    }else{
        for (NSInteger i=frontIndex; i<self.titleLayerArrM.count; i++) {
            CATextLayer *titleLayer = [self.titleLayerArrM objectAtIndex:i];
            [self checkIfCurrentTitleLayer:titleLayer];
        }
        for (NSInteger i=0; i<=rearIndex; i++) {
            CATextLayer *titleLayer = [self.titleLayerArrM objectAtIndex:i];
            [self checkIfCurrentTitleLayer:titleLayer];
        }
    }
}
- (void)checkIfCurrentTitleLayer:(CATextLayer*)titleLayer{
    if (!self.currentTitleLayer) {
        self.currentTitleLayer = titleLayer;
        return;
    }
    if (self.currentTitleLayer.transform.m11<titleLayer.transform.m11) {
        self.currentTitleLayer = titleLayer;
    }
}
- (void)refreshRearTitleLayerIndex{
    if ([self isRearTitleLayerAppear] && ![self isRearTitleLayerTheLastElement]) {
        NSLog(@"rear appear");
        NSInteger row = self.rearTitleLayer.name.integerValue+1;
        NSInteger index = [self.titleLayerArrM indexOfObject:self.rearTitleLayer]+1;
        index = index%self.titleLayerArrM.count;
        self.rearTitleLayer = [self.titleLayerArrM objectAtIndex:index];
        self.rearTitleLayer.hidden = NO;
        [self configTitleLayer:self.rearTitleLayer InRow:row];
    }
    if ([self shouldRearTitleLayerDisappear]) {
        NSLog(@"rear disappear");
        NSInteger index = [self.titleLayerArrM indexOfObject:self.rearTitleLayer]-1;
        index = (index==-1)?(self.titleLayerArrM.count-1):index;
        self.rearTitleLayer.hidden = YES;
        self.rearTitleLayer = [self.titleLayerArrM objectAtIndex:index];
        
    }
}
- (void)configTitleLayer:(CATextLayer*)titleLayer InRow:(NSInteger)row{
    if(self.dataSource){
        Easy3DSemicircleViewCell *cell = [self.dataSource easy3DSemicircleView:self cellForRow:row];
        titleLayer.string = cell.title;
        titleLayer.name = [NSString stringWithFormat:@"%ld", row];
    }
}
-(CATextLayer*)createTitleLayerWithTransform:(CATransform3D) transform{
    
    UIFont *font = [UIFont systemFontOfSize:15]; //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    CATextLayer *titleLayer = [CATextLayer layer];
    titleLayer.alignmentMode = kCAAlignmentCenter;
    titleLayer.backgroundColor = Easy_RandomColor.CGColor;
    titleLayer.hidden = YES;
    titleLayer.name = [NSString stringWithFormat:@"%d", -1];
    titleLayer.anchorPoint = CGPointMake(-2, 0.5);
    titleLayer.frame = CGRectMake(self.bounds.size.width*2/3, self.bounds.size.height/2-22, self.bounds.size.width/3, 44);
    titleLayer.wrapped = YES; //choose a font
    titleLayer.font = fontRef;
    titleLayer.fontSize = font.pointSize;
    titleLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.menuLayer addSublayer:titleLayer];
    titleLayer.transform = transform;
    CGFontRelease(fontRef);
    return titleLayer;
}
- (void)viewTransformWithPanGestureRecognizer:(UIPanGestureRecognizer*) pan{
    CGPoint point = [pan translationInView:self];
    CGFloat angleX = (point.x-self.zeroPoint.x)/200;
    self.zeroPoint = point;
    [self viewTransformWithAngle:angleX];
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.zeroPoint = CGPointZero;
        if (self.currentTitleLayer) {
            NSLog(@"current is %@", self.currentTitleLayer.string);
            [self changeCurrentTitleLayerTo:self.currentTitleLayer];
        }
    }
}
- (void)viewTransformWithAngle:(CGFloat)angleX{
    [self.menuLayer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //缺少模拟重力的翻转量
        obj.transform = CATransform3DRotate(obj.transform, angleX, 0, 1, 0);
    }];
    
    [self refreshFrontTitleLayerIndex];
    [self refreshCurrentTitleLayer];
    [self refreshCellContainerWithAngle:angleX];
    [self refreshRearTitleLayerIndex];
    [self logFrontAndRearTitleTransform];
}
-(void)logFrontAndRearTitleTransform{
    NSLog(@"frontTitleLayer %@ transform is {%f %f %f %f} {%f %f %f %f} {%f %f %f %f} {%f %f %f %f}", self.frontTitleLayer.string, self.frontTitleLayer.transform.m11, self.frontTitleLayer.transform.m12, self.frontTitleLayer.transform.m13, self.frontTitleLayer.transform.m14, self.frontTitleLayer.transform.m21, self.frontTitleLayer.transform.m22, self.frontTitleLayer.transform.m23, self.frontTitleLayer.transform.m24, self.frontTitleLayer.transform.m31, self.frontTitleLayer.transform.m32, self.frontTitleLayer.transform.m33, self.frontTitleLayer.transform.m34, self.frontTitleLayer.transform.m41, self.frontTitleLayer.transform.m42, self.frontTitleLayer.transform.m43, self.frontTitleLayer.transform.m44);
    NSLog(@"rearTitleLayer %@ transform is {%f %f %f %f} {%f %f %f %f} {%f %f %f %f} {%f %f %f %f}", self.rearTitleLayer.string, self.rearTitleLayer.transform.m11, self.rearTitleLayer.transform.m12, self.rearTitleLayer.transform.m13, self.rearTitleLayer.transform.m14, self.rearTitleLayer.transform.m21, self.rearTitleLayer.transform.m22, self.rearTitleLayer.transform.m23, self.rearTitleLayer.transform.m24, self.rearTitleLayer.transform.m31, self.rearTitleLayer.transform.m32, self.rearTitleLayer.transform.m33, self.rearTitleLayer.transform.m34, self.rearTitleLayer.transform.m41, self.rearTitleLayer.transform.m42, self.rearTitleLayer.transform.m43, self.rearTitleLayer.transform.m44);
    NSLog(@" mpi/4 is %f, hudu is %f", M_PI_4, atanf(self.frontTitleLayer.transform.m13/self.frontTitleLayer.transform.m11));
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark ---- Setter
#pragma mark ---- Getter

-(NSString *)reuseIdentifier{
    if (_reuseIdentifier == nil) {
        _reuseIdentifier = @"Easy3DSemicircleViewCell";
    }
    return _reuseIdentifier;
}
-(CALayer *)menuLayer{
    if (!_menuLayer) {
        _menuLayer = [[CALayer alloc] init];
        _menuLayer.anchorPoint = CGPointMake(0, 0.5);
        _menuLayer.frame = self.layer.bounds;
        CATransform3D mainTrans = CATransform3DIdentity;
//        mainTrans.m34 = -1.0/1000;
        mainTrans.m34 = -1/1000;
        _menuLayer.sublayerTransform = CATransform3DRotate(mainTrans, -M_PI/6, 1, 0, 0);
        _menuLayer.masksToBounds = YES;
        [self.layer addSublayer:_menuLayer];
    }
    return _menuLayer;
}
-(UIView *)cellContainer{
    if (!_cellContainer) {
        _cellContainer = [[UIView alloc] init];
        _cellContainer.backgroundColor = [UIColor brownColor];
        _cellContainer.frame = CGRectMake(10, CGRectGetHeight(self.bounds)/6, CGRectGetWidth(self.bounds)*0.5, CGRectGetHeight(self.bounds)*0.5);
        [self addSubview:_cellContainer];
    }
    return _cellContainer;
}

#pragma mark ---- CellContainer Cube Methods
- (void)refreshCellContainerWithAngle:(CGFloat)angleX{
//    self.cellContainer;
    if (self.currentTitleLayer) {
        NSInteger currentRow = self.currentTitleLayer.name.integerValue;
        NSInteger leftRow = self.currentTitleLayer.name.integerValue-1;
        leftRow = leftRow<-1?-1:leftRow;
        NSInteger rightRow = self.currentTitleLayer.name.integerValue+1;
        rightRow = rightRow>=self.numberOfRows?-1:rightRow;
        NSInteger behindRow = angleX<=0?(rightRow+1):(leftRow-1);
        behindRow = ((behindRow<-1)||(behindRow>=self.numberOfRows))?-1:behindRow;
        Easy3DSemicircleViewCell *currentCell = [self.dataSource easy3DSemicircleView:self cellForRow:currentRow];
        if (![self.cellContainer.subviews containsObject:currentCell]) {
            currentCell.frame = self.cellContainer.bounds;
            [self.cellContainer addSubview:currentCell];
        }
        self.currentCell = currentCell;
        /*
         if(标记有值){
         
         }else{
         
         }
         标记是否有值
         -1 reture nil
         不是-1 判断是否已显示
         已显示 直接赋予标记
         未显示 去队列获取
         获取到 配置 赋予标记
         未获取到 创建 赋予标记
         */
        Easy3DSemicircleViewCell *leftCell;
        if (leftRow>=0) {
            leftCell = [self.dataSource easy3DSemicircleView:self cellForRow:leftRow];
            if (![self.cellContainer.subviews containsObject:leftCell]) {
                leftCell.frame = self.cellContainer.bounds;
                [self.cellContainer addSubview:leftCell];
            }
        }
        self.leftCell = leftCell;
        
        Easy3DSemicircleViewCell *rightCell;
        if (rightRow>=0) {
            rightCell = [self.dataSource easy3DSemicircleView:self cellForRow:rightRow];
            if (![self.cellContainer.subviews containsObject:rightCell]) {
                rightCell.frame = self.cellContainer.bounds;
                [self.cellContainer addSubview:rightCell];
            }
        }
        self.rightCell = rightCell;
        
        Easy3DSemicircleViewCell *behindCell;
        if (behindRow>=0) {
            behindCell = [self.dataSource easy3DSemicircleView:self cellForRow:behindRow];
            if (![self.cellContainer.subviews containsObject:behindCell]) {
                behindCell.frame = self.cellContainer.bounds;
                [self.cellContainer addSubview:behindCell];
            }
        }
        if(behindCell){
            if (self.behindCell) {
                if (![self.behindCell isEqual:behindCell]) {
                    if ([self.cellQueueDicM.allKeys containsObject:self.behindCell.reuseIdentifier]) {
                        [self.behindCell removeFromSuperview];
                    }else{
                        [self.cellQueueDicM setObject:self.behindCell forKey:self.behindCell.reuseIdentifier];
                        self.behindCell.hidden = YES;
                    }
                }
            }
            self.behindCell = behindCell;
        }
    }
    
}

-(Easy3DSemicircleViewCell*)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    Easy3DSemicircleViewCell *cell;
    if ([self.cellQueueDicM.allKeys containsObject:identifier]) {
        cell = [self.cellQueueDicM objectForKey:identifier];
        cell.hidden = NO;
        [self.cellQueueDicM removeObjectForKey:identifier];
    }
    return cell;
}
@end
