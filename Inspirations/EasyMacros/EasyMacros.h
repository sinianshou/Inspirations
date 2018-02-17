//
//  EasyMacros.h
//  Inspirations
//
//  Created by Easer on 2018/2/9.
//  Copyright © 2018年 Easer. All rights reserved.
//

#ifndef EasyMacros_h
#define EasyMacros_h
#import "AppDelegate.h"

//弱强Self的宏
#define Easy_WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define Easy_StrongSelf(strongSelf) __strong __typeof(&*self)strongSelf = self


//颜色相关的宏
#define Easy_Random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define Easy_RandomColor Easy_Random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 255.0)


//Code缩减的宏
#define Easy_SharedAppDelegate(appDelegate) AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate]
#define Easy_UserDefaults(userDefaults) NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]
#define Easy_AsyncMainQueue(blockCode) dispatch_async(dispatch_get_main_queue(), ^{\
    blockCode\
})


//NSLog()的宏
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif


#endif /* EasyMacros_h */
