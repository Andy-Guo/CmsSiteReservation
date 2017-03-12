//
//  LoginView.m
//  siteReservation
//
//  Created by Nigel Lee on 19/02/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "LoginView.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIButton.h>
#import <UIKit/UIStringDrawing.h>
#import <UIKit/UIKitDefines.h>
#import "Global.h"

#define USER_ACCOUNT_TAG 101
#define PASSWORD_TAG 102
#define CustomHeight 480

@interface LoginView ()

@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetButton;

@property (nonatomic, strong) UIButton *qqLoginButton;
@property (nonatomic, strong) UIButton *sinaLoginButton;
@property (nonatomic, strong) UIButton *weixinLoginButton;
@property (nonatomic, strong) UIView *thirdLoginView;
@property (nonatomic, strong) UITableView *loginTableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *imageview;
@end

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        [self loadView];
    }
    return self;
}

- (void)loadView
{
    self.imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.imageview.image=[UIImage imageNamed:@"bg_480"];
    [self addSubview:self.imageview];
    
     NSString *tips = NSLocalizedString(@"立即注册", nil);
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake((__MainScreen_Width - 290.0), __MainScreen_Height + 120, 159-15, 40)];
    [self.registerButton addTarget:self
                        action:@selector(registerAction:)
              forControlEvents:UIControlEventEditingChanged];
    [self.registerButton setTitle:tips forState:UIControlStateNormal];//设置button的title
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:16];//title字体大小
    self.registerButton.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [self.registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
}
    






@end
