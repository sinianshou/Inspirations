//
//  Easy3DSemicircleView.m
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//
/*
 cell.frame 会因未知原因导致与self.cellContainer.bounds不一致
 当cell数量《=2时需要处理
 需要defaultCell来填补空白cell以及topcell
 */

#import "Easy3DSemicircleView.h"
#import "Easy3DSemicircleViewCell.h"

@interface Easy3DSemicircleView ()

@property (nonatomic, strong) UIView *cellContainer;
@property (nonatomic, strong) NSMutableDictionary <NSString*, Easy3DSemicircleViewCell*>*cellQueueDicM;
@property (nonatomic, strong) NSMutableDictionary <NSString*, Easy3DSemicircleViewCell*>*visiableCellDicM;
@property (nonatomic, strong) Easy3DSemicircleViewCell *currentCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *leftCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *rightCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *behindCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *leftDefaultCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *rightDefaultCell;
@property (nonatomic, strong) Easy3DSemicircleViewCell *topDefaultCell;

@property (nonatomic, strong) CALayer *menuLayer;
@property (nonatomic, assign) CGPoint zeroPoint;
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
    [self loadData];
}
- (void)loadData{
    self.numberOfRows = [self.dataSource numberOfRowsInEasy3DSemicircleView:self];
    if (self.dataSource && self.numberOfRows>0) {
        self.cellQueueDicM = [NSMutableDictionary dictionary];
        self.visiableCellDicM = [NSMutableDictionary dictionary];
        self.titleLayerArrM = [NSMutableArray array];
        self.titleLayertextColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        for (int i=0; i<24; ++i) {
            CATransform3D transform = CATransform3DMakeRotation(2*M_PI/24*i, 0, 1, 0);
            CATextLayer *titleLayer = [self createTitleLayerWithTransform:transform];
            [self.titleLayerArrM addObject:titleLayer];
        }
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewTransformWithPanGestureRecognizer:)];
        [self addGestureRecognizer:panGesture];
        [self reloadData];
    }
}
- (void)reloadData{
    if (self.dataSource && self.numberOfRows>0) {
        for (int i=0; i<self.numberOfRows; ++i) {
            Easy3DSemicircleViewCell *cell = [self getCellInRow:i];
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
        
        NSInteger row = self.frontTitleLayer.name.integerValue;
        Easy3DSemicircleViewCell *cell = [self getCellInRow:row];
        [self.visiableCellDicM removeObjectForKey:[NSString stringWithFormat:@"%ld", row]];
        if (![self.cellQueueDicM.allKeys containsObject:cell.reuseIdentifier]) {
            [self.cellQueueDicM setValue:cell forKey:cell.reuseIdentifier];
            cell.hidden = YES;
        }else{
            [cell removeFromSuperview];
        }
        
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
        NSInteger row = self.rearTitleLayer.name.integerValue;
        Easy3DSemicircleViewCell *cell = [self getCellInRow:row];
        [self.visiableCellDicM removeObjectForKey:[NSString stringWithFormat:@"%ld", row]];
        if (![self.cellQueueDicM.allKeys containsObject:cell.reuseIdentifier]) {
            [self.cellQueueDicM setValue:cell forKey:cell.reuseIdentifier];
            cell.hidden = YES;
        }else{
            [cell removeFromSuperview];
        }
        self.rearTitleLayer = [self.titleLayerArrM objectAtIndex:index];
    }
}
- (void)configTitleLayer:(CATextLayer*)titleLayer InRow:(NSInteger)row{
    if(self.dataSource){
        Easy3DSemicircleViewCell *cell = [self getCellInRow:row];
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
    titleLayer.truncationMode = kCATruncationEnd;
    titleLayer.backgroundColor = self.titleLayertextColor.CGColor;
    titleLayer.hidden = YES;
    titleLayer.name = [NSString stringWithFormat:@"%d", -1];
    titleLayer.anchorPoint = CGPointMake(-2, 0.5);
    titleLayer.frame = CGRectMake(self.bounds.size.width*2/3, self.bounds.size.height/2-22, self.bounds.size.width/3, 44);
    titleLayer.wrapped = YES; //choose a font
    titleLayer.font = fontRef;
    titleLayer.fontSize = font.pointSize;
    titleLayer.foregroundColor = [UIColor blackColor].CGColor;
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
    /*
     2*M_PI/24
     2*M_PI/4
     angleX*6
     */
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
        _menuLayer.sublayerTransform = CATransform3DRotate(mainTrans, -M_PI/4, 1, 0, 0);
//        _menuLayer.masksToBounds = YES;
        [self.layer addSublayer:_menuLayer];
    }
    return _menuLayer;
}
-(UIView *)cellContainer{
    if (!_cellContainer) {
        _cellContainer = [[UIView alloc] init];
        _cellContainer.backgroundColor = [UIColor clearColor];
        _cellContainer.frame = CGRectMake(10, CGRectGetHeight(self.bounds)*0.08, CGRectGetWidth(self.bounds)*0.5, CGRectGetHeight(self.bounds)*0.5);
        CATransform3D mainTrans = CATransform3DIdentity;
        //        mainTrans.m34 = -1.0/1000;
        mainTrans.m34 = -1/1000;
        _cellContainer.layer.sublayerTransform = CATransform3DRotate(mainTrans, -M_PI/30, 1, 0, 0);
        [self addSubview:_cellContainer];
    }
    return _cellContainer;
}

#pragma mark ---- CellContainer Cube Methods
- (void)refreshCellContainerWithAngle:(CGFloat)angleX{
    if (self.currentTitleLayer) {
        NSInteger currentRow = self.currentTitleLayer.name.integerValue;
        NSInteger leftRow = self.currentTitleLayer.name.integerValue-1;
        leftRow = leftRow<-1?-1:leftRow;
        NSInteger rightRow = self.currentTitleLayer.name.integerValue+1;
        rightRow = rightRow>=self.numberOfRows?-1:rightRow;
        NSInteger behindRow = angleX<=0?((rightRow<0)?(-1):(rightRow+1)):(leftRow-1);
        behindRow = ((behindRow<0)||(behindRow>=self.numberOfRows))?-1:behindRow;
        
        [self refreshCellProperty:@"_currentCell" inRow:currentRow WithAngle:angleX];
        [self refreshCellProperty:@"_leftCell" inRow:leftRow WithAngle:angleX];
        [self refreshCellProperty:@"_rightCell" inRow:rightRow WithAngle:angleX];
        [self refreshCellProperty:@"_behindCell" inRow:behindRow WithAngle:angleX];
        
        self.currentCell.layer.transform = CATransform3DRotate(self.currentCell.layer.transform, angleX*6, 0, 1, 0);
        self.leftCell.layer.transform = CATransform3DRotate(self.currentCell.layer.transform, -M_PI_2, 0, 1, 0);
        self.rightCell.layer.transform = CATransform3DRotate(self.currentCell.layer.transform, M_PI_2, 0, 1, 0);
        self.behindCell.layer.transform = CATransform3DRotate(self.currentCell.layer.transform, M_PI, 0, 1, 0);
    }
    
}
- (void)refreshCellProperty:(NSString *)cellPropertyString inRow:(NSInteger)row WithAngle:(CGFloat)angleX{
    
    Easy3DSemicircleViewCell *cell = [self getCellInRow:row];
    const char* propertyName = [cellPropertyString UTF8String];
    Ivar ivar = class_getInstanceVariable([self class], propertyName);
    Easy3DSemicircleViewCell *cellProperty = object_getIvar(self, ivar);
    if (![cellProperty isEqual:cell]) {
        if ([cellPropertyString isEqualToString:@"_leftCell"]) {
            cellProperty.hidden = angleX<0?YES:NO;
        }else if ([cellPropertyString isEqualToString:@"_rightCell"]){
            cellProperty.hidden = angleX>0?YES:NO;
        }else if ([cellPropertyString isEqualToString:@"_behindCell"]){
            cellProperty.hidden = YES;
        }
        object_setIvar(self, ivar, cell);
    }
    if (cell.hidden) {
        cell.hidden = NO;
    }
    
}
- (Easy3DSemicircleViewCell*)getCellInRow:(NSInteger)row{
    Easy3DSemicircleViewCell *cell;
    if (row>=0) {
        NSString *rowStr = [NSString stringWithFormat:@"%ld", row];
        if ([self.visiableCellDicM.allKeys containsObject:rowStr]) {
            cell = [self.visiableCellDicM objectForKey:rowStr];
        }
        if (!cell && self.dataSource) {
            cell = [self.dataSource easy3DSemicircleView:self cellForRow:row];
            cell.hidden = YES;
            cell.frame = self.cellContainer.bounds;  //frame 会因未知原因导致与self.cellContainer.bounds不一致
            cell.layer.anchorPointZ = -CGRectGetWidth(self.cellContainer.bounds)*0.5;
//            cell.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            [self.cellContainer addSubview:cell];
            [self.visiableCellDicM setValue:cell forKey:rowStr];
            NSLog(@"in row %ld , za is %f, frame is %@, bounds is %@", row, cell.layer.anchorPointZ, NSStringFromCGRect(cell.frame), NSStringFromCGRect(self.cellContainer.bounds));
        }
    }
    return cell;
}
-(Easy3DSemicircleViewCell*)dequeueReusableCellWithIdentifier:(NSString *)identifier inRow:(NSInteger)row{
    Easy3DSemicircleViewCell *cell;
    if ([self.cellQueueDicM.allKeys containsObject:identifier]) {
        cell = [self.cellQueueDicM objectForKey:identifier];
        cell.hidden = YES;
        [self.cellQueueDicM removeObjectForKey:identifier];
    }
    
    return cell;
}
@end
