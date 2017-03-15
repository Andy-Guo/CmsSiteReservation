//
//  AppDelegate.m
//  siteReservation
//
//  Created by Nigel Lee on 19/02/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
//    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
//    [_viewController.siteCollectionView setCollectionViewLayout:flowLayout];
//    
//    //    利用NSUserDefaults实现
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) { //首次启动
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//        NSLog(@"首次启动");
//
//        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
//        [_viewController.siteCollectionView setCollectionViewLayout:flowLayout];
//        self.window.rootViewController = _viewController;
//    } else {
//        NSLog(@"非首次启动");
//        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
//        [_viewController.siteCollectionView setCollectionViewLayout:flowLayout];
//        self.window.rootViewController = _viewController;
//    }
    _loginVC = [[LoginViewController alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    _navController = [[UINavigationController alloc]initWithRootViewController:_loginVC];//将loginVC添加在navigation上
    self.window.rootViewController = _loginVC;//navigation加在window上
    [self.window makeKeyAndVisible];
    
    return YES;
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
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"siteReservation"];
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

- (void)setUpViewControllers
{
    
//    self.tabBarController = [[LTRootViewController_iPhone alloc] init];
//    [self.tabBarController addLesoSearchAction];
    
    // 解决闪动的问题，希望能解决
//    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setSelectedImageTintColor:[UIColor clearColor]];
    
//    if (LTAPI_IS_ALLOWED(7.0)) {
//        self.tabBarController.tabBar.barTintColor = [UIColor clearColor];
//        
//        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//        [self.tabBarController.tabBar setBackgroundImage:[[UIImage alloc] init]];
//    }
//    else {
//        self.tabBarController.tabBar.tintColor = [UIColor clearColor];
  
    
//    self.tabBarControllerNav = [[LTNavigationController_iPhone alloc] initWithRootViewController:self.tabBarController];
//    [self hideTabbar:self.tabBarController];

//    LetvIphoneClientAppDelegate *appDelegate = (LetvIphoneClientAppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.window = [(LetvIphoneClientAppDelegate*)[[UIApplication sharedApplication] delegate] window];
//    appDelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [appDelegate.window makeKeyAndVisible];
//    appDelegate.window.backgroundColor = kColor246;

//#ifdef LT_IOS8_TRANSFORM
//    if (LTAPI_IS_ALLOWED(8.0) && !LTAPI_IS_ALLOWED(8.3)){
//        [appDelegate.window addSubview:self.tabBarControllerNav.view];
//        appDelegate.letvNavigationController = self.tabBarControllerNav;
//    }
//    else
//#endif
//    {
//        appDelegate.window.rootViewController = self.tabBarControllerNav;
//    }

}


@end
