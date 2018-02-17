//
//  EasyCATransform3D.m
//  Inspirations
//
//  Created by Easer on 2018/2/17.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyCATransform3D.h"

@implementation EasyCATransform3D

+ (CATransform3D)transform:(CATransform3D)transformA minus:(CATransform3D)transformB{
    transformA.m11 = transformA.m11 - transformB.m11;
    transformA.m12 = transformA.m12 - transformB.m12;
    transformA.m13 = transformA.m13 - transformB.m13;
    transformA.m14 = transformA.m14 - transformB.m14;
    
    transformA.m21 = transformA.m21 - transformB.m21;
    transformA.m22 = transformA.m22 - transformB.m22;
    transformA.m23 = transformA.m23 - transformB.m23;
    transformA.m24 = transformA.m24 - transformB.m24;
    
    transformA.m31 = transformA.m31 - transformB.m31;
    transformA.m32 = transformA.m32 - transformB.m32;
    transformA.m33 = transformA.m33 - transformB.m33;
    transformA.m34 = transformA.m34 - transformB.m34;
    
    transformA.m41 = transformA.m41 - transformB.m41;
    transformA.m42 = transformA.m42 - transformB.m42;
    transformA.m43 = transformA.m43 - transformB.m43;
    transformA.m44 = transformA.m44 - transformB.m44;
    
    return transformA;
}

@end
