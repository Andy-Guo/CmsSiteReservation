//
//  LTHalfPlayerPageCardModel.h
//  LeTVMobileDataModel
//
//  Created by bob on 15/8/26.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>
#import <LetvMobileDataModel/LTPlayerIntroModel.h>
#import <LetvMobileDataModel/VideoListModel.h>
#import <LetvMobileDataModel/MovieDetailModel.h>
#import <LetvMobileDataModel/VarityShowInfoModel.h>
#import <LetvMobileDataModel/RecommendModel.h>
#import <LetvMobileDataModel/LTSubjectDetailModel.h>
#import <LetvMobileDataModel/LTPlayHalfScreenCardXMLParse.h>
#import <LetvMobileDataModel/VarityShowVideoListModel.h>
#import <LetvMobileDataModel/LTCommentListModel.h>

#ifdef LT_IPAD_CLIENT

// ç®ä»
@interface LTPageCardPlayerInfoModel : JSONModel
@property (nonatomic, strong) LTPlayerIntroModel<Optional> *desc;
@end

// èµãè¸©æ°
@interface LTPageCardZanCaiCountModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *up;
@property (nonatomic, strong) NSString<Optional> *down;
@end

// èµãè¸©
@interface LTPageCardZanCaiModel : JSONModel
@property (nonatomic, strong) LTPageCardZanCaiCountModel<Optional> *count;
@end

//å§éåé¡µæ¨¡åç±»ï¼éæå¡å¨æ å°ç±»ï¼
@interface LTEpisodeRegionItem : NSObject<NSCoding>

@property (nonatomic, strong) NSString * regionName;//ååºåå­
@property (nonatomic, assign) NSInteger totalNum;//æ»éæ°
@property (nonatomic, assign) NSInteger pageIndex;//å½åååºpageé¡ºåºindex
@property (nonatomic, assign) NSInteger currPageIndex;//å½åæ¾ç¤ºçåé¡µ
@property (nonatomic, assign) MovieShowStyle style;//å§éæ ·å¼
@property (nonatomic, strong) VideoListModel *videoList;//å§élist
@property (nonatomic, strong) VideoListModel *previousVideoList;//é¢åçlist
@property (nonatomic, assign) BOOL isLastItem;//æ¯å¦æ¯æåä¸é¡µ
@property (nonatomic, strong) NSString * year;//ææ°ç±»çå§éå½ååé¡µæå¨å¹´ä»½
@property (nonatomic, strong) NSString * currentYear;//ææ°ç±»çå§éå½åå§élistæå¨å¹´ä»½
@property (nonatomic, strong) MovieDetailModel * movieDetail;//å½åä¸è¾è¯¦æ

@property (nonatomic, copy) NSArray *totalYears; //å
-(BOOL)isContainPlayingVid:(NSString*)playingVid;

@end

// è§é¢åè¡¨
@interface  LTPageCardVideoListModel : JSONModel
@property (nonatomic, assign) MovieShowStyle style;// 1:ä¹å®«æ ¼å§é  2:é¿åè¡¨å§é  3:æææ¾ç¤º
@property (nonatomic, strong) NSDictionary<Optional> * videoList;
@property (nonatomic, strong) NSArray<Optional> * fragments;
@property (nonatomic, readonly) VideoListModel<Ignore>* fragmentsVideoList;//ææ°çæ®µ
@property (nonatomic, readonly) VideoListModel<Ignore> * commonVideoList;//æ®éå§é
@property (nonatomic, readonly) VarityShowVideoListModel<Ignore> * varityShowModel;//æææ°å§é

@end

// å¨è¾¹è§é¢
@interface LTPageCardOuterVideoListModel : JSONModel
@property (nonatomic, strong) VideoListModel<Optional> *otherVideos;
@end

// æææ¨è
@interface LTPageCardStar : JSONModel
@property(strong,nonatomic)NSString<Optional>*leId;
@property(strong,nonatomic)NSString<Optional>*leName;
@property(strong,nonatomic)NSString<Optional>*postS1_11_300_300;
@property(strong,nonatomic)NSString<Optional>*professional;
@property(strong,nonatomic)NSString<Optional>*tDescription;
@end

@protocol LTPageCardStarVideoModel @end
@interface LTPageCardStarVideoModel : JSONModel
@property(strong,nonatomic)NSString<Optional>*type;
@property(strong,nonatomic)NSString<Optional>*pid;//aidè½¬æpid
@property(strong,nonatomic)NSString<Optional>*cid;
@property(strong,nonatomic)NSString<Optional>*vid;
@property(strong,nonatomic)NSString<Optional>*name;
@property(strong,nonatomic)NSString<Optional>*category;
@property(strong,nonatomic)NSString<Optional>*categoryName;
- (NSString *)getVideoDisplayName; //è·åçµè§å§å±ç¤ºåå­
@end

@protocol LTPageCardStarItem @end
@interface LTPageCardStarItem : JSONModel
@property(strong,nonatomic)LTPageCardStar<Optional>* star;
@property(strong,nonatomic)NSArray<Optional,LTPageCardStarVideoModel> * videoList; // éæºå¤ç åªä¿çä¸¤ä¸ªç»æ
@property(strong,nonatomic)NSString<Ignore> *focusStatus; //æ¯å¦å

- (BOOL)isFocused;
- (void)setFocus:(BOOL)focustStatus;
@end

@interface LTPageCardStarRecommendModel : JSONModel
@property (nonatomic, strong) NSArray<Optional,LTPageCardStarItem>*starRecommend;
@property (nonatomic, strong) NSString<Ignore>*synchroFocusStateFlag;

- (NSString *)getAllStarId; //è·åææææçidï¼ç¨äºè·åæ¯å¦å·²å

- (void)synchroFocusState:(NSDictionary *)focusDic;//å¤çææå

- (BOOL)isSynchronized;//æ¯å¦åæ­¥è¿å

- (void)setNoNeedSynchro;//è®¾ç½®ä¸éè¦åæ­¥
- (void)setNeedSynchro;//éè¦åæ­¥
@end

//æ¨èï¼ç¸å

@interface LTPageCardRelateModel : JSONModel
@property (nonatomic, strong) NSMutableArray<MovieDetailModel, Optional> *relateAlbums;
@property (nonatomic, strong) NSMutableArray<RecommendItem, Optional> *recData;

- (NSInteger)indexOfItemWithVid:(NSString *)vid;

- (RecommendItem *)itemWithVid:(NSString *)vid;

- (RecommendItem *)nextValidSingleVideoRecommendItemAfterItemWithVid:(NSString *)vid;
@end


//çä½ åæ¬¢
@interface LTPageCardYourLikeModel : JSONModel
@property (nonatomic, strong) NSArray<RecommendItem,Optional> *  list;
@end


//å®æ´çï¼æ­£çæ¨èï¼
@interface LTPageCardRecommendModel : JSONModel
@property (nonatomic, strong) NSArray<MovieDetailModel,Optional> *  recAlbumList;
@end

//åå£°é³ä¹
@protocol LTPageCardMusicOriginalElemModel
@end
@interface LTPageCardMusicOriginalElemModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *vid;
@property (nonatomic, strong) NSString<Optional> *nameCn;
@property (nonatomic, strong) NSString<Optional> *singerName;
@property (nonatomic, strong) NSString<Optional> *songType;
@end

// é³ä¹åå£°
@interface LTPageCardMusicOriginalModel : JSONModel
@property (nonatomic, strong) NSArray<LTPageCardMusicOriginalElemModel, Optional> *audioInfo;
@end

//ç»¼èºé¢éç¸å

@interface LTPageCardRelatePostiveModel : JSONModel

@property(strong,nonatomic)VideoListModel<Optional,VideoModel>*relateVideoList;
@end


//æ¸¸ææ¨å¹¿
@interface LTPageCardCMSGameSpredModel : JSONModel
/**
 *  åªåæ°ç»ä¸­ç¬¬ä¸ä¸ª
 */
@property (nonatomic, strong) NSArray<Optional,BlockContent> *cmsRecommendGameList;
@end


//æ¨å¹¿
@interface LTPageCardCMSSpredModel : JSONModel
/**
 *  åªåæ°ç»ä¸­ç¬¬ä¸ä¸ª
 */
@property (nonatomic, strong) NSArray<Optional,BlockContent> *cmsRecomandList;
@end

//è¿è¥
@interface LTPageCardCMSItem : JSONModel
@property (nonatomic, strong) NSArray<BlockContent,Optional> *list;
@property (nonatomic, strong) NSString<Optional> *blockname;
@end

@protocol LTPageCardCMSItem <NSObject>
@end

@interface LTPageCardCMSOperateModel : JSONModel
/**
 *  è§£æç¨ç
 */
@property (nonatomic, strong) NSArray<Optional> *cmsOperateList;
/**
 *  æ°æ®æº
 */
@property (nonatomic, readonly)NSMutableArray<Ignore,LTPageCardCMSItem>*cmsItems;

@end


/**
 *  ä¸é¢æ°æ®
 */

//ä¸é¢ç®ä»
@interface LTPageCardIntroModel : JSONModel

@property (strong, nonatomic) NSString<Optional>* name;         // string	ä¸é¢åç§°;
@property (strong, nonatomic) NSString<Optional>* desc;         // string	ç®ä»
@property (strong, nonatomic) NSString<Optional>* pubName;      // string	ä¸è¾ç±»å
@property (assign, nonatomic) LTSubjectType type;               // string	1ãä¸è¾ï¼3ãè§é¢
@property (strong, nonatomic) NSString<Optional>* tag;          // string	å¯æ é¢
@property (strong, nonatomic) NSString<Optional>* ctime;        // json	æ¶é´
@property (strong, nonatomic) NSString<Optional>* cid;          // string	é¢éid

@end

@interface LTPageCardSubjectModel : JSONModel
/**
 *  ç®ä»
 */
@property (strong ,nonatomic) LTPageCardIntroModel<Optional> * desc;
/**
 *  ä¸é¢ä¸è¾åè¡¨
 */
@property (strong, nonatomic) NSMutableArray<MovieDetailModel,ConvertOnDemand,Optional>* albumList;
/**
 *  ä¸é¢è§é¢åè¡¨
 */
@property (nonatomic, strong) NSDictionary<Optional> * videoList;
@property (nonatomic, assign) MovieShowStyle style;//å§éæ ·å¼
@property (nonatomic, readonly) VideoListModel<Ignore> * commonVideoList;//æ®éå§é
@property (nonatomic, readonly) VarityShowVideoListModel<Ignore> * varityShowModel;//æææ°å§é

/**
 *  æpidæ¥è¯¢index
 *
 *  @param pid ä¸è¾id
 *
 *  @return
 */
- (NSInteger)indexOfSubjectAlbumWithPid:(NSString*)pid;

/**
 *  æpidè¿ååæ¥ä¸è¾è¯¦æ
 
 *
 *  @param pid ä¸è¾id
 *
 *  @return
 */
- (MovieDetailModel *)subjectAlbumWithPid:(NSString *)pid;

/**
 *  åæ¥ä¸ä¸ä¸ªå¯ä»¥æ­æ¾çä¸è¾
 *
 *  @param pid ä¸è¾id
 *
 *  @return
 */
- (MovieDetailModel *)nextValidSubjectAlbumWithPid:(NSString *)pid;

/**
 *  åæ¥ç¬¬ä¸ä¸ªå¯ä»¥æ­æ¾çä¸è¾
 *
 *  @param pid ä¸è¾id
 *
 *  @return
 */
- (MovieDetailModel *)firstValidSubjectAlbumWithPid:(NSString *)pid;

/**
 *  ævidåæ¥è§é¢index
 *
 *  @param vid è§é¢id
 *
 *  @return
 */
- (NSInteger)indexOfSubjectVideoWithVid:(NSString*)vid;

/**
 *  ævidåæ¥è§é¢ä¿¡æ¯
 *
 *  @param vid è§é¢id
 *
 *  @return
 */
- (VideoModel *)subjectVideoWithVid:(NSString *)vid;

/**
 *  ä¸ä¸ä¸ªå¯ä»¥æ­æ¾çvideo
 *
 *  @param vid è§é¢id
 *
 *  @return
 */
- (VideoModel *)nextValidSubjectVideoWithVid:(NSString *)vid;

/**
 *  ç¬¬ä¸ä¸ªå¯ä»¥æ­æ¾çvideo
 *
 *  @param vid è§é¢id
 *
 *  @return
 */
- (VideoModel *)firstValidSubjectVideoWithVid:(NSString *)vid;

@end

/*
 * çº¢å
 æ°æ®
 */
@interface LTPageCardRedPackageInfoModel : JSONModel

@property(strong,nonatomic)NSString<Optional>* mobilePic;   //çº¢å

@property(strong,nonatomic)NSString<Optional>* title;    //çº¢å

@property(strong,nonatomic)NSString<Optional>* shorDesc;    //çº¢å
@property(strong,nonatomic)NSString<Optional>* url;         //çº¢å

@property(strong,nonatomic)NSString<Optional>* skipUrl;     //åäº«æååçæ¥çurl
@property(strong,nonatomic)NSString<Optional>* activeID;    //çº¢å
@property(strong,nonatomic)NSString<Optional>* banner;      //çº¢å

@property(strong,nonatomic)NSString<Optional>* subtitle;     //çº¢å

@property(strong,nonatomic)NSString<Optional>* limitNum;
@property(strong,nonatomic)NSString<Optional>* isVip;
@property(strong,nonatomic)NSString<Optional>* leftButton;
@property(strong,nonatomic)NSString<Optional>* rightButton;
@property(strong,nonatomic)NSString<Optional>* shareTitle;  // åäº«ææ¡æ é¢
@property(strong,nonatomic)NSString<Optional>* shareDesc;    // åäº«ææ¡å

@property(strong,nonatomic)NSString<Optional>* sharePic;  // åäº«ææ¡å¾ç
@end

@interface LTPageCardRedPackageModel : JSONModel

@property(strong,nonatomic)NSString<Optional> * code;//1-æçº¢å

@property(strong,nonatomic)LTPageCardRedPackageInfoModel<Optional> * packageInfo;
@end



@class LTCommentListModel;
@interface LTHalfPlayerPageCardModel : JSONModel

@property (nonatomic, strong) VideoModel<Optional> * videoInfo;
@property (nonatomic, strong) MovieDetailModel<Optional> * albumInfo;
@property (nonatomic, strong) LTPageCardPlayerInfoModel<Optional> *intro;
@property (nonatomic, strong) LTPageCardZanCaiModel<Optional> *zanCai;
@property (nonatomic, strong) LTPageCardVideoListModel<Optional> *videoList;
@property (nonatomic, strong) LTPageCardOuterVideoListModel<Optional> *outerVideoList;
@property (nonatomic, strong) LTPageCardStarRecommendModel<Optional> *starRecommend;
@property (nonatomic, strong) LTPageCardRelateModel<Optional> *relate;
@property (nonatomic, strong) LTPageCardRecommendModel<Optional> *recommend;
@property (nonatomic, strong) LTPageCardMusicOriginalModel<Optional> *musicOriginal;
@property (nonatomic, strong) LTPageCardRelatePostiveModel<Optional> *otherVideoRelate;
@property (nonatomic, strong) LTPageCardCMSOperateModel<Optional> *cmsOperate;
@property (nonatomic, strong) LTPageCardCMSSpredModel<Optional> *cmsRecommend;
@property (nonatomic, strong) LTPageCardCMSGameSpredModel<Optional>*cmsRecommendGame;
@property (nonatomic, strong) LTPageCardSubjectModel<Optional> * ztList;
@property (nonatomic, strong) LTPageCardRedPackageModel<Optional> * redPackage;
@property (nonatomic, strong) LTPageCardYourLikeModel<Optional> *yourLike;
@property (nonatomic, strong) NSArray<Ignore> * captureList;
@property (nonatomic, strong) NSDictionary<Optional> *cidInfo;//åªäºé¢éä¼ææ¬éåå§éè¯è®º


/**
 *  æ¯å¦ä¸ºæ­£ç/æ ç®
 *
 *  @return
 */
-(BOOL)isPostiveVideo;

/**
 *  è·åæ­æ¾åè¡¨æ°æ®æ¥æºç±»å
 *
 *  @return
 */
-(LTPlayListDataType)getPlayListDataType;

/**
 *  è·åå§écardæ´æ°ææ¡
 *
 *  @param isHalf æ¯å¦æ¯åå±è·åææ¡
 *
 *  @return
 */
-(NSString*)getEpsoideCardSubTitleDisplay:(BOOL)isHalf;

/**
 *  è·åå
 ¨å±å§éæé®æ é¢åå­
 *
 *  @return
 */
- (NSString *)getFullScreenTitleName;

/**
 *  è·åå§écard style æ®éå§é/ä¸é¢å§é
 *
 *  @return
 */
-(MovieShowStyle)getEpisodeCardStyle;

/**
 *  è·åå§élist æ®éå§é/ä¸é¢å§é
 *
 *  @return
 */
-(VideoListModel*)getEpisodeVideoList;

/**
 *  è·åææ°ç±»æ°æ®æ¨¡å
 *
 *  @return
 */
-(VarityShowVideoListModel*)getVarityShowVideoListModel;

/**
 *  è·åå§éåé¡µæ¨¡å æ®éå§é/ä¸é¢å§é
 *
 *  @param videoList      æ®éå§élist
 *  @param varityShowInfo æææ°å§élist
 *  @param movieShowStyle å§éæ ·å¼
 *
 *  @return
 */
-(NSArray*)getEpisodeRegionItemArrayWithVideoList:(VideoListModel *)videoList withVarityShowVideoList:(VarityShowVideoListModel *)varityShowInfo withStyle:(MovieShowStyle)movieShowStyle;

/**
 *  å¦ææ¯çµå½±é¢éæ­£çæ¨¡æ¿ï¼åå¹¶å¨è¾¹è§é¢æ°æ®å°å§éåè¡¨videoListä¸­
 *
 *  @param videoListModel åå§videoList
 *
 *  @return æ°çvideoList
 *
 *  @discu  è¿åçæ°çvideoListå¯è½ååå§çä¸æ ·ï¼å¦æä¸ç¬¦åæ¡ä»¶ï¼çµå½±é¢é + æ­£ç
 */
-(VideoListModel*)combineOuterVideoLisToVideoList:(VideoListModel*)videoListModel;
@end




#else

// 简介
@interface LTPageCardPlayerInfoModel : JSONModel
@property (nonatomic, strong) LTPlayerIntroModel<Optional> *desc;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;

@end

// 赞、踩数
@interface LTPageCardZanCaiCountModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *up;
@property (nonatomic, strong) NSString<Optional> *down;
@end

// 赞、踩
@interface LTPageCardZanCaiModel : JSONModel
@property (nonatomic, strong) LTPageCardZanCaiCountModel<Optional> *count;
@end

//剧集分页模型类（非服务器映射类）
@interface LTEpisodeRegionItem : NSObject<NSCoding>

@property (nonatomic, strong) NSString * regionName;//分区名字
@property (nonatomic, assign) NSInteger totalNum;//总集数
@property (nonatomic, assign) NSInteger pageIndex;//当前分区page顺序index
@property (nonatomic, assign) NSInteger currPageIndex;//当前显示的分页
@property (nonatomic, assign) MovieShowStyle style;//剧集样式
@property (nonatomic, strong) VideoListModel *videoList;//剧集list
@property (nonatomic, strong) VideoListModel *previousVideoList;//预告片list
@property (nonatomic, assign) BOOL isLastItem;//是否是最后一页
@property (nonatomic, strong) NSString * year;//期数类的剧集当前分页所在年份
@property (nonatomic, strong) NSString * currentYear;//期数类的剧集当前剧集list所在年份
@property (nonatomic, strong) MovieDetailModel * movieDetail;//当前专辑详情
@property (nonatomic, copy) NSArray *totalYears; //全量期数年数
-(BOOL)isContainPlayingVid:(NSString*)playingVid;

@end

// 视频列表
@interface  LTPageCardVideoListModel : JSONModel
@property (nonatomic, assign) MovieShowStyle style;// 1:九宫格剧集  2:长列表剧集  3:按月显示
@property (nonatomic, strong) NSDictionary<Optional> * videoList;
@property (nonatomic, strong) NSDictionary<Optional> * fragments;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@property (nonatomic, readonly) VideoListModel<Ignore>* fragmentsVideoList;//期数片段
@property (nonatomic, readonly) VideoListModel<Ignore> * commonVideoList;//普通剧集
@property (nonatomic, readonly) VarityShowVideoListModel<Ignore> * varityShowModel;//按期数剧集
@end

// 周边视频
@interface LTPageCardOuterVideoListModel : JSONModel
@property (nonatomic, strong) VideoListModel<Optional> *otherVideos;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@end

// 明星推荐
@interface LTPageCardStar : JSONModel
@property(strong,nonatomic)NSString<Optional>*leId;
@property(strong,nonatomic)NSString<Optional>*leName;
@property(strong,nonatomic)NSString<Optional>*postS1_11_300_300;
@property(strong,nonatomic)NSString<Optional>*professional;
@property(strong,nonatomic)NSString<Optional>*tDescription;
@end

@protocol LTPageCardStarVideoModel @end
@interface LTPageCardStarVideoModel : JSONModel
@property(strong,nonatomic)NSString<Optional>*type;
@property(strong,nonatomic)NSString<Optional>*pid;//aid转成pid
@property(strong,nonatomic)NSString<Optional>*cid;
@property(strong,nonatomic)NSString<Optional>*vid;
@property(strong,nonatomic)NSString<Optional>*name;
@property(strong,nonatomic)NSString<Optional>*category;
@property(strong,nonatomic)NSString<Optional>*categoryName;
- (NSString *)getVideoDisplayName; //获取电视剧展示名字
@end

@protocol LTPageCardStarItem @end
@interface LTPageCardStarItem : JSONModel
@property(strong,nonatomic)LTPageCardStar<Optional>* star;
@property(strong,nonatomic)NSArray<Optional,LTPageCardStarVideoModel> * videoList; // 随机处理 只保留两个结果
@property(strong,nonatomic)NSString<Ignore> *focusStatus; //是否关注 值为"1"时表示已关注
- (BOOL)isFocused;
- (void)setFocus:(BOOL)focustStatus;
@end

@interface LTPageCardStarRecommendModel : JSONModel
@property (nonatomic, strong) NSArray<Optional,LTPageCardStarItem>*starRecommend;
@property (nonatomic, strong) NSString<Ignore>*synchroFocusStateFlag;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;

- (NSString *)getAllStarId; //获取所有明星的id，用于获取是否已关注
- (void)synchroFocusState:(NSDictionary *)focusDic;//处理明星关注状态
- (BOOL)isSynchronized;//是否同步过关注状态
- (void)setNoNeedSynchro;//设置不需要同步
- (void)setNeedSynchro;//需要同步
@end

//推荐（相关系列+推荐）
@interface LTPageCardRelateModel : JSONModel
@property (nonatomic, strong) NSMutableArray<MovieDetailModel, Optional> *relateAlbums;
@property (nonatomic, strong) NSMutableArray<RecommendItem, Optional> *recData;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;

- (NSInteger)indexOfItemWithVid:(NSString *)vid;

- (RecommendItem *)itemWithVid:(NSString *)vid;

- (RecommendItem *)nextValidSingleVideoRecommendItemAfterItemWithVid:(NSString *)vid;
@end


//猜你喜欢
@interface LTPageCardYourLikeModel : JSONModel
@property (nonatomic, strong) NSArray<RecommendItem,Optional> *  list;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@end


//完整版（正片推荐）
@interface LTPageCardRecommendModel : JSONModel
@property (nonatomic, strong) NSArray<MovieDetailModel,Optional> *  recAlbumList;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@end

//原声音乐
@protocol LTPageCardMusicOriginalElemModel
@end
@interface LTPageCardMusicOriginalElemModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *vid;
@property (nonatomic, strong) NSString<Optional> *nameCn;
@property (nonatomic, strong) NSString<Optional> *singerName;
@property (nonatomic, strong) NSString<Optional> *songType;
@end

// 音乐原声
@interface LTPageCardMusicOriginalModel : JSONModel
@property (nonatomic, strong) NSArray<LTPageCardMusicOriginalElemModel, Optional> *audioInfo;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@end

//综艺频道相关正片
@interface LTPageCardRelatePostiveModel : JSONModel

@property(strong,nonatomic)VideoListModel<Optional,VideoModel>*relateVideoList;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@end


//游戏推广
@interface LTPageCardCMSGameSpredModel : JSONModel
/**
 *  只取数组中第一个
 */
@property (nonatomic, strong) NSArray<Optional,BlockContent> *cmsRecommendGameList;
@end


//推广
@interface LTPageCardCMSSpredModel : JSONModel
/**
 *  只取数组中第一个
 */
@property (nonatomic, strong) NSArray<Optional,BlockContent> *cmsRecomandList;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@end

//运营
@interface LTPageCardCMSItem : JSONModel
@property (nonatomic, strong) NSArray<BlockContent,Optional> *list;
@property (nonatomic, strong) NSString<Optional> *blockname;
@end

@protocol LTPageCardCMSItem <NSObject>
@end

@interface LTPageCardCMSOperateModel : JSONModel
/**
 *  解析用的
 */
@property (nonatomic, strong) NSArray<Optional> *cmsOperateList;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
/**
 *  数据源
 */
@property (nonatomic, readonly)NSMutableArray<Ignore,LTPageCardCMSItem>*cmsItems;

@end


/**
 *  专题数据
 */

//专题简介
@interface LTPageCardIntroModel : JSONModel

@property (strong, nonatomic) NSString<Optional>* name;         // string	专题名称;
@property (strong, nonatomic) NSString<Optional>* desc;         // string	简介
@property (strong, nonatomic) NSString<Optional>* pubName;      // string	专辑类型
@property (assign, nonatomic) LTSubjectType type;               // string	1、专辑，3、视频
@property (strong, nonatomic) NSString<Optional>* tag;          // string	副标题
@property (strong, nonatomic) NSString<Optional>* ctime;        // json	时间
@property (strong, nonatomic) NSString<Optional>* cid;          // string	频道id
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;

@end

@interface LTPageCardAlbumListModel : JSONModel
/**
 *  专题专辑列表
 */
@property (strong, nonatomic) NSArray<MovieDetailModel,ConvertOnDemand,Optional>* data;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@end

@interface LTPageCardSubjectModel : JSONModel
/**
 *  简介
 */
@property (strong ,nonatomic) LTPageCardIntroModel<Optional> * desc;
/**
 *  专题专辑列表
 */
@property (strong, nonatomic) LTPageCardAlbumListModel<Optional>* albumList;
/**
 *  专题视频列表
 */
@property (nonatomic, strong) NSDictionary<Optional> * videoList;
@property (nonatomic, assign) MovieShowStyle style;//剧集样式
@property (nonatomic, readonly) VideoListModel<Ignore> * commonVideoList;//普通剧集
@property (nonatomic, readonly) VarityShowVideoListModel<Ignore> * varityShowModel;//按期数剧集
// 辅助属性存储cell高度
@property (nonatomic, strong) NSNumber<Ignore> *introCellHeight;

/**
 *  按pid查询index
 *
 *  @param pid 专辑id
 *
 *  @return
 */
- (NSInteger)indexOfSubjectAlbumWithPid:(NSString*)pid;

/**
 *  按pid返回反查专辑详情
 *
 *  @param pid 专辑id
 *
 *  @return
 */
- (MovieDetailModel *)subjectAlbumWithPid:(NSString *)pid;

/**
 *  反查下一个可以播放的专辑
 *
 *  @param pid 专辑id
 *
 *  @return
 */
- (MovieDetailModel *)nextValidSubjectAlbumWithPid:(NSString *)pid;

/**
 *  反查第一个可以播放的专辑
 *
 *  @param pid 专辑id
 *
 *  @return
 */
- (MovieDetailModel *)firstValidSubjectAlbumWithPid:(NSString *)pid;

/**
 *  按vid反查视频index
 *
 *  @param vid 视频id
 *
 *  @return
 */
- (NSInteger)indexOfSubjectVideoWithVid:(NSString*)vid;

/**
 *  按vid反查视频信息
 *
 *  @param vid 视频id
 *
 *  @return
 */
- (VideoModel *)subjectVideoWithVid:(NSString *)vid;

/**
 *  下一个可以播放的video
 *
 *  @param vid 视频id
 *
 *  @return
 */
- (VideoModel *)nextValidSubjectVideoWithVid:(NSString *)vid;

/**
 *  第一个可以播放的video
 *
 *  @param vid 视频id
 *
 *  @return
 */
- (VideoModel *)firstValidSubjectVideoWithVid:(NSString *)vid;

@end

/*
 * 红包数据
 */
@interface LTPageCardRedPackageInfoModel : JSONModel

@property(strong,nonatomic)NSString<Optional>* mobilePic;   //红包弹窗图片
@property(strong,nonatomic)NSString<Optional>* title;    //红包弹窗文案标题
@property(strong,nonatomic)NSString<Optional>* shorDesc;    //红包弹窗文案内容
@property(strong,nonatomic)NSString<Optional>* url;         //红包分享地址
@property(strong,nonatomic)NSString<Optional>* skipUrl;     //分享成功后的查看url
@property(strong,nonatomic)NSString<Optional>* activeID;    //红包活动id
@property(strong,nonatomic)NSString<Optional>* banner;      //红包banner图片
@property(strong,nonatomic)NSString<Optional>* subtitle;     //红包banner文案
@property(strong,nonatomic)NSString<Optional>* limitNum;
@property(strong,nonatomic)NSString<Optional>* isVip;
@property(strong,nonatomic)NSString<Optional>* leftButton;
@property(strong,nonatomic)NSString<Optional>* rightButton;
@property(strong,nonatomic)NSString<Optional>* shareTitle;  // 分享文案标题
@property(strong,nonatomic)NSString<Optional>* shareDesc;    // 分享文案内容
@property(strong,nonatomic)NSString<Optional>* sharePic;  // 分享文案图片
@end

@interface LTPageCardRedPackageModel : JSONModel

@property(strong,nonatomic)NSString<Optional> * code;//1-有红包，0-无红包
@property(strong,nonatomic)LTPageCardRedPackageInfoModel<Optional> * packageInfo;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
@end



@class LTCommentListModel;
@interface LTHalfPlayerPageCardModel : JSONModel

@property (nonatomic, strong) VideoModel<Optional> * videoInfo;
@property (nonatomic, strong) MovieDetailModel<Optional> * albumInfo;
@property (nonatomic, strong) LTPageCardPlayerInfoModel<Optional> *intro;  // 简介
//@property (nonatomic, strong) LTPageCardZanCaiModel<Optional> *zanCai; // 6.7被废弃，直接用intro中字段
@property (nonatomic, strong) LTPageCardVideoListModel<Optional> *videoList;  //剧集
@property (nonatomic, strong) LTPageCardOuterVideoListModel<Optional> *outerVideoList; // 周边视频
@property (nonatomic, strong) LTPageCardStarRecommendModel<Optional> *starRecommend;  // 明星推荐
@property (nonatomic, strong) LTPageCardRelateModel<Optional> *relate;  // 推荐
@property (nonatomic, strong) LTPageCardRecommendModel<Optional> *recommend; // 完整版
@property (nonatomic, strong) LTPageCardMusicOriginalModel<Optional> *musicOriginal; // 音乐原声
@property (nonatomic, strong) LTPageCardRelatePostiveModel<Optional> *otherVideoRelate; // 相关正片
@property (nonatomic, strong) LTPageCardCMSOperateModel<Optional> *cmsOperate; // 运营位
//@property (nonatomic, strong) LTPageCardCMSSpredModel<Optional> *cmsRecommend; // 推广位 6.7废弃
//@property (nonatomic, strong) LTPageCardCMSGameSpredModel<Optional>*cmsRecommendGame; //游戏运营位，被废弃
@property (nonatomic, strong) LTPageCardSubjectModel<Optional> * ztList; // 专题列表
@property (nonatomic, strong) LTPageCardRedPackageModel<Optional> * redPackage; // 红包banner
@property (nonatomic, strong) LTPageCardYourLikeModel<Optional> *yourLike; // 猜你喜欢
@property (nonatomic, strong) NSDictionary<Optional> *cidInfo;//哪些频道会有本集和剧集评论
@property (nonatomic, strong) NSString<Optional> *videoSort;  // card顺序
@property (nonatomic, strong) NSString<Optional> *ztListSort; // 专题card顺序
@property (nonatomic, strong) NSArray<Ignore> *captureList;
@property (nonatomic, strong) NSArray<Ignore> *cardList;

/**
 *  是否为正片/栏目
 *
 *  @return
 */
-(BOOL)isPostiveVideo;

/**
 *  获取播放列表数据来源类型
 *
 *  @return
 */
-(LTPlayListDataType)getPlayListDataType;

/**
 *  获取剧集card更新文案
 *
 *  @param isHalf 是否是半屏获取文案
 *
 *  @return
 */
-(NSString*)getEpsoideCardSubTitleDisplay:(BOOL)isHalf;

/**
 *  获取相关正片副标题更新文案
 *
 *  @return 副标题
 */
- (NSString *)getRelatePostiveSubTitleDisplay;

/**
 *  获取全屏剧集按钮标题名字
 *
 *  @return
 */
- (NSString *)getFullScreenTitleName;

/**
 *  获取剧集card style 普通剧集/专题剧集
 *
 *  @return
 */
-(MovieShowStyle)getEpisodeCardStyle;

/**
 *  获取剧集list 普通剧集/专题剧集
 *
 *  @return
 */
-(VideoListModel*)getEpisodeVideoList;

/**
 *  获取期数类数据模型
 *
 *  @return
 */
-(VarityShowVideoListModel*)getVarityShowVideoListModel;

/**
 *  获取剧集分页模型 普通剧集/专题剧集
 *
 *  @param videoList      普通剧集list
 *  @param varityShowInfo 按期数剧集list
 *  @param movieShowStyle 剧集样式
 *
 *  @return
 */
-(NSArray*)getEpisodeRegionItemArrayWithVideoList:(VideoListModel *)videoList withVarityShowVideoList:(VarityShowVideoListModel *)varityShowInfo withStyle:(MovieShowStyle)movieShowStyle;

/**
 *  如果是电影频道正片模板，合并周边视频数据到剧集列表videoList中
 *
 *  @param videoListModel 原始videoList
 *
 *  @return 新的videoList
 *
 *  @discu  返回的新的videoList可能和原始的一样，如果不符合条件：电影频道 + 正片
 */
-(VideoListModel*)combineOuterVideoLisToVideoList:(VideoListModel*)videoListModel;


/**
 更新预告片到videoListModel的videoinfo

 @param videoListModel videoListModel
 */
- (void)updatePerviewListForCurrentUserAndVideoListModel:(VideoListModel *)videoListModel;


/**
 更新预告片到videoListModel的videoinfo

 @param videoListModel 更新的videolist
 @param isPaySuccess 是否是购买会员成功,购买会员完成时，setttingmanager还没更新状态，使用isPaySuccess参数
 */
- (void)updatePerviewListForCurrentUserAndVideoListModel:(VideoListModel *)videoListModel isPaySuccess:(BOOL)isPaySuccess;
@end



#endif
