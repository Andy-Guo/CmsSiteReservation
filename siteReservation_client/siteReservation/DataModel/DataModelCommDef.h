//
//  LTDataModelCommDef.h
//  LetvIphoneClient
//
//  Created by zhaochunyan on 13-1-25.
//
//

#ifndef Letv_LTDataModelCommDef_h
#define Letv_LTDataModelCommDef_h

#import <LeTVMobileFoundation/LeTVMobileFoundationConfig.h>

// 返回数据状态
typedef enum {
    
    DataStatusNormal    = 1,    // 数据正常
    DataStatusEmpty     = 2,    // 数据为空
    DataStatusAbnormal  = 3,    // 数据异常
    DataStatusNotChange = 4,    // 数据无变化
    DataStatusTokenExpired =5,  //tv_token过期
    DataStatusIPShield  = 6,    // IP被屏蔽
    
}DataStatus;



// 推广位的展示
typedef NS_ENUM(NSInteger, PromotionStyle) {
    PromotionStyle_Unkown = 0,              // 无数据
    PromotionStyle_Live_One = 1,            // 1条直播
    PromotionStyle_Operation_One = 2,       // 1条运营数据
    PromotionStyle_Live_Operation = 3,      // 1条直播1条运营数据（左直播）
    PromotionStyle_Live_Two = 4,            // 2条直播
    PromotionStyle_TV_One = 5,              // 1条卫视台
    PromotionStyle_Live_TV = 6,             // 1条直播1条卫视（左直播）
    PromotionStyle_TV_Operation = 7,        // 1条卫视1条运营数据（左卫视）
    PromotionStyle_TV_Two = 8,              // 2个卫视
    PromotionStyle_Operation_Two = 9,       // 2条运营数据
};

// 专题/排行
typedef enum {
    
    LAYOUT_NONE     = 0,
    LAYOUT_SUBJECT  = 1,    // 专题
    LAYOUT_CHART    = 2,    // 排行
    
}SubjectType;

typedef enum {
    MovieShowWithUnknown = 0,
    MovieShowWithMatrix = 1,
    MovieShowWithTable,
    MovieShowWithDate,
    MovieShowWithTotalNumberZero,//剧集列表为0
    MovieShowWithButton  //避免编译报错，临时
}MovieShowStyle;


// 进入频道初始化条件
typedef enum{
    INIT_NORMAL = 0,                            // 默认首页
    INIT_WITH_FILTERARRAY,                      // 有检索条件的初始化
    INIT_NORMAL_VIP_CHANNEL,                    // 会员频道
    INIT_SECONDARY_PAGES,                       // 二级页面初始化
    INIT_SECONDARY_PAGES_FILTER,                // 二级页面不通过contentType判断
    INIT_SECONDARY_SHOWLISTVIEW,                       // SHOWLISTView
    INIT_TABBAR_VIP,                           //tabbar 的会员页
    INIT_SECONDARY_PAGES_SpecialFILTER = 44,    // at值为44的二级页面

    

}CHANNEL_INIT_TYPE;

// 列表大类类型
typedef enum
{
    
    CHANNEL_MAINLIST_SORT,      // 频道大类
    CHANNEL_MAINLIST_SPECIAL,   // 专题大类
    CHANNEL_MAINLIST_CHART,    // 排行榜
    
}CHANNEL_MAINLIST_TYPE;

// 频道标识
typedef enum {
    
    ChannelTV = 0,          // 电视剧
	ChannelMovie,           // 电影
    ChannelSport,           // 体育
    ChannelTVProgram,       // 综艺
    ChannelEntertainment,   // 娱乐
	ChannelAnime,           // 动漫
    ChannelVip,             // 会员频道
    ChannelMusic,           // 音乐
    ChannelKids,            // 亲子
    ChannelNBA,             // NBA
    ChannelFinance,         // 财经
    ChannelFashion,         // 风尚
    ChannelDocumentary,     // 纪录片
    ChannelCar,             // 汽车
    ChannelTravel,          // 旅游
    ChannelNews,            // 资讯
    
    ChannelEnglish,         // 美剧
    ChannelF1,              // F1
    ChannelGame,            // 比赛日
    ChannelAdvertise,       // 广告
    ChannelEPL,             // 英超
    
    ChannelLive,            // 直播
    

} SiteID;

