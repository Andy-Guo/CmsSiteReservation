//
//  LTRequestURLDefine.h
//  LetvIphoneClient
//
//  Created by zhaochunyan on 13-1-25.
//
//

// 预定义http请求接口

#ifndef Letv_LTRequestURLDefine_h
#define Letv_LTRequestURLDefine_h

#pragma mark - urls

//微信sso登陆授权，换取token url
#define LT_WX_SSO_GET_TOKEN_URL(appid,secret,code) [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",appid,secret,code]

// 广告拼接测试url
#define AD_TEST_URL         @"http://%@/gate_way.m3u8?ID=id9,id10&id9.proxy_url=%@&id10.proxy_url=%@"

// IP地域侦测接口
#define IP_COUNTRY_URL      @"http://api.letv.com/getipgeo"

// 浏览器播放地址
#ifdef LT_IPAD_CLIENT
#define LT_JUMPOUTPLAY_URL  @"http://www.letv.com/ptv/vplay/%@.html"
#else
#define LT_JUMPOUTPLAY_URL  @"http://m.letv.com/play.php?type=%@&id=%@&vid=%@&br=%@&back=app_iphone"
#endif

// 乐视使用协议
#define LETV_PROTOCAL_URL   @"http://sso.letv.com/user/protocol"
// 密码找回 by email
#define UC_RESET_PWD_URL    @"http://sso.letv.com/user/backpwdemail"


#define LT_LoginByQQ_URL    @"http://sso.letv.com/oauth/appqq?display=mobile&plat=mobile_tv";
#define LT_LoginBySina_URL  @"http://sso.letv.com/oauth/appsina?display=mobile&plat=mobile_tv";

#pragma mark - component

// 动态地址
#define LT_REQUEST_URL_DYNAMIC_TAIL             @""
#define LT_REQUEST_URL_DYNAMIC_HEAD             @"http://dynamic.app.m.letv.com/android/"
#define LT_REQUEST_URL_DYNAMIC_HEAD_SEARCH      @"http://dynamic.search.app.m.letv.com/android/"
#define LT_REQUEST_URL_DYNAMIC_HEAD_MEIZI       @"http://dynamic.meizi.app.m.letv.com/android/"
#define LT_REQUEST_URL_DYNAMIC_HEAD_PAY         @"http://dynamic.pay.app.m.letv.com/android/"
#define LT_REQUEST_URL_DYNAMIC_HEAD_USER        @"http://dynamic.user.app.m.letv.com/android/"
#define LT_REQUEST_URL_DYNAMIC_HEAD_RECOMMEND   @"http://dynamic.recommend.app.m.letv.com/android/"
#define LT_REQUEST_URL_DYNAMIC_HEAD_LIVE        @"http://dynamic.live.app.m.letv.com/android/"
//#define LT_REQUEST_URL_DYNAMIC_HEAD_LEAD        @"http://dynamic.lead.app.m.letv.com/android/"
#define LT_REQUEST_URL_DYNAMIC_HEAD_LEAD        @"http://dynamic.app.m.letv.com/android/"


// 仿静态地址
#define LT_REQUEST_URL_STATIC_TAIL              @".mindex.html"
#define LT_REQUEST_URL_STATIC_HEAD              @"http://static.app.m.letv.com/android/"
#define LT_REQUEST_URL_STATIC_HEAD_SEARCH       @"http://static.search.app.m.letv.com/android/"
#define LT_REQUEST_URL_STATIC_HEAD_MEIZI        @"http://static.meizi.app.m.letv.com/android/"
#define LT_REQUEST_URL_STATIC_HEAD_PAY          @"http://static.pay.app.m.letv.com/android/"
#define LT_REQUEST_URL_STATIC_HEAD_USER         @"http://static.user.app.m.letv.com/android/"
#define LT_REQUEST_URL_STATIC_HEAD_RECOMMEND    @"http://static.recommend.app.m.letv.com/android/"
#define LT_REQUEST_URL_STATIC_HEAD_LIVE         @"http://static.live.app.m.letv.com/android/"
#define LT_REQUEST_URL_STATIC_HEAD_LEAD         @"http://static.lead.app.m.letv.com/android/"


//播放合并接口
#define LT_REQUEST_URL_PLAY_COMBINE_TAIL        @""
//正式
#define LT_REQUEST_URL_PLAY_COMBINE_HEAD        @"http://api.mob.app.letv.com/"
//测试
#define LT_REQUEST_URL_PLAY_COMBINE_HEAD_TEST   @"http://t.api.mob.app.letv.com/"
//测试接口香港
#define LT_REQUEST_URL_PLAY_COMBINE_HEAD_HK_TEST   @"http://hk.t.api.mob.app.letv.com/"
//#define LT_REQUEST_URL_PLAY_COMBINE_HEAD_HK_TEST   @"http://t.api.mob.app.letv.com/"

//直播部门的直播新接口地址
#define LT_REQUEST_URL_LIVE_NEW_HEAD            @"http://api.live.letv.com/"

// 测试接口
#define LT_REQUEST_URL_TEST_HEAD                @"http://test2.m.letv.com/android/"

#define LT_REQUEST_URL_HK_TEST_HEAD             @"http://hk.test2.m.letv.com/android/"

#define LT_REQUEST_URL_LB_TEST_HEAD             @"http://t-sdk-mob-app.le.com/"

#define LT_REQUEST_URL_LB_HEAD             @"http://sdk-mob-app.le.com/"

// 仿静态地址(搜索推荐)
#define LT_REQUEST_URL_STATIC_SEARCH_RECOMMEND_HEAD      @"http://recommend.app.m.letv.com/android/"

//异常日志地址
#define LT_REQUEST_URL_ERRORLOG_HEAD    @"http://upload.app.m.letv.com/"

//收集IOS App设备信息(deviceToken)；
//测试地址：
#define LT_REQUEST_URL_DEVTOKEN_TEST_HEAD @"http://10.154.157.39/ios" //测试推送使用新地址
//线上环境：
#define LT_REQUEST_URL_DEVTOKEN_HEAD @"http://api.push.platform.letv.com/ios/"

/*
 广告拼接接口 - post
 参数：  ahl  前贴广告地址， 多个广告地址用| 切分
 vl   视频地址
 atl  后贴广告地址，多个广告地址用| 切分

 返回格式 JSON 如下
 {"ahs": [7, 8, 10], "vs": [14], "ats": [7, 8, 10], "muri": "http://115.182.63.61/m3u8cont/20140221/Ff/20140221162107-Ff0wr-TanR3OcDW-23764d82-b4d6-43d8-9d3f-373edab6e66b.m3u8"}

 ahs 前贴广告拼接状态，列表中每个元素为每个广告拼接状态，数字大于0 为成功，等于0为失败
 vs 视频拼装状态  列表中每个元素为 每个广告拼接状态，数字大于0 为成功，等于0为失败
 ats  后贴广告拼接状态   列表中每个元素为 每个广告拼接状态，数字大于0 为成功，等于0为失败
 muri，播放地址
 */

#ifdef DEBUG
//测试服务器
//#define LT_REQUEST_URL_AD_PINJIE_HEAD    @"http://115.182.63.61/m3u8api/"
#define LT_REQUEST_URL_AD_PINJIE_HEAD    @"http://106.120.179.110/m3u8api/"
#else
#define LT_REQUEST_URL_AD_PINJIE_HEAD    @"http://n.mark.letv.com/m3u8api/"
#endif


// 需要传入的参数
#define LT_REQUEST_URL_DYNAMIC_VALUE        @"%@"
#define LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY  @""

#ifdef LT_IPAD_CLIENT
#define LT_VIDEOLIST_REQUEST_NUM        (50)
#else
#define LT_VIDEOLIST_REQUEST_NUM        (50)
#endif

// 地址类型
typedef enum {
    LTRequestURL_None,
    LTRequestURL_Dynamic,   // 动态地址
    LTRequestURL_Static,    // 仿静态地址
    LTRequestURL_Parse,
    LTRequestURL_LiveNew,   // 直播新接口地址（去掉代理）
    LTRequestURL_PlayCombine, //播放接口合并
    LTRequestURL_LebPay,      //乐币支付接口

}LTRequestURLType;

// 域名分类
typedef enum {
    LTRequestURLDomainTypeNormal,   // 普通，（新版V5.2.2除去下面分类的其它接口使用，旧版使用）

    LTRequestURLDomainTypeSearch,   // 搜索
    LTRequestURLDomainTypeMeizi,    // 大媒资
    LTRequestURLDomainTypePay,      // 付费中心
    LTRequestURLDomainTypeUser,     // 用户中心
    LTRequestURLDomainTypeRecommend,// 个性化推荐
    LTRequestURLDomainTypeLive,     // 直播
    LTRequestURLDomainTypeLiveNew,  // 直播部门的直播新接口
    LTRequestURLDomainTypeLead,     // 弹幕。
    LTRequestURLDomainTypeLebPay,   // 乐币支付
    LTRequestURLDomainTypeNoCare, //当不关心域名分类时，用此type
}LTRequestURLDomainType;

// URL类型
typedef enum {

    LTURLModule_Unknown,

    LTURLModule_Begin = 1001,

    /*************************************************/

    LTURLModule_HalfScreen_PageCardXMLData = 102,//获取半屏pagecardXMl数据
    // 首页
    LTURLModule_NewIndex=1001,               // 大媒资首页，开机图片

    LTURLModule_Recommend_Personalized=1003, // 首页(个性化推荐)
    LTURLModule_Recommend_APP_INDEX=1004,    // 首页推荐App
    LTURLModule_Recommend_APP_POP=1005,      // 首页弹窗推荐
    LTURLModule_Recommend_Live=1006,         // 直播数据
    LTURLModule_Recommend_Tag=1007,          // 首页标签（左上角显示内容）
    LTURLModule_Recommend_New_Live=1008,     // 首页直播新接口。5.8.1添加
    LTURLModule_Recommend_CMS=1009,          // 首页直播区块，左侧图片5.9
    LTURLModule_PlayerHalfPageList = 1100,        // 播放器半屏页 list
    LTURLModule_Recommend_Promotion = 1101,  // 首页推广位展示数据
    LTURLModule_Recommend_Launch_Logo = 1102,// 启动图logo
    //地理位置经纬度上传
    LTURLModule_Location_Geo = 1103,

    LTURLModule_Recommend_Personalized_PB = 1104, // 首页(个性化推荐)PB
    LTURLModule_Recommend_BlockExchange = 1105,   // 首页换一换
    LTURLModule_Recommend_Live_Block = 1106,    // 首页直播区块新接口


    // 专题/排行
    LTURLModule_Chart =2001,              // 排行榜
    LTURLModule_Sub_Chart =2002,          // 具体频道的排行榜
    LTURLModule_Subject =2003,            // 专题
    LTURLModule_SpecialList =2005,        // 专题列表, for iPhone only
    LTURLModule_SpecialDetail =2006,      // 专题列表, for iPhone only
    LTURLModule_Subject_Detail= 2004,     // 专题 -- 数据包
    LTURLModule_HotVideos = 2007,           // 热点视频
    LTURLModule_HotVideosPB = 1002007,       // 热点视频PB
    LTURLModule_SpecialTopic =2008,        //5.4专题
    LTURLModule_SpecialTopicPB = 1002008,        //5.4专题PB
    LTURLModule_FindTopic =2009,        //5.8发现频道
    LTURLModule_HotVideosCategery = 2010,   //6.1热点分类

    // 频道
    LTURLModule_Channel_List =3001,       // 频道列表
    LTURLModule_Channel_Index =3002,      // 频道首页
    LTURLModule_Channel_IndexZt =3003,    // 频道首页（带有专题数据）
    LTURLModule_Channel_Filter =3004,     // 频道筛选
    LTURLModule_Channel_Type =3005,       // 频道分类
    LTURLModule_Channel_Album=3006,     // 频道列表 -大媒资专辑
    LTURLModule_Channel_Video=3007,  // 频道列表 -大媒资视频
    LTURLModule_Channel_NewList=3011,//5.4新版本频道列表。
    LTURLModule_Channel_ChannelVideoTotal=3012, //5.4新版本频道更新数。
    LTURLModule_Channel_NewList_5_5=3013,//5.5新版本频道列表
    LTURLModule_Channel_New_Live=3014,// 体育频道直播新接口。5.8.1
    LTURLModule_Channel_NewList_5_9=3015,// 5.9频道墙首页接口调整
    LTURLModule_Channel_Filter_Pad_57=3016, // pad筛选接口和phone区分开，还用老接口
    LTURLModule_Channel_NewList_6_5=3017,// 6.5频道墙首页接口调整(目前只运用于iPhone)

    LTURLModule_Channel_Index_PB = 3018,      // 频道首页PB
    LTURLModule_Channel_Filter_PB = 3019,     // 频道筛选
    LTURLModule_Channel_Album_PB = 3020,     // 频道列表 -大媒资专辑
    LTURLModule_Channel_Video_PB = 3021,  // 频道列表 -大媒资视频
    LTURLModule_VIP_Channel_Filter = 3022,     // 会员频道筛选
    LTURLModule_VIP_Channel_Filter_PB = 3023,   // 会员频道筛选PB
    LTURLModule_Channel_Dolby_Album = 3024,    // 杜比频道专辑
    LTURLModule_Channel_Dolby_Video = 3025,  // 杜比频道视频
    LTURLModule_Channel_FeedFLow = 3026,  // 负一屏热点视频
    LTURLModule_Channel_FeedFlow_Up = 3027, // 负一屏热点视频点赞
    LTURLModule_Channel_FeedFlow_Instant_Statistic = 3028, // 负一屏热点实时统计
    LTURLModule_Channel_FeedFlow_Offline_Statistic = 3029, // 负一屏热点视频点赞
    // 详情
    LTURLModule_Detail_VRS_Album=4001,   // 详情 -- vrs专辑
    LTURLModule_Detail_VRS_Video =4002,   // 详情 -- vrs单视频
    LTURLModule_Album_VideoList =4004,    // 详情 -- 大媒资专辑视频列表
    LTURLModule_Video_FileInfo =4006,     // 视频文件信息
    LTURLModule_Video_FileInfoPB =1004006,     // 视频文件信息

    LTURLMOdule_Video_UrlParse =4007,     // 防盗链url调度

    LTURLModule_Album_Pay=4008,          // 专辑付费详情
    LTURLModule_Play_Recommend  = 4009,  // 视频联播推荐
    LTURLModule_Play_SurroundVideo=4010,  // 周边视频
    LTURLModule_Album_Video_PlayCount = 4012, // 批量获取专辑、视频播放数
    LTURLModule_Album_VideoList_ByDate = 4013,   // 按年月请求视频列表
    LTURLModule_Album_VideoList_prevue = 4014,   // 预告片列表
    LTURLModule_Video_VF = 4015,                 // 新的请求视频文件的接口
    LTURLModule_Video_Introduction = 4016,       // 简介接口
    LTURLModule_VideoList =4017,    // 专辑列表(合并后通用videoList)
    LTURLModule_Video_VF_And_Advertise = 4018,    // 合并视频文件请求和广告请求
    // 播放相关接口起始位置
    LTURLModule_PlayRelated_Begin = 4001,
    LTURLModule_PlayRelated_End = 4020,

    // 搜索
    LTURLModule_Search_Hotword =5001,         // 搜索热词
    LTURLModule_Search_Related =5002,         // 搜索联想词
    LTURLModule_Search_Init =5003,            // 搜索初始化数据
    LTURLModule_Search_Mixed_Search =5004,    // 搜索-混合搜索
    LTURLModule_Search_Star_Works =5005,      // 搜索明星的作品
    LTURLModule_Search_Star_Album =5006,      // 搜索明星专辑
    LTURLModule_Search_Star_Video =5007,      // 搜明明星单视频
    LTURLModule_Search_Video_Source =5008,    // 视频的数据来源(乐视、优酷等)
    LTURLModule_Search_OuterNet_VideoList =5009, // 外网专辑视频列表
    LTURLModule_Search_Recommend =5010,       // 搜索推荐
    LTURLModule_Search_Suggest =5011,         //搜索suggest 5.4.2 wyw add

    // 直播
    LTURLModule_Live_List =6001,          // 直播电视台
    LTURLModule_Live_LunboList =6002,   // 轮播台
    LTURLModule_Live_WeishiList =6003,     // 卫视台
    LTURLModule_Live_LiveList=06004 ,       // 直播厅节目单
    LTURLModule_Live_ChannelBill=06005,     // 轮播台，卫视台节目单
    LTURLModule_Live_Bill=6006,          // 直播节目单
    LTURLModule_Live_Focus=6007,         // 直播焦点图
    LTURLModule_Live_PlayingBill=6008,   // 正在直播的节目单
    LTURLModule_Live_ChannelInfo=6009,   //
    LTURLModule_Live_SeverTime=6010,     // 获取服务器时间
    LTURLModule_Live_LiveTm=6011,        //获取直播过期时间戳
    LTURLModule_Live_CanPlay=6012,       //是否可以播放
    LTURLModule_Live_GetLiveUrlByScode=6013, //LTURLModule_Live
    LTURLModule_Live_Authority=6014,     //直播付费鉴权
    LTURLModule_Live_UseTicket=6015,     //直播付费使用直播券
    LTURLModule_Live_TicketInfo=6016,    //直播付费查询直播券


    /*直播新接口*/
    LTURLModule_LiveHall_SearchByDate =6018, //直播大厅特定日期数据获取接口
    LTURLModule_LiveHall_GetCurrentInfo =6019, //直播大厅当前数据获取接口
    LTURLModule_LiveHall_GetIncremental =6020, //直播大厅增量数据获取接口
    LTURLModule_Live_GetLiveChannel =6030,     //乐视频道列表获取接口
    LTURLModule_Live_GetLiveChannelByThirdParty =6031, //开放平台频道列表获取接口
    LTURLModule_Live_GetChannelStream =6032 , //频道流信息获取接口
    LTURLModule_Live_GetSnapShot =6033,  //频道流实时截图接口
    LTURLModule_Live_GetCurrentBillList1 =6034, //频道当前播放节目信息获取接口1
    LTURLModule_Live_GetCurrentDayBillList =6035, //频道整天节目单获取接口
    LTURLModule_Live_GetBillListIncremental =6036, //频道节目单增量获取接口
    LTURLModule_Live_GetBillListPlayingInfo =6037, //视频详细信息获取接口
    LTURLModule_Live_GetCurrentBillList2 =6038, //频道当前播放节目信息获取接口2
    LTURLModule_Live_Livehall_GetPlayerInfo =6039, //直播大厅终端半屏播放器接口
    LTURLModule_Live_Livehall_sortHotLives =6040, //直播大厅终端分类接口
    LTURLModule_Live_LivingPrice=6041,   //获取直播价格接口
    LTURLModule_Live_GetLiveOrderID =6042,  //直播下单接口
    LTURLModule_Live_Batch_Validate = 6043, // 直播付费直播批量鉴权接口
    LTURLModule_Live_GetLiveOrderIDAudit = 6044, //直播下单审核接口

    // 5.8直播新接口
    LTURLModule_Live_Hot_SortHotLives = 6045,       // 热门列表接口
    LTURLModule_Live_Hot_DefaultLive = 6056,        // 热门默认接口
    LTURLModule_Live_LunBo_WeiShi_ChannelList = 6047,      // 轮播台、卫视列表
    LTURLModule_Live_LunBo_WeiShi_PreCurNextBillList = 6048,  // 轮播台、卫视节目列表,包括前一个、当前、下一个。
    LTURLModule_Live_LunBo_WeiShi_CurrentBillList = 6049,  // 轮播台、卫视当前节目
    LTURLModule_Live_New_LiveList = 6050,           // 直播大厅接口 体育、娱乐、音乐、游戏、资讯、财经
    LTURLModule_Live_ChannelStream = 6051,          // 频道流信息获取接口
    LTURLModule_Live_BillListIncremental = 6052,    // 频道节目单增量获取接口
    LTURLModule_Live_LiveHollList_General = 6053,   // 直播大厅通用查询接口 iphone >= 5.8
    LTURLModule_Live_CMS_Reccommend = 6054,    // 直播大厅获取推荐数据
    LTURLModule_Live_New_LiveSportMusic_Een_List = 6055,    // 直播大厅 （体育娱乐音乐,Pad新接口） 日历数据
    LTURLModule_Live_New_LiveS_M_E_SubList = 6057,   // 直播大厅（体育娱乐音乐,Pad新接口）日历数据 －》二级接口数据
    LTURLModule_Live_New_SearchByLiveID =6058,  //直播大厅主键查询接口
    // AppleWatch直播数据
    LTURLModule_Live_AppleWatch_LiveList = 6059,//AppleWatch直播列表
    LTURLModule_Live_MIGU_ChannelStream = 6060, // 咪咕直播流请求
    
    /*6.7直播首页改版*/
    LTURLModule_Live_Home_SortHotLives = 6061,      //新版直播首页接口
    LTURLModule_Live_AllLiveList=6062,          //全部直播-670新接口
    LTURLModule_Live_Lunbo_Authority = 6063,    //香港轮播台直播鉴权
    
    /*6.9直播-我的预约*/
    LTURLModule_Live_MyOrders=6066,             //我的预约-690新接口
    LTURLModule_Live_MyOrderDetail=6067,        //我的预约-690新接口
    /*6.9直播合并接口*/
    LTURLModule_Live_LivePlay = 6068,           //直播合并接口-6.9新接口
    LTURLModule_Live_ChannelPlay = 6069,           //直播轮播台卫视台合并接口-6.9新接口
    /*6.10精彩回看*/
    LTURLModule_Live_WonderLookBack = 6071,     //直播精彩回看-610新接口
    
    /*6.14直播频道页接口*/
    LTURLModule_Live_Channel_New = 6072,
    /*6.14轮播台类型列表接口*/
    LTURLModule_Live_Carouse_Category = 6073,
    /*6.14轮播台列表根据code获取*/
    LTURLModule_Carouse_ChannelList_By_Code = 6074,

    // 直播预定
    LTURLModule_BookLive_Add=7001,       // 添加直播预定
    LTURLModule_BookLive_Del=7002,       // 取消直播预定
    LTURLModule_BookLive_Close=7003,     // 关闭直播预定
    LTURLModule_BookLive_Open=7004,      // 打开直播预定
    LTURLModule_BookLive_Clean=7005,     // 清空直播预定

    // 追剧
    LTURLModule_Push_Add=8001,           // 添加追剧
    LTURLModule_Push_Del=8002,           // 取消追剧
    LTURLModule_Push_Close=8003,         // 关闭追剧
    LTURLModule_Push_Open=8004,          // 打开追剧
    LTURLModule_Push_Clean=8005,         // 清空追剧
    //recommed
    LTURLModule_Recommed_Promotion = 8080, // 首页会员推广位
    // app
    LTURLModule_ApiStatus=9001,          // 接口初始化状态、客户端设备信息上报、升级、广告控制、精品推荐控制接口
    LTURLModule_IOSDevice=9002,          // 设备统计
    LTURLModule_Audit=9003,              // 审核状态
    LTURLModule_About=9004,              // 关于我们
    LTURLModule_Alert_Info=9005,         // 提示语
    LTURLModule_Feedback=9006,           // 产品反馈
    LTURLModule_Upgrade=9007,            // 升级
    LTURLModule_ErrorUpload=9008,        // 错误上报

    // 个人中心
    LTURLModule_UC_ThirdPartyLogin=10001, // 第三方登录
    LTURLModule_UC_Login=10002,           // 登录
    LTURLModule_UC_Register=10003,        // 注册
    LTURLModule_UC_MovieAvaiable=10004,   // 付费片子是否可播
    LTURLModule_UC_GenerateOrderID=10005, // 产生订单ID
    LTURLModule_UC_Pay=10006,             // 支付
    LTURLModule_UC_PayResult=10007,       // 轮询支付结果
    LTURLModule_UC_QueryLePoint=10008,    // 查询乐点
    LTURLModule_UC_QueryVIP=10009,        // 是否VIP
    LTURLModule_UC_UserInfo=10010,        // 获取用户信息
    LTURLModule_UC_CheckMobileExists=10011,// 手机号是否已注册
    LTURLModule_UC_CheckEmailExists=10012,// 邮箱是否已注册
    LTURLModule_UC_SMSMobile=10013,       // 发送验证短信
    LTURLModule_UC_ChangeEmail=10014,     // 修改邮箱
    LTURLModule_UC_ChangeMobile=10015,    // 修改手机号
    LTURLModule_UC_ChangePassword=10016,  // 修改密码
    LTURLModule_UC_Consume=10017,         // 消费记录
    LTURLModule_UC_ConsumePB = 10010017,         // 消费记录PB
    LTURLModule_UC_Recharge=10018,        // 充值记录
    LTURLModule_UC_VERTIFY_TOKEN=10019,   // 检测token是否过期
    LTURLModule_UC_SendBackPwdEmail=10020,// 发送邮件找回密码
    LTURLModule_UC_SearchVoucher =10021,   // 查询观影券
    LTURLModule_UC_UseVoucher =10022,      // 使用观影券
    LTURLModule_UC_VoucherList =10023,     // 观影券列表
    LTURLModule_UC_VoucherListIPad_PB =10010023,     // 观影券列表
    LTURLModule_UC_CommendForVip =10024,   // 好评送会员
    
    LTURLModule_UC_AppCheckin = 10025,     //客户端签到

    LTURLModule_UC_SSOLoginSina=10026,     //sina微博sso登陆
    LTURLModule_UC_SSOLoginQQ=10027,       //qq sso登陆
    LTURLModule_UC_SSOLoginWX=10028,       //weixin sso登陆

    LTURLModule_UC_AppCheckin_V56= 10030,  //V5.6浮球活动列表
    LTURLModule_UC_AppCheckin_V56PB = 10010030,  //V5.6浮球活动列表PB
    LTURLModule_UC_ConsumeAudit=10031,     // 审核状态下消费记录
    LTURLModule_UC_ConsumeAuditPB = 10010031,     // 审核状态下消费记录
    LTURLModule_UC_VertiCode=10032,        //注册界面获取验证码
    LTURLModule_UC_PhoneNumRegistered=10033,//新的验证手机号是否存在
    LTURLModule_UC_DeviceUidVipInfo = 10034, //获取设备uid的会员信息
    LTURLModule_UC_BindAccount = 10035,    //设备用户id和乐视会员id进行绑定
    LTURLModule_UC_GetDeviveUserInfo = 10036, //用设备id换取设备的uid和name
    LTURLModule_UC_LiveAmount = 10037,       //获取用户所有直播券

    LTURLModule_UC_ChatHistory = 10038,     //聊天室聊天记录
    LTURLModule_UC_ChatSendMessage = 10039, //聊天室发送消息
    LTURLModule_UC_ChatHistoryPB = 10010038,     //聊天室聊天记录
    LTURLModule_UC_ChatSendMessagePB = 10010039, //聊天室发送消息
    LTURLModule_UC_UpdataNickName = 10040,  //更新用户昵称
   
    // 消息
    LTURLModule_UC_UnloginSystemMessage = 10041,            //未登录系统信息
    LTURLModule_UC_UnloginSystemMessagePB = 10010041,        //未登录系统信息PB
    LTURLModule_UC_loginSystemMessage = 10042,              //登录系统信息
    LTURLModule_UC_singleMessage_read = 10043,              //登录用户消息设置为已读
    LTURLModule_UC_loginCommentMessage = 10044,             //登录用户评论回复
    LTURLModule_UC_loginCommentMessage_delete = 10045,      //消息删除接口
    LTURLModule_UC_loginReplyedCommentMessage_List = 10046,  //被评论的回复列表
    LTURLModule_UC_startUnreadMessage = 10047,               //开机未读消息
    LTURLModule_UC_startUnreadMessagePB = 10010047,               //开机未读消息PB
    LTURLModule_UC_allMessage_read = 10048,                  //将所有消息置为已读
    
     LTURLModule_UC_LogoutImageCade = 10049,   // 退出验证码

    // IAP
    LTURLModule_IAP_Product = 11001,        // 获取产品标识
    LTURLModule_IAP_OrderID = 11002,        // 订单申请
    LTURLModule_IAP_OrderID_Test= 11003,   // 订单申请，审核期间用
    LTURLModule_IAP_Receipt= 11004,        // 订单回调
    LTURLModule_IAP_Receipt_Test= 11005,   // 订单回调，审核期间用
    LTURLModule_IAP_OrderID_Test_Notlogin =11006, //订单申请，审核期间无登录购买时用
    LTURLModule_IAP_ProductId = 11007,     //获取所有付费商品id
    LTURLModule_IAP_ProductId_Pre = 11008, //获取部分付费商品id
    LTURLModule_IAP_HK_OrderID = 11009,         //获取香港订单id
    LTURLModule_IAP_HK_OrderID_Test = 11010,    //获取香港订单id，审核期间用
    LTURLModule_IAP_HK_OrderID_Test_Notlogin = 11011,    //获取香港订单id，审核期间无登录购买时用
    // 乐币支付
    LTURLModule_IAP_LEB_Extra_Count = 11012,    //乐币余额接口
    LTURLModule_IAP_LEB_Package_List = 11013,   //乐币列表
    LTURLModule_IAP_LEB_OrderID = 11014,        //乐币下单
    LTURLModule_IAP_LEB_OrderDetail = 11015,    //购买乐币明细

    // 播放记录云同步
    LTURLModule_Cloud_GetAll= 12001,       // 获取播放记录
    LTURLModule_Cloud_GetAllPB = 10012001, // 获取播放记录PB方式
    LTURLModule_Cloud_GetFirst= 12002,     // 获取第一条播放记录
    LTURLModule_Cloud_SubmitSingle= 12003, // 提交播放记录
    LTURLModule_Cloud_SubmitMore= 12004,   // 批量提交播放记录,POST方式
    LTURLModule_Cloud_Delete= 12005,       // 删除播放记录
    LTURLModule_Cloud_GetPoint= 12006,     // 获取播放记录时间点
    LTURLModule_Cloud_Search= 12007,       // 搜索播放记录
    LTURLModule_Cloud_PageSize= 12008,     // 获取第一页指定条数的数据
    LTURLModule_Cloud_GetByPage = 12009,   //分页
    LTURLModule_Cloud_GetAllNew= 12010,    // 615获取播放记录新接口包含短视频的

    // 追剧收藏云同步
    LTURLModule_Cloud_GetAllFavrite= 13001, //获取所有收藏记录
    LTURLModule_Cloud_DeleteFavrite= 13002, //删除收藏记录
    LTURLModule_Cloud_SubmitFavrite= 13003, //上传收藏记录
    LTURLModule_Cloud_SubmitFavriteMore= 13004,//批量上传收藏记录

    // 广告
    LTURLModule_Ad_Config= 14001,          // 广告配置
    LTURLModule_Ad_Combine= 14002,         // 广告拼接

    // 二维码
    LTURLModule_QRCode_Submit= 15001,      // 二维码提交验证

    // 摇一摇
    LTURLModule_Shake_Add= 16001,          // 提交记录
    LTURLModule_Shake_Get= 16002,          // 获取记录

    LTURLModule_IndexRecommend= 16003,     // 首页推荐
    LTURLModule_DetailRecommend= 16004,    // 详情推荐(该接口请求参数在ipad5.5做了更新)

    LTURLModule_Share_PlayUrl= 16005,      // 动态获取分享播放地址

    LTURLModule_Recommend_APP= 16006,       //精品应用

    LTURLModule_Report_ASIdentifier= 16007,        // 上报广告标示符

    LTURLModule_Get_TimeStamp= 16008,      // 获取服务器当前时间戳

    LTURLModule_Get_Promotion_Info= 16009, // 获取产品推广信息

    LTURLModule_Get_VIP_Video_List= 16010, // 获取会员视频列表
    LTURLModule_Get_VIP_Privilege_Info= 16011, // 获取VIP特权信息

    LTURLModule_UploadErrorLogFile= 16012,      //错误日志文件上报

    // 评论
    LTURLModule_Comment_List= 17001,            // 获取评论列表
    LTURLModule_Comment_Add= 17002,             // 添加评论
    LTURLModule_Comment_Reply= 17003,           // 添加回复
    LTURLModule_Comment_Reply_List= 17004,      // 回复列表
    LTURLModule_Comment_Like= 17005,            // 喜欢
    LTURLModule_Comment_Unlike= 17006,          // 取消喜欢

    LTURLModule_Comment_VoteList = 17007,       //评论阵营投票
    LTURLModule_Comment_Vote = 17008,           //评论投票
    LTURLModule_Comment_Number = 17009,         //评论数

    LTURLModule_Comment_EmojiList = 17010,      //Emoji列表
    LTURLModule_Comment_YanmojiList = 17011,    //颜表情列表
    LTURLModule_Comment_AllKeyboardList = 17012,//所有表情列表

    //弹幕
    LTURLModule_Danmaku_Get = 17100,            //获取点播弹幕
    LTURLModule_Danmaku_Send = 17101,           //发送弹幕。
    LTURLModule_Danmaku_IsDanmaku = 17102,           //发送弹幕。
   //pb 接口
    LTURLModule_Comment_ListPB = 10017001,
    LTURLModule_Comment_AddPB = 10017002, //POST  接口暂时没有替换成PB
    LTURLModule_Comment_ReplyPB = 10017003,//POST
    LTURLModule_Comment_Reply_ListPB = 10017004,
    LTURLModule_Comment_LikePB = 10017005,
    LTURLModule_Comment_VoteListPB = 10017006,
    LTURLModule_Comment_VotePB = 10017007,
    LTURLModule_Comment_NumberPB = 10017008,

    LTURLModule_Danmaku_GetPB = 10017100,            //获取点播弹幕
    LTURLModule_Danmaku_SendPB = 10017101,           //发送弹幕。
    LTURLModule_Danmaku_IsDanmakuPB = 10017102,           //是否支持弹幕。

    // 积分商城
    LTURLModule_Integretion_Rules= 18001,       // 获取积分规则
    LTURLModule_Integretion_Task= 18002,        // 积分任务
    LTURLModule_Integretion_Action= 18003,      // 添加积分

    LTURLModule_Top_Game_Data= 18004,          //世界杯体育频道添加赛事集锦。


    // 热点
    LTURLModule_Hot_PraiseOrDown = 22001, //点赞
    LTURLModule_Hot_Praise_Count = 22002, //  获取点赞数
    /*************************************************/
    LTURLModule_MyNew = 22006,
    LTURLModule_My_FocusView = 22004,     //“我的焦点图”
    LTScoreRecord = 22005,     // 5.5增加 获取规则项积分记录
    LTURLModule_MyConcern = 22007, // 6.1 我的关注
    LTURLModule_AddConcern = 22008, // 6.1 添加关注
    LTURLModule_CancelConcern = 22009, // 6.1 我取消关注
    LTURLModule_IsConcernStar = 22010, // 6.1 是否已关注
    LTURLModule_IsConcernStarlist = 22011, // 6.1 是否已关注
    LTURLModule_Get_WaterMark= 23001,//5.8  查询活水印
    LTURLModule_Get_WaterMarkPB= 10023001,


    //收藏
    LTURLModule_Fav_Add = 24001,
    LTURLModule_Fav_Delete = 24002,
    LTURLModule_Fav_MultiDelete = 24003,
    LTURLModule_Fav_List = 24004,
    LTURLModule_Fav_IsFav = 20005,
    LTURLModule_Fav_Dump,      //本地上传

    //截屏分享推荐台词
    LTURLModule_Shot_TextShare_Get = 25001,
    LTURLModule_Shot_TextShare_GetPB = 10025001,
    LTURLModule_IsBadWord = 25002,//敏感词判断接口
    LTURLModule_IsBadWordPB = 10025002,                 //敏感词判读PB接口
    LTURLModule_Shot_Icons_CMS = 25003,                 //截图的icon model
    LTURLModule_Shot_Icons_CMSPB = 10025003,            //截图的icon PB model

    //明星
    LTURLModule_STAR_Video_List = 26001,                //明星信息列表
    LTURLModule_Star_History_List = 26002,                //明星 往期排行榜
    LTURLModule_Star_Ranklist = 26003,                //明星 当前排行榜
    LTURLModule_Star_HalfPlayList = 26004,              // 半屏明星card列表

    LTURLModule_STAR_Video_ListPB = 10026001,      //明星信息列表PB
    LTURLModule_Star_History_ListPB = 10026002,    //明星 往期排行榜PB
    LTURLModule_Star_RanklistPB = 10026003,        //明星 当前排行榜PB


    //红包
    LTURLModule_RedPacket_StaringUp = 270001,           //开机红包接口
    LTURLModule_RedPacket_PaySuccess = 270002,          //支付成功接口
    LTURLModule_RedPacket_PaySucCallBack = 270003,      //分享成功回调接口
    LTURLModule_RedPacket_Position = 270004,            //APP红包入口接口
    LTURLModule_RedPacket_List = 270005,                //红包列表接口
    // 红包PB
    LTURLModule_RedPacket_StaringUpPB = 100270001,
    LTURLModule_RedPacket_PaySuccessPB = 100270002,
    LTURLModule_RedPacket_PaySucCallBackPB = 100270003,
    //热补丁
    LTURLModule_HotPatch = 30001,
    LTURLModule_HotPatchPB = 10030001,

    // PageCard
    LTURLModule_PageCard = 30002,            // PageCard配置文件更新接口

    LTURLModule_LoadingPoster = 30005,     //loading海报图
    LTURLModule_LiveVoteList = 30006,      //iPhone6.1新增投票（直播）
    LTURLModule_Votelist = 30007,         //iPhone6.1新增投票（点播）
    LTURLModule_Vote = 30008,             //iPhone6.1投票接口
    //新版投票
    LTURLModule_FullScreenVoteList = 30030, //投票信息列表

    LTURLModule_VideoPraiseOrStep = 30009,//iPhone6.1半屏踩和赞

    LTURLModule_STAR_VOTE = 30010, //ipheon 6.2 明星投票
    LTURLModule_STAR_VOTEPB = 1003010,

    LTURLModule_GetClientIP = 40001,      // 获取客户端IP

    LTURLModule_GetLivingOnlineNum = 40002, //获取直播半屏在线人数

    //直播边看边买
    LTURLModule_GetLiveShoppingProduct = 40003,   //获取直播id对应商品信息
    LTURLModule_GetLiveShoppingCartCount = 40004, //购物车数量及购物车商品信息
    LTURLModule_liveAddProductToCart = 40005,     //添加商品到购物车
    LTURLModule_GetProductAttentionCount = 40006, //获取商品关注人数
    
    LTURLModule_Live_GetAllOrderData = 200000,   //全部预约接口，6.7改版添加
    
    //corespotlight数据
    LTURLModule_GetCoreSpotlightData = 200001,   //corespotlight搜索
    LTURLModule_GetCoreSpotlightDataPB = 200002,
    
    //PB
    LTURLModule_FindTopicPB = 1002009,         //发现PB接口
    LTURLModule_Live_SeverTimePB=1006010,     // 获取服务器时间PB
    LTURLModule_Video_VF_And_AdvertisePB = 1004018,    // 合并视频文件请求和广告请求
    LTURLModule_DRM_XMLToken = 1009000,    // drm tokenurl 请求接口

    /*直播边看边买*/
    LTURLModule_GetLiveShoppingProductPB = 1004019,   //获取直播id对应商品信息
    LTURLModule_GetLiveShoppingCartCountPB = 1004020, //购物车数量及购物车商品信息
    LTURLModule_liveAddProductToCartPB = 1004021,     //添加商品到购物车
    LTURLModule_GetProductAttentionCountPB = 1004022, //获取商品关注人数
    LTURLModule_BuyingOrderPB = 1004123,              //预约接口
    LTURLModule_BuyingCheckIsOrderedPB = 1004124,     //检查是否已预约接口
    /*直播在线人数*/
    LTURLModule_GetLivingOnlineNumPB = 1004023,//获取直播半屏在线人数
    /*全屏播放器内投票*/
    LTURLModule_LiveVoteListPB = 1004024,//iPhone6.1新增投票（直播)
    LTURLModule_VotelistPB = 1004025,//iPhone6.1新增投票（点播）
    LTURLModule_VotePB = 1004026,//iPhone6.1投票接口


    LTURLModule_MyNewPB = 10022006,
    LTURLModule_UC_UserInfoPB=1000010,        // 获取用户信息
    LTURLModule_UC_VoucherListPB =1000023,     // 观影券列表
    LTURLModule_IAP_ProductIdPB = 1001007,     //获取所有付费商品id
    LTURLModule_Live_UseTicketPB = 1006015, //直播付费使用直播券PB
    LTURLModule_Live_TicketInfoPB = 1006016,  //直播付费查询直播券PB

    LTURLModule_IAP_ProductId_PrePB = 10011008, //获取部分付费商品id PB
    LTURLModule_Get_VIP_Privilege_InfoPB= 10016011, // 获取VIP特权信息 PB

    LTURLModule_End, //


}LTURLModule;

// -------------------------------------------------- //

#pragma mark - url body


#endif

typedef enum{
    PlayerViewDefaultSuperTVPushUrlFromLeftView,
    PlayerViewDefaultSuperTVPushUrlFromBottomView,
    PlayerViewDefaultSuperTVPushUrlFromOther
}PlayerViewDefaultSuperTVPushUrlFromType;

//播放页切换1080p后可进入的默认地址
#define  LT_1080P_DEFAULT_PURCHASE_URL @"http://m.shop.letv.com/?cps_id=le_app_apprx_other_appbfy1080p_brand_h_msqgcjds0701"

//购买超级电视默认地址
#define  LT_SUPERTV_DEFAULT_PURCHASE_URL @"http://m.shop.letv.com/?cps_id=le_app_apprx_other_appbfycjds_brand_h_qr0610"
//#define LT_SUPERTV_DEFAULT_PURCHASE_URL @"http://shop.letv.com/zt/mobile.html"

//搜索结果html5页面url审核状态过滤数据参数
#define LT_SearchResult_html5_AuditsState_param (![SettingManager isPassAudit]?[NSString stringWithFormat:@"%@",@"&contentfilter=1"]:[NSString stringWithFormat:@"%@",@""])

//搜索结果html5页面url  启用正式接口 去掉数据过滤
//#define LT_SearchResult_html5_URL(keyWord,lc,uid,ua)     ([SettingManager isTestApi]?[NSString stringWithFormat:@"http://t.m.letv.com/search?&noheader=1&nofooter=1&ref=0102&from=mobile_01&os=ios&wd=%@&lc=%@&uid=%@&ua=%@%@",keyWord,lc,uid,ua,LT_SearchResult_html5_AuditsState_param]:[NSString stringWithFormat:@"http://m.letv.com/search?&noheader=1&nofooter=1&ref=0102&from=mobile_01&os=ios&wd=%@&lc=%@&uid=%@&ua=%@%@",keyWord,lc,uid,ua,LT_SearchResult_html5_AuditsState_param])

// 过滤+接口切换
#define LT_SearchResult_html5_URL(keyWord,lc,uid,ua,version) ([SettingManager isTestApi]?[NSString stringWithFormat:@"http://t.m.letv.com/search?&noheader=1&nofooter=1&ref=0102&from=mobile_01&os=ios&wd=%@&lc=%@&uid=%@&ua=%@&version=%@&contentfilter=0",keyWord,lc,uid,ua,version]:[NSString stringWithFormat:@"http://m.letv.com/search?&noheader=1&nofooter=1&ref=0102&from=mobile_01&os=ios&wd=%@&lc=%@&uid=%@&ua=%@&version=%@&contentfilter=0",keyWord,lc,uid,ua,version])

#define LT_SearchResult_html5_Title NSLocalizedString(@"乐看搜索", nil)
#define LT_SeatchResult_html5_Ref @"0102"
#ifdef LT_IPAD_CLIENT
#define HKWEBLogin @"https://sso.le.com/userGlobal/mlogin?next_action=http%3A%2F%2Fsso.le.com%2Fopen%2Fchecklogin%3Fjsonp%3Djxb_hk" //é¦æ¸¯ç»å½
#else


#define HKWEBLogin @"https://sso-hk.le.com/user/mloginHome?ver=3.0&plat=msite&next_action=http%3A%2F%2Fsso.le.com%2Fopen%2Fchecklogin%3Fjsonp%3Djxb_hk" //香港登录
                   // "https://sso.le.com/userGlobal/mlogin?next_action=http%3A%2F%2Fsso.le.com%2Fopen%2Fchecklogin%3Fjsonp%3Djxb_hk"
#endif
