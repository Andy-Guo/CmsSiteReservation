//
//  LTUserCenterEngine.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-8-29.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTOrderInfo.h>

@class UserInfo;

typedef enum{
    
    MovieAvailableErrorCode_OK = 0,         // 可播放
    MovieAvailableErrorCode_NOTLOGIN,       // 未登录
    MovieAvailableErrorCode_NOAUTHORITY,    // 已登录，不可播
    MovieAvailableErrorCode_FORBIDDEN,      // 用户被封禁
    MovieAvailableErrorCode_NOTRIAL,        // 付费电视剧，没有试看,已登录
    MovieAvailableErrorCode_NOTRIAL_NOTLOGIN,// 付费电视剧，没有试看,未登录
    MovieAvailableErrorCode_UNKNOWN,        // 未知
    
}MovieAvailableErrorCode;   // 影片是否可以播放

@protocol LTUserCenterEngineDelegate;

@interface LTUserCenterEngine : NSObject{
   
@private
   
    id <LTUserCenterEngineDelegate> __weak _delegate;
    
    NSString    *_userId;
    NSString    *_userPwd;


}

@property (nonatomic, weak) id <LTUserCenterEngineDelegate> delegate;
@property (nonatomic, copy) NSString    *userId;
@property (nonatomic, copy) NSString    *userPwd;


/*
+ (LTUserCenterEngine *)sharedInstance;
*/
+ (LTUserCenterEngine *)userCenterEngine;
- (void)getUserInfo;
- (void)getUserInfoWithFinishBlock:(void (^)(BOOL isSuccess, NSDictionary *feedBack))finishBlock;
- (void)logInWithUserID:(NSString *)theUserID
            andPassword:(NSString *)thePassword;
- (void)registerWithEmail:(NSString *)theEmail
              andPassword:(NSString *)thePassword;
- (void)registerWithPhoneNumber:(NSString *)thePhoneNumber
                    andPassword:(NSString *)thePassword
                    andAuthCode:(NSString *)theAuthCode;
- (void)generateOrderIDWithPType:(NSString *)pType
                          andPid:(NSString *)pid
                          andVid:(NSString *)vid;
- (void)getLeftLePoint;
- (void)getVipCancelTime;
- (void)payOrder:(LTOrderInfo *)orderInfo;
- (void)payOrderResult:(NSString *)orderID;
- (void)checkRegisterNameExists:(NSString *)theRegisterName;   // 邮箱/手机号

-(void)phoneNumberRegistered:(NSString*)phoneNumber;

-(void)sendAuthCodeSMS:(NSString *)thePhoneNumber;

- (void)sendAuthCodeSMS:(NSString *)thePhoneNumber andCaptchaValue:(NSString*)captchaValue andcaptchaId:(NSString *)captchaId;

-(void)getVertiCodeWithInterval:(NSString*)timeInterval andKey:(NSString*)keyScrete;//请求验证码

- (NSString *)alreadyLoginUserID;
- (NSString *)alreadyLoginUserName;
- (void) resetLoginUserID;
- (void) autoLogin;
- (void)checkTokenExpired;
- (NSString *)getCurrentUserInfoByKey:(NSString *)key;

- (void)changeEmail:(NSString*)email;
- (void)changeMobile:(NSString*)mobile;
- (void)changePassword:(NSString*)newPassword andOldPassword:(NSString *)oldPassword;

@end


@protocol LTUserCenterEngineDelegate <NSObject>

@optional
- (void)LTUserCenterEngineDidGetUserInfo:(LTUserCenterEngine *)engine withUserInfo:(UserInfo *)userInfo;

- (void)LTUserCenterEngineAlreadyLoggedIn:(LTUserCenterEngine *)engine;
- (void)LTUserCenterEngineDidLogIn:(LTUserCenterEngine *)engine;
- (void)LTUserCenterEngineDidFailToLogIn:(LTUserCenterEngine *)engine WithError:(NSString *)errorMessage;
- (void)LTUserCenterEngineDidLogOut:(LTUserCenterEngine *)engine;

- (void)LTUserCenterEngineDidRegister:(LTUserCenterEngine *)engine WithMessage:(NSString *)message;
- (void)LTUserCenterEngineDidFailToRegister:(LTUserCenterEngine *)engine WithError:(NSString *)errorMessage;

- (void)LTUserCenterEngineDidGenerateOrderID:(LTUserCenterEngine *)engine withOrderID:(NSString *)orderID WithError:(NSString *)errorMessage;

- (void)LTUserCenterEngineDidGetLeftLePoint:(LTUserCenterEngine *)engine leftLePoint:(NSInteger)lePoint;

- (void)LTUserCenterEngineDidGetVipCancelTime:(LTUserCenterEngine *)engine cancelTime:(NSString*)cancelTime;

- (void)LTUserCenterEngineDidPayOrder:(LTUserCenterEngine *)engine isSuccess:(BOOL)bSuccess withError:(NSString *)errorMessage;

- (void)LTUserCenterEngineDidPayOrderResult:(LTUserCenterEngine *)engine isSuccess:(BOOL)bSuccess;

- (void)LTUserCenterEngineDidCheckRegisterNameExists:(LTUserCenterEngine *)engine isSuccess:(BOOL)bSuccess isRegistered:(BOOL)bRegistered withError:(NSString *)errorMessage;

- (void)LTUserCenterEngineDidSendAuthCodeSMS:(LTUserCenterEngine *)engine isSuccess:(BOOL)bSuccess;

- (void)LTUserCenterEngineDidChangeEmail:(LTUserCenterEngine *)engine isSuccess:(BOOL)bsuccess WithError:(NSString *)errorMessage;
- (void)LTUserCenterEngineDidChangeMobile:(LTUserCenterEngine *)engine isSuccess:(BOOL)bsuccess WithError:(NSString *)errorMessage WithErrorCode:(NSString *)errorCode;
- (void)LTUserCenterEngineDidChangePassword:(LTUserCenterEngine *)engine isSuccess:(BOOL)bsuccess WithError:(NSString *)errorMessage WithErrorCode:(NSString *)errorCode;

-(void)LTUserCenterGetVertiCodeImage:(NSString *)imageUrl;

-(void)checkRegisterNameExistsWithIsSuccess:(BOOL)bSuccess isRegistered:(BOOL)bResult withError:(NSString*)errorMessage;

@end
