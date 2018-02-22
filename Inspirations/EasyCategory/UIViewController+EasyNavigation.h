//
//  UIViewController+EasyNavigation.h
//  Inspirations
//
//  Created by Easer on 2018/2/21.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (EasyNavigation)

-(void)easy_AddRightButton:(UIButton*)button;
-(void)easy_AddRightItem:(UIBarButtonItem*)item;
-(void)easy_AddRightItems:(NSArray*)items;

@end
