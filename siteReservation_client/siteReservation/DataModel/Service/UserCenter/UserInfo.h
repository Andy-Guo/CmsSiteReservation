//
//  UserInfo.h
//  LetvIphoneClient
//
//  Created by 鹏飞 季 on 12-8-28.
//  Copyright (c) 2012年 乐视网. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>
//#import "JSONModel.h"

@protocol VipUserInfo @end
@interface VipUserInfo : JSONModel

@property(nonatomic,strong) NSString<Optional> *__canceltime;
@property(nonatomic,strong) NSString<Optional> *id;
@property(nonatomic,strong) NSString<Optional> *orderFrom;
@property(nonatomic,strong) NSString<Optional> *productid;
@property(nonatomic,strong) NSString<Optional> *username;
@property (nonatomic, strong) NSString<Optional> *userid;
@property (nonatomic, strong) NSString<Optional> *vipType; // 1 移动会员 2 全屏会员
@property (nonatomic, strong) NSString<Optional> *__seniorcanceltime;
@property (nonatomic, strong) NSString<Optional> *lastdays;
@property (nonatomic, strong) NSString<Optional> *uinfo;

- (NSString *)canceltime;
- (BOOL)isSeniorVip;
- (NSString *)seniorcanceltime;
- (NSDate*) expireDate;
- (float)vipLastTime;

@end


@protocol UserInfo @end
@interface UserInfo : JSONModel

@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString<Optional> *name;
@property(nonatomic,strong) NSString *nickname;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *picture;
@property(nonatomic,strong) NSString<Optional> *birthday;
@property(nonatomic,strong) NSString<Optional> *__isvip;
@property(nonatomic,strong) NSString<Optional> *province;
@property(nonatomic,strong) NSString<Optional> *city;
@property(nonatomic,strong) NSString<Optional> *address;
@property(nonatomic,strong) NSString *email;
@property(nonatomic,strong) NSString<Optional> *gender;
@property(nonatomic,strong) NSString<Optional> *mobile;
@property(nonatomic,strong) NSString<Optional>  *level_id;
@property(nonatomic,strong) NSString<Optional> *registTime;
@property(nonatomic,strong) VipUserInfo<Optional> *vipinfo;
@property(nonatomic,strong) NSString<Optional>  *point;
@property(nonatomic,strong) NSString<Optional>  *score;
@property (nonatomic, strong) NSString<Optional> *ssouid;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *chkvipday;
@property(nonatomic, strong) NSString<Optional> *vipBrand;

- (BOOL)isvip;
- (NSString*) getVIPLevelImageName;
- (BOOL)isExpire;
@end


@protocol UserInfoWrapper @end
@interface UserInfoWrapper : JSONModel

@property (nonatomic, strong) UserInfo<Optional> *bean;
@property (nonatomic, strong) NSString<Optional> *action;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *errorCode;
@property (nonatomic, strong) NSString<Optional> *message;

@end


