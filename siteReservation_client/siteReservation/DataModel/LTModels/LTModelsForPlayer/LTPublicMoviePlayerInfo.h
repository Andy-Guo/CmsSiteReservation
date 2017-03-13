//
//  LTPublicLetvPlayerInfo.h
//  LetvIpadClient
//
//  Created by Letv on 14-9-20.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTLetvPlayerInfo.h>//#import "LTLetvPlayerInfo.h"

typedef NS_ENUM(NSInteger, LTLiveType) {
    LTLiveType_Unknown = 0,
    LTLiveType_Block,
    LTLiveType_LiveChannel,
};

@interface LTPublicMoviePlayerInfo : NSObject
// 跳转类型
@property (nonatomic) LT_VIDEO_AT_5 at;

// 直播区分
@property (nonatomic) LTLiveType liveType;

// 点播数据
@property (nonatomic, strong) LTLetvPlayerInfo *plyerInfo;
#ifdef LT_IPAD_CLIENT
@property (nonatomic, strong) NSString *pageid;
#endif
// 直播数据
@property (nonatomic, strong) LTLiveStatisticInfo *liveStatisticInfo;
@property (nonatomic, strong) NSString *streamUrl;
@property (nonatomic, strong) NSString *streamCode;
@property (nonatomic, strong) NSString *tm;

// 网页处理
@property (nonatomic, strong) NSString *webUrl;         // 外跳网页地址
@property (nonatomic, strong) NSString *webViewUrl;     // 内部网页地址
@end
//调起app
@interface LTPublicOpenMoviePlayerInfo : NSObject

@property (nonatomic, assign) LT_MSITE_ACTION_TYPE actionType;

@property (nonatomic, strong) NSString *pid;//专辑id
@property (nonatomic, strong) NSString *vid;//视频id
@property (nonatomic, strong) NSString *zid;//专题id
@property (nonatomic, strong) NSString *sid;//快速专题id,暂时不用
@property (nonatomic, strong) NSString *ref;//from来源
@property (nonatomic, strong) NSString *streamId;

/**
 *  6.2 支持外部网页跳转
 *  是否是全景视频
 */
@property (nonatomic) BOOL isPanorama;

@property (nonatomic) LT_VIDEO_AT_5 type;
@end
