//
//  BaseModel.h
//  Inspirations
//
//  Created by Easer on 2018/2/10.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
/**
 *  对象属相和服务器的键值关联
 *
 *  @return 映射键值对
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey;
/**
 *  在array属性中是什么对象class
 *
 *  @return 映射键值对
 */
+ (NSDictionary *)JSONObjectClassInArrayProperty;

@end
