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

@interface LoginViewController ()

@end

@implementation LoginViewController


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        self.loginView = [[LoginView alloc] initWithFrame:frame];
        self.loginView.delegate = self; // 设置代理
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
    //    self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:YES];
    
}


@end

