//
//  HTTPParser.h
//  Inspirations
//
//  Created by Easer on 2018/2/13.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPParser : NSObject

+(NSMutableDictionary *)ParseBooheeSearchResultWithHTMLData:(NSData *)theData;
+(NSMutableDictionary *)ParseBooheeFoodHomePageWithHTMLData:(NSData *)theData;

@end
