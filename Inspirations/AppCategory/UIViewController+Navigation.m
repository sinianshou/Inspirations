//
//  UIViewController+Navigation.m
//  Inspirations
//
//  Created by Easer on 2018/2/21.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

+(void)load{
    [super load];
    __easy_swizzleViewDidLoadMethod([self class]);
    
    //    class_replaceMethod(class, selector, _objc_msgForward, method_getTypeEncoding(targetMethod));
    //    id newForwardInvocation = ^(id self, NSInvocation *invocation) { //hook时要添加的代码放在这里
    //        if (originalForwardInvocation == NULL) {
    //            [self doesNotRecognizeSelector:invocation.selector];
    //
    //        } else {
    //            originalForwardInvocation(self, forwardInvocationSEL, invocation);
    //
    //        }
    //
    //    };
    //    class_replaceMethod(class, @selector(forwardInvocation:), imp_implementationWithBlock(newForwardInvocation), "v@:@")
    
}

void __easy_swizzleViewDidLoadMethod(Class class){
    
    // 获取imageName:方法的地址
    Method viewDidLoadMethod = class_getInstanceMethod(class, @selector(viewDidLoad));
    //    Method viewDidLoadMethod = class_getClassMethod(self, @selector(viewDidLoad));
    // 获取wg_imageWithName:方法的地址
    
    Method easy_viewDidLoadMethod = class_getInstanceMethod(class, @selector(easy_ViewDidLoadMethod));
    //    Method easy_viewDidLoadMethod = class_getClassMethod(self, @selector(easy_ViewDidLoadMethod));
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(viewDidLoadMethod, easy_viewDidLoadMethod);
    
}
-(void)easy_ViewDidLoadMethod{
    NSLog(@"Please Complete %s", __func__);
    
    [self easy_ViewDidLoadMethod];
    
    UIButton *bn = [[UIButton alloc] init];
    bn.bounds = CGRectMake(0, 0, 44, 44);
    bn.backgroundColor = [UIColor brownColor];
    [self easy_AddRightButton:bn];
}
@end
