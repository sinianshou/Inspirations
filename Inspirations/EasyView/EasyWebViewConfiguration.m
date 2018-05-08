//
//  EasyWebViewConfiguration.m
//  Inspirations
//
//  Created by Easer on 2018/2/8.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyWebViewConfiguration.h"

@implementation EasyWebViewConfiguration
- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置configur对象的preferences属性的信息
        WKPreferences *preferences = [[WKPreferences alloc] init];
        self.preferences = preferences;
        
        //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
        preferences.javaScriptEnabled = YES;
    }
    return self;
}
@end
