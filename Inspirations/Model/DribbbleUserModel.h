//
//	DribbbleUserModel.h
//
//	Create by Easer on 10/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface DribbbleUserModel : BaseModel

@property (nonatomic, strong) NSString * avatarUrl;
@property (nonatomic, strong) NSString * bio;
@property (nonatomic, assign) BOOL canUploadShot;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * htmlUrl;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSDictionary * links;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * login;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) BOOL pro;
@property (nonatomic, strong) NSArray * teams;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
