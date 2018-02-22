//
//  AppDelegate.m
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchListCollectionViewController.h"
#import "RootNavigationController.h"
#import "OAuth2VC.h"
#import "EasyOAuthV2VC.h"
#import "DribbbleUserModel.h"

#import "FoodTableVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//设置自定义悬浮框坐标

-(void)setNew

{
    Easy_WeakSelf(weakSelf);
    self.circleMenu= [[LoginButton alloc]init];
    self.circleMenu.center = CGPointMake(100, 100);
    self.circleMenu.shouldClickCenterButton = ^BOOL{
        
        UIViewController *vc1 = [weakSelf getCurrentVC];
        UIViewController *vc2 = [weakSelf getPresentedViewController];
        NSLog(@"vc1 is %@,  vc2 is %@", NSStringFromClass([vc1 class]), NSStringFromClass([vc2 class]));
        
        if ([vc1 isKindOfClass:[UINavigationController class]]) {
            UINavigationController*vc = (UINavigationController*)vc1;
//            OAuth2VC *oavc = [[OAuth2VC alloc] init];
            EasyOAuthV2VC *oavc = [[EasyOAuthV2VC alloc] init];
            
            [vc pushViewController:oavc animated:YES];
        }
        
        return NO;
    };
//    [self setCircleMenuCenterImg];
    
    NSArray * iconArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_can"],
                           [UIImage imageNamed:@"icon_pos"],
                           [UIImage imageNamed:@"icon_img"],
                           [UIImage imageNamed:@"icon_can"], nil];
//    [self.circleMenu setCircleButtonsWithImgs:iconArray Radius:25];
//    [self.circleMenu.circleButtons[0] addTarget:self action:@selector(loginUsername) forControlEvents:UIControlEventTouchUpInside];
//    [self.circleMenu.circleButtons[1] addTarget:self action:@selector(updateAccessKeys) forControlEvents:UIControlEventTouchUpInside];
//    [self.circleMenu.circleButtons[2] addTarget:self action:@selector(cleanCoreData) forControlEvents:UIControlEventTouchUpInside];
//    [self.circleMenu.circleButtons[3] addTarget:self action:@selector(sendNotification) forControlEvents:UIControlEventTouchUpInside];
    
    
//    self.OverallControlls = [[OverallControlls alloc] init];
//    self.logInViewExpend = 0;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self performSelector:@selector(setNew) withObject:nil afterDelay:3];
    
//    SearchListCollectionViewController *rootVC = [[SearchListCollectionViewController alloc] init];
    FoodTableVC *foodTVC = [[FoodTableVC alloc] initWithStyle:UITableViewStylePlain];
    RootNavigationController *rootNC = [[RootNavigationController alloc] initWithRootViewController:foodTVC];
    self.window.rootViewController = rootNC;    
    return YES;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Inspirations"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - Methods
- (void)updateAccessToken{
    
}
- (NSString*)accessToken{
    Easy_UserDefaults(userDefaults);
    NSDictionary *dic = [userDefaults valueForKey:AccessTokenKeyWordString];
    NSString *accessTokenStr = nil;
    if ([dic.allKeys containsObject:AccessTokenKeyWordString]) {
        accessTokenStr = [dic objectForKey:AccessTokenKeyWordString];
    }
    return accessTokenStr;
}

- (void)updateCurrentUserInfo{
//    NSMutableURLRequest *request = [RootSessionDataTask requestWithRequestUrlString:DribbbleGetCurrentUserURLString HTTPMethod:HTTPMethodGet RequestParameters:nil];
//    Easy_WeakSelf(weakSelf);
//    [RootSessionDataTask DataTaskWithRequest:request CompletionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse*)response;
//        if (urlResponse.statusCode == 200) {
//            NSDictionary *dic = data.responseDictionary;
////            DribbbleUserModel *model = [DribbbleUserModel mj_objectWithKeyValues:dic];
//            weakSelf.circleMenu.model = [[DribbbleUserModel alloc] initWithDictionary:dic];
//            
//            if (weakSelf.circleMenu.model!=nil) {
//                [RACObserve(self.circleMenu.model, avatarUrl) subscribeNext:^(NSString *str) {
//                    NSURL *url = [NSURL URLWithString:weakSelf.circleMenu.model.avatarUrl];
//                    [weakSelf.circleMenu.centerButton sd_setImageWithURL:url forState:UIControlStateNormal];
//                }];
////                NSURL *url = [NSURL URLWithString:weakSelf.circleMenu.model.avatarUrl];
////                [weakSelf.circleMenu.centerButton sd_setImageWithURL:url forState:UIControlStateNormal];
//            }
//        }
//    }];
    
    NSString *stringUrl = @"http://www.boohee.com/food/search?keyword=鸡肉&page=1";
    NSURL *url = [NSURL URLWithString:[stringUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [RootSessionDataTask DataTaskWithRequest:request CompletionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *str = data.easy_ResponseString;
        NSLog(@"data is %@", str);
        [HTTPParser ParseBooheeSearchResultWithHTMLData:data];
    }];
}
#pragma mark - Setter
//-(NSString *)accessTokenStr{
//    
//}
#pragma mark - Getter
@end
