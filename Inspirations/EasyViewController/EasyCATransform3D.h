//
//  EasyCATransform3D.h
//  Inspirations
//
//  Created by Easer on 2018/2/17.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyCATransform3D : NSObject

+ (CATransform3D)transform:(CATransform3D)transformA minus:(CATransform3D)transformB;

@end

