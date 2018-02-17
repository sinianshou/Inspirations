//
//  AppDelegate.h
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoginButton.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) LoginButton* circleMenu;

- (void)saveContext;


- (void)updateAccessToken;
- (NSString*)accessToken;
- (void)updateCurrentUserInfo;
@end

