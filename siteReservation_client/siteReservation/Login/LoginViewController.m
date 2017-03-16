//
//  Created by Nigel Lee on 19/02/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "LoginViewController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIButton.h>
#import <UIKit/UIStringDrawing.h>
#import <UIKit/UIKitDefines.h>
#import "LoginView.h"
#import "Global.h"
#import "SiteWallViewController.h"
#import "UIKit/UICollectionViewFlowLayout.h"

@interface LoginViewController ()<LoginViewDelegate>

@end

@implementation LoginViewController


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        self.loginView = [[LoginView alloc] initWithFrame:frame];
        self.loginView.delegate = self; // 设置代理对象
        [self.view addSubview:self.loginView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COMMON_COLOUR;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark -LoginViewDelegate 登录
- (void)loginAction:(id)sender
{
    SiteWallViewController *siteWallVC = [[SiteWallViewController alloc] init];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(30, 30)];//cell item的大小
    siteWallVC.siteCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64,kScreenWidth, kScreenHeight-64) collectionViewLayout:flowLayout];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    [self presentViewController:nav animated:YES completion:nil];
    [self.navigationController pushViewController:siteWallVC animated:YES];
}

@end

