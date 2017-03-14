//
//  AppDelegate.h
//  siteReservation
//
//  Created by Nigel Lee on 19/02/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoginViewController.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "SiteWallViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) SiteWallViewController *viewController;
@property (strong, nonatomic) UINavigationController *navController;

- (void)saveContext;


@end

