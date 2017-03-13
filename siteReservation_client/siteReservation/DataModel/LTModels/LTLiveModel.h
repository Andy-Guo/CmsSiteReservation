//
//  LTLiveModel.h
//  LetvIphoneClient
//
//  Created by Dabao on 14-10-28.
//
//

//#import "JSONModel.h"

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileFoundation/LetvMobileFoundation.h>
#import <LetvMobileDataModel/LTDataModelCommDef.h>
#import <LetvMobileDataModel/LiveModel.h>

@interface LTLiveModel : JSONModel
@end

#pragma mark - New Live Home Data Modle
@interface LTLiveHomeResultModel : JSONModel
@property (nonatomic, strong) NSDictionary<Optional> *result;
@end

@protocol LTLiveRoomDetailModel
@end
@protocol LTLiveChannelStreamsModel
@end
/*乐视专题 created by 6.8 & GuoYi You*/
@interface LTLiveHomeLeTopicModel: JSONModel
@property (nonatomic, copy) NSString<Optional> *displayName;
@property (nonatomic, strong) NSArray<Optional, LTLiveRoomDetailModel> *data;
@property (nonatomic, copy) NSString<Optional> *sports;
@property (nonatomic, copy) NSString<Optional> *others;
@property (nonatomic, copy) NSString<Optional> *music_ent_variety;
/*
@property (nonatomic, copy) NSString<Optional> *homeTeam;
@property (nonatomic, copy) NSString<Optional> *awayTeam;
@property (nonatomic, copy) NSString<Optional> *homeTeamIcon;
@property (nonatomic, copy) NSString<Optional> *awayTeamIcon;
@property (nonatomic, copy) NSString<Optional> *isVs;
@property (nonatomic, copy) NSString<Optional> *channelName;
@property (nonatomic, copy) NSString<Optional> *liveStatus;
@property (nonatomic, copy) NSString<Optional> *liveDate;
@property (nonatomic, copy) NSString<Optional> *topicType;
*/
@end

/*热门直播/热门回看*/
@interface LTLiveHomeHotLiveBlockModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *displayName;
@property (nonatomic, strong) NSArray<Optional, LTLiveRoomDetailModel> *data;
@property (nonatomic, copy) NSString<Optional> *sports;
@property (nonatomic, copy) NSString<Optional> *others;
@property (nonatomic, copy) NSString<Optional> *music_ent_variety;
@end

/*热门预告*/
@protocol LTLiveHomeTrailerModel
@end
@interface LTLiveHomeTrailerBlockModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *displayName;
@property (nonatomic, strong) NSArray<Optional, LTLiveHomeTrailerModel> *data;
@end

@interface LTLiveHomeTrailerModel : JSONModel
@property (nonatomic, copy) NSString *display;
@property (nonatomic, strong) NSArray<Optional, LTLiveRoomDetailModel> *data;
@end

/*热门轮播台*/
@protocol LTLiveHomeHotCarouselModel
@end
@interface LTLiveHomeHotCarouselBlockModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *displayName;
@property (nonatomic, strong) NSArray<Optional, LTLiveHomeHotCarouselModel> *data;
@end

@interface LTLiveHomeHotCarouselModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *channelName;
@property (nonatomic, copy) NSString<Optional> *channelId;
@property (nonatomic, copy) NSString<Optional> *channelEname;
@property (nonatomic, copy) NSString<Optional> *signal;
@property (nonatomic, copy) NSString<Optional> *pic;
@property (nonatomic, copy) NSString<Optional> *poster;
@property (nonatomic, copy) NSString<Optional> *numericKeys;
@property (nonatomic, copy) NSString<Optional> *isPay;
@end

/*热门卫视台*/
@protocol LTLiveHomeHotTVModel
@end
@interface LTLiveHomeHotTVBlockModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *displayName;
@property (nonatomic, strong) NSArray<Optional, LTLiveHomeHotTVModel> *data;
@end

@interface LTLiveHomeHotTVModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *channelName;
@property (nonatomic, copy) NSString<Optional> *pic;
@property (nonatomic, copy) NSString<Optional> *channelId;
@property (nonatomic, copy) NSString<Optional> *channelEname;
@property (nonatomic, copy) NSString<Optional> *signal;
@property (nonatomic, strong) NSMutableArray<Optional, LTLiveChannelStreamsModel> *streams;
@property (nonatomic, copy) NSString<Optional> *poster;
@property (nonatomic, copy) NSString<Optional> *numericKeys;
@end

#pragma mark - 直播大厅数据
@protocol LTLiveBranchesModel @end
@protocol LTLiveRoomDetailModel @end
@protocol LTLiveChannelStreamsModel @end
@protocol LTLiveRoomBlockModel @end
@protocol LTLiveChannelListDetailModel @end
@protocol LTliveFocusModel @end
@protocol LTLiveOrderBlockModel @end

// app首页，体育用
@interface LTLiveRecommendModel : JSONModel
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel, Optional> *result;
@property (nonatomic, strong) NSMutableArray<Optional> *blockContent;
@end

@interface LTLiveRoomBlockModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *displayName;
@property (nonatomic, strong) NSString<Optional> *beginDate;
@property (nonatomic, strong) NSString<Optional> *itemDate;
@property (nonatomic, strong) NSString<Optional> *name; // PAD直播大厅体育娱乐音乐－日期数据
@property (nonatomic, strong) NSString<Optional> *value;// PAD直播大厅体育娱乐音乐－日期数据
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel, Optional> *list;
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel, Optional> *result;

@end

//全部预约model
@interface LTLiveOrderBlockModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *date;
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel, Optional> *result;
@end

@interface LTLiveOrderModel : JSONModel
@property (nonatomic, strong) NSMutableArray<LTLiveOrderBlockModel, Optional> *result;
- (void)removeInvalidData;
@end

@interface LTLiveRoomModel : JSONModel
@property (nonatomic, strong) NSArray<LTLiveRoomBlockModel, Optional> *result;

@end

@interface LTLiveNewRoomModel : JSONModel
@property (nonatomic, strong) LTLiveHomeLeTopicModel<Optional> *sortHotItems;
@property (nonatomic, strong) LTLiveHomeTrailerBlockModel<Optional> *hotTrailer;
@property (nonatomic, strong) LTLiveHomeHotLiveBlockModel<Optional> *lookBack;
@end

@interface LTLiveBranchesModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *belongArea;           // 所属区域 参考《频道归属区域词典》
@property (nonatomic, strong) NSString<Optional> *channelId;            // 频道ID
@property (nonatomic, strong) NSString<Optional> *channelName;          // 频道名称
@property (nonatomic, strong) NSString<Optional> *channel_ename;        // 频道英文名
@property (nonatomic, strong) NSString<Optional> *title;                // 多分支/多节目 名称
@property (nonatomic, strong) NSString<Optional> *viewImg;              // 多分支/多节目 截图地址
@property (nonatomic, strong) NSString<Optional> *beginTime;            // 分支开始时间
@property (nonatomic, strong) NSString<Optional> *endTime;              //分支结束时间
@end

@interface LTLiveMultiProgramModel : JSONModel
@property (nonatomic, strong) NSArray<LTLiveBranchesModel,Optional> *branches;
@property (nonatomic, strong) NSString<Optional> *branchDesc;     // 多分支描述
@end

@interface LTLiveFocusModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *pic1;     // pic1_746_419
@property (nonatomic, strong) NSString<Optional> *pic2;     // pic2_960_540
@property (nonatomic, strong) NSString<Optional> *pic3;     // pic3_400_225
@property (nonatomic, strong) NSString<Optional> *pic4;     // pic4_160_90
-(NSString*)getSharePic;
@end

@interface LTLiveRoomDetailModel : JSONModel

// 公共部分
@property (nonatomic, strong) NSString<Optional> *id;                           // 直播id
@property (nonatomic, strong) NSString<Optional> *beginTime;                    // 节目开始时间（格式：yyyy-MM-dd HH:mm:ss）
@property (nonatomic, strong) NSString<Optional> *endTime;                      // 节目结束时间（格式：yyyy-MM-dd HH:mm:ss）
@property (nonatomic, strong) NSString<Optional> *isPrecise;                    // 时间是否精确（1是 0否）
@property (nonatomic, strong) NSString<Optional> *title;                        // 节目标题
@property (nonatomic, strong) NSString<Optional> *status;                       // 显示数据的状态，例如：直播中
@property (nonatomic, strong) NSString<Optional> *__description;                // 节目详细描述
@property (nonatomic, strong) NSString<Optional> *pid;                          // 专辑ID
@property (nonatomic, strong) NSString<Optional> *preVid;                       // 预告视频ID
@property (nonatomic, strong) NSString<Optional> *recordingId;                  // 录制ID
@property (nonatomic, strong) NSString<Optional> *vid;                          // 视频ID
@property (nonatomic, strong) NSString<Optional> *viewPic;                      // 节目预览图片
@property (nonatomic, strong) NSString<Optional> *typeico;                      // 直播类型图标
@property (nonatomic, strong) NSString<Optional> *vodUrl;                       // 节目预览地址
@property (nonatomic, strong) NSString<Optional> *backgroundImgUrl;             // 页面背景图片地址
@property (nonatomic, strong) NSString<Optional> *allowVote;                    // 是否支持投票
@property (nonatomic, copy) NSString<Optional> *voteType;                       // 投票类型
@property (nonatomic, strong) NSString<Optional> *selectId;                     // 直播所选择的频道id
@property (nonatomic, strong) NSString<Optional> *liveWatermarkId;              // 直播基础水印信息ID
@property (nonatomic, strong) NSString<Optional> *ch;                           // 渠道号码
@property (nonatomic, strong) NSString<Optional> *timelyReport;                 // 是否及时上报(1 是 0 否 )
@property (nonatomic, strong) NSString<Optional> *weight;                       // 权重（0-99之间）
@property (nonatomic, strong) NSString<Optional> *isPay;                        // 是否收费（1是 0否）
@property (nonatomic, strong) NSString<Optional> *screenings;                   // 场次
@property (nonatomic, strong) NSString<Optional> *branchType;                   // 多分支类型（1多视角，2多解说）
@property (nonatomic, strong) NSString<Optional> *payProps;                     // 付费道具开关 0 关闭 1 明星道具 2 聊天道具
@property (nonatomic, strong) LTLiveMultiProgramModel<Optional> *multiProgram;  // 多路流
@property (nonatomic, strong) NSString<Optional> *isBranch;                     // 1支持多视角或者多解说，0不支持
@property (nonatomic, strong) LTLiveFocusModel<Optional> *focusPic;             // 直播分享用到的图片
@property (nonatomic, strong) NSString<Optional> *vipFree;                      // 是否会员免费

// 聊天室
@property (nonatomic, strong) NSString<Optional> *chatRoomNum;                  // 聊天室号码
@property (nonatomic, strong) NSString<Optional> *isChat;                       // 是否启用聊天（1 是 0 否）
@property (nonatomic, strong) NSString<Optional> *isDanmaku;                    // 是否启用弹幕（1 是 0 否）
@property (nonatomic, strong) NSString<Optional> *isQuestion;                   // 是否允许提问（1 是 0 否）
@property (nonatomic, strong) NSString<Optional> *questionStartTime;            // 提问开始时间（2014-06-24 00:00:00）
@property (nonatomic, strong) NSString<Optional> *questionEndTime;              // 提问结束时间（2014-06-24 00:00:00）
@property (nonatomic, strong) NSString<Optional> *quickReply;                   // 快捷回复范本（已分号分割）

// 体育
@property (nonatomic, strong) NSString<Optional> *commentaryLanguage;           // 解说语言
@property (nonatomic, strong) NSString<Optional> *level1;                       // 一级赛事名称
@property (nonatomic, strong) NSString<Optional> *level2;                       // 二级赛事名称
@property (nonatomic, strong) NSString<Optional> *level2ImgUrl;                 // 二级赛事logo
@property (nonatomic, strong) NSString<Optional> *isVS;                         // 是否A VS B（1 是 0 否）
@property (nonatomic, strong) NSString<Optional> *guest;                        // 客队名称、主持人
@property (nonatomic, strong) NSString<Optional> *guestImgUrl;                  // 客队logo
@property (nonatomic, strong) NSString<Optional> *guestscore;                   // 客队得分
@property (nonatomic, strong) NSString<Optional> *home;                         // 主队名称
@property (nonatomic, strong) NSString<Optional> *homeImgUrl;                   // 主队logo
@property (nonatomic, strong) NSString<Optional> *homescore;                    // 主队得分
@property (nonatomic, strong) NSString<Optional> *homeDisplay;                  // PC首页是否展示
@property (nonatomic, strong) NSString<Optional> *liveStudioLink;               // 专题页面地址
@property (nonatomic, strong) NSString<Optional> *shortDesc;                    // 短描述
@property (nonatomic, strong) NSString<Optional> *season;                       // 多分支类型（0 无，1 多分支，2 多节目）
@property (nonatomic, strong) NSString<Optional> *match;                        // 赛事
@property (nonatomic, strong) NSString<Optional> *liveType;                     // 类型 sports

// 娱乐
@property (nonatomic, strong) NSString<Optional> *address;                      // 直播地点
@property (nonatomic, strong) NSString<Optional> *type;                         // 参考《娱乐直播类型编码词典》
@property (nonatomic, strong) NSString<Optional> *typeValue;                    // "颁奖典礼、音乐会"
@property (nonatomic, strong) NSString<Optional> *isPlayback;                   // 是否允许回放（1是 0否）
@property (nonatomic, strong) NSString<Optional> *moderator;                    // 主持人
@property (nonatomic, strong) NSString<Optional> *specialPageUrl;               // 专题页面地址
@property (nonatomic, strong) NSString<Optional> *typeICO;                      // 娱乐

// 音乐
@property (nonatomic, strong) NSString<Optional> *relevanceStar;                // 关联名星

// 其他
// 统计自行添加
@property (strong, nonatomic) NSString<Optional> *liveref;                      // 统计需要添加  5.4.1添加。接口没有,5.8.1移过来。
@property (nonatomic, strong) NSString<Optional> *liveTypeCode;                 // 直播频道id,5.8加用于上报
@property (nonatomic, strong) NSString<Optional> *isPush;                       // 是否是推送进来的

// 全景视频（1 是 0 否）
@property (nonatomic, strong) NSString<Optional> *isPanoramicView;

//是否支持边看边买（1 是 0 否
@property (nonatomic, strong) NSString<Optional> *buyFlag; //是否支持边看边买
@property (nonatomic, strong) NSString<Optional> *partId; //直播边看边买版块id

//6.70全部直播
@property (nonatomic, strong) NSNumber<Optional> *onLineNumbers;//在线人数
//6.8直播首页专题版块
@property (nonatomic, strong) NSString<Optional> *typeName;//类型名称
@property (nonatomic, strong) NSString<Optional> *pic169;//类型名称

@property (nonatomic, copy) NSString<Optional> *tagName;
//6.9香港体育
@property (nonatomic, strong) NSString<Optional> *at; // 表明是否为香港体育直播
@property (nonatomic, strong) NSString<Optional> *BookLiveNum; //代理层新加字段；预约人数
@property (nonatomic, strong) NSString<Optional> *playCount;   //播放数
- (NSString *)formatLiveType:(NSString *)liveType;
- (NSString *)getIconUrl;
- (BillStatus)getBillStatus;
- (BillStatus)getHomeBillStatus;    // 首页直播显示显示status
- (NSString *)getHomeFocusPic;      // 用于首页直播显示图片选取
- (NSString *)getChannelTypeValue;  // 所有类型的频道值
- (NSString *)getChannelIconName;
/**
 当前直播是否已预约
 */
- (BOOL)isLiveAppoint;
/**
 当前直播的类型
 */
- (LTLivingPayType)currentLiveType;

/**
 *  是否是全景视频
 *
 *  @return
 */
- (BOOL)isPanorama;
/**
 *  是否支持多视角
 */
- (BOOL)isSupportedMultiProgram;

/**
 *  是否是push
 *
 *  @return YES/NO
 */
- (BOOL)isLivePush;

@end
//直播通用查询接口返回的直播列表。
@interface LTLiveRoomHalfListResultModel: JSONModel
@property (nonatomic, strong) NSMutableArray<LTLiveRoomDetailModel,Optional> *data;
@end

// 半屏播放器默认播放
@interface LTLiveRoomDefaultModel : JSONModel
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel, Optional> *data;
@property (nonatomic, strong) NSArray<LTLiveChannelListDetailModel, Optional> *rows;
@end


@interface LTLiveRoomResultDefaultModel : JSONModel
@property (nonatomic, strong) LTLiveRoomDefaultModel<Optional> *result;
@end

// 热门
@protocol LTLiveRoomHotBlockModel @end

@interface LTLiveRoomSpecialModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *displayName;
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel, Optional> *data;
@end

@interface LTLiveRoomHotResultModel: JSONModel
@property (nonatomic, strong) NSMutableArray<LTLiveRoomHotBlockModel, Optional> *sortHotItems;
@property (nonatomic, strong) LTLiveRoomSpecialModel<Optional> *liveSpecia;
@end

@interface LTLiveRoomHotHalfResultModel: JSONModel
@property (nonatomic, strong) LTLiveRoomDetailModel<Optional> *data;
@end

@interface LTLiveRoomHotBlockModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *displayName;
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel, Optional> *data;
@end

@interface LTLiveRoomHotModel : JSONModel
@property (nonatomic, strong) LTLiveRoomHotResultModel<Optional> *result;
- (void)removeInvalidData;
@end

@interface LTLiveRoomHotHalfModel : JSONModel
@property (nonatomic, strong) LTLiveRoomHotHalfResultModel<Optional> *result;
@end

#pragma mark - 频道当前播放节目信息
@protocol LTLiveChannelDetailModel @end

@interface LTLiveChannelModel: JSONModel
@property (nonatomic, strong) NSArray<LTLiveChannelDetailModel, Optional> *rows;
@end

@protocol LTLiveCurrentChannelModel @end

@interface LTLiveCurrentChannelModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *channelId;//
@property (nonatomic, strong) NSArray<LTLiveChannelDetailModel, Optional> *data;

@end

@interface LTLiveCurrentChannelMenuModel: JSONModel
@property (nonatomic, strong) NSArray<LTLiveCurrentChannelModel, Optional> *rows;
@end


@interface LTLiveTheaterIcoModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *name;                     // 剧场名称
@property (nonatomic, strong) NSString<Optional> *imgUrl;                   // 角标地址
@end

@interface LTLiveMarkDetailModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *tv;                       // 直播中、回放、录播TV端水印
@property (nonatomic, strong) NSString<Optional> *pc;                       // 直播中、回放、录播PC端水印(大于480PX)
@property (nonatomic, strong) NSString<Optional> *mbFull;                   // 直播中、回放、录播移动端全屏水印(PC小于等于480PX)
@property (nonatomic, strong) NSString<Optional> *mbHalf;                   // 直播中、回放、录播移动端半屏水印
@property (nonatomic, strong) NSString<Optional> *percentage;               // 边距（百分比）
@property (nonatomic, strong) NSString<Optional> *displayDuration;          // 显示时长
@property (nonatomic, strong) NSString<Optional> *hiddenDuration;           // 隐藏时长
@end

@interface LTLiveWaterMarkModel : JSONModel
@property (nonatomic, strong) LTLiveMarkDetailModel<Optional> *theaterIco;        // 直播中水印信息
@property (nonatomic, strong) LTLiveMarkDetailModel<Optional> *playback;          // 回放水印信息
@property (nonatomic, strong) LTLiveMarkDetailModel<Optional> *recorder;          // 录播水印信息
@end

@interface LTLiveChannelDetailModel: JSONModel
@property (nonatomic, strong) NSString<Optional> *id;                               // 节目ID
@property (nonatomic, strong) NSString<Optional> *title;                            // 节目名称
@property (nonatomic, strong) NSString<Optional> *playTime;                         // 节目开始播放时间，格式：yyyy-MM-dd HH:mm:ss
@property (nonatomic, strong) NSString<Optional> *endTime;                          // 节目播放结束时间，格式：yyyy-MM-dd HH:mm:ss，注意：结束时间并不一定就是实际节目的结束时间，有可能被下一个节目覆盖掉。
@property (nonatomic, strong) NSString<Optional> *duration;                         // 节目时长(单位秒)
@property (nonatomic, strong) NSString<Optional> *viewPic;                          // 节目缩略图地址（120*90）
@property (nonatomic, strong) NSDictionary<Optional> *allPic;                       // 节目缩略图地址（400*300)
@property (nonatomic, strong) NSString<Optional> *programType;                      // 节目类型(1 直播 0 点播)
@property (nonatomic, strong) NSString<Optional> *vid;                              // 视频ID（节目类型为点播时非空）
@property (nonatomic, strong) NSString<Optional> *liveChannelId;                    // 直播频道ID（节目类型为直播时非空）
@property (nonatomic, strong) LTLiveTheaterIcoModel<Optional> *theaterIco;          // 剧场角标信息
@property (nonatomic, strong) LTLiveWaterMarkModel<Optional> *waterMark;            // 水印信息
@property (nonatomic, strong) NSString<Optional> *branchType;                       // 多分支类型（0 无，1 多分支，2 多节目）
@property (nonatomic, strong) NSString<Optional> *isRecorder;                       // 是否显示录播logo  0 否 1 是

//5.8.1新接口添加的字段。add by wangduan
@property (nonatomic, strong) NSString<Optional> *aid;                              // 视频的专辑ID，点播视频被加入到节目单时的专辑ID，如果加入节目单之后又发生了变更，则不更新
@property (nonatomic, strong) NSString<Optional> *category;                         // 视频分类，参考《视频类型词典》文档说明，节目类型为点播时非空
@property (nonatomic, strong) LTLiveMultiProgramModel<Optional> *multiProgram;

- (NSString *)formatPlayTime;                                                   // 格式化播放开始时间
- (int)programPlayType;                                                         // 当前节目播放类型： 1：回看 2： 直播 3：预告
- (BillStatus)getChannelBillStatusWithChannelCode:(NSString *)channelCode;
@end


#pragma mark - 频道节目单增量
@interface LTLiveChannelRowsModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *count;                                // 返回节目条数
@property (nonatomic, strong) NSArray<LTLiveChannelDetailModel, Optional> *programs;    // 为节目数组。按播放时间排序。
@end

@interface LTLiveChannelMenuModel : JSONModel
@property (nonatomic, strong) LTLiveChannelRowsModel<Optional> *rows;
@end

#pragma mark - 视频详细信息
@interface LTLiveVideoDetailModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *id;                           // 视频ID
@property (nonatomic, strong) NSString<Optional> *pid;                          // 专辑ID
@property (nonatomic, strong) NSString<Optional> *nameCn;                       // 返回节目条数
@property (nonatomic, strong) NSString<Optional> *videoPic;                     // 视视频类型
@property (nonatomic, strong) NSString<Optional> *category;                     // 视频分类
@property (nonatomic, strong) NSString<Optional> *__description;                // 视频描述
@property (nonatomic, strong) NSString<Optional> *duration;                     // 时长
@property (nonatomic, strong) NSString<Optional> *releaseDate;                  // 发行日期
@end

@interface LTLiveVideoModel : JSONModel
@property (nonatomic, strong) LTLiveVideoDetailModel<Optional> *data;
@end

#pragma mark - 频道当前播放节目信息2
@protocol LTLiveChannelBillBlockModel @end

@interface LTLiveChannelBillResultModel: JSONModel
@property (nonatomic, strong) NSMutableArray<LTLiveChannelBillBlockModel, Optional> *rows;
@end

@interface LTLiveChannelBillModel: JSONModel
@property (nonatomic, strong) LTLiveChannelBillResultModel<Optional> *result;

- (id)getProgramWithChannelId:(NSString *)channelId; // 根据频道id 获取相应节目model

@end

@interface LTLiveChannelBillViewPicModel: JSONModel
@property (nonatomic, strong) NSString<Optional> * pic_400_300;

@end
@interface LTLiveChannelBillDetailModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *id;                           // 节目ID
@property (nonatomic, strong) NSString<Optional> *title;                        // 节目名称
@property (nonatomic, strong) NSString<Optional> *playTime;                     // 节目开始播放时间，格式：yyyy-MM-dd HH:mm:ss
@property (nonatomic, strong) NSString<Optional> *endTime;                      // 节目播放结束时间，格式：yyyy-MM-dd HH:mm:ss，注意：结束时间并不一定就是实际节目的结束时间，有可能被下一个节目覆盖掉。
@property (nonatomic, strong) NSString<Optional> *duration;                     // 节目时长(单位秒)
@property (nonatomic, strong) LTLiveChannelBillViewPicModel<Optional> *viewPic;                      // 节目缩略图地址
@property (nonatomic, strong) NSString<Optional> *programType;                  // 节目类型(1 直播 0 点播)

@end

@interface LTLiveChannelBillBlockModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *channelId;
@property (nonatomic, strong) LTLiveChannelBillDetailModel<Optional> *cur;
@property (nonatomic, strong) LTLiveChannelBillDetailModel<Optional> *next;
@property (nonatomic, strong) LTLiveChannelBillDetailModel<Optional> *pre;
@end


#pragma mark - 乐视频道列表
@interface LTLiveChannelResultModel: JSONModel
@property (nonatomic, strong) NSMutableArray<LTLiveChannelListDetailModel, Optional> *rows;
@end

@interface LTLiveChannelListModel: JSONModel
@property (nonatomic, strong) LTLiveChannelResultModel<Optional> *result;
@property (nonatomic, strong) NSNumber<Optional> *isCacheBack;
- (void)sortWithNumericKeys;
- (BOOL)isHasChannel:(NSString *)channelId;
- (id)getChannelListDetailModel:(NSString *)channelId;
- (id)getChannelBillBlockModel:(NSString *)channelId;
@end

@interface LTLiveChannelStreamsModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *streamId;                     // 流ID
@property (nonatomic, strong) NSString<Optional> *streamName;                   // 流名称
@property (nonatomic, strong) NSString<Optional> *rateType;                     // 码率类型，参考《码率类型词典编码》
@property (nonatomic, strong) NSString<Optional> *streamUrl;                    // 对该客户端有效的直播流播放地址
- (LiveCodeType)getLiveTypeFromCode:(LTLiveChannelStreamsModel *)liveStream;
@end

@interface LTLiveChannelLogoModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *pic1;
@property (nonatomic, strong) NSString<Optional> *pic2;
@end

@interface LTLiveChannelListDetailModel: JSONModel
@property (nonatomic, strong) NSString<Optional> *channelId;                    // 频道ID
@property (nonatomic, strong) NSString<Optional> *numericKeys;                  // 频道LOGO数字键
@property (nonatomic, strong) NSString<Optional> *channelEname;                 // 频道英文名称
@property (nonatomic, strong) NSString<Optional> *channelName;                  // 乐视频道中文名称
@property (nonatomic, strong) NSString<Optional> *cibnChannelName;              // 国广频道中文名称，TV端产品应该显示这个名称
@property (nonatomic, strong) NSString<Optional> *beginTime;                    // 频道启用开始时间
@property (nonatomic, strong) NSString<Optional> *endTime;                      // 频道启用结束时间，为空表示频道一直启用
@property (nonatomic, strong) NSString<Optional> *channelClass;                 // 频道分类，参考词典《频道分类编码》
@property (nonatomic, strong) NSString<Optional> *belongBrand;                  // 频道所属品牌，参考《频道所属品牌信息获取接口》
@property (nonatomic, strong) NSString<Optional> *demandId;                     // 需求方，参考词典《频道需求方编码》
@property (nonatomic, strong) NSString<Optional> *sourceId;                     // 信号源，参考词典《信号源编码》
@property (nonatomic, strong) NSString<Optional> *is3D;                         // 是否为3D频道（1是 0否）
@property (nonatomic, strong) NSString<Optional> *is4K;                         // 是否为4K频道（0 否 1 4K 2 伪4K）
@property (nonatomic, strong) NSString<Optional> *ch;                           // 渠道号
@property (nonatomic, strong) NSString<Optional> *orderNo;                      // 序号，客户端排序用
@property (nonatomic, strong) NSString<Optional> *isRecommend;                  // 是否推荐 （1 是 0 否）
@property (nonatomic, strong) NSString<Optional> *pcWatermarkUrl;               // PC端台标地址
@property (nonatomic, strong) NSString<Optional> *watermarkUrl;                 // TV端台标地址
@property (nonatomic, strong) NSString<Optional> *cibnWatermarkUrl;             // 国广TV端台标地址
@property (nonatomic, strong) NSMutableArray<LTLiveChannelStreamsModel, Optional> *streams;                       // 频道流信息
@property (nonatomic, strong) NSString<Optional> *poster;                       //loading海报图
@property (nonatomic, strong) NSString<Optional> *postH3;                       // 频道LOGO竖图 120*90
@property (nonatomic, strong) NSString<Optional> *postOrigin;                   // 频道LOGO原图
@property (nonatomic, strong) NSString<Optional> *postS1;                       // 频道LOGO横图150*200
@property (nonatomic, strong) NSString<Optional> *postS2;                       // 频道LOGO横图120*160
@property (nonatomic, strong) NSString<Optional> *postS3;                       // 频道LOGO横图96*128
@property (nonatomic, strong) NSString<Optional> *postS4;                       // 频道LOGO横图150*150
@property (nonatomic, strong) NSString<Optional> *postS5;                       // 频道LOGO横图30*30

@property (nonatomic, strong) NSString<Optional> *isFovo;                       // 是否收藏
@property (nonatomic, strong) NSString<Optional> *lastRecordTime;               // 最后更新时间
@property (nonatomic, strong) NSString<Optional> *isCurrentPlay;                // 是否是当前播放的频道，0:不是，1:是 （非接口传回）

@property (nonatomic, strong) NSString<Optional> *type;                         //  1、轮播台，2、卫视台，3、体育直播厅，4、娱乐直播厅，5、音乐直播厅，6、其它直播厅
@property (nonatomic, strong) LTLiveChannelBillBlockModel<Optional> *billBlockModel;

@property (nonatomic, strong) LTLiveChannelLogoModel<Optional> *defaultLogo;    // 卫视台logo
@property (nonatomic, strong) LTLiveChannelBillDetailModel<Optional> *cur;      // app首页接口用到的当前播放

@property (nonatomic, strong) NSString<Optional> *signal;                       // 卫视台区分咪咕 咪咕为9

@property (nonatomic, strong) NSString<Optional> *pic3;                         // 卫视台展示图片

@property (nonatomic, strong) NSString<Optional> *liveref;                      // 轮播台来源
@property (nonatomic, strong) NSString<Optional> *isPay;
@property (nonatomic, copy) NSString<Optional> *tagName;
@property (nonatomic, copy) NSString<Optional> *programName;     //


- (LiveCodeType)getDefaultLiveType;

- (LiveCodeType)getLiveTypeFromCode:(LTLiveChannelStreamsModel *)liveStream;

- (LTLiveChannelStreamsModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType;

- (BOOL)isValidCodeType:(LiveCodeType)liveCodeType;


- (LTLiveChannelStreamsModel *)getLiveChannelStream:(NSString *)streamCode;

- (NSArray *)getAllValidCodeTypes;

@end

#pragma mark - 频道流信息
@protocol LTLiveChannelFlowDetailModel @end

@interface LTLiveChannelFlowModel: JSONModel
@property (nonatomic, strong) NSArray<LTLiveChannelStreamsModel, Optional> *rows;
- (LTLiveChannelStreamsModel *)getDefaultLiveStreamModel;
- (LTLiveChannelStreamsModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType;
@end

#pragma mark - 卫视台新加咪咕台
@interface LTLiveChannelMIGUFlowModel : JSONModel
@property (nonatomic, strong) NSArray<Optional> *streamUrl;
- (NSString *)streamUrlAtArray;
@end

#pragma mark - 频道第三方品牌信息
@protocol LTLiveChannelBrandDetailModel @end

@interface LTLiveChannelBrandModel: JSONModel
@property (nonatomic, strong) NSArray<LTLiveChannelBrandDetailModel, Optional> *rows;
@end

@interface LTLiveChannelBrandDetailModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *id;                      // 品牌ID
@property (nonatomic, strong) NSString<Optional> *brandName;               // 品牌名称
@property (nonatomic, strong) NSString<Optional> *brandDesc;               // 品牌说明
@property (nonatomic, strong) NSString<Optional> *brandIcon;               // 品牌Logo地址
@property (nonatomic, strong) NSString<Optional> *isPreInstall;            // 是否预安装
@end

@interface LTLiveOnlineNumModel : JSONModel
@property (nonatomic, strong) NSNumber<Optional> *number;             //直播在线人数
@property (nonatomic, strong) NSNumber<Optional> *total_number;       //直播累计在线人数
@end

/**
 *  直播边看边买
 */
@interface LTLiveAddProductModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *message;      //信息
//@property (nonatomic, strong) NSArray<Optional>  *result;
@property (nonatomic, strong) NSString<Optional> *status;       //状态
@end

@protocol LTLiveShoppingCartListModel
@end

@interface LTLiveShoppingCartModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *message;      //信息
@property (nonatomic, strong) NSDictionary <Optional> *result;  //商品数量
@property (nonatomic, strong) NSString<Optional> *status;       //状态
@property (nonatomic, strong) NSArray<LTLiveShoppingCartListModel,Optional> *burcart_info;  //购物车商品列表
- (NSInteger)getShoppingCartCount;
@end

//购物车内商品列表
@interface LTLiveShoppingCartListModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *id;             //数据流水号
@property (nonatomic, copy) NSString<Optional> *pid;            //商品sku编码
@property (nonatomic, copy) NSString<Optional> *spuId;          //商品spuid
@property (nonatomic, copy) NSString<Optional> *pcount;         //购买数量
@property (nonatomic, copy) NSString<Optional> *pname;          //商品名称
@property (nonatomic, copy) NSString<Optional> *ptype;          //购物车类别1：单品 3：套装 4、加价购 8、电影票 9、衍生品
@property (nonatomic, copy) NSString<Optional> *price;          //商品最终销售价格
@property (nonatomic, copy) NSString<Optional> *imgStr;         //商品图片
@property (nonatomic, copy) NSString<Optional> *itemStatus;     //购物车选中状态
@property (nonatomic, copy) NSString<Optional> *showStatus;     //商品状态1有货、2无货、3失效
@property (nonatomic, copy) NSString<Optional> *createAt;       //创建时间
@end


//690我的预约-直播
@interface LTLiveListOrderModel : JSONModel
@property (nonatomic, strong) LTLiveRoomDetailModel<Optional> *data;
@property (nonatomic, strong) NSNumber *channel_type;
@end

@class LTLiveOrderChannelDetailModel;
@interface LTLiveListOrderChannelModel : JSONModel
@property (nonatomic, strong) LTLiveOrderChannelDetailModel<Optional> *data;
@property (nonatomic, strong) NSNumber *channel_type;
@end

//690我的预约-卫视台
@interface LTLiveOrderChannelDetailModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *channelName;     //
@property (nonatomic, copy) NSString<Optional> *code;     //
@property (nonatomic, copy) NSString<Optional> *live_id;     //
@property (nonatomic, copy) NSString<Optional> *endTime;     //
@property (nonatomic, copy) NSString<Optional> *play_time;     //
@property (nonatomic, strong) NSNumber *channel_type;
@property (nonatomic, copy) NSString<Optional> *beginTime;     //
@property (nonatomic, copy) NSString<Optional> *programName;     //
@property (nonatomic, copy) NSString<Optional> *tagName;     //
@end


/**
 *  直播合并接口model (目前仅限于 除 轮播台、卫视台、咪咕台 适用)
 */
@interface LTLivePlayModel : JSONModel
@property (nonatomic,strong) LTLiveRoomDetailModel<Optional> *liveInfo;
@property (nonatomic,strong) NSArray<LTLiveChannelStreamsModel, Optional> *streamInfo;
@property (nonatomic,strong) LivePackages<Optional> *payInfo;
@property (nonatomic,strong) LiveAuthority<Optional> *validateInfo;
@property (nonatomic,strong) LTLiveChannelListDetailModel<Optional> *channelInfo;
@property (nonatomic, strong) LTLiveChannelBillBlockModel<Optional> *playBill;
- (LTLiveChannelStreamsModel *)getDefaultLiveStreamModel;
- (LTLiveChannelStreamsModel *)getUrlFromLiveType:(VideoCodeType)liveCodeType;
- (NSArray *)validLiveCodeTypeArray;
@end

/**/
@protocol LTLiveCarouseModel
@end
@interface LTLiveCarouseModel : JSONModel
@property (nonatomic, strong) NSString *code; // 轮播台类型id
@property (nonatomic, strong) NSString *name; // 轮播台类型名称
@end
/*
 * 轮播台类型列表接口Model
 */
@interface LTLiveCarouseCategoryModel : JSONModel
@property (nonatomic, strong) NSArray <LTLiveCarouseModel,Optional>*rows;
@end


/*
 cms获取推荐模块数据
 */
/*
@interface LTCmsReccomendModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *cmsid;//CMS中的记录唯一标示id
@property (nonatomic, strong) NSString<Optional> *vid;//视频id
@property (nonatomic, strong) NSString<Optional> *pid;//专辑id
@property (nonatomic, strong) NSString<Optional> *nameCn;//视频名称
@property (nonatomic, strong) NSString<Optional> *subTitle;//副标题
@property (nonatomic, strong) NSString<Optional> *cid;//频道id
@property (nonatomic, strong) NSString<Optional> *type;//影片来源标示：1-专辑,3-视频,4-专题
@property (nonatomic, strong) NSString<Optional> *at;//点击展示方式：1、半屏播放器2、全屏无专辑单视频3、全屏播放直播流4、外跳web5、内嵌webview6、进入精品推荐页7、频道入口引导（点击进入对应的频道）11、会员频道12、收银台界面13、联通流量包套餐订购页14、我的积分19、登录界面
@property (nonatomic, strong) NSString<Optional> *tag;//盖章标签
@property (nonatomic, strong) NSString<Optional> *mobilePic;//图片
@property (nonatomic, strong) NSString<Optional> *padPic;

@property (nonatomic, strong) NSString<Optional> *duration;//时长（秒）
@property (nonatomic, strong) NSString<Optional> *singer;//歌手
@property (nonatomic, strong) NSString<Optional> *is_rec;
@property (nonatomic, strong) NSString<Optional> *videoType;
@property (nonatomic, strong) NSString<Optional> *extends_extendRange;
@property (nonatomic, strong) NSString<Optional> *extends_extendCid;
@property (nonatomic, strong) NSString<Optional> *extends_extendPid;
@property (nonatomic, strong) NSString<Optional> *streamCode;//直播编号
@property (nonatomic, strong) NSString<Optional> *webUrl;//外跳web地址
@property (nonatomic, strong) NSString<Optional> *webViewUrl;//内嵌webview地址
@property (nonatomic, strong) NSString<Optional> *streamUrl;//直播流地址
@property (nonatomic, strong) NSString<Optional> *tm;//过期时间戳
@property (nonatomic, strong) NSString<Optional> *pay;//1:需要支付;0:免费（只有专辑有此属性）
@property (nonatomic, strong) NSString<Optional> *isEnd;//是否完结 1:完结;0未完结
@property (nonatomic, strong) NSString<Optional> *nowEpisodes;//跟播的当前总集数
@property (nonatomic, strong) NSString<Optional> *zid;//专题id

@property (nonatomic, strong) NSString<Optional> *homeImgUrl;//娱乐、音乐显示的图片
@property (nonatomic, strong) NSString<Optional> *guestImgUrl;

@end
 */
