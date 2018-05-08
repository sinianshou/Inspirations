//
//  UIViewController+EasyNavigation.m
//  Inspirations
//
//  Created by Easer on 2018/2/21.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "UIViewController+EasyNavigation.h"

@implementation UIViewController (EasyNavigation)

-(void)easy_AddRightButton:(UIButton*)button{
    [button sizeToFit];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self easy_AddItemForLeft:NO withItem:item spaceWidth:5];
}
-(void)easy_AddRightItem:(UIBarButtonItem*)item{
    [self easy_AddItemForLeft:NO withItem:item spaceWidth:5];
}

-(void)easy_AddRightItems:(NSArray*)items{
    [self easy_AddItemForLeft:NO withItem:items spaceWidth:5];
}
-(void)easy_AddItemForLeft:(BOOL)left withItem:(id)item spaceWidth:(CGFloat)width {
    if([item isKindOfClass:[UIBarButtonItem class]]){
        UIBarButtonItem *space = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil action:nil];
        space.width = width - 10;
        
        if (left) {
            self.navigationItem.leftBarButtonItems = @[space,item];
        } else {
            self.navigationItem.rightBarButtonItems = @[space,item];
        }
    }else if ([item isKindOfClass:[NSArray class]]){
        NSArray *items = (NSArray *)item;
        
        NSMutableArray *array = [NSMutableArray array];
        [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[UIBarButtonItem class]]){
                UIBarButtonItem *space = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                          target:nil action:nil];
                space.width = width - 10;
                [array addObject:space];
                [array addObject:obj];
            }
        }];
        if (left) {
            self.navigationItem.leftBarButtonItems = array;
        } else {
            self.navigationItem.rightBarButtonItems = array;
        }
    }
}
@end

