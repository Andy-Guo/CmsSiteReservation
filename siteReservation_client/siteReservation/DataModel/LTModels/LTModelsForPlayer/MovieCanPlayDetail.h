//
//  MovieCanPlayDetail.h
//  LetvIphoneClient
//
//  Created by pdh on 14-2-8.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileOpensource/LetvMobileOpensource.h>

@interface App : JSONModel

@property (nonatomic, strong) NSString<Optional> *appId;       //!< iPhone ProductID
@property (nonatomic, strong) NSString<Optional> *ipadId;      //!< iPad ProductID
@end

/**
 *  ios 产品信息(好丑陋，pb里就这样写的 得对应啊)
 *  "app": {
 *  "appId":"111", // iphone productId
 *  "ipadId":"bbb" // ipad productId
 },
 */
@interface app : JSONModel
@property(nonatomic, strong) NSString<Optional> *appId;                    //iphone productId
@property(nonatomic, strong) NSString<Optional> *ipadId;                   //ipad productId
@end

@interface MovieCanPlayDetail : JSONModel
@property (nonatomic, strong) NSString<Optional> *token;
@property (nonatomic, strong) NSString<Optional> *status;   //是否可以播放，0为不可以播放，1为可以播放
@property (nonatomic, strong) NSString<Optional> *ticketSize; //可用观影券的数量，6.2为可用会员观影券数量
@property (nonatomic, strong) NSString<Optional> *isUserBought; //用户是否购买过此片，买过为true，没买过为false
@property (nonatomic, strong) NSString<Optional> *isForbidden; //用户是否被封禁，0:没有，1:被封禁

@property (nonatomic, strong) NSString<Optional> *id;             //通用观影券Id
@property (nonatomic, strong) NSString<Optional> *ticketType;           //观影券类型，0：会员观影券，1：通用观影券
@property (nonatomic, strong) NSString<Optional> *generalTicketSize;    //通用观影券数量
@property (nonatomic, strong) NSString<Optional> *validDays;            //通用观影券使用后的有效时间

// 6.8 新增
@property (nonatomic, strong) app<Optional> *app;//ios 产品信息（>=6.8版本开始当isOpenTVOD=1时使用）
@property (nonatomic, strong) NSString<Optional> *price;//原价格 （>=6.8版本开始启用,单片购买类型提供）
@property (nonatomic, strong) NSString<Optional> *vipPrice;//会员价格 （>=6.8版本开始当isOpenTVOD=1时使用,单片购买类型提供）
@property (nonatomic, strong) NSString<Optional> *chargetType;//付费类型  0：点播 1：点播或包月  2：包月，3：免费 （>=6.8版本开始当isOpenTVOD=1时使用，是此字段判断付费类型）
@property (nonatomic, strong) NSString<Optional> *tryLookTime;//试看时长 （>=6.8版本开始启用,单片购买类型提供）


/**
 *  影片观影券类型
 *
 *  @return
 */
- (MoviePayTicketType)moviePayTicketType;

@end
