//
//	DribbbleUserModel.m
//
//	Create by Easer on 10/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DribbbleUserModel.h"

NSString *const kDribbbleUserModelAvatarUrl = @"avatar_url";
NSString *const kDribbbleUserModelBio = @"bio";
NSString *const kDribbbleUserModelCanUploadShot = @"can_upload_shot";
NSString *const kDribbbleUserModelCreatedAt = @"created_at";
NSString *const kDribbbleUserModelHtmlUrl = @"html_url";
NSString *const kDribbbleUserModelIdField = @"id";
NSString *const kDribbbleUserModelLinks = @"links";
NSString *const kDribbbleUserModelLocation = @"location";
NSString *const kDribbbleUserModelLogin = @"login";
NSString *const kDribbbleUserModelName = @"name";
NSString *const kDribbbleUserModelPro = @"pro";
NSString *const kDribbbleUserModelTeams = @"teams";
NSString *const kDribbbleUserModelType = @"type";

@interface DribbbleUserModel ()
@end
@implementation DribbbleUserModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kDribbbleUserModelAvatarUrl] isKindOfClass:[NSNull class]]){
		self.avatarUrl = dictionary[kDribbbleUserModelAvatarUrl];
	}	
	if(![dictionary[kDribbbleUserModelBio] isKindOfClass:[NSNull class]]){
		self.bio = dictionary[kDribbbleUserModelBio];
	}	
	if(![dictionary[kDribbbleUserModelCanUploadShot] isKindOfClass:[NSNull class]]){
		self.canUploadShot = [dictionary[kDribbbleUserModelCanUploadShot] boolValue];
	}

	if(![dictionary[kDribbbleUserModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kDribbbleUserModelCreatedAt];
	}	
	if(![dictionary[kDribbbleUserModelHtmlUrl] isKindOfClass:[NSNull class]]){
		self.htmlUrl = dictionary[kDribbbleUserModelHtmlUrl];
	}	
	if(![dictionary[kDribbbleUserModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kDribbbleUserModelIdField] integerValue];
	}

	if(![dictionary[kDribbbleUserModelLinks] isKindOfClass:[NSNull class]]){
		self.links = dictionary[kDribbbleUserModelLinks];
	}

	if(![dictionary[kDribbbleUserModelLocation] isKindOfClass:[NSNull class]]){
		self.location = dictionary[kDribbbleUserModelLocation];
	}	
	if(![dictionary[kDribbbleUserModelLogin] isKindOfClass:[NSNull class]]){
		self.login = dictionary[kDribbbleUserModelLogin];
	}	
	if(![dictionary[kDribbbleUserModelName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kDribbbleUserModelName];
	}	
	if(![dictionary[kDribbbleUserModelPro] isKindOfClass:[NSNull class]]){
		self.pro = [dictionary[kDribbbleUserModelPro] boolValue];
	}

	if(![dictionary[kDribbbleUserModelTeams] isKindOfClass:[NSNull class]]){
		self.teams = dictionary[kDribbbleUserModelTeams];
	}	
	if(![dictionary[kDribbbleUserModelType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kDribbbleUserModelType];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.avatarUrl != nil){
		dictionary[kDribbbleUserModelAvatarUrl] = self.avatarUrl;
	}
	if(self.bio != nil){
		dictionary[kDribbbleUserModelBio] = self.bio;
	}
	dictionary[kDribbbleUserModelCanUploadShot] = @(self.canUploadShot);
	if(self.createdAt != nil){
		dictionary[kDribbbleUserModelCreatedAt] = self.createdAt;
	}
	if(self.htmlUrl != nil){
		dictionary[kDribbbleUserModelHtmlUrl] = self.htmlUrl;
	}
	dictionary[kDribbbleUserModelIdField] = @(self.idField);
	if(self.links != nil){
		dictionary[kDribbbleUserModelLinks] = self.links;
	}
	if(self.location != nil){
		dictionary[kDribbbleUserModelLocation] = self.location;
	}
	if(self.login != nil){
		dictionary[kDribbbleUserModelLogin] = self.login;
	}
	if(self.name != nil){
		dictionary[kDribbbleUserModelName] = self.name;
	}
	dictionary[kDribbbleUserModelPro] = @(self.pro);
	if(self.teams != nil){
		dictionary[kDribbbleUserModelTeams] = self.teams;
	}
	if(self.type != nil){
		dictionary[kDribbbleUserModelType] = self.type;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.avatarUrl != nil){
		[aCoder encodeObject:self.avatarUrl forKey:kDribbbleUserModelAvatarUrl];
	}
	if(self.bio != nil){
		[aCoder encodeObject:self.bio forKey:kDribbbleUserModelBio];
	}
	[aCoder encodeObject:@(self.canUploadShot) forKey:kDribbbleUserModelCanUploadShot];	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kDribbbleUserModelCreatedAt];
	}
	if(self.htmlUrl != nil){
		[aCoder encodeObject:self.htmlUrl forKey:kDribbbleUserModelHtmlUrl];
	}
	[aCoder encodeObject:@(self.idField) forKey:kDribbbleUserModelIdField];
    if(self.links != nil){
		[aCoder encodeObject:self.links forKey:kDribbbleUserModelLinks];
	}
	if(self.location != nil){
		[aCoder encodeObject:self.location forKey:kDribbbleUserModelLocation];
	}
	if(self.login != nil){
		[aCoder encodeObject:self.login forKey:kDribbbleUserModelLogin];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kDribbbleUserModelName];
	}
	[aCoder encodeObject:@(self.pro) forKey:kDribbbleUserModelPro];
    if(self.teams != nil){
		[aCoder encodeObject:self.teams forKey:kDribbbleUserModelTeams];
	}
	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kDribbbleUserModelType];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.avatarUrl = [aDecoder decodeObjectForKey:kDribbbleUserModelAvatarUrl];
	self.bio = [aDecoder decodeObjectForKey:kDribbbleUserModelBio];
	self.canUploadShot = [[aDecoder decodeObjectForKey:kDribbbleUserModelCanUploadShot] boolValue];
	self.createdAt = [aDecoder decodeObjectForKey:kDribbbleUserModelCreatedAt];
	self.htmlUrl = [aDecoder decodeObjectForKey:kDribbbleUserModelHtmlUrl];
	self.idField = [[aDecoder decodeObjectForKey:kDribbbleUserModelIdField] integerValue];
	self.links = [aDecoder decodeObjectForKey:kDribbbleUserModelLinks];
	self.location = [aDecoder decodeObjectForKey:kDribbbleUserModelLocation];
	self.login = [aDecoder decodeObjectForKey:kDribbbleUserModelLogin];
	self.name = [aDecoder decodeObjectForKey:kDribbbleUserModelName];
	self.pro = [[aDecoder decodeObjectForKey:kDribbbleUserModelPro] boolValue];
	self.teams = [aDecoder decodeObjectForKey:kDribbbleUserModelTeams];
	self.type = [aDecoder decodeObjectForKey:kDribbbleUserModelType];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	DribbbleUserModel *copy = [DribbbleUserModel new];

	copy.avatarUrl = [self.avatarUrl copy];
	copy.bio = [self.bio copy];
	copy.canUploadShot = self.canUploadShot;
	copy.createdAt = [self.createdAt copy];
	copy.htmlUrl = [self.htmlUrl copy];
	copy.idField = self.idField;
	copy.links = [self.links copy];
	copy.location = [self.location copy];
	copy.login = [self.login copy];
	copy.name = [self.name copy];
	copy.pro = self.pro;
	copy.teams = [self.teams copy];
	copy.type = [self.type copy];

	return copy;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{kDribbbleUserModelAvatarUrl:@"avatar_url",
             kDribbbleUserModelBio:@"bio",
             kDribbbleUserModelCanUploadShot:@"can_upload_shot",
             kDribbbleUserModelCreatedAt:@"created_at",
             kDribbbleUserModelHtmlUrl:@"html_url",
             kDribbbleUserModelIdField:@"id",
             kDribbbleUserModelLinks:@"links",
             kDribbbleUserModelLocation:@"location",
             kDribbbleUserModelLogin:@"login",
             kDribbbleUserModelName:@"name",
             kDribbbleUserModelPro:@"pro",
             kDribbbleUserModelTeams:@"teams",
             kDribbbleUserModelType:@"type"};
}

+ (NSDictionary *)JSONObjectClassInArrayProperty{
    return @{};
}
@end
