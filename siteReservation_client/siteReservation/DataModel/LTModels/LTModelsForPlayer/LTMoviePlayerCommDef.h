//
//  LTMoviePlayerCommDef.h
//  LetvIphoneClient
//
//  Created by zhaochunyan on 13-8-15.
//
//

#import <LeTVMobileDataModel/LeTVMobileDataModel.h>


#ifndef LetvIphoneClient_LTMoviePlayerCommDef_h
# define LetvIphoneClient_LTMoviePlayerCommDef_h

///* 是否用avqueue播放非拼接广告*/
//#ifndef LT_PLAYMULTIAD_WITH_AVQUEUE
//#define LT_PLAYMULTIAD_WITH_AVQUEUE 1
//#endif

/* 播放打断恢复后是否重新加载播放器 */
# ifndef LT_RELOADPLAYER_ONPLAYRESUMED
#  define LT_RELOADPLAYER_ONPLAYRESUMED 0
# endif

//play framework开关
//#define LTMovieplayerFramework

/* 播放前贴广告的最小视频时长 */
# define LT_MIN_VIDEOLENGTH_FOR_ADVERTISE    (60)

/* 试看默认时长 - 6 min */
# define LT_DEF_VIDEO_TRIALPLAY_LENGTH       (6 * 60)

/* 播放开始类型  playType 之前的逻辑*/
typedef NS_OPTIONS (NSUInteger, LTPlayReplayType){
    LTPlayReplayTypePlayNew = 1,            // 新播放
    LTPlayReplayTypeSwitchVideoCode = 2,    // 切换码流播放
    LTPlayReplayTypePlayResume = 3,         // 播放打断后恢复
};

/* 播放被打断类型 */
typedef NS_OPTIONS (NSUInteger, LTPlayInterruptFlag){
    LTPlayInterruptFlagNone = 0,

    LTPlayInterruptFlagAppResignActive = 1 << 0,    // app将要进入后台
        LTPlayInterruptFlagShare = 1 << 1,          // 分享
        LTPlayInterruptFlagDisappear = 1 << 2,      // view controller disappear
        LTPlayInterruptFlagSpeechSearch = 1 << 3,   // 语音搜索
        LTPlayInterruptFlagNetworkError = 1 << 4,   // 网络异常
        LTPlayInterruptFlagAVD = 1 << 5,            // AVD

        LTPlayInterruptFlagAppLoginOrPay = 1 << 8,  // 登录或者支付
        LTPlayInterruptFlagCombineAdClicked = 1 << 9, // 拼接广告点击
        LTPlayInterruptFlagDownloadClicked = 1 << 10, // 半屏缓存点击
        LTPlayInterruptFlagPushToTv = 1 << 11,     // 推送/缓存到超级电视
        LTPlayInterruptFlagAdBannerClicked = 1 << 12, // banner广告点击
        LTPlayInterruptFlagPauseDownloadToPlayer = 1 << 13,//播放中卡，暂停缓存中的视频提示出来后打断
        LTPlayInterruptFlagLivePay = 1 << 14,       //直播付费打断
        LTPlayInterruptFlagVipPrePay = 1 << 15,       //点播付费打断
        LTPlayInterruptFlagRedPacket = 1 << 16,         // 红包打断
        LTPlayInterruptFlagDonwloadAllAlert = 1 << 17,  // 全部缓存alert打断
        LTPlayInterruptFlagVideoPlus = 1 << 18,         // Video++打断
};

///* 播放器类型 */
//typedef NS_ENUM(NSInteger, LT_MEDIAPLAYER_TYPE)
//{
//    LT_MEDIAPLAYER_TYPE_IOS,    // 系统播放器
//    LT_MEDIAPLAYER_TYPE_LETV,   // letv本地播放器， *** iPad5.5版本开始弃用 后续软解由公共模块组提供播放内核
//
//    LT_MEDIAPLAYER_TYPE_LETV_H265
//};

///* 播放器buju类型 */
//typedef NS_ENUM(NSInteger, LTMoviePlayerStyle)
//{
//    LTMoviePlayerStyleZoomNone,
//    LTMoviePlayerStyleZoomIn,    // 半屏
//    LTMoviePlayerStyleZoomOut,   // 全屏
//};

/* 播放器布局 */
typedef NS_ENUM (NSInteger, LTPlayControlViewLayout){
    LTPlayControlViewLayoutPlayer,
    LTPlayControlViewLayoutTop,
    LTPlayControlViewLayoutBottom,
    LTPlayControlViewLayoutLeft,
    LTPlayControlViewLayoutRight,
    LTPlayControlViewLayoutSmallRight,
    LTPlayControlViewLayoutCenter,
    LTPlayControlViewLayoutBehind,
    LTPlayControlViewLayoutBigTips,
    LTPlayControlViewLayoutHalfPlayerRight,
    LTPlayControlViewLayoutAdTop,
    LTPlayControlViewLayoutSmalleTips,
    LTPlayControlViewLayoutVipTipView,
    LTPlayControlViewLayoutShotShareTip,
    LTPlayControlViewLayoutShopCart,
    LTPlayControlViewLayoutShopToast,
    LTPlayControlViewLayoutShopMainView,
    LTPlayControlViewLayoutMidProAdControlView,
    LTPlayContorlViewLayoutLexboxEpisodeView,
    LTPlayContorlViewLayoutVideoPlusAdView,
    LTPlayControlViewLayoutVoteBubbleTip,
};

/* 剧集类型 */
typedef NS_ENUM (NSInteger, LTFSEpisodeType){
    LTFSEpisodeTypeNone,

    LTFSEpisodeTypePlay,        // 播放
    LTFSEpisodeTypeDownload,    // 缓存
    LTFSEpisodeTypeLiveBill,    // 直播选台
};

typedef NS_ENUM (NSInteger, LT3GTipType){
    LT3GTipTypePlay,        // 播放
    LT3GTipTypeDownload,    // 缓存
};

/* 播放器手势 */
typedef NS_ENUM (NSInteger, LTPlayControlGesture){
    LTPlayControlGestureWillTap,
    LTPlayControlGestureSingleTap,
    LTPlayControlGestureDoubleTap,
    LTPlayControlGesturePinch,
    LTPlayControlGesturePanoramaPan,    // 全景pan
    LTPlayControlGestureSwipeUp2Finger,
    LTPlayControlGestureSwipeDown2Finger,
    LTPlayControlGestureSwipeLeft,
    LTPlayControlGestureSwipeRight,
    LTPlayControlGestureSwipeUp,
    LTPlayControlGestureSwipeDown,
};
//
///* 播放器播放状态，跟系统播放器MPMoviePlaybackState对应 */
//typedef NS_ENUM(NSInteger, LTMoviePlaybackState)
//{
//    LTMoviePlaybackStateError = -1,
//
//    LTMoviePlaybackStateStopped,
//    LTMoviePlaybackStatePlaying,
//    LTMoviePlaybackStatePaused,
//    LTMoviePlaybackStateInterrupted,
//    LTMoviePlaybackStateSeekingForward,
//    LTMoviePlaybackStateSeekingBackward
//};


/* 播放错误类型 */
/**
     后续需要界面显示错误的码的，定义在LTPlayErrorCode中，
     后续另外定义.

     目前不需要界面定义错误的码的，定义在LTPlayErrorCodeNone之后

     by zhangzhongjie 20150727
 */

typedef NS_ENUM (NSInteger, LTPlayErrorCode){
    LTPlayErrorCodeParseUrlFailure = 19,          // 解析url失败（防盗链url调度失败）

    //add by dip 2014.11.19
    LTPlayErrorCodeNoPlayCopyRight_NoWeb = 15,   // 无播放版权，不支持外跳,不做任何提示
    LTPlayErrorCodeNoAreaCopyright_HongKong = 37,         // 海外iP受限(ip为香港)
    LTPlayErrorCodeNoAreaCopyright_OhterCountry = 8,     // 海外iP受限(ip为非大陆非香港)
    LTPlayErrorCodeNoAreaCopyright_China = 12,            // 大陆iP受限(ip为大陆)
    LTPlayErrorCodePlayLocalVideoFailed = 20,             //播放本地视频失败
    LTPlayErrorCodeDownloadVideoFailed = 18,              //地址是对的，但是无法缓存
    LTPlayErrorCodeJudgeUserIPFailed = 16,                //用户受限判断失败，即用户ip country返回为空

    LTPlayErrorCodeVideoFileInfo = 302,                    // 视频文件
    LTPlayErrorCodeAlbumVideoList = 304,                   // 专辑视频列表
    LTPlayErrorCodeAlbumPay = 305,                         // 付费信息
    LTPLayErrorCodeLiveOverLoadFailed = 208,               // 直播过载保护，不提供服务
    LTPLayErrorCodeLiveCdnUrlError = 209,                  // cde 调度失败
    LTPlayErrorCodeFailedToGetData = 17,          // 获取数据失败
    LTPlayErrorCodeDataError = 604,               // 数据错误
    LTPlayErrorCodeDataError_HotPlayer = 29,      // 热点频道如果需要付费试看
    LTPlayErrorCodeDataError_ZidError = 1502,      //播放专题时，但取到的专题zid是空的
    LTPlayErrorCodeDataError_MovieIdError = 1504,  //播放正常视频，取不到pid或者vid
    LTPlayErrorCodeDataError_VideoModelError = 1506, //从接口取到的播放的video model为空，因为必要的视频播放信息在video里面
    LTPlayErrorCodeDataError_VideofileError = 1507,  //请求videofile 时拿不到媒资id，所以缺少请求videofile接口的必要参数

    LTPlayErrorCodeLiveDataError_SearchByLiveID = 1400,  //根据直播id，调用主键查询接口失败
    LTPlayErrorCodeLiveDataError_LiveBill = 1401,        //取卫视台和直播厅数据失败
    LTPlayErrorCodeLiveDataError_LiveCodeError = 1402,   //推送进直播时数据发生错误或者没合适码流数据
    LTPlayErrorCodeLiveDataError_StreamInfo = 1403,      //频道流信息获取接口失败
    LTPlayErrorCodeLiveDataError_Scode = 1404,           //根据scode（直播id）取直播相关信息 接口失败
    LTPlayErrorCodeLiveDataError_CheckIsPay = 1405,      //检查是否付费异常
    LTPlayErrorCodeLiveDataError_LivePay = 1406,         //付费鉴权接口失败
    LTPlayErrorCodeLiveDataError_UseLiveVoucher = 1407,  //使用直播券接口失败
    LTPlayErrorCodeLiveDataError_SearchLiveVoucher = 1408,  //查询直播券
    LTPlayErrorCodeLiveDataError_GetLivePrice = 1409,    //获取直播价格失败
    LTPlayErrorCodeLiveDataError_GetLiveTm = 1410,       //获取服务器时间失败
    LTPlayErrorCodeLiveDataError_GetMergeLiveDataError = 1600,       //获取直播合并数据失败

    LTPlayErrorCodeLiveDataError_TrialCountDownTime = 1415,        //获取服务器时间错误导致直播试看倒计时负值错误
    LTPlayErrorCodeLiveDataError_LiveStatusAndTicketCount = 1417,  //直播券数量或者直播状态错误
    LTPlayErrorCodeLiveDataError_OrderCountDownTime = 1416,        //获取服务器时间错误导致直播预约倒计时负值错误
    LTPlayErrorCodeDataError_GetPayInfo = 1420,         //获取鉴权数据失败(只要正对tvod 片 changeType 为空)。

    LTPlayErrorCodeOther = 9999,                   // 其它

    LTPlayErrorCodeOther_CurrentCodePlayError = 407,  //当前码流不能正确播放，重试其他码流均失败
    LTPlayErrorCodeOther_DDUrlPlayError = 408,        //点播url播放失败，重试时如果发现获取调度地址为空或者vid为空
    LTPlayErrorCodeParseUrlFailure_TmError = 1411, //直播取tm的接口返回错误
    LTPlayErrorCodeParseUrlFailure_XuantaiError = 1412, //直播选台接口返回错误
    LTPlayErrorCodeParseUrlFailure_UrlExpired = 1413, //解析直播url ，发现url过期
    LTPlayErrorCodeOther_Other_LivePlayError = 1414,   //直播url播放失败，重试轮询查其他备用url尝试后仍然失败
    LTLivePlayErrorCodeGetPlayBillUrl_Failed = 1419,        //获取直播节目单接口失败
    LTLivePlayErrorCodeGetLiveUrlByStreamId_Failed = 21,  //通过直播stream_id获取直播地址失败
    LTLivePlayErrorCodeDispatchOrEndPlayUrl_Empty = 22,   //调度地址或者最终播放地址为空

    LTPlayErrorCodeDRMError = 2000,                // DRM错误
    
    LTPlayErrorCodeNone = 99999999,
    LTPlayErrorCodeNoPlayCopyRight,         // 无播放版权，需要外跳
    LTPlayErrorCodeNetWorkFailure,          // 网络连接失败
    LTPlayErrorCodePlayVia3G,               // 3G网络下播放

    LTPlayErrorCodeMovieAvailableError,     // 无播放权限（pay检查失败; 不支持播放（!play, brlist<=0））
    LTPlayErrorCodeTrialPlayFinished,       // 试看结束
    LTPlayErrorCodeTrialPlayFinishing,      // 试看即将结束
    LTPlayErrorCodeTrialPlayProcessing,     // 试看过程中
    LTPlayErrorCodeNoNextVideo,             // 没有下一集了
    LTplayErrorCodeTimeOut,                 // 超时
    LTPlayErrorCodeNoTrial,                 // 付费电视剧没有试看,已登录
    LTPlayErrorCodeNoTrialNotLogin,         // 付费电视剧没有试看,未登录
    LTPlayErrorCodeNoTrialTVODNeedPay,      // tvod 没有试看
    LTPlayErrorCodeNoTrialFrobidden,        // 会员被封禁 没有试看
    

    LTPlayErrorCodeInitLivingProcessFail,   //  客户端新增，根据直播id进行主键查询失败，导致初始化直播playproces失败
                                            //iPhone5.9以前即iPad版本直播付费鉴权失败显示画面
    LTPlayErrorCodeNotLogin,                //直播付费 未登录
    LTPlayErrorCodeNotBegin,                //直播付费 鉴权成功，直播未开始
    LTPlayErrorCodeRefresh,                 //直播付费 刷新页面
    LTPlayErrorCodeFail,                    //直播付费 接口失败
    LTPlayErrorCodeUseTicket,               //直播付费 立即观看

    LTPlayErrorCodeNeedPay,                 //直播付费 单点支付
    LTPlayErrorCodeNeedVip,                 //直播付费 会员
    LTPlayErrorCodeNeedPay_Vip,             //直播付费 会员或单点支付
    LTPlayErrorCodeNotUseTicket,            //直播付费 立即观看
    LTPlayErrorCodeNotOrder,                //直播付费 未预约
    LTPlayErrorCodeTrialPayPlayEnd,         //直播付费 单点付费试看结束
    LTPlayErrorCodeTrialPayOrVipPlayEnd,    //直播付费 单点付费或会员试看结束
    LTPlayErrorCodeCountDown,               //直播付费 倒计时界面

    //直播新增
    
    LTPlayErrorCodeNoPlayCopyRight_ToTv,             //无播放版权，tv有版权，需要tv投屏
    LTPlayErrorCodeNoPlayCopyRight_InnerJump,        //无播放版权，需要内跳
    LTPlayErrorCodeNoPlayCopyRight_NoJump,           //无播放版权，不支持外跳，但提示可以用网页观看
    LTPlayErrorCodeNoPlayCopyRight_NoAll,            //三段都无版权，但提示视屏已下线
    
    LTPlayErrorCodeShowPlayEnd,             // 直播结束显示
    LTPlayErrorCodeChannelNeedVip,
    
};


/* 播放源类型 */
typedef NS_ENUM (NSInteger, LTPlayStatus){
    LTPlayStatusUnknown = -1,
    LTPlayStatusLocalFile = 0,              // 从缓存界面播放
    LTPlayStatusLiving = 1,                 // 直播
    LTPlayStatusOnline = 2,                 // 在线播放
    LTPlayStatusOnlineByLocal = 3,          // 在线播放中已经缓存的，播放本地文件
    LTPlayStatusItunesFile = 4,             // 播放通过iTunes传输的视频文件
    LTPlayStatusItunesFileWithSystem = 5,   // 用系统播放器播放iTunes传输的视频文件
    LTPlayStatusLeBox = 6,            // 乐盒
    LTPlayStatusLivingNeedTM,               // 直播，需要请求时间戳
    LTPlayStatusMergeLivingNeedTM,          // 直播接口合并，需要请求时间戳
};

/* 播放流程动作 */
typedef NS_ENUM (NSInteger, LTPlayProcessAction){
    LTPlayProcessActionStart,               // process start
    LTPlayProcessActionRequestMovieDetail,  // 请求详情数据
    LTPlayProcessActionCheckPlayHistory,    // 检查播放记录
    LTPlayProcessActionCheckDownloadFile,   // 检查是否已经缓存完成
    LTPlayProcessActionCheckPlayAvialable,  // 检查是否可以播放
    LTPlayProcessActionRequestVideoList,    // 请求专辑视频列表数据
    LTPlayProcessActionRequestVideoFile,    // 请求视频播放地址数据
    LTPlayProcessActionParsePlayUrl,        // 解析播放地址
    LTPlayProcessActionStartPlay,           // 开始播放
    LTPlayProcessActionRequestTM,           // 请求直播时间戳
    LTPlayProcessActionGSLBInfomation,      // GSLB 信息获取
    //LTPlayProcessMergeActionRequestTableUIList,   // 请求UI页面信息

    LTPlayProcessMergeActionRequestHistoryOffset, // 请求历史观看点,
    LTPlayProcessMergeActionRequestVideoFile,     // 请求 VideoFile
    LTPlayProcessMergeActionRequestCachedFile, // 请求本地视频文件,
    LTPlayProcessMergeActionPreRequestCachedFile, // 提前请求本地视频文件,
    LTPlayProcessMergeActionCheckAvialable, // 检查是否可以播放.
    LTPlayProcessMergeActionRequestLivePlay,   // 直播合并请求 livePlay
    LTPlayProcessMergeActionLivePlayCheckAvialable,   // 检查直播是否可以播放
};

/* 播放流程状态 */
typedef NS_ENUM (NSInteger, LTPlayProcessState){
    LTPlayProcessStateNone,

    LTPlayProcessStateError,
    LTPlayProcessStateBeginNewPlay,
    LTPlayProcessStatePlayHistoryChecked,
    LTPlayProcessStateDownloadFileChecked,
    LTPlayProcessStateMovieAvailableChecked,
    LTPlayProcessStateWaitForLogin,
    LTPlayProcessStateWaitForPay,
    LTPlayProcessStateTrialPlayFinished,
    LTPlayProcessStateVideoFilePrepared,
    LTPlayProcessStatePlayUrlPrepared,
    LTPlayProcessStatePlaying,
    LTPlayProcessStateGSLBPrepared,
};

/*  直播流程状态 */
typedef NS_ENUM (NSInteger, LTPlayProcessLiveState){
    LTPlayProcessLiveStateNone,
    LTPlayProcessStateChannelBillPrepared,
    LTPlayProcessStateLiveHallBillBillPrepared,
};

/* 推送状态 */
typedef NS_ENUM (NSInteger, LTPlayProcessPushStatus){
    LTPlayProcessPushStatusPushSuccess,         // 推送成功
    LTPlayProcessPushStatusPushFailed,          // 推送失败

    LTPlayProcessPushStatusNotLogin,            // 未登录
    LTPlayProcessPushStatusNotSeniorVIP,        // 不是高级VIP
    LTPlayProcessPushStatusNoDevice,            // 没找到设备
    LTPlayProcessPushStatusNoExternalHarddisk,  // 无外接硬盘
    LTPlayProcessPushStatusOutOfDiskSpace,      // 磁盘空间不足
    LTPlayProcessPushStatusUserCanceled,        // 取消推送
};

/* 试看时的状态 */
typedef NS_ENUM (NSInteger, LTPlayProcessTrialState){
    LTPlayProcessTrialStateNone,                // 可直接播放整集，不需要试看

    LTPlayProcessTrialStateNotLogin,              //未登录
    LTPlayProcessTrialStateNotVip,                // 已登录，非会员
    LTPlayProcessTrialStateOwnVipVoucher,         // 有未使用Vip观影券
    LTPlayProcessTrialStateVipUserWithGeneralVoucher,   // 会员有未使用通用观影券
    LTPlayProcessTrialStateUnVipUserWithGeneralVoucher, // 非会员有未使用通用观影券
    LTPlayProcessTrialStateNoVoucher,           // 已登录，会员，单点，无观影券
    LTPlayProcessTrialStateLivingNeedPay,        // 直播试看，没有购买，ispre = 1
    LTPlayProcessTrialStateLivingNeedVip,        // 直播试看，不是会员，ispre = 1
    LTPlayProcessTrialStateForbiddenUserId,      //会员账号被封禁
    LTPlayProcessTrialStateNoTrial,             // 付费电视剧，没有试看,已登录
    LTPlayProcessTrialStateNoTrialNotLogin,     // 付费电视剧，没有试看,味登录
    LTPlayProcessTrialStateTVODNeedPay,                 // tvod试看，需付费
    LTPlayProcessTrialStateNoTrialTVODNeedPay          // tvod 无试看，需付费
    //    LTPlayProcessTrialStateIsFinishing,         // 试看即将结束
};

typedef struct LTAdFrontPlayFlag {
    unsigned int pin : 1;         // 拼接前贴广告
    unsigned int normal : 1;      // 普通前贴广告
    AdvertiseStatus pinAdStaus; // 拼接广告状态
} LTAdFrontPlayFlag;

typedef struct LTPlayerFlag {
    unsigned int isPauseByUser : 1;       // 是否用户主动暂停
    unsigned int isPauseByUserWhenEnterbackground : 1; // IOS8上退到后台如果是暂停，回来也需要再重新加载
    unsigned int isPauseByNetworkErr : 1; // 是否播放过程中因为网络故障暂停
    unsigned int isPauseByAVD : 1;        // 是否为AVD导致暂停
    unsigned int isHeadSkipped : 1;       // 是否已经跳过片头
    unsigned int isTailSkipDisabled : 1;  // 是否不允许跳过片尾，（手动改变进度到片尾之后，不允许跳过片尾）
    unsigned int isPlayLocalFile : 1;     // 是否播放本地文件
    unsigned int isScreenLocked : 1;      // 是否锁屏
    unsigned int isPauseVia3G : 1;        // 3G暂停
    unsigned int isPauseByPopView : 1;      // 是否因为弹出分享框暂停，以及是否因为弹出会员前置框暂停
    unsigned int isInteruptByNoBackgroud;  //是否因为push到另一个页面（非后台性打断）造成的打断

    unsigned int isRecommendBigTipsDisabled : 1;  // 是否不允许显示推荐视频联播大tip （手动点击大tip上的关闭按钮之后）
    unsigned int isRecommendBigTipsClosebyUser : 1; //是否手动关闭大Tip
    unsigned int isReleasePlayerByRetry : 1;
    unsigned int isInteruputWithNoMoviePlayer : 1;  //进后台时是否播放器为空
    unsigned int isRedPacketScreenLocked : 1;      // 直播红包全屏是否锁屏（只有直播红包全屏用）
    LTPlayProcessTrialState playTrialState; //试看状态
    NSInteger voucherCount;                 //剩余观影券数量
} LTPlayerFlag;

typedef struct LTPlayStatisticsInfo {
    NSTimeInterval readyTime;               // 资源加载起始时间
    NSTimeInterval resourceLoadFinishTime;  // 开始播放时间
    NSInteger bufCount;                     // 缓冲时间
    NSInteger bufAllTime;                     // 缓冲时间
    NSInteger bufCountByUser;               // 手动造成的卡顿次数
    NSInteger bufTimeByUser;
    BOOL isFrontAdExisted;                  // 是否播放前贴片
    BOOL isBuffByUser;
    NSTimeInterval FirstBufTime;                 //第一次非手动卡顿时间
    NSTimeInterval FirstBufByUserTime;           //第一次手动卡顿时间
    LTDCCodePlayFrom playFrom;              // 播放来源
    BOOL isTrialPlayFinished;
} LTPlayStatisticsInfo;

typedef void (^ LTFSEpisodeCellConfigureBlock)(id cell, id item, LTFSEpisodeType episodeType, MovieShowStyle showStyle, NSString* playingVid, NSIndexPath* indexPath);
typedef void (^ LTFSEpisodeCellGridConfigureBlock)(id cell, id item, LTFSEpisodeType episodeType, MovieShowStyle showStyle, NSString* playingVid, NSIndexPath* indexPath);

typedef NS_ENUM (NSInteger, LTFullScreenMoreViewItemType) {
    LTFullScreenMoreViewItemType_Download,         //下载
    LTFullScreenMoreViewItemType_Favorite,          //收藏
    LTFullScreenMoreViewItemType_Share,            //分享
    LTFullScreenMoreViewItemType_DownloadToLetv,   //缓存到Letv
    LTFullScreenMoreViewItemType_PushToLetv,       //推送到Letv
    LTFullScreenMoreViewItemType_Airplay           //AirPlay
};
#endif
