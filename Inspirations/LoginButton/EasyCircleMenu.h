//
//  EasyCircleMenu.h
//  Inspirations
//
//  Created by Easer on 2018/2/10.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyCircleMenu : UIWindow<CAAnimationDelegate>

@property  (strong, nonatomic) UIButton * centerButton;
@property  (strong, nonatomic) NSMutableArray<UIButton*>* circleButtons;
@property  (copy, nonatomic) BOOL (^shouldClickCenterButton)(void);
@property  (copy, nonatomic) void (^clickCenterButtonFinished)(void);

-(instancetype)initWithCenterButtonRadius:(CGFloat)CBRadius;
-(void)setCenterButtonWithRadius:(CGFloat)CBRadius;
-(void)setCenterButtonIconForState:(NSArray *)IconStateArrs;
-(void)setCircleButtonsWithImgs: (NSArray<UIImage*>*) iconArray Radius:(CGFloat) circleButtonRadius;

@end
