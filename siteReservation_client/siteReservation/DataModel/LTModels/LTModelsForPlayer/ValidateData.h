//
//  ValidateData.h
//  LetvMobileClient
//
//  Created by dullgrass on 17/2/9.
//  Copyright © 2017年 LeEco. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

// 定价信息
@interface ValidateVodInfoCharge : JSONModel
@property (nonatomic, strong) NSString<Optional> *price;            //!< 价格
@property (nonatomic, strong) NSString<Optional> *memberPrice;      //!< 会员价格
@property (nonatomic, strong) NSString<Optional> *appId;            //!< 产品id
@property (nonatomic, strong) NSString<Optional> *memberAppId;      //!< 会员产品id
@property (nonatomic, strong) NSString<Optional> *chargeID;         //!< 定价id
@property (nonatomic, strong) NSString<Optional> *memberDiscounts;  //!< 0：会员原价1：会员打折
@property (nonatomic, strong) NSString<Optional> *validTime;        //!< 有效时间
@property (nonatomic, strong) NSString<Optional> *validTimeDays;    //!< 格式:48小时
@property (nonatomic, strong) NSString<Optional> *chargeName;       //!< 定价名称
@end

// 付费信息
@interface ValidateVodInfoVideo : JSONModel

@property (nonatomic, strong) NSString<Optional> *chargeType;   //!< 付费类型 0:点播，1：点播或包月 3：免费但TV包月收费
@property (nonatomic, strong) NSString<Optional> *isSupportTicket;   //!< 1:支持使用观影券，0：不支持使用观影券
@end

// tvod鉴权信息
@interface ValidateVodInfo : JSONModel

@property (nonatomic, strong) ValidateVodInfoCharge<Optional> *charge; //!< 定价信息
@property (nonatomic, strong) ValidateVodInfoVideo<Optional> *video;     //!< 付费信息

@end

// 播放器鉴权信息
@interface ValidateData : JSONModel

@property (nonatomic, strong) NSString<Optional> *status;     //!< 1：代表鉴权通过，0：代表鉴权不通过
@property (nonatomic, strong) NSString<Optional> *token;      //!< 可以播放的token
@property (nonatomic, strong) NSArray<Optional> *vipInfo;     //!< 内容对应的会员ID（这些会员可看）:1乐次元影视会员,9全屏影视会员

@property (nonatomic, strong) ValidateVodInfo<Optional> *vodInfo; //!<  内容对应的会员ID（这些会员可看）:1乐次元影视会员,9全屏影视会员
@property (nonatomic, strong) NSString<Optional> *ticketSize;          //!< 可用观影券的数量
@property (nonatomic, strong) NSString<Optional> *uid;                 //!< 鉴权使用的uid

@property (nonatomic, strong) NSString<Optional> *tryTime;             //!< 试看时长

@end
