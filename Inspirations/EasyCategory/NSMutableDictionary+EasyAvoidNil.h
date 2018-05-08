//
//  NSMutableDictionary+EasyAvoidNil.h
//  Inspirations
//
//  Created by Easer on 2018/2/15.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (EasyAvoidNil)

-(void)easy_setValue:(id)value forKey:(NSString *)key;
-(id)easy_valueForKey:(NSString *)key;

@end
