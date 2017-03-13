//
//  LTDataCenterEnumDef.h
//  LetvMobileClient
//
//  Created by Allen on 28/11/2016.
//  Copyright © 2016 LeEco. All rights reserved.
//

#ifndef LTDataCenterEnumDef_h
#define LTDataCenterEnumDef_h

typedef NS_ENUM(NSInteger, LTDataCenterStatisticsType)
{
    LTDataCenterStatisticsTypeError,
    
    // 1.6 统计类型
    LTDataCenterStatisticsTypeLogin,    // 启动   -
    LTDataCenterStatisticsTypeLogout,   // 退出   -
    LTDataCenterStatisticsTypePlay,     // 播放
    LTDataCenterStatisticsTypeAction,   // 动作
    LTDataCenterStatisticsTypeAdPlay,   // 贴片广告
    
    LTDataCenterStatisticsTypeKVAction, // 2.0 动作
    LTDataCenterStatisticsTypeKVLogin,  // 2.0 启动
    LTDataCenterStatisticsTypeKVLogout, // 2.0 退出
    LTDataCenterStatisticsTypeKVEnv,    // 2.0 环境
    LTDataCenterStatisticsTypeKVPlay,   // 2.0 播放
    LTDataCenterStatisticsTypeKVAd,     // 2.0 广告
    LTDataCenterStatisticsTypeKVQuery,  // 2.0 搜索
    LTDataCenterStatisticsTypeKVError,  // 2.0 错误
    LTDataCenterStatisticsTypeKVUnknow, // 未知类型
};

// 播放过程最后状态
typedef NS_ENUM(NSInteger, LTDCCodePlayExitStatus)
{
    LTDCCodePlayExitStatusEmpty = -1,
    LTDCCodePlayExitStatusInit = 1,         // 1:初始
    LTDCCodePlayExitStatusFinishByUser = 2, // 2:用户手动结束播放
    LTDCCodePlayExitStatusFinishNormal = 3, // 3:视频自动完成播放
    LTDCCodePlayExitStatusPlayError = 4,    // 4:播放出错
    LTDCCodePlayExitStatusAdExit = 5,       // 5N：贴片广告N退出，N为贴片个数
};

// 播放错误代码
typedef NS_ENUM(NSInteger, LTDCCodePlayExitError)
{
    LTDCCodePlayExitErrorNone = 0,          // 正常
    LTDCCodePlayExitErrorSchedule = 1,      // 调度错误
    LTDCCodePlayExitErrorCDN = 2,           // cdn出错
    LTDCCodePlayExitErrorLoading = 3,       // 加载资源出错
    LTDCCodePlayExitErrorUnknown = 4,       // UNKNOWN
};

// 播放类型
typedef NS_ENUM(NSInteger, LTDCCodePlayActionType)
{
    LTDCCodePlayActionTypeUnknown = 0,
    LTDCCodePlayActionTypeNew = 1,          // 点播
    LTDCCodePlayActionTypeHistory = 2,      // 点播续播
    LTDCCodePlayActionTypeLiving = 3,       // 直播
};


// 播放来源 (1:列表 2:详情 3:播放记录 4:下载 5：搜索 6：排行 7：首页 8：其它)
typedef NS_ENUM(NSInteger, LTDCCodePlayFrom)
{
    LTDCCodePlayFromUnknown     = 0,
    
    LTDCCodePlayFromList        = 1,    // 列表
    LTDCCodePlayFromDetail      = 2,    // 详情
    LTDCCodePlayFromHistory     = 3,    // 播放记录
    LTDCCodePlayFromDownload    = 4,    // 下载
    LTDCCodePlayFromSearch      = 5,    // 搜索
    LTDCCodePlayFromChart       = 6,    // 排行
    LTDCCodePlayFromIndex       = 7,    // 首页
    LTDCCodePlayFromOther       = 8,    // 其它
    LTDCCodePlayFromPush        = 9,    // 推送
    LTDCCodePlayFromQcode       = 10,   //来自二维码续播
    LTDCCodePlayFromLunBoMenu   = 11,   //来自轮播台节目单
    LTDCCodePlayFromWeiShiMenu  = 12,   //来自卫视台节目单
    LTDCCodePlayFromLiveRelated = 13,   //来自直播半屏相关。
    LTDCCodePlayFromLeBox       = 14,   //来自乐盒
    LTDCCodePlayFromHomeCover   = 15,   //来自首页焦点图
};

// 动作模块
typedef NS_ENUM(NSInteger, LTDCCodeActionModule)
{
    LTDCCodeActionModuleSend     = -2,   // fixme 特殊处理：app进入background或者exit的时候，发送一个这个动作，强制向服务器发送缓存的数据
    LTDCCodeActionModuleEmpty    = -1,   // empty
    
    LTDCCodeActionModuleGeneral  = 0,    // 通用
    LTDCCodeActionModuleNav      = 1,    // 导航
    LTDCCodeActionModuleIndex    = 2,    // 首页
    LTDCCodeActionModuleChannel  = 3,    // 频道
    LTDCCodeActionModulePlayer   = 4,    // 播放器
    LTDCCodeActionModuleSearch   = 5,    // 搜索
    LTDCCodeActionModuleDownload = 6,    // 下载
    LTDCCodeActionModuleDetail   = 7,    // 详情页
    LTDCCodeActionModuleMore     = 8,    // 更多
    
    LTDCCodeActionModuleFav      = 9,    // 收藏夹(9)
    LTDCCodeActionModuleLiveOrder= 10,   // 直播预约(a)
    LTDCCodeActionModuleShare    = 11,   // 分享(b)
    LTDCCodeActionModuleFollow   = 12,   // 追剧 (c)
    LTDCCodeActionModuleExchangeApp = 13, // 精品推荐(d)
    LTDCCodeActionModuleSubChannel  = 14, // 频道列表页(e)
    
    LTDCCodeActionModuleLive     = 21,    //(l) 直播
    LTDCCodeActionModuleMyletv   = 22,    //(m) 我的乐视
    
    LTDCCodeActionModuleCount    = 25,    // count
};

// 动作类型
typedef NS_ENUM(NSInteger, LTDCCodeActionType)
{
    LTDCCodeActionTypeEmpty   = -1,   // empty
    
    LTDCCodeActionTypeEntry   = 3,    // 进入
    
    LTDCCodeActionTypeClick   = 4,    // 点击
    LTDCCodeActionTypeShow    = 5,    // 曝光
    LTDCCodeActionTypeUse     = 6,    // 使用
    
    LTDCCodeActionTypeCount   = 10,    // count
    
};

// 动作类型 2.0
typedef NS_ENUM(NSInteger, LTDCActionCode)
{
    
    LTDCActionCodeClick     = 0,    // 0 点击
    LTDCActionCodeComment   = 1,    // 1 评论
    LTDCActionCodeDownload  = 2,    // 2 下载
    LTDCActionCodeFav       = 3,    // 3 收藏
    LTDCActionCodeShare     = 4,    // 4 分享
    LTDCActionCodeRecharge  = 5,    // 5 充值
    LTDCActionCodePay       = 6,    // 6 缴费
    LTDCActionCodeOther     = 7,    // 7 待定
    LTDCActionCodeProgram   = 8,    // 8 节目单呼出次数
    LTDCActionCodeInstall   = 9,    // 9 安装
    LTDCActionCodeUninstall = 10,   // 10 卸载
    LTDCActionCodeLaunch    = 11,   // 11 启动
    LTDCActionCodeQuit      = 12,   // 12 退出
    LTDCActionCodeOnline    = 13,   // 13 在线
    LTDCActionCodeUpgrade   = 14,   // 14 升级
    LTDCActionCodeRecommendClick =17,  //17 个性化推荐点击
    LTDCActionCodePush      = 18,   // 18 移动统计push消息 recms(receive message)
    LTDCActionCodeShow      = 19,   // 19 曝光
    
    LTDCActionCodePlayFailed= 20,   // 20 播放失败
    LTDCActionCodeBufferTime =22,   //22 缓冲时长
    LTDCActionCodeSupport = 24,    //评论赞一下
    LTDCActionCodeShowForRecommend =25,  //25 首页个性化推荐曝光
    
    LTDCActionCodePLayerLoad =31,   //点击海报到播放页的时长
    LTDCActionCodePLayerBack =29,   //点击播放页返回到上一级的时长
    LTDCActionCodeTimeForRecommendLoad =30, //启动app，到首页加载结束
    LTDCActionCodeHalfPlayer = 34,    //半屏播放页,滑动上报
    LTDCActionCodeIrMonitorBack = 42, //艾瑞统计返回
    LTDCActionCodeWatchConnentCount = 46, // Watch连接iPhone的时候上报
};

#pragma mark - sub module code

// 首页
typedef enum {
    
    SUBMODULE_INDEX_EMPTY = -1,   // empty
    
    SUBMODULE_INDEX_MYLETV= 0,      // 进入“我的”
    SUBMODULE_INDEX_FAV   = 1,      // 收藏
    SUBMODULE_INDEX_RECOMMEND  = 5, // 首页个性化推荐：“您可能喜欢”
    SUBMODULE_INDEX_BLOCK = 6,      // 首页其它推荐，Block
    SUBMODULE_INDEX_FOCUS = 15,     // 焦点图
    
}DC_CODE_SUBMODULE_INDEX;

// 频道首页
typedef enum {
    
    SUBMODULE_CHANNEL_EMPTY    = -1,   // empty
    
    SUBMODULE_CHANNEL_MYLETV    = 0,   // 进入“我的”
    
}DC_CODE_SUBMODULE_CHANNEL;

// 频道列表
typedef enum {
    
    SUBMODULE_SUBCHANNEL_EMPTY    = -1,   // empty
    
    SUBMODULE_SUBCHANNEL_MYLETV   = 0,     // 进入“我的”
    SUBMODULE_SUBCHANNEL_FAV      = 1,     // 收藏
    
}DC_CODE_SUBMODULE_SUBCHANNEL;

// 播放页
typedef enum {
    
    SUBMODULE_PLAYER_EMPTY = -1,   // empty
    
    SUBMODULE_PLAYER_SHARE  = 1,    // 分享
    SUBMODULE_PLAYER_HS_FAV = 2,    // 收藏,半屏
    SUBMODULE_PLAYER_FS_FAV = 3,    // 收藏,全屏
    
}DC_CODE_SUBMODULE_PLAYER;

// 搜索
typedef enum {
    
    SUBMODULE_SEARCH_EMPTY    = -1,   // empty
    
    SUBMODULE_SEARCH_TEXT     = 0,    // 文字输入框搜索
    SUBMODULE_SEARCH_VOICE    = 1,    // 语音输入按钮搜索
    SUBMODULE_SEARCH_HISTORY  = 2,    // 搜索历史
    SUBMODULE_SEARCH_RECOMMEND= 3,    // 热门搜索推荐关键词输入
    SUBMODULE_SEARCH_RELATED  = 4,    // 关键词联想输入
    SUBMODULE_SEARCH_FAV      = 5,    // 收藏
    
}DC_CODE_SUBMODULE_SEARCH;

// 下载
typedef enum{
    
    SUBMODULE_DOWNLOAD_EMPTY = -1,  // empty
    
    SUBMODULE_DOWNLOAD_ADD = 3,  // 添加下载
    
}DC_CODE_SUBMODULE_DOWNLOAD;

// 详情
typedef enum {
    
    SUBMODULE_DETAIL_EMPTY    = -1,   // empty
    
    SUBMODULE_DETAIL_FAV      = 0,    // 收藏
    SUBMODULE_DETAIL_SHARE    = 1,    // 分享
    SUBMODULE_DETAIL_LIKE     = 5,    // 你可能喜欢
    SUBMODULE_DETAIL_DIRECTOR = 6,    // 导演相关
    SUBMODULE_DETAIL_ACTOR    = 7,    // 主演相关
    SUBMODULE_DETAIL_FOLLOW   = 8,    // 追剧
    
}DC_CODE_SUBMODULE_DETAIL;

// 收藏夹
typedef enum{
    
    SUBMODULE_FAV_EMPTY = -1,
    
    SUBMODULE_FAV_EDIT  = 0,    // 编辑
    SUBMODULE_FAV_DEL   = 1,    // 删除
    SUBMODULE_FAV_CLEAR = 2,    // 清空
    
}DC_CODE_SUBMODULE_FAV;

// 追剧
typedef enum{
    
    SUBMODULE_FOLLOW_EMPTY = -1,
    
    SUBMODULE_FOLLOW_EDIT  = 0,    // 编辑
    SUBMODULE_FOLLOW_DEL   = 1,    // 删除
    SUBMODULE_FOLLOW_CLEAR = 2,    // 清空
    
}DC_CODE_SUBMODULE_FOLLOW;

// 预约
typedef enum{
    
    SUBMODULE_ORDER_EMPTY = -1,
    
    SUBMODULE_ORDER_ALERTSWITCH  = 0,    // 预约提醒开关
    
}DC_CODE_SUBMODULE_ORDER;

// 分享
typedef enum{
    
    SUBMODULE_SHARE_EMPTY = -1,
    
    SUBMODULE_SHARE_SHARE  = 0,    // 分享
    
}DC_CODE_SUBMODULE_SHARE;

// 直播
typedef enum{
    
    SUBMODULE_LIVE_EMPTY = -1,
    
    SUBMODULE_LIVE_CHANNEL    = 0,    // 选台
    SUBMODULE_LIVE_TIMETABLE  = 1,    // 选时间表
    SUBMODULE_LIVE_MYORDER    = 2,    // 我的预约
    SUBMODULE_LIVE_PROGRAM    = 3,    // 节目单
    SUBMODULE_LIVE_MYLETV     = 4,    // 进入“我的”
    
}DC_CODE_SUBMODULE_LIVE;

// 精品推荐
typedef enum{
    
    SUBMODULE_EXCHANGEAPP_EMPTY = -1,
    
    SUBMODULE_EXCHANGEAPP_MYLETV    = 0,    // 进入“我的”
    
}DC_CODE_SUBMODULE_EXCHANGEAPP;

//退出播放器时播放的当前阶段
typedef enum{
    PlayerStatus_None,
    PlayerStatus_RequestADUrls,
    PlayerStatus_RequestADPin,
    PlayerStatus_ADLoading,
    PlayerStatus_ADPlaying,
    PlayerStatus_PlayerLoading,
    PlayerStatus_PlayerPlaying,
    
    
}DC_EXIT_PLAYER_STATUS;

//错误类型
typedef enum
{
    ERROR_PLAY   = 4001,    //播放失败，播放一半失败
    ERROR_CANNOT_PALY=4002, //不能成功播放（无法打开播放）
    ERROR_DOWNLOAD=4003,    //下载失败   download size > file size
    ERROR_REQUIREDATA=4004,  //各页面数据为空，获取数据失败
    ERROR_QUIT=4005,         //崩溃
    ERROR_MEM_OVERFLOW=4006, //内存溢出
    ERROR_MENU_ACTION=4007,      //主功能操作失败
    ERROR_UNDEFINED=4008,  //未定义错误
    ERROR_DOWNLOAD_OVERFLOW=4009,  //下载超过100%
}ERROR_TYPE;

//错误动作
typedef enum
{
    ERROR_ACT_PLAY   = 1001,    //播放动作
    ERROR_ACT_DOWNLOAD=1002,    //下载动作
    ERROR_ACT_UNDEFINED=1003,   //未定义
}ERROR_ACTION;

// 播放错误码
typedef NS_ENUM(NSInteger, LTDCPlayFailedCode)
{
    LTDCPlayFailedCodeNone,         // 无错误
    
    LTDCPlayFailedCodeAlbumDetail,  // 请求专辑详情失败
    LTDCPlayFailedCodeVideoDetail,  // 请求视频详情失败
    LTDCPlayFailedCodeVideoList,    // 专辑视频列表失败
    LTDCPlayFailedCodeVideoFile,    // 请求视频文件信息失败
    LTDCPlayFailedCodeTimestamp,    // 得到过期时间戳失败
    LTDCPlayFailedCodeCloud,        // 请求调度失败
    LTDCPlayFailedCodeLoading,      // 视频缓冲或播放失败
    LTDCPlayFailedCodeNetwork,      // 网络异常
    LTDCPlayFailedCodeUnknown,      // 未知错误
    
    LTDCPlayFailedCodeLiveIpForbid, // 直播海外屏蔽无法播放
    LTDCPlayFailedCodeLiveUrl,      // 请求真实的播放地址
    LTDCPlayFailedCodeLiveTimestamp,// 请求过期时间戳（直播）tm失败
    LTDCPlayFailedCodeLiveNetwork,  // 网络异常
    LTDCPlayFailedCodeLiveUnknown,  // 未知错误
};

//数据统计新错误码 add in V5.3.1
typedef NS_ENUM(NSInteger, LTDCFailedCode)
{
    LTDCFailedCodeNone,         // 无错误
    
    // LTDCFailedCodeNoVideo =0007,  // 视频下线或者不存在  废弃pad 5.7 合并到0015
    LTDCFailedCodeIpForbid =31,  // 海外屏蔽
    LTDCFailedCodeBlackList =9,    // 黑名单  0009
    LTDCFailedCodeAutypeError =24,    //  autypeError版权需求不在白名单内的域不能播放(类似:viki)
    LTDCFailedCodeLandForbid = 30,    //大陆ip受限的视频
    LTDCFailedCodePublishExpire =15,    // 版权到期
    //  LTDCFailedCodeNotOnline =0010,        // 未上线  废弃pad 5.7 合并到0015
    LTDCFailedCodeLoadControlNetworkError =500,     // 加载必须插件,网络错误
    LTDCFailedCodeLoadControlTimeOut=501,      // 加载必须插件,超时错误
    LTDCFailedCodeLoadControlSecurity=502,      // 加载必须插件,安全错误
    LTDCFailedCodeLoadControlDataParse=503,     //数据解析错误
    LTDCFailedCodeLoadControlOther=599,     // 加载必须插件,其它错误  0599
    LTDCFailedCodeVideoNotFind=402, //视频无法找到
    LTDCFailedCodePlayTimeOut=403,  //播放视频超时
    LTDCFailedCodePlaySecurity=404, //播放视频文件出现安全错误
    LTDCFailedCodePlayNoLegal =405,    //播放的视频文件不合法
    LTDCFailedCodePlayOther =406,  //播放视频文件其它错误
    LTDCFailedCodeVRSNetworkError =1300,  //加载VRS,网络错误
    LTDCFailedCodeVRSTimeOut =1301,  //加载VRS,超时错误
    LTDCFailedCodeVRSSecurity =1302,  //加载VRS,安全错误
    LTDCFailedCodeVRSDataParse =1303,  //加载VRS,数据解析错误
    LTDCFailedCodeDDNetworkError =900, //调度,网络错误 0900
    LTDCFailedCodeDDTimeOut =901, //调度,超时错误 0901
    LTDCFailedCodeDDSecurity =902, //调度,安全错误 0902
    LTDCFailedCodeDDDataPhase =903, //调度,数据解析错误 0903
    LTDCFailedCodeDDDataOherError =998, //调度,数据其它错误 0998
    LTDCFailedCodeDDOherError =999, //调度,其它错误  0999
    LTDCFailedCodeMeiziRequestError =1200,//新媒资接口访问失败
    LTDCFailedCodeMeiziRequestTimeout =1201,//新媒资接口访问超时
    LTDCFailedCodeMeiziSecurity =1202,//新媒资接口安全错误
    LTDCFailedCodeMeiziNoLegal =1203,  //新媒资接口访问内容不合法
    LTDCFailedCodeMeiziOtherError =1299, // 新媒资接口访问其它错误
    LTDCFailedCodeOtherError =999, //其他异常 0999
    
    LTDCFailedCodeDownloadCannotPlay =19001, //下载后不能播放
    LTDCFailedCodeDownloadCrash =19002,  //下载稳定性-崩溃导致无法下载
    LTDCFailedCodeDownloadLinkError =19003,  //下载链接错误
    
};
// login状态
typedef NS_ENUM(NSInteger, LTDCLoginStatus)
{
    LTDCLoginStatusLogin,   // 登录
    LTDCLoginStatusLogout,  // 退出
    LTDCLoginStatusLogin2UserCenter // 登录到用户中心
};

// 统计动作属性（ap）分类（fl）
typedef NS_ENUM(NSInteger, LTDCActionPropertyCategory)
{
    LTDCActionPropertyCategoryUndefine = 0,             // 未知
    
    // 首页
    LTDCActionPropertyCategoryLoginGuide,               //用户登录引导
    LTDCActionPropertyCategoryIndexFocus,               // 首页焦点图
    LTDCActionPropertyCategoryIndexBlock,               // 首页模板单元数据图
    LTDCActionPropertyCategoryIndexAppexchange,         // 首页精选应用
    LTDCActionPropertyCategoryIndexBlockPic,            // iPad首页模板单元数据图
    LTDCActionPropertyCategoryIndexRecommentPic,        // 首页推荐弹出框
    LTDCActionPropertyCategoryIndexBlockPlayHistory,    // 播放记录
    LTDCActionPropertyCategoryIndexLive1,               // 首页-直播运营区1
    LTDCActionPropertyCategoryIndexLive2,               // 首页-直播运营区2
    LTDCActionPropertyCategoryIndexShow,
    LTDCActionPropertyCategoryIndexImportRecommend,     // 首页－重磅推荐
    LTDCActionPropertyCategoryIndexSearch,              //首页 -搜索
    LTDCActionPropertyCategoryIndexLetvRecommend,       //首页 -乐视应用推荐
    LTDCActionPropertyCategoryIndexRecordTip,           //首页 -播放记录提示
    LTDCActionPropertyCategoryIndexPlayRecordShow,      // 首页-播放记录曝光
    LTDCActionPropertyCategoryIndexInvitePopView,       //首页-首次打开应用弹层
    LTDCActionPropertyCategoryIndexVipNotExpireRemindView, //首页 -会员快要过期提醒应用弹层
    LTDCActionPropertyCategoryIndexVipHasExpireRemindView, //首页 -会员已过期提醒应用弹层
    LTDCActionPropertyCategoryIndexAppRecommend,           //首页 -App推荐应用弹窗
    //
    LTDCActionPropertyCategoryPopWoshiGeShou,           // 弹框“我是歌手”
    
    LTDCActionPropertyCategoryIndexChannel,             // 首页频道
    LTDCActionPropertyCategoryChannelWallEdit,          // 频道也编辑
    LTDCActionPropertyCategoryCustomEdit,               //首页、频道墙等个性化编辑
    LTDCActionPropertyCategoryVipTrialInviteView,       //首页会员试用页面
    LTDCActionPropertyCategoryVIPPromotionView,         //会员推广
    // 导航
    LTDCActionPropertyCategoryNavigationChannel,        // 频道导航切换
    LTDCActionPropertyCategoryNavigationChannelMore,    // 频道导航切换，更多
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    LTDCActionPropertyCategoryNavigationChannelMoreList, // 更多 里的频道
    LTDCActionPropertyCategoryNavigationChart,          // 排行榜，缓存
#endif
    
    // 频道页
    LTDCActionPropertyCategoryChannelWall,               //频道墙
    LTDCActionPropertyCategoryChannelPage,              // 频道 分类检索/频道首页切换
    LTDCActionPropertyCategoryChannelFocus,             // 频道页焦点图
    LTDCActionPropertyCategoryChannelBlock,             // 频道页区块
    LTDCActionPropertyCategoryChannelExchangeButton,     //换一换首页video
    LTDCActionPropertyCategoryChannelManage,            // 更多频道页面-“管理我的频道”
    LTDCActionPropertyCategoryChannelSportHall,         // 体育频道-直播厅
    LTDCActionPropertyCategoryChannelSport,             // 体育直播
    LTDCActionPropertyCategoryChannelSubChannel,        // 频道-分类检索
    LTDCActionPropertyCategorySportJiJin,                // 重点赛事模块-集锦
    LTDCActionPropertyCategorySportSpecial,              //重点赛事模块-专题
    LTDCActionPropertyCategorySportMore,                 //重点赛事模块-查看更多
    LTDCActionPropertyCategorySportFlag,                //重点赛事模块-国旗
    LTDCActionPropertyCategorySportTextLink,            //重点赛事模块-文字连接
    LTDCActionPropertyCategoryChannelSecond,            //频道二级页面
    LTDCActionPropertyCategoryChannelSecondSearch,      //频道二级页面底部搜索
    LTDCActionPropertyCategoryChannelSortViewNew,       // 频道-分类检索:确定按钮点击 iphone6.0
    LTDCActionPropertyCategoryChannelSecondFilter,      // 频道首页顶部筛选条
    LTDCActionPropertyCategoryChannelSecondButtonFilter,// 频道二级页面的筛选
    
    LTDCActionAppStoreStar,                              //跳转AppStore评分
    
    // 搜索
    LTDCActionPropertyCategorySearchHotword,            // 热门搜索(v<5.4.2)
    
    //搜索首页热门搜索推荐选项卡相关(v>5.4.2)
    LTDCActionPropertyCategorySearchRecommendTab,      //热门推荐选项卡
    LTDCActionPropertyCategorySearchRecommendTab1Poster,//tab1中海报
    LTDCActionPropertyCategorySearchRecommendTab2Poster,//tab2中海报
    LTDCActionPropertyCategorySearchRecommendTab3Poster,//tab3中海报
    LTDCActionPropertyCategorySearchRecommendTab4Poster,//tab4中海报
    
    
    //搜索按钮相关
    LTDCActionPropertyCategorySearchInput,              // 直接搜索(v<5.4.2)
    LTDCActionPropertyCategorySearchGoSearch,           // 点击搜索按钮搜索(>5.4.2)
    //搜索建议词相关
    LTDCActionPropertyCategorySearchRelated,            // 关联词(v<5.4.2)
    LTDCActionPropertyCategorySearchSugest,             // 建议词(v>5.4.2)
    LTDCActionPropertyCategorySearchSugestPlayBtn,      // 搜索建议词列表右侧搜索按钮(v>5.4.2)
    //其他搜索动作
    LTDCActionPropertyCategorySearchResult,             // 搜索结果点击
    LTDCActionPropertyCategorySearchGoBack,             // 搜索返回
    LTDCActionPropertyCategorySearchH5ResultGoBack,       //搜索h5结果页返回
    
    // TV推广
    LTDCActionPropertyCategoryTVPromoteSearchresult,    // 搜索结果页
    LTDCActionPropertyCategoryTVPromoteSetting,         // 设置页
    LTDCActionPropertyCategoryTVPromoteAppexchange,     // 精选页
    LTDCActionPropertyCategoryTVPromoteHalfPlayer,      // 半屏播放页
    
    LTDCActionPropertyCategoryPlayer2KClick,            //全屏2K码流点击
    LTDCActionPropertyCategoryPlayerNoneWifiErrorClick, //全屏非wifi土豪请继续点击
    LTDCActionPropertyCategoryTVPromotePlayerLeft,      // 全屏播放器超级电视电视外部区块
    LTDCActionPropertyCategoryTVPromotePlayerLeftBlock, // 全屏播放器左侧功能栏超级电视内部区块
    LTDCActionPropertyCategoryTVPromotePlayerPush,      // 全屏播放器左下角推送到超级电视按钮
    LTDCActionPropertyCategoryTVPromotePlayer1080P,     // 全屏播放器清晰度切换1080p
    LTDCActionPropertyCategoryTVPromotePlayer,
    LTDCActionPropertyCategoryTVPromotePlayerPushSuperTV,  //投屏到推送超级电视
    LTDCActionPropertyCategoryTVPromotePlayerNotMatchSuperTV,//未匹配到超级电视提示弹框
    LTDCActionPropertyCategoryTVPromotePlayerAirPlayView,  //airplay-设备列表
    
    //发现模块选项卡相关
    LTDCActionPropertyCategoryFindContentArea,      // 内容区域
    LTDCActionPropertyCategoryFindToolArea,//工具区域
    LTDCActionPropertyCategoryFindPopularizeArea,//推广区域
    LTDCActionPropertyCategoryFindAppRecommendArea,//应用推广区域
    
    // 我是歌手
    LTDCActionPropertyCategorySearchResultWoShiGeShou,  // 我是歌手 搜索结果页banner
    
    // 直播页
    LTDCActionPropertyCategoryLivingFocus,              // 直播页焦点图
    LTDCActionPropertyCategoryLivingNavigation,         // 直播页二级导航
    LTDCActionPropertyCategoryLivingHalfBottom,
    LTDCActionPropertyCategoryLivingNavigationNew,      //直播二级导航  5.4版本
    LTDCActionPropertyCategoryLivingNavigationPosition1, //直播模块位置1  5.4版本
    LTDCActionPropertyCategoryLivingNavigationPosition2, //直播模块位置2  5.4版本
    LTDCActionPropertyCategoryLivingNavigationPosition3, //直播模块位置3  5.4版本
    LTDCActionPropertyCategoryLivingNavigationPosition4, //直播模块位置4  5.4版本
    LTDCActionPropertyCategoryLivingNavigationPosition5, //直播模块位置5  5.4版本
    LTDCActionPropertyCategoryLivingNavigationPosition6, //直播模块位置6  5.4版本
    LTDCActionPropertyCategoryLivingNavigationPosition7, //直播模块位置7  5.4版本
    
    
    // 半屏播放器
    LTDCActionPropertyCategoryHalfPlayerSurroundView,   // 周边视频
    LTDCActionPropertyCategoryHalfPlayerFouceView,      // 热点曝光
    LTDCActionPropertyCategoryHalfPlayerjuji,           //剧集列表
    LTDCActionPropertyCategoryHalfPlayerRelateView,      //相关 - 相关系列
    LTDCActionPropertyCategoryHalfPlayerVip,            //半屏开通会员
    LTDCActionPropertyCategoryHalfPlayerToolBar,        // 半屏播放器toolbar
    LTDCActionPropertyCategoryHalfPlayerTabScroll,    //  半屏播放器tabScroll
    LTDCActionPropertyCategoryHalfPlayerTabBar,        //  半屏播放器选集简介相关分享
    LTDCActionPropertyCategoryHalfPlayerEpisode,
    LTDCActionPropertyCategoryHalfPlayerRelate,
    LTDCActionPropertyCategoryHalfPlayerKanqiu,      // 半屏播放器必备看球神器
    //半屏播放页剧集 评论 相关
    LTDCActionPropertyHalfPlayerTag,
    //半屏播放页 缓存，分享，收藏 应用推荐
    LTDCActionPropertyHalfPlayerToolBar,
    //半屏播放页评论，赞一下、回复
    LTDCActionPropertyHalfPlayerComment,
    //半屏播放页相关 播放、收藏、取消收藏
    LTDCActionPropertyRelatedPlayAndFav,
    //半屏播放页 剧集 推广位
    LTDCActionPropertyEpisodePromotion,
    //半屏播放页相关 相关系列
    LTDCActionPropertyRelatedSeries,
    //半屏播放页相关 猜你喜欢
    LTDCActionPropertyRelatedGuessYouLike,
    //半屏播放页相关 剧集汇总、周边视频
    LTDCActionPropertyEpisodeSummary,
    //半屏播放页相关 剧集点击，完整和看点
    LTDCActionPropertyEpisodeClick,
    //半屏播放页 相关，猜你喜欢
    LTDCActionPropertyRelated,
    //半屏播放页 评论发送
    LTDActionPropertyCommentSend,
    //其他模块分享各平台点击
    LTDCActionPropertyCategoryShareClick,
    //其他模块分享成功
    LTDCActionPropertyShareSucces,
    //截屏分享分享各平台点击
    LTDcActionPropertyCaptureShareClick,
    //截屏分享成功
    LTDcActionPropertyCaptureShareSucces,
    
    LTDActionPropertyHalfLiveOrder,
    LTDActionPropertyHalfLive,
    LTDActionPropertyHalfLiveToolBar,
    LTDActionPropertyHalfLivePayOrder,//直播支付确认页
    LTDActionPropertyHalfLivePayConsumeHistory,//购买成功页面-查看消费记录
    LTDActionPropertyHalfLiveToolBarSwitchOrder, //预约
    
    LTDCActionPropertyCategoryTVPromoteHalfPlayerBigTip, //大tip 点击、关闭
    LTDCActionPropertyCategoryTVPromoteHalfPlayer3G,     //2g与3g切换
    LTDCActionPropertyCategoryPlayerCenterShow,         //播放器中间区域
    LTDCActionPropertyCategoryPlayerCenterLookTimeClick,//观看长时
    LTDCActionPropertyCategoryPlayerCenterbuffer, //卡顿缓存
    LTDCActionPropertyCategoryHalfPlayerSkipAd,   //跳过广告
    LTDCActionPropertyCategoryHalfPlayerPurChaseByTrial, //试看的开通会员icon
    LTDCActionPropertyCategoryPreVideoPurChase,         // 会员抢先看
    LTDCActionPropertyCategoryHalfPlayerTrialLogin,  //试看的登录
    LTDCActionPropertyCategoryHalfPlayerTrialView,   //使用观影券
    LTDCActionPropertyCategoryPlayerCenterDownloadbuffer,
    LTDCActionPropertyCategoryPlayerSettingBindInfor, //分享绑定
    LTDcActionPropertyCategoryMoreClick,              //查看更多回复
    LTDcActionPropertyCategoryReplyClick,             //半屏回复
    LTDcActionPropertyCategoryPriseClick,             //半屏点赞
    LTDCActionPropertyCategoryHalfClickPrise,         //累计点赞
    LTDCActionPropertyCategoryChannelShowListViewPlay,            //频道节目单
    
    
    // 全屏播放器
    LTDCActionPropertyCategoryPlayerRightBlock,         // 全屏播放器右侧功能栏目
    LTDCActionPropertyCategoryFullScreen,               // 全屏播放器
    LTDCActionPropertyCategoryPlayerDoubleClick,       // 播放器双击
    LTDCActionPropertyCategoryPlayerGestureClick,      //双击
    LTDCActionPropertyCategoryFULLPlayerTipJump,       //跳转至网页播放
    LTDCActionPropertyCategoryPlayerVoteClick,         //全屏播放器投票点击
    
    //直播边看边买
    LTDCActionPropertyCategoryPlayerLiveShopping,     //直播边看边买
    LTDCActionPropertyCategoryPlayerLiveShoppingDetail, //边看边买商品详情
    LTDCActionPropertyCategoryPlayerRightShoppingList, //右侧商品列表
    
    
    //    #ifdef LT_MERGE_FROM_IPAD_CLIENT
    LTDCActionPropertyCategoryPlayerSuperTVClick,
    LTDCActionPropertyCategoryPlayerCenterChangeNetWork,//播放器中间区域网络环境切换点击
    LTDCActionPropertyCategoryPlayerCenterPauseDownloadClick,//暂停缓存弹出框相关点击。
    LTDCActionPropertyCategoryPlayerNumberClick,//选台列表内剧集的点击数量
    //    #endif
    // 精选
    LTDCActionPropertyCategoryAppexchangeFocus,         // 精选页面焦点图
    LTDCActionPropertyCategoryAppexchangeSeg1,          // 精选页面1
    LTDCActionPropertyCategoryAppexchangeSeg2,          // 精选页面2
    LTDCActionPropertyCategoryAppexchangeSeg3,          // 精选页面3
    LTDCActionPropertyCategoryAppexchangeSeg4,          // 精选页面4
    
    //
    LTDCActionPropertyCategoryMyLetv,                   // 我的页面
    LTDCActionPropertyCategoryMyLetvFav,                // 我的页面-播放单
    LTDCActionPropertyCategoryNavigation,               // 顶部导航
    LTDCActionPropertyCategoryIndexBlock1,              // 首页中部区域第一个模块
    LTDCActionPropertyCategoryIndexBlock1VIP,           // 首页中部区域第一模块第二个位置VIP引导
    
    LTDCActionPropertyCategoryMyLetvHeadUcNotLogin,     // 我的页面（未登录）
    LTDCActionPropertyCategoryMyLetvHeadUcLogin,        // 我的页面（已登录）
    LTDCActionPropertyCategoryMyLetvVipPay,             // 我的信息-成为会员/续费
    LTDCActionPropertyCategoryMyLetvVipPayForIpad,      // 我的乐视-个人中心-乐视会员续费 Ipad
    LTDCActionPropertyCategoryCashierVipPayForIpad,     //收银台-vip会员-IPAD
    LTDCActionPropertyCategoryCashierSeniorVipPayForIpad, //收银台-高级vip会员-IPAD
    LTDCActionPropertyCategoryMyLetvVoucherVip,         // 我的信息-我的观影券-加入会员
    LTDCActionPropertyCategoryCashier,                 // 收银台
    LTDCActionPropertyCategoryCashierVipPay,            // 收银台-vip会员
    LTDCActionPropertyCategoryCashierSeniorVipPay,      // 收银台-高级vip会员
    LTDCActionPropertyCategoryCashierLogin,              // 收银台-登录
    LTDCActionPropertyCategorySetting,                   //设置页面
    LTDCActionPropertyCategorySettingPlayPrior,          // 设置播放清晰度
    LTDCActionPropertyCategorySettingDownLoadPrior,       //设置页面下载清晰度
    LTDCActionPropertyCategorySettingDownLoadCount,      // 设置页面下载个数
    LTDCActionPropertyCategorySettingDownLoadCache,      // 设置页面下载缓存。
    LTDCActionPropertyCategorySettingAboutOur,           //设置页面关于我们。
    LTDCActionPropertyCategorySettingPersonalInfor,      //我的信息
    
    LTDCActionPropertyCategoryDownloadNav,              // 下载页面中部导航
    LTDCActionPropertyCategoryDownloadDel,              // 下载页面删除
    LTDCActionPropertyCategoryDownloadingClearAll,      // 下载页面下载中全部删除
    LTDCActionPropertyCategoryDownloadOverClearAll,     // 下载页面下载完成全部删除
    LTDCActionPropertyCategoryDownloadItunesClearAll,   // 下载页面itunes传输全部删除
    
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    LTDCActionPropertyCategoryDownloadingStateALL,      //缓存中页面全部缓存或全部暂停
    LTDCActionPropertyCategoryDownloadingButtonState,   //缓存中页面缓存、排队、暂停状态
    LTDCActionPropertyCategoryDownloadDeleteAll,        //缓存 全部删除
    LTDCActionPropertyCategoryDownloadMoreMoview,       //缓存更多剧集
    LTDCActionPropertyCategoryDownloadOverNotice,       //缓存完成通知
#endif
    
    LTDCActionPropertyCategoryDownloadPageAction,       // 下载页面下载暂停/开始操作
    LTDCActionPropertyCategoryHalfPlayerDownload,       // 半屏播放页下载
    LTDCActionPropertyCategoryHalfPlayerManageDownload, // 半屏播放页-管理我的下载
    LTDCActionPropertyCategoryHalfPlayerLive,           // 直播半屏播放器
    LTDCActionPropertyCategoryScreenPlayerLive,         // 直播全屏播放器
    LTDCActionPropertyCategoryScreenPlayerLiveCode,     // 直播全屏播放器码流
    
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    LTDCActionPropertyCategoryDownloadSegement,         //缓存码流
    LTDCActionPropertyCategoryDownloadAddSuccess,       //添加缓存成功
    LTDCActionPropertyCategoryDownloadForbid,           //剧集禁用缓存
    LTDCActionPropertyCategoryDownloadOther,             //其他端缓存
#endif
    LTDCActionPropertyCategoryLoginPage,                // 登录页面
    LTDCActionPropertyCategoryPhoneRegisterPage,        // 手机注册页面
    LTDCActionPropertyCategoryEmailRegisterPage,        // 邮箱注册页面
    LTDCActionPropertyCategoryLetvLoginPage,            // 乐视帐号登录页面
    LTDCActionPropertyCategoryLetvForgetPwd,            // 乐视帐号找回密码页面
    LTDCActionPropertyCategoryLetvForgetPwdSendMsg,     // 乐视帐号找回密码-发送短信
    
    LTDCActionPropertyCategoryLoginPage4Pad,            // 登录页面
    LTDCActionPropertyCategoryRegisterPage4Pad,         // 注册页面
    LTDCActionPropertyCategoryPhoneRegisterPage4Pad,    // 手机注册页面
    LTDCActionPropertyCategoryEmailRegisterPage4Pad,    // 邮箱注册页面
    
    LTDCActionPropertyCategoryDownloadUserLoginTip,   //半屏下载页登录提示
    LTDCActionPropertyCategoryIndexLoginTip,          //首页登录加速提示
    LTDCActionPropertyCategoryIndexRenewVip,          //首页续费提醒
    
    LTDCActionPropertyCategoryUpdate,      //升级
    LTDCActionPropertyCategoryForceUpdate, //强制升级
    LTDCActionPropertyCategorySubject,    // 专题
    LTDCActionPropertyCategoryUpdateAndForceUpdate, //强制升级与非强制升级
    
    //热点
    LTDCActionPropertyCategoryHotUp, //热点频道-顶
    LTDCActionPropertyCategoryHotShareBtn, //热点频道-分享按钮
    LTDCActionPropertyCategoryHotShare, //热点频道-分享页
    
    //登录
    LTDCActionPropertyLoginGoback,
    LTDCActionPropertyLoginFromThirdParty,
    LTDCActionPropertyLoginAction,
    LTDCActionPropertyLoginAccessory,
    LTDCActionPropertyLoginSuccess,
    LTDCActionPropertyLoginHeadClick,
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    LTDcActionPropertyLoginVipClick,
#endif
    
    //图文投票
    LTDCActionPropertyGraphicVoteShare,    //图文投票分享点击
    //注册页面
    LTDCActionPropertyRegisterGoback,      //返回
    LTDCActionPropertyRegisterFromThirdParty,        //注册来源腾讯QQ or 新浪微博
    LTDCActionPropertyRegisterBy,          //注册方式
    LTDCActionPropertyRegisterByPhone,     //手机注册
    LTDCActionPropertyRegisterByEmail,     //邮箱注册
    LTDCActionPropertyRegisterByMessage,    //短信注册
    LTDCActionPropertyRegisterPageShow,  //注册页面曝光
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    LTDCActionPropertyRegisterLoginSucc,
#endif
    
    //找回密码
    LTDCActionPropertyFindPasswordFromMessage,  //立即发送短信
    LTDCActionPropertyFindPasswordFromEMail,    //立即发送邮件
    LTDCActionPropertyFindPasswordPageShow,     //找回密码页曝光
    
    //push
    LTDCActionPropertyPush,  //push
    LTDCActionPropertyPushShow,//推送曝光
    
    //我的
    LTDCActionPropertyMyLetvPlayRecord, //我的页面-播放记录列表
    LTDCActionPropertyMyLetvRecodeListClick,  //播放记录列表点击
    LTDCActionPropertyMyLetvRecodeLoginClick,  //播放记录页的登录按钮
    LTDCActionPropertyMyLetvRecodeNextPlayClick,  //播放点击下一集播放
    LTDCActionPropertyMyLetvSettingClick,
    LTDCActionPropertyMyLetvListClick,
    LTDCActionPropertyPlayRecord,
    LTDCActionPropertyPlayRecordList,
    LTDCActionPropertyPlayHistoryBack,//播放记录-返回按钮
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    LTDCActionPropertyCategoryMyPage, //登陆 注册
#endif
    //专题列表页
    LTDCActionPropertyRecommendSpecial, //推荐专题
    
    //悬浮球
    LTDCActionPropertyFloatBall,
    
    //热点频道暂停
    LTDCActionPropertyHotChannelPause,
    
    //热点频道播放
    LTDCActionPropertyHotChannelPlay,
    
    //标题右侧顶部搜索
    LTDCActionPropertyChannelSeach,
#if 0 //联通sdk 适配IPv6
    //联通流量包合作
    LTDCActionPropertyUnicomFlow,
    //联通流量包订购相关
    LTDCActionPropertyUnicomWo_Order,
    //播放时候联通SDK初始化失败弹窗。
    LTDCActionPropertyUnicomWo_InitHint,
#endif
    
    LTDCActionPropertyCategoryPlayer4KLearnMore,          // 全屏播放器清晰度切换4k了解更多
    LTDCActionPropertyCategoryPlayer1080PLearnMore,     // 全屏播放器清晰度切换1080了解更多
    LTDCActionPropertyCategoryTVPromoteHalfPlayerBottomView, //pad半屏播放底部导航条
    LTDCActionPropertyCategoryTVPromotePlayerPicturePrecent,//全屏播放器画面百分比切换
    LTDCActionPropertyCategoryTVPromotePlayerWatchingFocus,//全屏进度条上看点
    LTDCActionPropertyCategoryPlayerTopView,           //播放器顶部导航
    LTDCActionPropertyCategoryPlayerVolumeBar,         //音量点击
    
    
    //    #ifdef LT_MERGE_FROM_IPAD_CLIENT
    
    //半屏播放添加评论
    LTDcActionPropertyAddCommentClick,
    //半屏播放回复评论
    LTDCActionPropertyReplyComment,
    //半屏播放发送评论
    LTDCActionPropertySendComment,
    //    #endif
    //更多  分享
    LTDcActionPropertyShareMoreClick,
    LTDcActionPropertyShareClick,
    LTDCActionPropertyCategoryPlayerTopPushView,
    LTDCActionPropertyCategoryPlayerPlayBillView,     //轮播节目单列表
    //全屏播放剧集点击
    LTDcActionPropertyFullScreenEpisodeSummary,
    LTDCActionPropertyCategoryPlayerLearnMore,         //了解更多/推送超级电视升级高级会员弹框
    LTDCActionPropertyLivingDefaultPlayer, //直播默认播放器
    LTDCActionPropertyLivingFullPlayer,//直播全屏播放器
    
    LTDCActionPropertyCategoryLoginFailed,
    //播放记录
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    LTDCActionPropertyRecord,
    LTDCActionPropertyRecordTableDidSelect,
    LTDCActionPropertyRecordButton,
    LTDCActionPropertyRecordLogin,
    
#endif
    //会员转移购买上报
    LTDCActionPropertyVipPayClick,
    LTDcActionPropertyVipClick,
#ifndef  LT_MERGE_FROM_IPAD_CLIENT
    LTDCActionPropertyPay,
    LTDCActionPropertyPayShow,
    LTDCActionPropertyMovePay,
    
    
    //直播列表上报
    LTDCActionPropertyLivePlay,
    LTDCActionPropertyListLivePlay,
    LTDCActionPropertyListClickLivePlay,
#else
    //会员转移购买
    LTDCActionPropertyBuyMove,
    LTDCActionPropertyShow,
    LTDCActionPropertyVipRemmond,
    
    
#endif
    LTDCActionPropertyLiveHalfPlay,
    LTDcActionPropertyLiveHalfTime,
    LTDcActionPropertyLiveHalfPay,
    LTDcActionPropertyLiveHalfWeiShi,
    LTDcActionPropertyLiveHalfSprot,
    LTDcActionPropertyLiveHalfMusic,
    LTDcActionPropertyLiveDefaultRecommendView,
    LTDcActionPropertyLiveDefaultSelectedView,
    LTDCActionPropertyLiveHalfToolBarView,
    
    LTDcActionPropertyLiveHallTabSelected,
    LTDcActionPropertyLiveHallStoreUp,
    
    LTDCActionPropertyNewUserGuideLike,
    LTDCActionPropertyTimeShiftBackIcon,
    LTDCActionPropertyDanmakuSendButtonAction,
    LTDCActionPropertyDanmakuSyncButtonAction,
    LTDCActionPropertyLiveDanmakuOnOffButtonShow,
    LTDCActionPropertyLiveDanmakuOnOffButtonAction,
    LTDCActionPropertyLiveDanmakuSendButtonShow,
    LTDCActionPropertyLiveDanmakuSendButtonAction,
    //截屏
    LTDCActionPropertyScreenShotPhotosShare,
    LTDCActionPropertyScreenShotPhotosTextClick,
    LTDCActionPropertyScreenShotPhotosSignClick,
    //明星
    LTDCActionPropertyStarInfo,
    LTDCActionPropertyStarCardActivity,
    LTDCActionPropertyStarCardStarIDVideo,
    LTDCActionPropertyStarCardStarLiveVideo,
    LTDCActionPropertyStarCardRingVideo,
    LTDCActionPropertyStarCardMusicVideo,
    LTDCActionPropertyStarCardAlbumVideo,
    LTDCActionPropertyStarCardNewsVideo,
    //iPad半屏缓存浮卡
    LTDCActionPropertyDownloadAllVideo,
    LTDCActionPropertyDownloadAllAlertShow,
};

// 播放类型
typedef NS_ENUM(NSInteger, LTDCPlayType)
{
    LTDCPlayTypeUnknown = -1,
    
    LTDCPlayTypeNormal = 0,     // 点播
    LTDCPlayTypeLiving = 1,     // 直播
    LTDCPlayTypeRotation = 2,   // 轮播
    LTDCPlayTypeCache = 3,      // 缓存
    LTDCPlayTypeLocal = 4,      // 本地
    
};


// 播放动作名称
typedef NS_ENUM(NSInteger, LTDCPlayStage)
{
    LTDCPlayStageLaunch,     // 点击一个视频会上报
    LTDCPlayStageInit,       // 目前和Launch的上报时机差不多(VV统计的是这个值)
    LTDCPlayStageGslb,       // iPad V5.7、iPhone 6.0后改为由CDE上报
    LTDCPlayStageCload,      // iPad V5.7、iPhone 6.0后改为由CDE上报
    LTDCPlayStagePlay,       // 正片第一帧出来上报(CV统计的是这个值)
    LTDCPlayStageTime,
    LTDCPlayStageBlock,
    // ipad 5.7 add
    LTDCPlayStageEBlock,  //卡顿结束（卡顿之后恢复正常播放）时上报 eblock
    LTDCPlayStageTg,      //码流切换   tg
    LTDCPlayStageDrag,    //用户拖拽到新的播放位置后上报 drag
    //    LTDCPlayStageCp,      //用户点击播放按钮时上报    cp
    //    LTDCPlayStagePa,      //用户点击暂停播放按钮时上报 pa
    
    LTDCPlayStageEnd,
    LTDCPlayStageFinish,
    LTDCPlayStageADStart,
    LTDCPlayStageADEnd,
    
    LTDCPlayStagePA,   // 用户暂停
    LTDCPlayStageResume, // 用户恢复播放
};

// 播放卡顿类型
typedef NS_ENUM(NSInteger, LTDCBlockType)
{
    LTDCBlockNone = -1,
    
    LTDCBlockNormal = 0,        //正常播放过程卡顿
    LTDCBlockStartPlay = 1,     //起播
    LTDCBlockDrag = 2,          //拖拽
    LTDCBlockChangeChannel = 3, //换台
    LTDCBlockChangeCode = 4,    //切换码流
};

// 下载中断类型
typedef NS_ENUM(NSInteger, LTDCDownloadInterruptType)
{
    LTDCDownloadInterruptTypeNone = 0,
    
    LTDCDownloadInterruptTypeByHand = 1,            // 用户点击暂停
    LTDCDownloadInterruptTypeNetworkError = 2,      // 网络中断
    LTDCDownloadInterruptTypeNetworkChange = 3,     // 网络切换
    LTDCDownloadInterruptTypeDownloadError = 4,     // 异常报错
    LTDCDownloadInterruptTypeDownloadFinish = 5,    // 下载结束
};

//播放类型
typedef enum
{
    PLAYING_TYPE_PLAYER = 0,    //点播
    PLAYING_TYPE_LIVE = 1,    //直播
    PLAYING_TYPE_LIVE_CHANNEL = 2, //轮播卫视
}PLAYING_TYPE;


//页面iD
typedef NS_ENUM(NSInteger, LTDCPageID)
{
    LTDCPageIDUnKnown,         // 未知页面
    
    LTDCPageIDIndex,  //首页
    LTDCPageIDChannelWALL, //频道墙
    LTDCPageIDTV, //电视剧频道页
    LTDCPageIDMovie, //电影频道页
    LTDCPageIDWordCup, //世界杯频道页
    LTDCPageIDSport, //体育频道页
    LTDCPageIDVariety,   //综艺频道页
    LTDCPageIDEntertainment, //娱乐频道页 8
    LTDCPageIDAnimate, //动漫频道
    LTDCPageIDVIP, //会员频道页
    LTDCPageIDMusic, //音乐频道页
    LTDCPageIDNews,//资讯频道页
    LTDCPageIDKids, //亲子频道页
    LTDCPageIDNBA, //NBA频道页
    LTDCPageIDFinacial, //财经频道页
    LTDCPageIDFasion, //风尚频道页
    LTDCPageIDDocumentary,//纪录片频道页
    LTDCPageIDCar,//汽车频道页 18
    LTDCPageIDTour, //旅游频道页
    LTDCPageIDDolby,//杜比频道页
    LTDCPageIDH265,//4G专区频道页
    LTDCPageIDLiveMain, //直播首页  22
    LTDCPageIDLiveSport,//直播-体育
    LTDCPageIDLiveMusic,//直播-音乐
    LTDCPageIDLiveEntertainment,//直播-娱乐
    LTDCPageIDLiveOthers,//直播-其他
    LTDCPageIDLiveLunbo,//直播-轮播台
    LTDCPageIDLiveWeishi,//直播-卫视台
    LTDCPageIDHotChannel,//热点频道首页 29
    LTDCPageIDSpecialList, //专题列表页
    LTDCPageIDHalfPlayer, //半屏播放页
    LTDCPageIDFullScreenPlayer, //全屏播放页
    LTDCPageIDMyLetv, //我的页面
    LTDCPageIDLogin, //登录页面
    LTDCPageIDVipPurchase,//会员套餐页面 35
    LTDCPageIDRegister,    //注册页面
    LTDCPageIDForgotPassword,//找回密码页面
    LTDCPageIDDownloadManager,//下载管理页面
    LTDCPageIDChart, //排行榜
    LTDCPageIDMoreChannel,  //频道更多页
    LTDCPageIDSearch,//搜索页面
    LTDCPageIDSearchResult,//搜索结果页
    LTDCPageIDSetting, //设置页面。
    LTDCPageIDMyIntegration,//我的积分页面
    LTDCPageIDMyLottery,//我的抽奖页面
    LTDCPageIDIntegrationCenter,//积分中心页面
    LTDCPageIDIntegrationRecord,//积分记录页面
    LTDCPageIDIntegrationAnswer,//积分答题页面
    LTDCPageIDQuestionName,//题库名称页
    LTDCPageIDQuestionName_Obligate,//题库名称页（预留）
    LTDCPageIDPlayRecord,//播放记录
    LTDCPageIDFavorite,//收藏页面（播放单）
    LTDCPageIDPush,//push推送。
    LTDCPageIDDownloadFinish,//下载已完成。054
    LTDCPageIDDownloading,//下载进行中。055
    LTDCPageIDLocal,//本地，，Android的，056
    LTDCPageIDiTunesTransport,//iTunes.057
    LTDCPageIDLookMatchOnRoad, //路上看球 058
    LTDCPageIDForcedUpdates,//强升页面 059
    LTDCPageID_yuliu1,      //不知道是啥，先加上，060
    LTDCPageIDMyCollect_New, //我的收藏页，061
    LTDCPageID_yuliu2,    //不知道是啥，先加上， 062
    LTDCPageID_yuliu3,   //不知道是啥，先加上，063
#if 0  //联通sdk 适配IPv6
    LTDCPageIDUnicomWo_Order,//联通流量包订购页，064
    LTDCPageIDUnicomWo_OrderSuccess,//联通流量包订购成功页，065
    LTDCPageIDUnicomWo_cancelSuccess,//联通流量包退订成功页，067
    LTDCPageIDUnicomWo_cancelFailure,//联通流量包退订失败，068
#endif
    LTDCPageIDUnicomWo_OrderFailure = 66,//联通流量包订购失败页，066  mark by qinxl：jira 6601 与张晋确认，购买成功页pageid报066
    
    LTDCPageID_DownloadEpisode = 69,   //下载选集页，069
    LTDCPageIDFunny,      //频道-搞笑频道页	070
    LTDCPageIDBasketballWorldCup,     //频道-篮球世界杯	071
    LTDCPageIDSuperTV,    //频道-超级电视	072
    LTDCPageIDClassificationRetrieval,    //分类检索页 073
    LTDCPageIDAmericanTeleplay,           //美剧频道页	074
    LTDCPageIDEPL,     //英超频道页	075
    LTDCPageIDAlonePlay,      //独播页	076
    LTDCPageIDF1,             //F1	077
    LTDCPageIDPet,          //宠物	078
    LTDCPageIDTechnology,     //科技  079
    LTDCPageIDEducation,      //教育	080
    LTDCPageIDLiveHot = 81,       //直播-热门	081
    LTDCPageIDTodayWidget,     //ios8 today widget页	082
    LTDCPageIDGame,         // 游戏页  083
    LTDCPageIDFind = 84,         //  发现子页面信息    084
    LTDCPageIDMy,           //  我的信息页面      085
    LTDCPageIDOrderDetail,   //  订单详情         086
    LTDCPageIDSetShare,      //  分享设置         087
    LTDCPageIDShareClick,    //  分享浮层         088
    LTDCPageIDChannelSortView = 89,// 频道筛选页面       089
    LTDCPageIDPhotosEditingView = 90,//图片编辑页面      090
    LTDCPageIDNewUserGuide = 92,     // 引导图后后面的新用户喜欢 092
    LTDCPageIDScreenShotPhotos = 93,    //截屏图片编辑界面
    LTDCPageIDStarInfoView    =   94,    //明星页面              094
    LTDCPageIDShowListView    =   95,    //节目单                095
    LTDCPageIDMyConcernView   =   96,    //我的关注               096
    LTDCPageIDSclShareSuccess =   100,   //中超分享成功            100
    LTDCPageIDStarRankListView   =  102, //明星排行榜页面          102
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    //5.5新增频道
    LTDCPageIDAmericanDrama = LTDCPageIDAmericanTeleplay, //美剧频道页 074
    LTDCPageIDBroadcastOnly = LTDCPageIDAlonePlay, //独播频道页 076
#endif
    //6.2新增直播大厅
    LTDCPageIDLiveBrand = 103,//直播-品牌
    LTDCPageIDLiveGame = 104,//直播-游戏
    LTDCPageIDLiveFinace = 105,//直播-财经
    LTDCPageIDLiveInformation = 106,//直播-资讯
    
    //首页排序
    LTDCPageIDRecommedSortView = 114, //首页排序
    // 6.6及6.7新增直播大厅
    LTDCPageIDLiveZong = 115, //直播-综艺
    LTDCPageIDLiveHKTVSeries = 116, //直播-香港电视剧
    LTDCPageIDLiveHKMovie = 117, //直播-香港电影
    LTDCPageIDLiveHKComplex = 118, //直播-香港综合
    LTDCPageIDLiveMyOrderDetail = 119,//直播-我的预约-预约详情
    
    LTDCPagePlayHistoryVideoClips = 122,//短视频播放记录页面
};



#endif /* LTDataCenterEnumDef_h */
