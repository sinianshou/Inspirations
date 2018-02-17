//
//  EasyOAuthV2VC.h
//  Inspirations
//
//  Created by Easer on 2018/2/11.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyOAuthV2VC : UIViewController

@property (nonatomic, strong) NSString *authorizeUrlString;
@property (nonatomic, strong) NSString *tokenUrlString;
@property (nonatomic, strong) NSString *revokeUrlString;
@property (nonatomic, strong) NSString *redirectURLString;
@property (nonatomic, strong) NSString *ClientId;
@property (nonatomic, strong) NSString *ClientSecret;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *code;

@property (nonatomic,copy) void(^didGetAccessTokenBlock)(BOOL success);

@end
