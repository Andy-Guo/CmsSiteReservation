 //
//  LTUserCenterEngine.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-8-29.
//
//

#import "LTUserCenterEngine.h"
//#import "SettingManager.h"
#import "UserInfo.h"
//#import "NSDictionaryAdditions.h"
//#import "CoreTelephony.h"
//#import "NSString+HTTPExtensions.h"
#import "NSString+UserCenter.h"
//#import "NSString+MD5.h"
//#import "NSObject+ObjectEmpty.h"
#import "LTDataModelEngine.h"
#import "LTRequestURLManager.h"
#import "LTDataCenter.h"
#import "LTPlayHistoryCommand.h"
#import "SettingManager+VideoCode.h"
#import "HistoryCommand.h"
#import "LTAlertMsgManager+DataModel.h"

@implementation LTUserCenterEngine

@synthesize delegate = _delegate;

@synthesize userId = _userId;
@synthesize userPwd = _userPwd;


+ (LTUserCenterEngine *)userCenterEngine{
    
    return [[LTUserCenterEngine alloc] init];
    
}

- (void)dealloc{
    
    
}

- (id)init{
    
    if (self = [super init]) {
        //
    }
    
    return self;
    
}

#pragma mark -
#pragma mark get user info
- (void)getUserInfo
{
    [self getUserInfoWithFinishBlock:nil];
}

- (void)getUserInfoWithFinishBlock:(void (^)(BOOL isSuccess, NSDictionary *feedBack))finishBlock
{
    NSString* userToken = [SettingManager userCenterTVToken];
    
    //2016.12.27 新增dmsTK的过滤信息
    BOOL bNotRequestUserInfo = YES;
    
    BOOL dmsSwitch = [SettingManager DMSSwitch];
    BOOL isHK = [SettingManager isHK];
    if (dmsSwitch && !isHK) {
        BOOL dmsLogin = [SettingManager isDMSLogin];
        bNotRequestUserInfo = [NSString isBlankString:userToken] || !dmsLogin;
    }
    else{                           //dms未开启 或者 是香港环境，只需判断userToken
        bNotRequestUserInfo = [NSString isBlankString:userToken];
    }
    //---end---
    
    //如果token值异常，不做接口请求
    if (bNotRequestUserInfo) {
        if (    self && self.delegate
            &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetUserInfo:withUserInfo:)]) {
            [self.delegate LTUserCenterEngineDidGetUserInfo:self
                                               withUserInfo:nil];
        }
        
        if (finishBlock) {
            finishBlock(NO,nil);
        }
        
        return;
    }
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_UserInfo
                               andDynamicValues:@[[SettingManager userCenterTVToken]]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {

                                  @try {
                                      BOOL bSuccess = NO;
                                      
                                      {
                                          //yyj0326
                                          if(![NSObject empty:responseDic])
                                          {
                                              NSString *errorCode=[NSString safeString:responseDic[@"errorCode"]];
                                              BOOL dmsSetStatus = [responseDic[@"dmsSetStatus"] boolValue];
                                              if([errorCode isEqualToString:@"1014"])
                                              {
                                                  LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                                  statisInfo.acode = LTDCActionCodeShow;
                                                  statisInfo.st =  @"0";
                                                  statisInfo.pageID = LTDCPageIDMyLetv;
                                                  statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                                  [LTDataCenter addStatistic:statisInfo];
                                                  
                                                  [SettingManager resetUserInfo];
                                                  if (    self && self.delegate
                                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetUserInfo:withUserInfo:)]) {
                                                      [self.delegate LTUserCenterEngineDidGetUserInfo:self
                                                                                         withUserInfo:nil];
                                                  }
                                                  if (finishBlock) {
                                                      finishBlock(NO,nil);
                                                  }
                                                  return;
                                              }
                                              //dms的处理
                                              else if (dmsSetStatus)
                                              {
                                                  //3000表dms校验失败
                                                  if ([errorCode isEqualToString:@"3000"]) {
                                                      BOOL dmsSwitch = [SettingManager DMSSwitch];
                                                      //服务端和本地都开启dms开关前提下，才会清除登陆sdk中的数据（表示dmstk失效，需要重登）
                                                      if (dmsSwitch) {
                                                          [SettingManager resetUserInfo];
                                                          if (    self && self.delegate
                                                              &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetUserInfo:withUserInfo:)]) {
                                                              [self.delegate LTUserCenterEngineDidGetUserInfo:self
                                                                                                 withUserInfo:nil];
                                                          }
                                                      }
                                                      
                                                      if (finishBlock) {
                                                          finishBlock(NO,@{@"errorCode":errorCode,
                                                                           @"dmsSetStatus":@(dmsSetStatus)});       //2017.1.17 传递代理回传的dms开关状态
                                                      }
                                                      
                                                      return;
                                                      
                                                  }
                                                  else{
                                                      //do nothing(正常逻辑)
                                                  }
                                              }
                                              else if (!dmsSetStatus)
                                              {
                                                  //do nothing (正常逻辑)
                                              }
                                              
                                          }
                                      }

                                      
                                      UserInfoWrapper *userInfoWapper = [[UserInfoWrapper alloc] initWithDictionary:responseDic error:nil];
                                      
                                      if (userInfoWapper) {
                                          NSString *status = [NSString safeString:userInfoWapper.status];
                                          if (    ![NSString isBlankString:status]
                                              &&  [status isEqualToString:@"1"]) {
                                              bSuccess = YES;
                                              
                                              if (!userInfoWapper.bean) {
                                                  if (    self && self.delegate
                                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetUserInfo:withUserInfo:)]) {
                                                      [self.delegate LTUserCenterEngineDidGetUserInfo:self
                                                                                         withUserInfo:bSuccess ? userInfoWapper.bean : nil];
                                                  }
                                                  if (finishBlock) {
                                                      finishBlock(NO,nil);
                                                  }
                                                  return ;
                                              }
                                              
                                              
                                              if ([NSString isBlankString:userInfoWapper.bean.nickname]) {
                                                  userInfoWapper.bean.nickname = userInfoWapper.bean.isvip ? NSLocalizedString(@"乐视会员", @"乐视会员") : NSLocalizedString(@"乐视用户", @"乐视用户");
                                              }
                                              
                                              if ([responseDic isKindOfClass:[NSDictionary class]]) {
                                                  NSDictionary *dicBody = responseDic[@"bean"];
                                                  
                                                  if (dicBody != nil && [dicBody isKindOfClass:[NSDictionary class]]) {
                                                      [SettingManager setUserCenterUserInfo:dicBody];
                                                  }
                                              }
                                              
                                              [self dealVipExpire:userInfoWapper];
                                          }
                                      }
                                      if (!bSuccess) {
                                          NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_UserInfo
                                                                                       andDynamicValues:@[[SettingManager userCenterTVToken]]];
                                          
                                          NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_UserInfo,url,[responseDic description]];
                                          [LTDataCenter writeToErrorLogFile:errlog];
                                      }
                                      if (    self && self.delegate
                                          &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetUserInfo:withUserInfo:)]) {
                                          [self.delegate LTUserCenterEngineDidGetUserInfo:self
                                                                             withUserInfo:bSuccess ? userInfoWapper.bean : nil];
                                      }
                                      if (finishBlock) {
                                          finishBlock(bSuccess,nil);
                                      }
                                  }
                                  @catch (NSException *exception) {

                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self && self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetUserInfo:withUserInfo:)]) {
                                      [self.delegate LTUserCenterEngineDidGetUserInfo:self
                                                                         withUserInfo:nil];
                                  }
                                  if (finishBlock) {
                                      finishBlock(NO,nil);
                                  }
                              }];
    
}

- (void)dealVipExpire:(UserInfoWrapper *)userInfoWapper {
    NSInteger chkvipday = [userInfoWapper.bean.chkvipday integerValue];
    
    // 如果为0, 则不需要显示
    if (chkvipday == 0) {
        [SettingManager setIsNeedShowVipExpireRedPoint:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOShowVipRedPoint" object:nil];
        //                                              return;
    }
    else{
        
        NSString *lastdaysStr = userInfoWapper.bean.vipinfo.lastdays;
        
        if (lastdaysStr != nil && ![lastdaysStr isEqualToString:@""]) {
            NSInteger lastdays = [lastdaysStr integerValue];
            
            chkvipday = chkvipday * 24 * 60 * 60;
            
            if (abs(lastdays) <= chkvipday) {
                [SettingManager setIsNeedShowVipExpireRedPoint:YES];
               //5.9产品不让显示 [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowVipRedPoint" object:nil];
#ifndef LT_IPAD_CLIENT
                [[NSNotificationCenter defaultCenter] postNotificationName:kNoNeedRefreshRedPointNotification object:nil];
#endif
            }
            else{
                [SettingManager setIsNeedShowVipExpireRedPoint:NO];
            }
            
        }
        else{
            [SettingManager setIsNeedShowVipExpireRedPoint:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NOShowVipRedPoint" object:nil];
        }
    }
}

-(void)phoneNumberRegistered:(NSString*)phoneNumber
{
    NSString *key = @"3Des2Ts0ItfS32G";
    NSString *keyScrete = [NSString md5:[NSString stringWithFormat:@"%@,%@",phoneNumber,key]];
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_PhoneNumRegistered andDynamicValues:@[phoneNumber,keyScrete] andHttpMethod:@"GET" andParameters:nil completionHandler:^(NSDictionary *responseDic) {
        
        NSDictionary *body = [responseDic objectForKey:@"body"];
        NSDictionary *result = [body objectForKey:@"result"];
        BOOL isRegister = [[result objectForKey:@"result"] intValue];
        int errorCode = [[result objectForKey:@"errorCode"]intValue];
        
        NSDictionary *header = [responseDic objectForKey:@"header"];
        NSString *status = [header objectForKey:@"status"];
        if ([status intValue]== 1&&self.delegate&&[self.delegate respondsToSelector:@selector(checkRegisterNameExistsWithIsSuccess:isRegistered:withError:)]) {
            if (errorCode == 1011) {
                [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                         WithError:@"手机格式错误"];
                return;
            }
            
            [self.delegate checkRegisterNameExistsWithIsSuccess:(BOOL)status isRegistered:isRegister withError:nil];
        }
        
    } errorHandler:^(NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark register

- (void) checkRegisterNameExists:(NSString *)theRegisterName{
    
    BOOL isEmail = NO;
    NSString *sign;
    if ([NSString isValidEmail:theRegisterName]) {
        isEmail = YES;
        sign = [NSString md5:[NSString stringWithFormat:@"email=%@&version=%@&poi345",theRegisterName,CURRENT_VERSION]];
    }
    
    [LTDataModelEngine refreshTaskWithUrlModule:isEmail ? LTURLModule_UC_CheckEmailExists : LTURLModule_UC_CheckMobileExists
                               andDynamicValues:isEmail ? @[theRegisterName,sign]:@[theRegisterName]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  NSString *errorMessage = @"";
                                  NSString *errorCode = @"";
                                  BOOL bResult = NO;
                                  BOOL bSuccess = NO;

                                  errorCode = [NSString safeString:responseDic[@"errorCode"]];
                                  bSuccess = (    ![NSString isBlankString:errorCode]
                                              &&  (0 == [errorCode intValue]));
                                  if (!bSuccess) {
                                      errorMessage = [NSString safeString:responseDic[@"message"]];
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:isEmail ? LTURLModule_UC_CheckEmailExists : LTURLModule_UC_CheckMobileExists
                                                                                   andDynamicValues:isEmail ? @[theRegisterName,sign]:@[theRegisterName]];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",(isEmail ? LTURLModule_UC_CheckEmailExists : LTURLModule_UC_CheckMobileExists),url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];

                                  }
                                  else{
                                      NSDictionary *dict = responseDic[@"bean"];
                                      NSString *result = [NSString safeString:[dict valueForKey:@"result"]];
                                      bResult = (1 == [result intValue]);
                                  }

                                
                                  if (self.delegate&&[self.delegate respondsToSelector:@selector(checkRegisterNameExistsWithIsSuccess:isRegistered:withError:)]) {
                                      [self.delegate checkRegisterNameExistsWithIsSuccess:bSuccess isRegistered:bResult withError:errorMessage];
                                  }
                                  
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidCheckRegisterNameExists:isSuccess:isRegistered:withError:)]) {
                                      [self.delegate LTUserCenterEngineDidCheckRegisterNameExists:self
                                                                                        isSuccess:bSuccess
                                                                                     isRegistered:bResult
                                                                                        withError:errorMessage];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidCheckRegisterNameExists:isSuccess:isRegistered:withError:)]) {
                                      [self.delegate LTUserCenterEngineDidCheckRegisterNameExists:self
                                                                                        isSuccess:NO
                                                                                     isRegistered:NO
                                                                                        withError:nil];
                                  }
                              }];
}

#ifndef LT_IPAD_CLIENT
-(void)getVertiCodeWithInterval:(NSString*)timeInterval andKey:(NSString*)keyScrete
{
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_VertiCode andDynamicValues:@[timeInterval,keyScrete] andHttpMethod:@"GET" andParameters:nil completionHandler:^(NSDictionary *responseDic) {
        
        NSDictionary *body = [responseDic objectForKey:@"body"];
        NSDictionary *result = [body objectForKey:@"result"];
        NSString *apiurl = [result objectForKey:@"apiurl"];
        NSDictionary *header = [responseDic objectForKey:@"header"];
        NSString *status = [header objectForKey:@"status"];
        if ([status intValue]== 1&&self.delegate&&[self.delegate respondsToSelector:@selector(LTUserCenterGetVertiCodeImage:)]) {
           [self.delegate LTUserCenterGetVertiCodeImage:apiurl];
        }
        
    } errorHandler:^(NSError *error) {
        
    }];
}
#endif
#ifdef LT_IPAD_CLIENT
//激活码
-(void)sendAuthCodeSMS:(NSString *)thePhoneNumber{
     NSString * apisign =[NSString md5:[NSString stringWithFormat:@"action=%@&mobile=%@&pcode=%@&plat=%@&version=%@&poi345" ,@"reg" , thePhoneNumber , CURRENT_PCODE , @"mobile_tv" , CURRENT_VERSION]];
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_SMSMobile
                               andDynamicValues:@[thePhoneNumber,apisign]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  BOOL bSuccess = NO;
                                  /* 短信下发激活码接口换了，返回结果也换了
                                   NSString *errorCode = [NSString safeString:responseDic[@"code"]];
                                   */
                                  
                                  NSString *errorCode = nil;
                                  NSDictionary *body = [responseDic objectForKey:@"body"];
                                  NSDictionary *result = [body objectForKey:@"result"];
                                  errorCode = [result objectForKey:@"errorCode"];
                                  
                                  if (    ![NSString isBlankString:errorCode]
                                      &&  [errorCode isEqualToString:@"0"]) {
                                      // 0:成功
                                      // 其他:失败
                                      bSuccess = YES;
                                  }
                                  if (!bSuccess) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_SMSMobile
                                                                                   andDynamicValues:@[thePhoneNumber]];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_SMSMobile,url,[responseDic description]];
                                      
                                      switch ([errorCode integerValue]) {
                                          case 1011:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError: @"手机格式错误"];
                                              break;
                                          case 1000:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError:@"参数错误"];
                                              break;
                                          case 1026:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError:@"每个手机号每天最多能够发送3条短信"];
                                              break;
                                          case 500:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError: @"激活码存储失败"];
                                              break;
                                              
                                          default:
                                              break;
                                      }
                                      
                                      
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidSendAuthCodeSMS:isSuccess:)]) {
                                      [self.delegate LTUserCenterEngineDidSendAuthCodeSMS:self
                                                                                isSuccess:bSuccess];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidSendAuthCodeSMS:isSuccess:)]) {
                                      [self.delegate LTUserCenterEngineDidSendAuthCodeSMS:self
                                                                                isSuccess:NO];
                                  }
                              }];
}
#else


//激活码
-(void)sendAuthCodeSMS:(NSString *)thePhoneNumber{
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_SMSMobile
                               andDynamicValues:@[thePhoneNumber]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  BOOL bSuccess = NO;
                                  /* 短信下发激活码接口换了，返回结果也换了
                                   NSString *errorCode = [NSString safeString:responseDic[@"code"]];
                                   */
                                  
                                  NSString *errorCode = nil;
                                  NSDictionary *body = [responseDic objectForKey:@"body"];
                                  NSDictionary *result = [body objectForKey:@"result"];
                                  errorCode = [result objectForKey:@"errorCode"];
                                  
                                  if (    ![NSString isBlankString:errorCode]
                                      &&  [errorCode isEqualToString:@"0"]) {
                                      // 0:成功
                                      // 其他:失败
                                      bSuccess = YES;
                                  }
                                  if (!bSuccess) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_SMSMobile
                                                                                   andDynamicValues:@[thePhoneNumber]];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_SMSMobile,url,[responseDic description]];
                                      
                                      switch ([errorCode integerValue]) {
                                          case 1011:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError: @"手机格式错误"];
                                              break;
                                          case 1000:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError:@"参数错误"];
                                              break;
                                          case 1026:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError:@"每个手机号每天最多能够发送3条短信"];
                                              break;
                                          case 500:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError: @"激活码存储失败"];
                                              break;
                                              
                                          default:
                                              break;
                                      }
                                      
                                      
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidSendAuthCodeSMS:isSuccess:)]) {
                                      [self.delegate LTUserCenterEngineDidSendAuthCodeSMS:self
                                                                                isSuccess:bSuccess];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidSendAuthCodeSMS:isSuccess:)]) {
                                      [self.delegate LTUserCenterEngineDidSendAuthCodeSMS:self
                                                                                isSuccess:NO];
                                  }
                              }];
}
#endif
#ifndef LT_IPAD_CLIENT
-(void)sendAuthCodeSMS:(NSString *)thePhoneNumber andCaptchaValue:(NSString *)captchaValue andcaptchaId:(NSString *)captchaId{
    
    NSString * apisign =[NSString md5:[NSString stringWithFormat:@"action=%@&mobile=%@&pcode=%@&plat=%@&version=%@&poi345" ,@"reg" , thePhoneNumber , CURRENT_PCODE , @"mobile_tv" , CURRENT_VERSION]];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_SMSMobile
                               andDynamicValues:@[thePhoneNumber,captchaValue,captchaId,apisign]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  BOOL bSuccess = NO;
                                  /* 短信下发激活码接口换了，返回结果也换了
                                  NSString *errorCode = [NSString safeString:responseDic[@"code"]];
                                   */
                                  
                                  NSString *errorCode = nil;
                                  NSDictionary *body = [responseDic objectForKey:@"body"];
                                  id result = [body objectForKey:@"result"];
                                  if ([result isKindOfClass:[NSDictionary class]]) {
                                      errorCode = [(NSDictionary *)result objectForKey:@"errorCode"];
                                  }
                                  
                                  if (    ![NSString isBlankString:errorCode]
                                      &&  [errorCode isEqualToString:@"0"]) {
                                      // 0:成功
                                      // 其他:失败
                                      bSuccess = YES;
                                  }
                                  if (!bSuccess) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_SMSMobile
                                                                                   andDynamicValues:@[thePhoneNumber,captchaValue,captchaId,apisign]];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_SMSMobile,url,[responseDic description]];
                                      
                                      switch ([errorCode integerValue]) {
                                          case 1011:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError:@"手机格式错误"];
                                              break;
                                          case 1000:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError:@"参数错误"];
                                              break;
                                          case 1026:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError: @"每个手机号每天最多能够发送3条短信"];
                                              break;
                                          case 1027:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError:@"图片验证码不正确"];
                                              break;
                                          case 500:
                                              [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                                       WithError:@"激活码存储失败"];
                                              break;
                                              
                                          default:
                                              break;
                                      }

                                      
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidSendAuthCodeSMS:isSuccess:)]) {
                                      [self.delegate LTUserCenterEngineDidSendAuthCodeSMS:self
                                                                                isSuccess:bSuccess];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidSendAuthCodeSMS:isSuccess:)]) {
                                      [self.delegate LTUserCenterEngineDidSendAuthCodeSMS:self
                                                                                isSuccess:NO];
                                  }
                              }];
}
#endif

- (void)registerWithParams:(NSArray *)params
{
    NSMutableDictionary *postParams = [NSMutableDictionary dictionaryWithCapacity:10];
    /* v>5.6 新接口参数修改
    postParams[@"email"] = params[0];
    postParams[@"mobile"] = params[1];
    postParams[@"password"] = params[2];
    postParams[@"nickname"] = params[3];
    postParams[@"vcode"] = params[4];
    postParams[@"devid"] = [DeviceManager getDeviceUUID];
     */
    if (params != nil && params.count >= 4) {
        postParams[@"email"] = params[0];
        postParams[@"mobile"] = params[1];
        postParams[@"password"] = params[2];
        postParams[@"nickname"] = params[3];
    }
    postParams[@"deviceid"] = [DeviceManager getDeviceUUID];
    postParams[@"plat"] = @"mobile_tv";                             //平台标示
    
    if(params != nil && params.count >= 4){
        postParams[@"code"] = params[4];                                //激活码
    }
    
    postParams[@"gender"] = @"0";                                   //性别， 0：保密  1：男  2：女
    postParams[@"registService"] = @"mapp";                         //注册服务标示
    postParams[@"sendmail"] = @"1";                                 //是否下发激活邮件  1：是   0：否
    postParams[@"next_action"] = @"";                               //邮箱激活成功之后回跳地址，需urlencode编码
    postParams[@"equipID"] = [DeviceManager getDeviceUUID];         //设备ID
    postParams[@"equipType"] = [DeviceManager getDeviceSpecificModel];//设备类型
    postParams[@"softID"] = CURRENT_VERSION;                        //软件版本
    postParams[@"dev_id"] = [DeviceManager getDeviceUUID];          //手机端注册手机的设备id
    
    

    

    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_Register
                               andDynamicValues:nil
                               andHttpMethod:@"POST"
                              andParameters:postParams
                              completionHandler:^(NSDictionary *responseDic) {
                                  NSString *errorMessage = @"";
                                  
                                  NSDictionary *body = [responseDic objectForKey:@"body"];
                                  NSDictionary *result = [body objectForKey:@"result"];
                                  NSString *errorCode = [result objectForKey:@"errorCode"];
                                  errorMessage = [result objectForKey:@"message"];
                                  
                                  if (0 == [errorCode intValue]) {
                                      NSString *uid = [NSString stringWithFormat:@"%@",[[ result objectForKey:@"bean"] objectForKey:@"ssouid"] ];
                                      
                                      if (    self.delegate
                                          &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidRegister:WithMessage:)]) {
                                           NSString *uid = [NSString stringWithFormat:@"%@",[[ result objectForKey:@"bean"] objectForKey:@"ssouid"] ];
                                          if (!self.userId) {
                                              self.userId = uid;
                                          }
                                          
                                          [self.delegate LTUserCenterEngineDidRegister:self WithMessage:NSLocalizedString(@"注册成功", @"注册成功")];
                                      }
                                      return;
                                  }
                                  
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidFailToRegister:WithError:)]) {
                                      NSString *message = nil;
                                      switch ([errorCode integerValue]) {
                                          case 500:
                                              message = [[LTAlertMsgManager shareAlertManageInstance] getLTAlertMsgByAlertID:LTAlertMsg_Register_MobileNumIsUsed];
                                              break;
                                          case 1010:
                                              message =  [[LTAlertMsgManager shareAlertManageInstance] getLTAlertMsgByAlertID:LTAlertMsg_UserCenter_EmailUsed];
                                              break;
                                          case 1012:
                                              message = [[LTAlertMsgManager shareAlertManageInstance] getLTAlertMsgByAlertID:LTAlertMsg_UserCenter_MobileNumUsed];
                                              break;
                                          case 1022:
                                              message = [[LTAlertMsgManager shareAlertManageInstance] getLTAlertMsgByAlertID:LTAlertMsg_Register_Identify_Code_Error];
                                              break;
                                          default:
                                              message = errorMessage;
                                              break;
                                      }
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_Register
                                                                                   andDynamicValues:nil];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_Register,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];

                                      if(self.delegate && [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidFailToRegister:WithError:)]){
                                      [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                               WithError:message];
                                      }
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidFailToRegister:WithError:)]) {
                                      NSString *message = [[LTAlertMsgManager shareAlertManageInstance] getLTAlertMsgByAlertID:LTAlertMsg_Network_RequestError];
                                      [self.delegate LTUserCenterEngineDidFailToRegister:self
                                                                               WithError:message];
                                  }
                              }];
}

- (void)registerWithEmail:(NSString *)theEmail
              andPassword:(NSString *)thePassword{
    
    NSArray *arrayParamValues = @[theEmail,
                                 @"",
                                 thePassword,
                                 @"",
                                 @""];
    
    [self registerWithParams:arrayParamValues];

}

- (void)registerWithPhoneNumber:(NSString *)thePhoneNumber
                    andPassword:(NSString *)thePassword
                    andAuthCode:(NSString *)theAuthCode{
    
    NSArray *arrayParamValues = @[@"",
                                 thePhoneNumber,
                                 thePassword,
                                 @"",
                                 theAuthCode];
    
    [self registerWithParams:arrayParamValues];
    
}

#pragma mark -
#pragma mark login
- (void) loginDoneAction:(NSDictionary *)responseDic{
    
    Boolean bSuccess = NO;
    NSString *errorMessage = NSLocalizedString(@"登录失败", nil);
    NSDictionary *userInfo = nil;

    NSString *token = @"";

    // NSString *tv_token = @"";

    if (![NSObject empty:responseDic]) {

        NSString *errorCode = [NSString safeString:responseDic[@"errorCode"]];
        // tv_token = [NSString safeString:[responseDic objectForKey:@"tv_token"]];
        errorMessage = [NSString safeString:responseDic[@"message"]];
        if (0 == [errorCode intValue]) {
            userInfo = responseDic[@"bean"];
            if (    [NSObject empty:userInfo]
                ||  [userInfo count] <= 0 || [NSString isBlankString:responseDic[@"tv_token"]]) {
                errorMessage = NSLocalizedString(@"登录失败", nil);
            }
            else{
                bSuccess = YES;

                token = [NSString safeString:responseDic[@"tv_token"]];
            }
        }
        else{
            if (    [NSObject empty:errorMessage]
                ||  [NSString isBlankString:errorMessage]) {
                errorMessage = NSLocalizedString(@"登录失败", nil);
            }
        }
    }
    
    if (bSuccess) {
        
#ifdef LT_IPAD_CLIENT

#else
        
        [SettingManager saveIntValueToUserDefaults:1 ForKey:kIsLogin];
#endif
        
        [SettingManager setUserCenterUserName:self.userId];
        [SettingManager setUserCenterPassword:self.userPwd];
        [SettingManager saveBoolValueToUserDefaults:NO ForKey:kThirdPartyLogin];
        [SettingManager saveStringValueToUserDefaults:@"" ForKey:kChatCurrentUserRole];
        [SettingManager setUserCenterTVToken:token];
        
        // 登录成功，上传本地播放记录
        [LTPlayHistoryCommand submitToCloudByRecentWithFinishBlock:^{
            [LTPlayHistoryCommand updateDBWithCloudWithFinishBlock:nil];
        }];
        //是否需要运追剧
        if (NEED_CLOUD_FOLLOW) {
            //登录成功，上传本地播放单
            [HistoryCommand submitToCloudByFavWithFinishBlock:^{
                //[HistoryCommand updateDBWithCloudWithFinishBlock:nil];
            }];
        }
        
        
        // 登录成功，上报一条login日志
        [LTDataCenter loginToUserCenter];
        
        // delegate dealt
        // 登录成功必须取一次userInfo
        [self getUserInfoWithFinishBlock:^(BOOL isSuccess, NSDictionary *feedBack){
            
            [HistoryCommand commitLocalFav:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:COMMITLOCALFAVFINISHED object:nil];
            }];
            
            if (    self.delegate
                &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidLogIn:)]) {
                [self.delegate LTUserCenterEngineDidLogIn:self];
            }
#ifdef LT_IPAD_CLIENT
            
#else
        //登录成功，如果用户在未登录的情况下评论了。。在这里送7天会员给用户
        BOOL giveVipMember = [SettingManager getBoolValueFromUserDefaults:KUserLoginGiveVipMember];
        NSDictionary *userInfo = [SettingManager userCenterUserInfo];
        if ([userInfo isKindOfClass:[NSDictionary class]] && giveVipMember) {
            NSString *uid = [userInfo objectForKey:@"uid"];
            NSString *username = [userInfo objectForKey:@"username"];
            NSString *devid = [DeviceManager getDeviceUUID];
            NSString *sign = [NSString md5:[NSString stringWithFormat:@"uid=%@&username=%@&devid=%@&pcode=%@&version=%@&letvpraise2014",
                                            [NSString safeString:uid],
                                            [NSString safeString:username],
                                            [NSString safeString:devid],
                                            CURRENT_PCODE,CURRENT_VERSION]];
            NSArray *param = @[[NSString safeString:uid],[NSString safeString:username],[NSString safeString:devid],sign];
            [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_CommendForVip
                                       andDynamicValues:param
                                            isNeedCache:NO
                                          andHttpMethod:@"GET"
                                          andParameters:nil
                                      completionHandler:^(NSDictionary *bodyDict, NSString *markid) {

                                      } nochangeHandler:^{
                                          
                                      } emptyHandler:^{
                                          
                                      } tokenExpiredHander:^{
                                          
                                      } errorHandler:^(NSError *error) {
                                          
                                      }];
            [SettingManager saveBoolValueToUserDefaults:NO ForKey:KUserLoginGiveVipMember];
        }
  
#endif
        }];
        
    }
    else{
        NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_Login
                                                     andDynamicValues:nil];
#ifdef LT_IPAD_CLIENT
        NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorInfo:%@",LTURLModule_UC_Login,url,[responseDic description]];
#else


        
        NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_Login,url,[responseDic description]];
#endif
        [LTDataCenter writeToErrorLogFile:errlog];

        self.userId = nil;
        self.userPwd = nil;
        if (    self.delegate
            &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidFailToLogIn:WithError:)]) {
            NSString *errorCode = [NSString safeString:responseDic[@"errorCode"]];
            if ([errorCode integerValue] == 1002) {
                errorMessage = [[LTAlertMsgManager shareAlertManageInstance] getLTAlertMsgByAlertID:LTAlertMsg_Login_PasswordError];
            }
            [self.delegate LTUserCenterEngineDidFailToLogIn:self
                                                  WithError:errorMessage];
        }
        
    }
    
    
    
    return;
    
}

- (NSString *)alreadyLoginUserName{
    
    NSDictionary *dictUserInfo = [SettingManager userCenterUserInfo];
    if (    nil == dictUserInfo
        ||  ![dictUserInfo isKindOfClass:[NSDictionary class]]
        ||  [dictUserInfo count] <= 0) {
        return @"";
    }
    
    NSString *strExistedUserName = dictUserInfo[@"username"];
    
    if (![NSString isBlankString:strExistedUserName]) {
        return strExistedUserName;
    }
    
    
    return @"";
    
}

- (NSString *)alreadyLoginUserID{
    
    NSDictionary *dictUserInfo = [SettingManager userCenterUserInfo];
    if (    nil == dictUserInfo
        ||  ![dictUserInfo isKindOfClass:[NSDictionary class]]
        ||  [dictUserInfo count] <= 0) {
        return @"";
    }
    
    /*
     NSString *strExistedEmail = [dictUserInfo objectForKey:@"email"];
     
     if (![NSString isBlankString:strExistedEmail]) {
     return strExistedEmail;
     }
     
     NSString *strExistedPhone = [dictUserInfo objectForKey:@"mobile"];
     
     if (![NSString isBlankString:strExistedPhone]) {
     return strExistedPhone;
     }
     */
    
    NSString *strExistedUID = dictUserInfo[@"uid"];
    
    if (![NSString isBlankString:strExistedUID]) {
        return strExistedUID;
    }
    
    
    return @"";
    
}

- (NSString *)getCurrentUserInfoByKey:(NSString *)key{
    
    NSDictionary *dictUserInfo = [SettingManager userCenterUserInfo];
    if (    nil == dictUserInfo
        ||  ![dictUserInfo isKindOfClass:[NSDictionary class]]
        ||  [dictUserInfo count] <= 0) {
        return @"";
    }
    
    NSString *strExistedUID = dictUserInfo[key];
    
    if (![NSString isBlankString:strExistedUID]) {
        return strExistedUID;
    }
    
    
    return @"";
    
}

- (void) autoLogin{
    
    NSString *strUserName = [SettingManager userCenterUserName];
    NSString *strPassword = [SettingManager userCenterPassword];
    if (    ![NSString isBlankString:strUserName]
        &&  ![NSString isBlankString:strPassword]) {
//        [self logInWithUserID:strUserName
//                  andPassword:strPassword];
        [self checkTokenExpired];
    }
    else //第三方登陆
    {
        NSString *token = [SettingManager userCenterTVToken];
        if(![NSString isBlankString:token])
        {
            [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_VERTIFY_TOKEN
                                       andDynamicValues:@[token]
                                          andHttpMethod:@"GET"
                                          andParameters:nil
                                      completionHandler:^(NSDictionary *responseDic) {
                                          
                                          if(![NSObject empty:responseDic])
                                          {
                                              NSString *errorCode=[NSString safeString:responseDic[@"errorCode"]];
                                              
                                              if([errorCode isEqualToString:@"1014"])
                                              {
                                                  LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                                  statisInfo.acode = LTDCActionCodeShow;
                                                  statisInfo.st =  @"0";
                                                  statisInfo.pageID = LTDCPageIDUnKnown;
                                                  statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                                  [LTDataCenter addStatistic:statisInfo];
                                                  
                                                  
                                                  
                                              }
                                          }
#ifdef LT_IPAD_CLIENT

#else


                                          [[LTJSLoginManager shareInstance] login];
#endif
                                          NSString *statusCode = [NSString safeString:responseDic[@"status"]];
                                          BOOL isTokenExpired = (1 != [statusCode intValue]);
                                          if (isTokenExpired) {
                                              [self resetLoginUserID];
                                              
                                          }
                                      } errorHandler:^(NSError *error) {//token...

                                      }];

        }
    }
    
    return;
    
}

- (void)checkTokenExpired{
    NSString *token = [SettingManager userCenterTVToken];
    NSString *strUserName = [SettingManager userCenterUserName];
    NSString *strPassword = [SettingManager userCenterPassword];
    if (![NSString isBlankString:token]) {
        [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_VERTIFY_TOKEN
                                   andDynamicValues:@[token]
                                      andHttpMethod:@"GET"
                                      andParameters:nil
                                  completionHandler:^(NSDictionary *responseDic) {
                                      
                                      if(![NSObject empty:responseDic])
                                      {
                                          NSString *errorCode=[NSString safeString:responseDic[@"errorCode"]];
                                          
                                          if([errorCode isEqualToString:@"1014"])
                                          {
                                              LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                              statisInfo.acode = LTDCActionCodeShow;
                                              statisInfo.st =  @"0";
                                              statisInfo.pageID = LTDCPageIDUnKnown;
                                              statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                              [LTDataCenter addStatistic:statisInfo];
                                              
                                              
                                              
                                          }
                                      }
                                      
                                      NSString *statusCode = [NSString safeString:responseDic[@"status"]];
                                      BOOL isTokenExpired = (1 != [statusCode intValue]);
                                      if (isTokenExpired) {
                                          [self resetLoginUserID];
                                          NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_VERTIFY_TOKEN
                                                                                       andDynamicValues:@[token]];
                                          
                                          NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_VERTIFY_TOKEN,url,[responseDic description]];
                                          [LTDataCenter writeToErrorLogFile:errlog];

                                      }else{
                                          [self logInWithUserID:strUserName
                                                    andPassword:strPassword];
                                      }
                                  } errorHandler:^(NSError *error) {
                                      [self logInWithUserID:strUserName
                                                andPassword:strPassword];
                                  }];
    }else{
        [self logInWithUserID:strUserName
                  andPassword:strPassword];
    }
    
}

- (void)resetLoginUserID {
    //注销后将云播放记录下载到本地播放记录
    [LTPlayHistoryCommand updateDBWithCloudWithFinishBlock:nil];
    
    [SettingManager resetUserInfo];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        [standardUserDefaults synchronize];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshUserInfoWithLoginActionNotification object:nil];
}

- (Boolean)isAlreadyLoginWithUserID:(NSString *)theUserID {
    
    if ([NSString isBlankString:theUserID]) {
        return NO;
    }
    
    NSDictionary *dictUserInfo = [SettingManager userCenterUserInfo];
    if (    nil == dictUserInfo
        ||  ![dictUserInfo isKindOfClass:[NSDictionary class]]
        ||  [dictUserInfo count] <= 0) {
        return NO;
    }
    
    NSString *strExistedEmail = dictUserInfo[@"email"];
    
    if (    ![NSString isBlankString:strExistedEmail]
        &&  [strExistedEmail isEqualToString:theUserID]) {
        return YES;
    }
    
    NSString *strExistedPhone = dictUserInfo[@"mobile"];
    
    if (    ![NSString isBlankString:strExistedPhone]
        &&  [strExistedPhone isEqualToString:theUserID]) {
        return YES;
    }
    
    return NO;
    
}

- (void)logInWithUserID:(NSString *)theUserID
            andPassword:(NSString *)thePassword{
    
    self.userId = theUserID;
    self.userPwd = thePassword;
    NSString *token = [SettingManager userCenterTVToken];
    
    NSInteger isLogin = [SettingManager getValueFromUserDefaults:kIsLogin];
    if (isLogin && [self isAlreadyLoginWithUserID:theUserID]&&![NSString isBlankString:token]) {
        if (    self.delegate
            &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineAlreadyLoggedIn:)]) {
            [self.delegate LTUserCenterEngineAlreadyLoggedIn:self];
        }
        return;
    }
    
    NSString *longitude = [SettingManager getLocaionLongitude];
    NSString *latitude = [SettingManager getLocationLatitude];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginname"] = self.userId;
    params[@"password"] = self.userPwd;
    params[@"registService"] = @"mapp";
    params[@"profile"] = @"1";
    params[@"plat"] = @"mobile_tv";
    params[@"devid"] = [DeviceManager getDeviceUUID];
    params[@"sign"] = [NSString md5:[NSString stringWithFormat:@"%@%@%@%@%@",
                                     CURRENT_VERSION,
                                     self.userId,
                                     self.userPwd,
                                     [DeviceManager getDeviceUUID],
                                     @"e3F5gIfT3zj43MAc3F"]];
    params[@"longitude"] = [NSString safeString:longitude];
    params[@"latitude"] = [NSString safeString:latitude];
    /*
    params[@"cid"] = [NSString safeString:[IPhoneCellID getCid]];
    params[@"lac"] = [NSString safeString:[IPhoneCellID getLac]];
    */
    params[@"imei"] = @"";
    params[@"mac"] = [NSString safeString:[NSString macaddress]];
    params[@"ext"] = [NSDictionary dictionaryWithObject:[[UIDevice currentDevice] systemName] forKey:@"buildmodel"];
    params[@"extsign"] = @"";

    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_Login
                               andDynamicValues:nil
                                  andHttpMethod:@"POST"
                                  andParameters: params
                              completionHandler:^(NSDictionary *responseDic) {
                                  [self loginDoneAction:responseDic];
                              } errorHandler:^(NSError *error) {
#ifdef LT_IPAD_CLIENT
                                  if (error) {
                                      [self loginDoneAction:@{@"error":error}];
                                  }else{
                                      [self loginDoneAction:nil];
                                  }
                                  
#else



                                  [self loginDoneAction:nil];
#endif
                              }];
    
}

#pragma mark -
#pragma mark generate orderId
- (void)generateOrderIDWithPType:(NSString *)pType
                          andPid:(NSString *)pid
                          andVid:(NSString *)vid{
    
    NSString *userNameLoggedIn = [self alreadyLoginUserName];
    if ([NSString isBlankString:userNameLoggedIn]) {
        if (    self.delegate
            &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGenerateOrderID:withOrderID:WithError:)]) {
            [self.delegate LTUserCenterEngineDidGenerateOrderID:self
                                                    withOrderID:@""
                                                      WithError:NSLocalizedString(@"请先登录", nil)];
        }
        return;
    }
    

#ifdef LT_IPAD_CLIENT
    NSString *subend = @"41";
#else
    NSString *subend = @"42";
#endif
    
    [LTDataModelEngine refreshTaskWithUrlModule:[SettingManager isPassAudit] ? LTURLModule_IAP_OrderID : LTURLModule_IAP_OrderID_Test
                               andDynamicValues:@[pType, pid, vid, subend, userNameLoggedIn]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  NSString *orderID = @"";
                                  NSString *errorMessage = @"";
                                  
                                  orderID = [NSString safeString:responseDic[@"orderId"]];
                                  if ([NSString isBlankString:orderID]) {
                                      if (nil != responseDic[@"error"]
                                          && [responseDic[@"error"] isKindOfClass:[NSDictionary class]]) {
                                          errorMessage = [NSString safeString:responseDic[@"error"][@"msg"]];
                                      }
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:[SettingManager isPassAudit] ? LTURLModule_IAP_OrderID : LTURLModule_IAP_OrderID_Test
                                                                                   andDynamicValues:@[pType, pid, vid, subend, userNameLoggedIn]];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",[SettingManager isPassAudit] ? LTURLModule_IAP_OrderID : LTURLModule_IAP_OrderID_Test,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGenerateOrderID:withOrderID:WithError:)]) {
                                      [self.delegate LTUserCenterEngineDidGenerateOrderID:self
                                                                              withOrderID:orderID
                                                                                WithError:errorMessage];
                                  }
                              } errorHandler:^(NSError *error) {
                                  [self.delegate LTUserCenterEngineDidGenerateOrderID:self
                                                                          withOrderID:nil
                                                                            WithError:nil];
                              }];
    return;
    
}

#pragma mark -
#pragma mark getLeftLePoint
- (void)getLeftLePoint{
    
    NSString *userNameLoggedIn = [self alreadyLoginUserName];
    if ([NSString isBlankString:userNameLoggedIn]) {
        if (    self.delegate
            &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetLeftLePoint:leftLePoint:)]) {
            [self.delegate LTUserCenterEngineDidGetLeftLePoint:self
                                                   leftLePoint:0];
        }
        return;
    }
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_QueryLePoint
                               andDynamicValues:@[userNameLoggedIn]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  NSInteger balance = 0;
                                  NSString *status = [NSString safeString:responseDic[@"status"]];
                                  if (    ![NSString isBlankString:status]
                                      &&  [status isEqualToString:@"00"]) {
                                      balance = [[NSString safeString:responseDic[@"balance"]] integerValue];
                                  }else {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_QueryLePoint
                                                                                   andDynamicValues:@[userNameLoggedIn]];
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_QueryLePoint,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetLeftLePoint:leftLePoint:)]) {
                                      [self.delegate LTUserCenterEngineDidGetLeftLePoint:self
                                                                             leftLePoint:balance];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetLeftLePoint:leftLePoint:)]) {
                                      [self.delegate LTUserCenterEngineDidGetLeftLePoint:self
                                                                             leftLePoint:0];
                                  }
                              }];
    return;
}

- (void)getVipCancelTime
{
    NSString *userNameLoggedIn = [self alreadyLoginUserName];
    if ([NSString isBlankString:userNameLoggedIn]) {
        if (    self.delegate
            &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetVipCancelTime:cancelTime:)]) {
            [self.delegate LTUserCenterEngineDidGetVipCancelTime:self cancelTime:@""];
        }
        return;
    }
    NSString *sign = [NSString md5:[NSString stringWithFormat:@"end=4&uname=%@&version=%@&poi345",userNameLoggedIn,CURRENT_VERSION]];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_QueryVIP
                               andDynamicValues:@[userNameLoggedIn,sign]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  BOOL isSuccess = NO;
                                  if(![NSObject empty:responseDic])
                                  {
                                      NSInteger status = [[responseDic objectForKey:@"status"] integerValue];
                                      NSString *errorCode=[NSString safeString:responseDic[@"errorCode"]];
                                      isSuccess = ([errorCode intValue] == 0 && status == 1);
                                  }
                                  else{
                                      isSuccess = NO;
                                  }
                                  
                                  if (!isSuccess) {
                                       NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_QueryVIP
                                                                                    andDynamicValues:@[userNameLoggedIn,sign]];
                                       
                                       NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_QueryVIP,url,[responseDic description]];
                                       [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  NSArray *array = responseDic[@"data"];
                                  if ([array count]) {
                                      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                      [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                                      double seconds = [array[0][@"canceltime"] doubleValue] / 1000;
                                      NSString *cancelTime = (seconds>0)?[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:seconds]]:@"";
                                      
                                      if (    self.delegate
                                          &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidGetVipCancelTime:cancelTime:)]) {
                                          [self.delegate LTUserCenterEngineDidGetVipCancelTime:self cancelTime:cancelTime];
                                      }
                                  }
                              } errorHandler:^(NSError *error) {
                                  //
                              }];
    
    return;
}

#pragma mark -
#pragma mark order pay

- (void)payOrder:(LTOrderInfo *)orderInfo{
    
    NSString *userNameLoggedIn = [self alreadyLoginUserName];
    if ([NSString isBlankString:userNameLoggedIn]) {
        if (    self.delegate
            &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidPayOrder:isSuccess:withError:)]) {
            [self.delegate LTUserCenterEngineDidPayOrder:self
                                               isSuccess:NO
                                               withError:@""];
        }
        return;
    }
    
    NSArray *arrayParamValues = @[userNameLoggedIn,
                                 [orderInfo.productName URLEncodedString],
                                 [NSString stringWithFormat:@"%d", (int)(orderInfo.singlePrice * 10 * 10)],
                                 orderInfo.orderId];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_Pay
                               andDynamicValues:arrayParamValues
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  BOOL bSuccess = NO;
                                  NSString *errorMessage =  @"支付失败";
                                  NSString *result = [NSString safeString:responseDic[@"result"]];
                                  if (![NSString isBlankString:result]) {
                                      //            0000	下单成功
                                      //            0001	参数缺少或者错误	返回缺少的参数或者错误参数。格式： 0001,deptno
                                      //            0002 	MD5校验失败
                                      //            1000	系统侧原因交易失败	当支付中心系统异常，系统忙时均使用此编码，表示支付中心系统不可正确处理
                                      //            1001	交易超时	当网络超时或系统超时均使用此编码
                                      //            1002	传递了不符合要求的参数	借记卡、手机充值卡支付时，提交的相关参数第三方校验时错误。
                                      //            1003	账户乐点不足
                                      //            1004	乐卡不存在或已失效
                                      if ([result isEqualToString:@"0000"]) {
                                          bSuccess = YES;
                                          errorMessage =  @"支付成功";
                                      }
                                      else{
                                          if ([result isEqualToString:@"0002"]) {
                                              errorMessage = @"MD5校验失败";
                                          }
                                          else if ([result isEqualToString:@"1001"]) {
                                              errorMessage =@"交易超时";
                                          }
                                          else if ([result isEqualToString:@"0002"]) {
                                              errorMessage = @"MD5校验失败";
                                          }
                                          else if ([result isEqualToString:@"1003"]) {
                                              errorMessage = @"账户乐点不足";
                                          }
                                      }
                                  }
                                  if (!bSuccess) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_Pay
                                                                                   andDynamicValues:arrayParamValues];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_Pay,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidPayOrder:isSuccess:withError:)]) {
                                      [self.delegate LTUserCenterEngineDidPayOrder:self
                                                                         isSuccess:bSuccess
                                                                         withError:errorMessage];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidPayOrder:isSuccess:withError:)]) {
                                      [self.delegate LTUserCenterEngineDidPayOrder:self
                                                                         isSuccess:NO
                                                                         withError:nil];
                                  }
                              }];
    return;
}

#pragma mark -
#pragma mark order pay result
- (void)payOrderResult:(NSString *)orderID{
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_PayResult
                               andDynamicValues:@[orderID]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  BOOL bSuccess = NO;
                                  NSString *stat = [NSString safeString:responseDic[@"stat"]];
                                  if (![NSString isBlankString:stat]) {
                                      if ([stat isEqualToString:@"00"]) {
                                          bSuccess = YES;
                                      }
                                  }
                                  if (!bSuccess) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_PayResult
                                                                                   andDynamicValues:@[orderID]];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_PayResult,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidPayOrderResult:isSuccess:)]) {
                                      [self.delegate LTUserCenterEngineDidPayOrderResult:self
                                                                               isSuccess:bSuccess];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidPayOrderResult:isSuccess:)]) {
                                      [self.delegate LTUserCenterEngineDidPayOrderResult:self
                                                                               isSuccess:NO];
                                  }
                              }];
    return;
}

#pragma mark change user info - email mobile password
- (void)changeEmail:(NSString*)email
{
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_ChangeEmail
                               andDynamicValues:@[[self alreadyLoginUserID], [SettingManager userCenterTVToken], email]
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  BOOL bSuccess = NO;
                                  NSString *stat = nil;
                                  NSString *errorCode = @"";
                                  NSString *errorMessage = @"";
                                  
                                  stat = [NSString safeString:responseDic[@"status"]];
                                  errorCode = [NSString safeString:responseDic[@"errorCode"]];
                                  errorMessage = [NSString safeString:responseDic[@"message"]];
                                  if (![NSString isBlankString:stat]) {
                                      if (    [stat isEqualToString:@"1"]
                                          &&  [errorCode isEqualToString:@"0"]) {
                                          bSuccess = YES;
                                      }
                                  }
                                  if (!bSuccess) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_ChangeEmail
                                                                                   andDynamicValues:@[[self alreadyLoginUserID], [SettingManager userCenterTVToken], email]];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_ChangeEmail,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidChangeEmail:isSuccess:WithError:)]) {
                                      [self.delegate LTUserCenterEngineDidChangeEmail:self
                                                                            isSuccess:bSuccess
                                                                            WithError:errorMessage];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidChangeEmail:isSuccess:WithError:)]) {
                                      [self.delegate LTUserCenterEngineDidChangeEmail:self
                                                                            isSuccess:NO
                                                                            WithError:nil];
                                  }
                              }];
}

- (void)changeMobile:(NSString*)mobile
{
//    NSArray *arrayParamValues = @[[self alreadyLoginUserID],
//                                 mobile,[SettingManager userCenterTVToken]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = [self alreadyLoginUserID];
    params[@"mobile"] = mobile;
    params[@"tk"] = [SettingManager userCenterTVToken];

    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_ChangeMobile
                               andDynamicValues:nil
                              andHttpMethod:@"POST"
                             andParameters:params 
                              completionHandler:^(NSDictionary *responseDic) {
                                  BOOL bSuccess = NO;
                                  NSString *stat = nil;
                                  NSString *errorCode = @"";
                                  NSString *errorMessage = @"";
                                  stat = [NSString safeString:responseDic[@"status"]];
                                  errorCode = [NSString safeString:responseDic[@"errorCode"]];
                                  errorMessage = [NSString safeString:responseDic[@"message"]];
                                  if (![NSString isBlankString:stat]) {
                                      if (    [stat isEqualToString:@"1"]
                                          &&  [errorCode isEqualToString:@"0"]) {
                                          bSuccess = YES;
                                      }
                                  }
                                  if (!bSuccess) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_ChangeMobile
                                                                                   andDynamicValues:nil];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_ChangeMobile,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  if ([errorCode integerValue]==1020) {
                                      //token过期或者错误
                                      [SettingManager resetUserInfo];
                                  }
                                  
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidChangeMobile:isSuccess:WithError:WithErrorCode:)]) {
                                      [self.delegate LTUserCenterEngineDidChangeMobile:self
                                                                             isSuccess:bSuccess
                                                                             WithError:errorMessage
                                                                        WithErrorCode:errorCode];
                                  }
                                  
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidChangeMobile:isSuccess:WithError:WithErrorCode:)]) {
                                      [self.delegate LTUserCenterEngineDidChangeMobile:self
                                                                             isSuccess:NO
                                                                             WithError:nil
                                                                       WithErrorCode:nil];
                                  }
                              }];
}

- (void)changePassword:(NSString*)newPassword andOldPassword:(NSString *)oldPassword
{
//    NSArray *arrayParamValues = @[[self alreadyLoginUserID],
//                                 oldPassword,
//                                 newPassword,[SettingManager userCenterTVToken]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"tk"] = [SettingManager userCenterTVToken];
//    params[@"oldpwd"] = oldPassword;
//    params[@"newpwd"] = newPassword;
//    
//    //20150722 新加字段
//    params[@"need_tk"] = @"true";
//    params[@"plat"] = @"mobile_tv";
//    params[@"version"] = CURRENT_VERSION;
//    params[@"pcode"] = CURRENT_PCODE;
    
    
    NSMutableArray *praArr = [NSMutableArray array];

    [praArr addObject:@{@"need_tk":@"true"}];
    [praArr addObject:@{@"newpwd":newPassword}];
    [praArr addObject:@{@"oldpwd":oldPassword}];
    [praArr addObject:@{@"pcode":CURRENT_PCODE}];
    [praArr addObject:@{@"plat":@"mobile_tv"}];
    [praArr addObject:@{@"tk":[SettingManager userCenterTVToken]}];
    [praArr addObject:@{@"version":CURRENT_VERSION}];

    
    __block NSString *apisignFrom = @"";
    
    @autoreleasepool {
        [praArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if([obj allKeys].count>0)
            {
                NSString *tempKey = [obj allKeys][0];
                NSString *tempObj = obj[tempKey];
                apisignFrom = [apisignFrom stringByAppendingFormat:@"%@=%@",tempKey,tempObj];
                if(idx != praArr.count-1)
                {
                    apisignFrom = [apisignFrom stringByAppendingFormat:@"%@",@"&"];
                }
                
                params[tempKey] = tempObj;
            }
        }];
    }
    apisignFrom = [apisignFrom stringByAppendingString:@"&poi345"];//!!!!
    
    params[@"apisign"] = [NSString md5:apisignFrom];
    


    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_UC_ChangePassword
                               andDynamicValues:nil
                               andHttpMethod:@"POST"
                               andParameters:params 
                              completionHandler:^(NSDictionary *responseDic) {
                                  
                                  responseDic = [responseDic valueForKeyPath:@"body.result"];
                                  
                                  if(![NSObject empty:responseDic])
                                  {
                                      NSString *errorCode=[NSString safeString:responseDic[@"errorCode"]];
                                      
                                      if([errorCode isEqualToString:@"1020"])
                                      {
                                          LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                          statisInfo.acode = LTDCActionCodeShow;
                                          statisInfo.st =  @"0";
                                          statisInfo.pageID = LTDCPageIDUnKnown;
                                          statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                          [LTDataCenter addStatistic:statisInfo];
                                          
                                          
                                          
                                      }
                                  }
                                  
                                  BOOL bSuccess = NO;
                                  NSString *stat = nil;
                                  NSString *errorCode = @"";
                                  NSString *errorMessage = @"";
                                  stat = [NSString safeString:responseDic[@"status"]];
                                  errorCode = [NSString safeString:responseDic[@"errorCode"]];
                                  errorMessage = [NSString safeString:responseDic[@"message"]];
                                  if (![NSString isBlankString:stat]) {
                                      if (    [stat isEqualToString:@"1"]
                                          &&  [errorCode isEqualToString:@"0"]) {
                                          bSuccess = YES;
                                      }
                                  }
                                  if (!bSuccess) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_UC_ChangePassword
                                                                                   andDynamicValues:nil];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_UC_ChangePassword,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                  }
                                  if ([errorCode integerValue]==1020) {
                                      //token过期或者错误
                                      [SettingManager resetUserInfo];
                                  }
                                  
                                  if(bSuccess)
                                  {
                                      NSString *newToken = [responseDic valueForKeyPath:@"bean.sso_tk"];
                                      if(![NSString isBlankString:newToken])
                                      {
                                          [SettingManager setUserCenterTVToken:newToken];
                                      }
                                      //iPhone6.14 - 修改密码成功曝光
                                      [LTDataCenter addActionOnly:LTDCActionCodeShow position:-1 name:nil fl:@"pd01" pageid:@"126" statisticInfo:nil];
                                  }
                                  
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidChangePassword:isSuccess:WithError:WithErrorCode:)]) {
                                      [self.delegate LTUserCenterEngineDidChangePassword:self
                                                                               isSuccess:bSuccess
                                                                               WithError:errorMessage
                                                                               WithErrorCode:errorCode];
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (    self.delegate
                                      &&  [self.delegate respondsToSelector:@selector(LTUserCenterEngineDidChangePassword:isSuccess:WithError:WithErrorCode:)]) {
                                      [self.delegate LTUserCenterEngineDidChangePassword:self
                                                                               isSuccess:NO
                                                                               WithError:nil
                                                                           WithErrorCode:nil];
                                  }
                              }];
    return;
}

@end
