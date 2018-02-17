//
//  SearchListCellModel.h
//  Inspirations
//
//  Created by Easer on 2018/2/13.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "BaseModel.h"

@interface SearchListCellModel : BaseModel

@property (nonatomic, strong) NSString* imgURLString;
@property (nonatomic, strong) NSString* detailURLString;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* foodEnergy;

@end
