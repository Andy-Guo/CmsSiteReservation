//
//  LTApiStatusDataModel.h
//  LetvIphoneClient
//
//  Created by bob on 14-8-1.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>


// API 状态信息
@interface LTApiInfo : JSONModel
@property (nonatomic, strong) NSString<Optional> *apistatus;
@end


//
@interface LTStatInfo : JSONModel
@property (nonatomic, strong) NSString<Optional> *result;
@end

// 广告信息
@interface LTAdInfo : JSONModel
@property (nonatomic, strong) NSString<Optional> *key;
@property (nonatomic, strong) NSString<Optional> *val;
@property (nonatomic, strong) NSString<Optional> *num;
@end

//
@protocol LTRecommendInfoElem <NSObject>
@end
@interface LTRecommendInfoElem : JSONModel
@property (nonatomic, strong) NSString<Optional> *key;
@property (nonatomic, strong) NSString<Optional> *val;
@property (nonatomic, strong) NSString<Optional> *num;
@end

@interface LTShake : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end

// 下载和播放的清晰度
@interface LTDefinitionElem : JSONModel
@property (nonatomic, strong) NSString<Optional> *low;
@property (nonatomic, strong) NSString<Optional> *low_zh;
@property (nonatomic, strong) NSString<Optional> *normal;
@property (nonatomic, strong) NSString<Optional> *normal_zh;
@property (nonatomic, strong) NSString<Optional> *high;
@property (nonatomic, strong) NSString<Optional> *high_zh;
@end
// 下载清晰度
@interface LTDownloadDefinition : JSONModel
@property (nonatomic, strong) LTDefinitionElem<Optional> *iphone;
@property (nonatomic, strong) LTDefinitionElem<Optional> *ipad;
@end
// 播放清晰度
@interface LTPlayDefinition : JSONModel
@property (nonatomic, strong) LTDefinitionElem<Optional> *iphone;
@property (nonatomic, strong) LTDefinitionElem<Optional> *ipad;
@end
// 下载和播放的清晰度
@interface LTDefinition : JSONModel
@property (nonatomic, strong) LTDownloadDefinition<Optional> *download;
@property (nonatomic, strong) LTPlayDefinition<Optional> *play;
@end

// 拼接开关
@interface LTAdPinInfo : JSONModel
@property (nonatomic, strong) NSString<Optional> *val;
@end

@protocol LTExchangeElem <NSObject>
@end
@interface LTExchangeElem : JSONModel
@property (nonatomic, strong) NSString<Optional> *key;
@property (nonatomic, strong) NSString<Optional> *val;
@property (nonatomic, strong) NSString<Optional> *num;
@end

@interface LTLogoInfo : JSONModel
@property (nonatomic, strong) NSString<Optional> *icon;
@property (nonatomic, strong) NSString<Optional> *url;
@property (nonatomic, strong) NSString<Optional> *padicon;
@property (nonatomic, strong) NSString<Optional> *padurl;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *comments;
@end

@interface LTH265 : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end

@interface LTAndroidUtp : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end

@interface LTFreeTime : JSONModel
@property (nonatomic, strong) NSString<Optional> *time;
@end

@interface LTAdConfig : JSONModel
@property (nonatomic, strong) NSString<Optional> *data;
@end

@interface LTPhonePay : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end

@interface LTTempChannel : JSONModel
@property (nonatomic, strong) NSString<Optional> *channel_name;
@property (nonatomic, strong) NSString<Optional> *channel_url;
@property (nonatomic, strong) NSString<Optional> *channel_url_pad;
@property (nonatomic, strong) NSString<Optional> *channel_position;
@property (nonatomic, strong) NSString<Optional> *channel_status;
@end

@interface LTAdOffline : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end

@interface LTRetryDownload : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end

@interface LTApiTimeout : JSONModel
@property (nonatomic, strong) NSString<Optional> *value;
@end

@interface LTExchangePop : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end

@interface LTExchangePage : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end

@interface LTExchangeBottom : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@end


// 接口状态信息
@interface LTApiStatusDataModel : JSONModel

@property (nonatomic, strong) LTApiInfo<Optional> *apiinfo;         // 接口初始化状态
@property (nonatomic, strong) LTStatInfo<Optional> *statinfo;       // 客户端设备信息上报,返回数据
@property (nonatomic, strong) LTAdInfo<Optional> *adinfo;           // 广告控制信息
@property (nonatomic, strong) NSArray<LTRecommendInfoElem, Optional> *recommendinfo;  // 精品推荐控制信息
@property (nonatomic, strong) LTShake<Optional> *shake;             // 摇一摇配置
@property (nonatomic, strong) LTDefinition<Optional> *defaultbr;    // 默认码流配置
@property (nonatomic, strong) LTAdPinInfo<Optional> *adpininfo;     // 广告拼接开关
@property (nonatomic, strong) NSArray<LTExchangeElem, Optional> *exchange;  // exchange开关
@property (nonatomic, strong) NSString<Optional> *tm;               // 服务器时间戳(秒)
@property (nonatomic, strong) LTLogoInfo<Optional> *logoinfo;       // 首页logo运营信息
@property (nonatomic, strong) LTH265<Optional> *h265;               // 265专区开关
@property (nonatomic, strong) LTAndroidUtp<Optional> *androidUtp;   // utp模块开关
@property (nonatomic, strong) LTFreeTime<Optional> *freetime;       // 试看时间
@property (nonatomic, strong) LTAdConfig<Optional> *adconfig;       // 广告配置
@property (nonatomic, strong) LTPhonePay<Optional> *phonePay;       // 话费支付开关
@property (nonatomic, strong) LTTempChannel<Optional> *tempChannel; // 临时频道
@property (nonatomic, strong) LTAdOffline<Optional> *adoffline;     // 离线广告开关
@property (nonatomic, strong) LTRetryDownload<Optional> *retryDownload; // IOS下载重试开关
@property (nonatomic, strong) LTApiTimeout *apiTimeout;             // 接口超时时间
@property (nonatomic, strong) LTExchangePop *exchange_pop;          // 首页应用弹窗推荐开关
@property (nonatomic, strong) LTExchangePop *exchange_page;         // 换量页开关
@property (nonatomic, strong) LTExchangePop *exchange_bottom;       // 首页底部推荐开关

@end


