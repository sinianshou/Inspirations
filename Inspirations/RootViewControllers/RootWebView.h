//
//  RootWebView.h
//  Inspirations
//
//  Created by Easer on 2018/2/8.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyWebView.h"

@interface RootWebView : EasyWebView

@property (nonatomic,copy) void(^didGetAccessTokenBlock)(BOOL success);

@end
