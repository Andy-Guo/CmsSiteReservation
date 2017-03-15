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
    siteWallVC.siteCollectionView.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(kCellItemWidth, kCellItemWidth)];//cell item的大小
    flowLayout.minimumLineSpacing = kminimumLineSpacing;//每行的间距）
    flowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;//每行内部cell item的间距
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//Scrolling direction（滚动方向）
    
    photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64,kScreenWidth, kScreenHeight-64) collectionViewLayout:flowLayout];//一定要collectionViewLayout:flowLayout   （Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'UICollectionView must be initialized with a non-nil layout parameter’）
    [photoCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoShowCell"];//进行Cell类的注册
    photoCollectionView.delegate = self;
    photoCollectionView.dataSource = self;
    photoCollectionView.contentInset = UIEdgeInsetsMake(2, 1, 1, 1);
    
    [self.view addSubview:photoCollectionView];
    
 self.navigationController pushViewController:siteWallVC animated:YES];
    
}


@end

