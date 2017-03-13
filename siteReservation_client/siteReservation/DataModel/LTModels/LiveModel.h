//
//  LiveModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-5.
//
//

//#import "JSONModel.h"


//#ifndef LT_IPAD_CLIENT

#import <LetvMobileOpensource/LetvMobileOpensource.h>

#pragma mark - sever time
@protocol LiveServerTime @end
@interface LiveServerTime : JSONModel

@property (strong, nonatomic) NSDate* date;         // String	节目单日期，YY:MM:DD hh:mm:ss
@property (strong, nonatomic) NSString* week_day;   // String	星期几的节目单：1-星期一，7-星期日

@end


#pragma mark - live focus
@protocol LiveFocusItem @end
@interface LiveFocusItem : JSONModel

//@property (strong, nonatomic) NSString* title;      // String	直播焦点图名称
@property (strong, nonatomic) NSString* streamUrl;       // String	直播地址
@property (strong, nonatomic) NSString* streamCode;        // String	直播编号
@property (strong, nonatomic) NSString* mobilePic;       // String	图片
@property (strong, nonatomic) NSString<Optional>* padPic;       // String	图片
@property (strong, nonatomic) NSString* tm;           // String	时间戳
@property (strong, nonatomic) NSString* title;        //String 标题
@end

@protocol LiveFocusModel @end
@interface LiveFocusModel : JSONModel

@property (strong, nonatomic) NSArray<LiveFocusItem, ConvertOnDemand> *focuspic;      // 焦点图

@end



@protocol LiveBookInfo @end
@interface LiveBookInfo : JSONModel

@property (strong, nonatomic) NSString* total;       // String	已预订的节目个数

@end



#pragma mark - phoneStreamUrl
@protocol PhoneStreamLiveUrlModel @end
@interface PhoneStreamLiveUrlModel : JSONModel
@property (strong, nonatomic) NSString<Optional> *code;     //String    码流代码
@property (strong, nonatomic) NSString<Optional> *liveUrl;  //String    直播流
@property (strong, nonatomic) NSString<Optional> *streamId; //String   直播流的streamId
@property (strong, nonatomic) NSString<Optional> *tm;       //String    当前时间戳
@end

#pragma mark - playBillModel
@protocol PlayBillModel @end
@interface PlayBillModel : JSONModel
@property (strong, nonatomic) NSString *name;      //String    名称
@property (strong, nonatomic) NSString *play_time; //String    播放时间
@property (strong, nonatomic) NSString *isplay;    //String    是否正在播放

@end
#pragma mark - live lunbo & weishi list
@protocol LiveChannelModel @end
@interface LiveChannelModel : JSONModel
@property (strong, nonatomic) NSString<Optional> *name;   //String	直播频道名称
@property (strong, nonatomic) NSString<Optional> *icon;   //String	直播频道图标

@property (strong, nonatomic) NSString<Optional> *channel_ename; //string 频道英文名称
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *phoneStreamLiveUrls; //直播地址
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_350; //String 350直播地址
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_800; //String 800直播地址
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_1000; //String 1000直播地址
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_1300; //String 1300直播地址
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_720p; //String 720p直播地址
//@property (strong, nonatomic) NSString<Optional> *canPlay;      //String 判断能不能播放
@property (strong, nonatomic) NSArray<PlayBillModel, Optional> *playBillList;      //当前/下一个节目列表
@property (strong, nonatomic) NSArray<PlayBillModel, Optional> *playBillListThird;      //当前/下一个节目列表 ipad专用

@property (strong, nonatomic) NSString<Optional> *id;   //直播id
@property (strong, nonatomic) NSString<Optional> *ch;   //直播频道ch
@property (strong, nonatomic) NSString<Optional> *level;  //赛事类型2
@property (strong, nonatomic) NSString<Optional> *level1;  //赛事类型1
@property (strong, nonatomic) NSString<Optional> *liveref; ////统计需要添加  5.4.1添加。接口没有。

@property (strong, nonatomic) NSString<Optional> *channelId;//5.7 添加的频道id

//// 防盗链使用参数
//@property (strong, nonatomic) NSString<Optional>* stream_id;
//@property (strong, nonatomic) NSString<Optional>* stream_id_350;
//@property (strong, nonatomic) NSString<Optional>* tm;

- (LiveCodeType)getLiveTypeFromCode:(PhoneStreamLiveUrlModel *)liveStream;
- (LiveCodeType)getDefaultLiveType:(PhoneStreamLiveUrlModel *)liveUrlModel;
- (PhoneStreamLiveUrlModel *)getUrlFromLiveType:(LiveCodeType)LiveCodeType;
- (BOOL)isValidCodeType:(LiveCodeType)liveCodeType;
- (NSArray *)getAllValidCodeTypes;
//add by qinxl 对码流进行容错
- (void)correctLiveStream;
@end

@protocol LiveChannelListModel @end
@interface LiveChannelListModel : JSONModel
@property (strong, nonatomic) NSArray<LiveChannelModel,ConvertOnDemand> *data;
//- (NSInteger)indexOfLiveChannelCode:(NSString *)code;
@end

@protocol GetLiveUrlModel @end
@interface GetLiveUrlModel : JSONModel
@property (strong, nonatomic) LiveChannelModel<Optional> *data;
//- (NSInteger)indexOfLiveChannelCode:(NSString *)code;
@end

@protocol DateList @end
@interface DateList : JSONModel
@property (strong, nonatomic) NSString *d;         //String  星期几
@property (strong, nonatomic) NSString *weekday;   //String  名称
@end
#pragma mark - livehall programInfo
@protocol LivehallProgramInfoModel @end
@interface LivehallProgramInfoModel : JSONModel
@property (strong, nonatomic) NSString *date;  //String 节目单日期
@property (strong, nonatomic) NSString *week_day; //String 星期几节目单 1 星期一 7 星期日
@property (strong, nonatomic) NSDate<Optional> *current_date;//String 当前时间,格式例子（2014-02-26 14:30:20）
@property (strong, nonatomic) NSString<Optional> *current_week_day; //当前星期几：1-星期一，7-星期日
@property (strong, nonatomic) NSArray<DateList,ConvertOnDemand> *dateList;
@end

#pragma mark - livehall livelist
@protocol LivehallLiveListModel @end
@interface LivehallLiveListModel : JSONModel
@property (strong, nonatomic) NSString<Optional> *name;   //String 直播名
@property (strong, nonatomic) NSString<Optional> *play_time; //String 播放时间
@property (strong, nonatomic) NSString<Optional> *play_date; //String 播放日期
@property (strong, nonatomic) NSString<Optional> *end_time;  //String 结束时间
@property (strong, nonatomic) NSString<Optional> *aid;      //String 回看专辑id
@property (strong, nonatomic) NSString<Optional> *vid;     //String 视频ID
@property (strong, nonatomic) NSString<Optional> *preVID;  //String 前一视频ID
@property (strong, nonatomic) NSString<Optional> *recordingId; //String 回看视频ID
@property (strong, nonatomic) NSString<Optional> *ct;       //String 频道ID 对应预约 channel_code
@property (strong, nonatomic) NSString<Optional> *programTypeName; //String 频道名称
@property (strong, nonatomic) NSString<Optional> *isplay;  //String 是否正在播放 1 正在播放 0 不在播放
@property (strong, nonatomic) NSString<Optional> *isbooked; //string 是否已预约:0-没有预约，1-已预约
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *phoneStreamLiveUrls;
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_350;
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_1000;
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_1300;
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_720p;
@property (strong, nonatomic) LiveBookInfo<Optional> *bookinfo;
//@property (strong, nonatomic) NSString *canPlay;     //String 是否能播放 1 能播  0 不能播
//ct=sports的字段
@property (strong, nonatomic) NSString<Optional> *level1;  //一级赛事类型
@property (strong, nonatomic) NSString<Optional> *ch;     //渠道
@property (strong, nonatomic) NSString<Optional> *id;     //赛事ID
@property (strong, nonatomic) NSString<Optional> *cid;    //频道
@property (strong, nonatomic) NSString<Optional> *liveref; //统计需要添加  5.4.1添加。接口没有。
@property (strong, nonatomic) NSString<Optional> *pay;     //付费 是否付费(0为免费，1为付费)
@property (strong, nonatomic) NSString<Optional> *liveid;  //场次id

@property (strong, nonatomic) NSString<Optional> *level;        //String 赛事类型
@property (strong, nonatomic) NSString<Optional> *home;         //String 主队名称
@property (strong, nonatomic) NSString<Optional> *guest;        //String 客队名称
@property (strong, nonatomic) NSString<Optional> *homescore;    //String 主队分数
@property (strong, nonatomic) NSString<Optional> *guestscore;   //String 客队分数
@property (strong, nonatomic) NSString<Optional> *commentaryLanguage; //String 解说语言
@property (strong, nonatomic) NSString<Optional> *match;        //String 赛事轮次
@property (strong, nonatomic) NSString<Optional> *status;       //String 0 未开始 1 进行中 2 已结束
@property (strong, nonatomic) NSString<Optional> *isVS;         //String 0 菲比赛类 1 比赛类
//ct = ent/music
@property (strong, nonatomic) NSString<Optional> *type;         //String 直播类型

//ct=sports的字段
@property (strong, nonatomic) NSString<Optional> *homeImgUrl;   //String 主队图标
@property (strong, nonatomic) NSString<Optional> *guestImgUrl;  //String 客队图标

//// 用于定位半屏界面tab的位置，只有首页直播赋值play_date，体育直播play_time没有没有年份
@property (nonatomic, strong) LivehallProgramInfoModel<Optional> *programInfo;

@property (strong, nonatomic) NSString<Optional> *typeICO;// 音乐娱乐其他频道小图片
@property (strong, nonatomic) NSString<Optional> *level2ImgUrl;// 体育小图片


-(BOOL)isPlay;
-(BOOL)isBooked;
- (LiveCodeType)getDefaultLiveType;
- (LiveCodeType)getLiveTypeFromCode:(PhoneStreamLiveUrlModel *)liveStream;
- (PhoneStreamLiveUrlModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType;
- (BOOL)isValidCodeType:(LiveCodeType)liveCodeType;
- (NSArray *)getAllValidCodeTypes;
//add by qinxl 对码流进行容错
- (void)correctLiveStream;
@end

#pragma mark - livehall
@protocol LiveHallModel @end
@interface LiveHallModel : JSONModel                            //直播厅
@property (strong, nonatomic) LivehallProgramInfoModel *programInfo; //节目单信息
@property (strong, nonatomic) NSArray<LivehallLiveListModel, Optional> *data; //直播厅/首页体育节目列表
@property (strong, nonatomic) NSString<Optional> *from;  // 从哪里来的，处理从首页进来的情况

- (NSInteger)getCurrentPlayingIndex:(NSString *)name;
- (NSInteger)getCurrentPlayingIndexByID:(NSString *)idStr;
//- (BillStatus)getBillStatusOfLiveItemAtIndex:(NSInteger)idxOfItem;
- (NSString *)getPlayingDateString:(NSInteger)index;
- (NSString *)getDateString:(NSInteger)index;
- (BillStatus)getBillStatusOfLiveItemAtIndex:(NSInteger)idxOfItem
                              forChannelCode:(NSString *)channelCode;

- (BillStatus)getBillStatusOfLiveForHomeItemAtIndex:(NSInteger)idxOfItem
                              forChannelCode:(NSString *)channelCode;

@end


#pragma mark - LiveChannelInfo
@protocol LiveProgramListModel @end
@interface LiveProgramListModel : JSONModel
@property (strong, nonatomic) NSString *title;            //节目名称
@property (strong, nonatomic) NSString *playtime;         //播放时间
@property (strong, nonatomic) NSString *endtime;          //结束时间
@property (strong, nonatomic) NSString *isplay;           //是否正在播放  0 没在播放 1 正在播放
@property (strong, nonatomic) NSString *isbooked;         //是否预约 0 没有预约 1 已预约
- (BOOL)isPlay;
- (BOOL)isBooked;
@end



@protocol BookInfoModel @end
@interface BookInfoModel : JSONModel
@property (strong, nonatomic) NSString *total;

@end



@protocol LiveChannel @end                                 //轮播台 卫视台节目单
@interface LiveChannel : JSONModel
@property (strong, nonatomic) NSString *channelName;           //频道名称
@property (strong, nonatomic) NSString *channel_ename;         //频道英文名称
@property (strong, nonatomic) PhoneStreamLiveUrlModel *phoneStreamLiveUrls; //直播流
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_350;  // 350直播地址
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_1000; // 1000直播地址
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_1300; // 1300直播地址
@property (strong, nonatomic) PhoneStreamLiveUrlModel<Optional> *live_url_720p; // 720p直播地址
//@property (strong, nonatomic) NSString *canPlay;               //是否可以播放
@property (strong, nonatomic) LivehallProgramInfoModel *programInfo; //节目单信息
@property (strong, nonatomic) NSArray<LiveProgramListModel,ConvertOnDemand> *programList; //节目单列表
@property (strong, nonatomic) BookInfoModel<Optional> *bookinfo;
- (NSInteger)getCurrentPlayingIndex;
- (BillStatus)getBillStatusOfLiveItemAtIndex:(NSInteger)idxOfItem
                              forChannelCode:(NSString *)channelCode;
- (LiveCodeType)getDefaultLiveType;
- (LiveCodeType)getLiveTypeFromCode:(PhoneStreamLiveUrlModel *)liveStream;
- (PhoneStreamLiveUrlModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType;
- (BOOL)isValidCodeType:(LiveCodeType)liveCodeType;
//add by qinxl 对码流进行容错
- (void)correctLiveStream;
@end

@protocol LiveTm @end
@interface LiveTm : JSONModel
@property (strong, nonatomic) NSString *expiretime;         // 直播过期时间戳
@end


// 直播付费鉴权
@protocol LiveAuthenticationDetailModel @end

@interface LiveAuthenticationDetailModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *liveid;   // 鉴权的场次id
@property (nonatomic, strong) NSString<Optional> *status;   // 1 有权限 0 无权限
@end

@interface LiveAuthenticationModel : JSONModel
@property (strong, nonatomic) NSArray<LiveAuthenticationDetailModel, Optional> *result;
- (BOOL)isHaveBuy:(NSString *)liveid;
@end

#ifdef LT_LIVING_PAY
#pragma mark - 直播付费相关
#pragma mark - 鉴权
@protocol LiveAuthorityInfo @end
@interface LiveAuthorityInfo : JSONModel
@property (strong, nonatomic) NSString<Optional> *code;    // 错误编码：1004,token生成失败;1011,赛季包鉴权成功，但直播未开始;1012,球队包鉴权成功，但直播未开始;1013,场次卷鉴权成功，但直播未开始
@property (strong, nonatomic) NSString<Optional> *msg;      //错误描述
@property (strong, nonatomic) NSNumber<Optional> *count;    //直播卷数量
@property (strong, nonatomic) NSString<Optional> *team;     //队伍包信息（如果购买多包，则返回一个）
@property (strong, nonatomic) NSString<Optional> *season;   //返回赛季信息
@property (strong, nonatomic) NSNumber<Optional> *liveStatus; //直播状态
@property (strong, nonatomic) NSNumber<Optional> *curTime;  //服务器时间
@property (strong, nonatomic) NSString<Optional> *payType;   //1: 包年以上会员免费、2:包年以上或单点免费、3:会员免费、4:会员或单点免费、5:单点、6:全屏包年以上或单点免费
@end

@interface LiveAuthorityError : JSONModel
@property (strong, nonatomic) NSString<Optional> *code;    // 错误编码：1004,token生成失败;1011,赛季包鉴权成功，但直播未开始;1012,球队包鉴权成功，但直播未开始;1013,场次卷鉴权成功，但直播未开始
@property (strong, nonatomic) NSString<Optional> *msg;      //错误描述
@end

@protocol LiveAuthority @end
@interface LiveAuthority : JSONModel
@property (strong, nonatomic) NSString<Optional> *status;    //0：没有播放权限 1：有播放权限
@property (strong, nonatomic) LiveAuthorityInfo<Optional> *info;    //status 为 0 没有播放权限 时的详细信息
@property (strong, nonatomic) LiveAuthorityError<Optional> *error;
@property (strong, nonatomic) NSString<Optional> *token;    //Token信息
@property (strong, nonatomic) NSNumber<Optional> *prestart; //直播token开始时间（单位为秒）
@property (strong, nonatomic) NSNumber<Optional> *preend;   //直播token结束时间（单位为秒）
@property (assign, nonatomic) BOOL isPre;                     //是否是直播试看鉴权成功，true是直播试看，false是正常鉴权
@property (strong, nonatomic) NSNumber<Optional> *curTime;   //当前服务器时间（单位为秒）
@property (strong, nonatomic) NSString *payType;
/**
 *  是否为单点付费类型
 *
 *  @return
 */
- (BOOL)isSinglePointPayType;
/**
 *  直播试看是否可以试看倒计时
 *
 *  @return
 */
- (BOOL)islivePreCanCountDown;
/**
 *  直播试看倒计时时间
 *
 *  @return
 */
- (NSInteger)livePreCountDownTime;

@end

@interface LiveLunboAuthorityStatus : JSONModel

@property (strong, nonatomic) NSNumber<Optional> *status; // 轮直播鉴权状态（1通过。0不通过）
@property (strong, nonatomic) NSString<Optional> *token; // 轮直播鉴权token
@end

@interface LiveLunboAuthority : JSONModel

@property (strong, nonatomic) NSNumber<Optional> *code;
@property (strong, nonatomic) NSString<Optional> *msg;
@property (strong, nonatomic) LiveLunboAuthorityStatus<Optional> *data;

@end

#pragma mark - 价格
/**
 直播价格套餐包
 */
@protocol LivePackages @end
@interface LivePackages : JSONModel
@property (strong, nonatomic) NSString<Optional> *type;    //
@property (strong, nonatomic) NSString<Optional> *name;    //
@property (strong, nonatomic) NSString<Optional> *vip_price;     //会员价格
@property (strong, nonatomic) NSString<Optional> *regular_price;  //非会员价格
@property (strong, nonatomic) NSString<Optional> *validate_days;   //有效时间间
@property (strong, nonatomic) NSString<Optional> *status;       //0可用，1不可用
@property (strong, nonatomic) NSString<Optional> *counts;       //频道id
@property (strong, nonatomic) NSString<Optional> *start_time;    //本轮开始时间
@property (strong, nonatomic) NSString<Optional> *end_time;      //本轮结束时间
@property (strong, nonatomic) NSString<Optional> *rounds;        //轮次
@property (strong, nonatomic) NSString<Optional> *matchname;
@property (strong, nonatomic) NSString<Optional> *itemname;
@property (strong, nonatomic) NSString<Optional> *sessionname;
@property (strong, nonatomic) NSString<Optional> *session_end_time;
@property (strong, nonatomic) NSString<Optional> *play_number;
@property (strong, nonatomic) NSString<Optional> *app_price;
@property (strong, nonatomic) NSString<Optional> *app_product_id; //iphone productId
@property (strong, nonatomic) NSString<Optional> *ipadProductId;//ipad productId


@end



/**
 直播价格
 */
@protocol LivePrice @end
@interface LivePrice : JSONModel
@property (strong, nonatomic) NSString<Optional> *status;    //接口成功失败0失败1成功
@property (strong, nonatomic) NSString<Optional> *matchId;    //频道id
@property (strong, nonatomic) NSString<Optional> *itemId;     //赛事id
@property (strong, nonatomic) NSString<Optional> *sessionId;  //赛季id
@property (strong, nonatomic) NSString<Optional> *sessionEndDate;   //赛季结束时间
@property (strong, nonatomic) NSArray<LivePackages,Optional> *packages;    //套餐包

@end

/**
 查询直播券
 */
@protocol LiveQueryPackages @end
@interface TicketInfo : JSONModel
@property (strong, nonatomic) NSString<Optional> *status;    //接口成功失败0失败1成功
@property (strong, nonatomic) NSString<Optional> *message;    //
@property (strong, nonatomic) NSArray<LiveQueryPackages,Optional> *package;    //套餐包

@end
/**
 查询直播券套餐包
 */
@interface LiveQueryPackages : JSONModel
@property (strong, nonatomic) NSString<Optional> *type;   //
@property (strong, nonatomic) NSString<Optional> *count;   //
@property (strong, nonatomic) NSString<Optional> *status;     //
@end

/**
 使用直播券
 */
@interface LiveUseTicket : JSONModel
@property (strong, nonatomic) NSString<Optional> *liveid;   //
@property (strong, nonatomic) NSString<Optional> *status;     //
@property (strong, nonatomic) NSString<Optional> *error;     //
@end

#endif


