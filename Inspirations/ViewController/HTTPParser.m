//
//  HTTPParser.m
//  Inspirations
//
//  Created by Easer on 2018/2/13.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "HTTPParser.h"
#import "SearchListCellModel.h"
#import "FoodCategoryModel.h"

@implementation HTTPParser

+(NSMutableDictionary *)ParseBooheeSearchResultWithHTMLData:(NSData *)theData{
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    if (theData!=nil) {
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:theData];
        NSArray *imgDataArr = [xpathParser searchWithXPathQuery:@"//div[@class='img-box pull-left']"];
        NSArray *contentDataArr = [xpathParser searchWithXPathQuery:@"//div[@class='text-box pull-left']"];
        [imgDataArr enumerateObjectsUsingBlock:^(TFHppleElement* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for (TFHppleElement* aNode in obj.children) {
                if ([aNode.tagName isEqualToString:@"a"] && [aNode.attributes.allKeys containsObject:@"href"] && aNode.attributes[@"href"]!=nil) {
                    NSString *detailUrlStr = aNode.attributes[@"href"];
                    for (TFHppleElement* ele in aNode.children) {
                        //image size 35x35
                        if ([ele.tagName isEqualToString:@"img"] && [ele.attributes.allKeys containsObject:@"src"]) {
                            SearchListCellModel *model;
                            if ([dicM.allKeys containsObject:detailUrlStr]) {
                                model = dicM[detailUrlStr];
                                model.imgURLString = ele.attributes[@"src"];
                            }else{
                                model = [[SearchListCellModel alloc] init];
                                model.detailURLString = detailUrlStr;
                                model.imgURLString = ele.attributes[@"src"];
                                [dicM setObject:model forKey:model.detailURLString];
                            }
                        }
                    }
                }
            }
            
        }];
        [contentDataArr enumerateObjectsUsingBlock:^(TFHppleElement* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dicMTemp = [NSMutableDictionary dictionary];
            for (TFHppleElement* child in obj.children){
                if ([child.tagName isEqualToString:@"h4"]) {
                    for (TFHppleElement* grandchild in child.children) {
                        if ([grandchild.tagName isEqualToString:@"a"] && grandchild.text!=nil && grandchild.attributes[@"href"]!=nil) {
                            [dicMTemp setObject:grandchild.text forKey:@"title"];
                            [dicMTemp setObject:grandchild.attributes[@"href"] forKey:@"detailURLString"];
                        }
                    }
                }else if ([child.tagName isEqualToString:@"p"]){
                    [dicMTemp setObject:child.text forKey:@"foodEnergy"];
                }
            }
            if (dicMTemp.count>=3) {
                NSString *detailUrlStr = dicMTemp[@"detailURLString"];
                SearchListCellModel *model;
                if ([dicM.allKeys containsObject:detailUrlStr]) {
                    model = dicM[detailUrlStr];
                    model.title = dicMTemp[@"title"];
                    model.foodEnergy = dicMTemp[@"foodEnergy"];
                }else{
                    model = [[SearchListCellModel alloc] init];
                    model.detailURLString = detailUrlStr;
                    model.title = dicMTemp[@"title"];
                    model.foodEnergy = dicMTemp[@"foodEnergy"];
                    [dicM setObject:model forKey:model.detailURLString];
                }
            }
        }];
    }
    return dicM;
}


+(NSMutableDictionary *)ParseBooheeFoodHomePageWithHTMLData:(NSData *)theData{
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    if (theData!=nil) {
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:theData];
        NSArray *imgDataArr = [xpathParser searchWithXPathQuery:@"//div[@class='img-box']"];
        NSArray *contentDataArr = [xpathParser searchWithXPathQuery:@"//div[@class='text-box']"];
        [contentDataArr enumerateObjectsUsingBlock:^(TFHppleElement* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FoodCategoryModel *model = [[FoodCategoryModel alloc] init];
            for (TFHppleElement* child in obj.children){
                if ([child.tagName isEqualToString:@"h3"]) {
                    for (TFHppleElement* grandchild in child.children) {
                        if ([grandchild.tagName isEqualToString:@"a"] && [grandchild.attributes.allKeys containsObject:@"href"] && grandchild.attributes[@"href"]!=nil) {
                            model.categoryTitle = grandchild.text;
                            model.detailURLString = grandchild.attributes[@"href"];
                        }
                    }
                }else if ([child.tagName isEqualToString:@"p"]){
                    for (TFHppleElement* grandchild in child.children) {
                        if ([grandchild.tagName isEqualToString:@"a"] && [grandchild.attributes.allKeys containsObject:@"href"] && grandchild.attributes[@"href"]!=nil) {
                            [model.subtitles setValue:grandchild.text forKey:grandchild.attributes[@"href"]];
                        }
                    }
                }
            }
            [dicM setValue:model forKey:model.detailURLString];
        }];
        [imgDataArr enumerateObjectsUsingBlock:^(TFHppleElement* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for (TFHppleElement* aNode in obj.children) {
                if ([aNode.tagName isEqualToString:@"a"] && [aNode.attributes.allKeys containsObject:@"href"] && aNode.attributes[@"href"]!=nil) {
                    NSString *detailUrlStr = aNode.attributes[@"href"];
                    for (TFHppleElement* ele in aNode.children) {
                        //image size 110x110
                        if ([ele.tagName isEqualToString:@"img"] && [ele.attributes.allKeys containsObject:@"src"]) {
                            if ([dicM.allKeys containsObject:detailUrlStr]) {
                                FoodCategoryModel *model = dicM[detailUrlStr];
                                model.imgURLString = ele.attributes[@"src"];
                            }
                        }
                    }
                }
            }
        }];
    }
    
    return dicM;
}
@end
