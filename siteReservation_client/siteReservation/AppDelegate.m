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
    
//    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_loginVC];
    self.window.rootViewController =nil;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
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
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)setUpViewControllers
{
    
}


@end
