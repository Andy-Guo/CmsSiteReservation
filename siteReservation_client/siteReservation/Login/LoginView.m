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

#define HEIGHT_OF_BOTTOM 49

static  CGRect headerRect;
static  CGRect searchRect;
static  CGRect messageRect;
static  CGRect userNameRect;
static  CGRect vipImageRect;

@protocol LoginViewDelegate <NSObject>
@end
@interface LoginView ()<LoginViewDelegate>

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

// 角色选择
@property (nonatomic, strong) UIButton *LoginView;
@property (nonatomic, strong) UIButton *selectButton1;
@property (nonatomic, strong) UIButton *selectButton2;
@property (nonatomic, strong) UIButton *selectButton3;
@property (nonatomic, strong) UIImageView *headIconImage1;
@property (nonatomic, strong) UIImageView *headIconImage2;
@property (nonatomic, strong) UIImageView *headIconImage3;
@property (nonatomic, strong) UILabel *userNameLabel1;
@property (nonatomic, strong) UILabel *userNameLabel2;
@property (nonatomic, strong) UILabel *userNameLabel3;

@end

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        // 最大时位置
        [self loadView];
    }
    return self;
}

- (void)loadView
{
    // 最大时位置
//    headerRect = CGRectMake(kScreenWidth/3 * 2, adapteWith(48), adapteWith(60), adapteWith(60));
    headerRect = CGRectMake(kScreenWidth/3 - adapteWith(48), adapteWith(48), adapteWith(60), adapteWith(60));
    userNameRect = CGRectMake(kScreenWidth - adapteWith(40), adapteWith(68), adapteWith(30), adapteWith(80));
    
    UIImage *backgroundImage = [UIImage imageNamed:@"person_icon_administrator"];//管理员
    _headIconImage1 = [[UIImageView alloc] initWithFrame:headerRect];
    _headIconImage1.image = backgroundImage;
    _headIconImage1.clipsToBounds = YES;
    _headIconImage1.backgroundColor = [UIColor clearColor];
    _headIconImage1.hidden = NO;
    [self addSubview:_headIconImage1];
    
    CGRect frame = CGRectMake(_headIconImage1.frame.origin.x, _headIconImage1.frame.origin.y + _headIconImage1.frame.size.height /2, userNameRect.size.width * 2, userNameRect.size.height);
    _userNameLabel1 = [[UILabel alloc] initWithFrame:frame];
    _userNameLabel1.backgroundColor = [UIColor clearColor];
    [_userNameLabel1 setTextColor:[UIColor blackColor]];
    _userNameLabel1.numberOfLines = 1;
    _userNameLabel1.textAlignment = UITextAlignmentCenter;
    _userNameLabel1.font = [UIFont systemFontOfSize:14.f];
    _userNameLabel1.text = NSLocalizedString(@"管理员", @"管理员");
    [self addSubview:_userNameLabel1];
    
    _headIconImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - adapteWith(48)/2, adapteWith(48), adapteWith(60), adapteWith(60))];
    _headIconImage2.image = [UIImage imageNamed:@"person_icon_customer"];//顾客;
    _headIconImage2.clipsToBounds = YES;
    _headIconImage2.backgroundColor = [UIColor clearColor];
    _headIconImage2.hidden = NO;
    [self addSubview:_headIconImage2];
    
    CGRect frame2 = CGRectMake(_headIconImage2.frame.origin.x, _headIconImage2.frame.origin.y + _headIconImage1.frame.size.height /2, userNameRect.size.width * 2, userNameRect.size.height);
    _userNameLabel2 = [[UILabel alloc] initWithFrame:frame2];
    _userNameLabel2.backgroundColor = [UIColor clearColor];
    [_userNameLabel2 setTextColor:[UIColor blackColor]];
    _userNameLabel2.numberOfLines = 1;
    _userNameLabel2.textAlignment = UITextAlignmentCenter;
    _userNameLabel2.font = [UIFont systemFontOfSize:14.f];
    _userNameLabel2.text = NSLocalizedString(@"顾客", @"顾客");
    [self addSubview:_userNameLabel2];
    
    _headIconImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/3 *2, adapteWith(48), adapteWith(60), adapteWith(60))];
    _headIconImage3.image = [UIImage imageNamed:@"person_icon_salesman"];//顾客;
    _headIconImage3.clipsToBounds = YES;
    _headIconImage3.backgroundColor = [UIColor clearColor];
    _headIconImage3.hidden = NO;
    [self addSubview:_headIconImage3];
    
    CGRect frame3 = CGRectMake(_headIconImage3.frame.origin.x, _headIconImage3.frame.origin.y + _headIconImage3.frame.size.height /2, userNameRect.size.width * 2, userNameRect.size.height);
    _userNameLabel3 = [[UILabel alloc] initWithFrame:frame3];
    _userNameLabel3.backgroundColor = [UIColor clearColor];
    [_userNameLabel3 setTextColor:[UIColor blackColor]];
    _userNameLabel3.numberOfLines = 1;
    _userNameLabel3.textAlignment = UITextAlignmentCenter;
    _userNameLabel3.font = [UIFont systemFontOfSize:14.f];
    _userNameLabel3.text = NSLocalizedString(@"销售员", nil);
    [self addSubview:_userNameLabel3];
    
    CGRect rcMain = [UIScreen mainScreen].bounds;
    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0,rcMain.size.height-HEIGHT_OF_BOTTOM, rcMain.size.width, HEIGHT_OF_BOTTOM)];
    [_loginButton setBackgroundColor:RGBACOLOR(228,33,18,1)];
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginButton setTitleColor:RGBACOLOR(255,255,255,1) forState:UIControlStateNormal];
    [_loginButton setTitleColor:RGBACOLOR(204,204,204,1) forState:UIControlStateHighlighted];
    [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    _loginButton.layer.cornerRadius = 0;
    _loginButton.clipsToBounds = YES;
    [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginButton];
}

- (void)loginAction:(id)sender
{
    if (self.ltDelegate && [self.ltDelegate respondsToSelector:@selector(ltContentTableViewDidScrolledContentOffset:)]) {
        [self.ltDelegate ltContentTableViewDidScrolledContentOffset:scrollView.contentOffset];
    }
}

@end
