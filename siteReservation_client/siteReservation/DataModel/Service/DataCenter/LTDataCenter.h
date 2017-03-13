//
//  LTDataCenter.h
//  LetvIphoneClient
//
//  Created by zhaochunyan on 13-9-2.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDataModelCommDef.h>
#import <LetvMobileDataModel/LTStatisticInfo.h>
#import <LetvMobileDataModel/LTDataModelEngine.h>


@interface LTDataCenter : NSObject

+ (NSString *)urlFlagForStatisticsType:(LTDataCenterStatisticsType)statisticsType;


+ (NSString *)getActionCodeByActionCategory:(LTDCActionPropertyCategory)apCategory;

// 启动
+ (void)login;
// 退出
+ (void)logout;
// 登录到用户中心，需要上报一次login日志
+ (void)loginToUserCenter;
+ (void)logout:(LTDCPageID)pageID;
// 动作
+ (void)addActionData:(LTDCCodeActionModule)module
            subModule:(int)subModule
                  act:(LTDCCodeActionType)act
              extInfo:(NSArray *)arrExt;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
#warning ZhangQigang: 解耦, 暂时改成 Integer
#if 0
// 非贴片广告动作
+ (void)addADActionData:(LTDCCodeActionModule)module
                    act:(LTDCCodeActionType)act
                 adType:(MovieAdvertiseType)advertiseType
                   adID:(NSString *)adid
                extInfo:(NSArray *)arrExt
               adSystem:(NSString *)adSystem;
               
// 广告播放
+(void)addAdvertiseData:(MovieAdvertiseType)advertiseType
           adFormatType:(AD_TYPE)adFormtType
                   adID:(NSString *)adID
               adAction:(NSString *)action
           adClickTimes:(NSString *)clickTime
                adUtime:(NSString *)utime
             adDuration:(NSString *)adduration
             adPlayTime:(NSString *)playTimeLen
                  adcid:(NSString *)cid
                  adPid:(NSString *)pid
                  adVid:(NSString *)vid
               VideoLen:(NSString *)videoLen
               adSystem:(NSString *)adSystem;
#else
// 非贴片广告动作
+ (void)addADActionData:(LTDCCodeActionModule)module
                    act:(LTDCCodeActionType)act
                 adType:(NSInteger)advertiseType
                   adID:(NSString *)adid
                extInfo:(NSArray *)arrExt
               adSystem:(NSString *)adSystem;
               
// 广告播放
+(void)addAdvertiseData:(NSInteger)advertiseType
           adFormatType:(NSInteger)adFormtType
                   adID:(NSString *)adID
               adAction:(NSString *)action
           adClickTimes:(NSString *)clickTime
                adUtime:(NSString *)utime
             adDuration:(NSString *)adduration
             adPlayTime:(NSString *)playTimeLen
                  adcid:(NSString *)cid
                  adPid:(NSString *)pid
                  adVid:(NSString *)vid
               VideoLen:(NSString *)videoLen
               adSystem:(NSString *)adSystem;
#endif
#endif
// 错误上报
+(void)addErrorDataWithAid:(NSString *)album_id
                       vid:(NSString *)vid
                     title:(NSString *)title
                 videoType:(NSString *)videoType
               originalUrl:(NSString *)original_url
                     ddUrl:(NSString *)dd_url
                    action:(ERROR_ACTION)act
                error_type:(ERROR_TYPE)errorType;


// 2.0动作统计
+ (void)addStatisticChannelWallFilter:(LTStatisticInfo *)statisticInfo;
+ (void)addStatisticForAction:(LTStatisticInfo *)statisticInfo;
+ (void)addStatistic:(LTStatisticInfo *)statisticInfo;

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;

+(void)addAction:(LTDCActionPropertyCategory)apc
        position:(NSInteger)wz
            name:(NSString *)name
           name1:(NSString *)name1
             cid:(NewMovieCid)cid
      currentUrl:(NSString *)cur_url
       isSuccess:(BOOL)ar;

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
           pageID:(LTDCPageID)pageID
       currentUrl:(NSString *)cur_url
            acode:(LTDCActionCode)acode
        isSuccess:(BOOL)ar;


/**
     动作统计
 */
+ (void)addActionOnly:(LTDCActionCode)acode
             position:(NSInteger)wzPosition
                 name:(NSString *)name
                   fl:(NSString *)fl
               pageid:(NSString *)pageid
        statisticInfo:(LTStatisticInfo *)statisticInfo;

        
#ifdef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
           pageID:(LTDCPageID)pageID
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;
#endif

//iphone v6.7 搜索运营词上报 sName
+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
            sname:(NSString *)sname
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
           pageID:(LTDCPageID)pageID
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
           pageID:(LTDCPageID)pageID
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;
        
#ifdef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
           pageID:(LTDCPageID)pageID
           scidID:(NSString *)scidID
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;
#endif

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
           pageID:(LTDCPageID)pageID
           scidID:(NSString *)scidID
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;

#ifdef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
              lid:(NSString *)lid
           pageID:(LTDCPageID)pageID
           scidID:(NSString *)scidID
           fragId:(NSString *)fragId
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar;
#endif

+ (void)addActionData:(LTDCActionCode)acode
       actionProperty:(NSDictionary *)ap
         actionResult:(BOOL)ar
                  cid:(NSString *)cid
                  pid:(NSString *)pid
                  vid:(NSString *)vid
                  zid:(NSString *)zid
           currentUrl:(NSString *)cur_url
                 reid:(NSString *)reid  //推荐反馈的随机数
                 area:(NSString *)area  //页面区域标识
               bucket:(NSString *)bucket //推荐的算法策略
                 rank:(NSString *)rank;  //点击视频在推荐区域的排序;

+ (void)addActionData:(LTDCActionCode)acode
       actionProperty:(NSDictionary *)ap
         actionResult:(BOOL)ar
                  cid:(NSString *)cid
                  pid:(NSString *)pid
                  vid:(NSString *)vid
                  zid:(NSString *)zid
           currentUrl:(NSString *)cur_url
                 reid:(NSString *)reid  //推荐反馈的随机数
                 area:(NSString *)area  //页面区域标识
               bucket:(NSString *)bucket //推荐的算法策略
                 rank:(NSString *)rank  //点击视频在推荐区域的排序;
                  lid:(NSString *)lid;  //直播id


+ (void)addActionData:(LTDCActionCode)acode
       actionProperty:(NSDictionary *)ap
         actionResult:(BOOL)ar
                  cid:(NSString *)cid
                  pid:(NSString *)pid
                  vid:(NSString *)vid
                  zid:(NSString *)zid
           currentUrl:(NSString *)cur_url
                 reid:(NSString *)reid  //推荐反馈的随机数
                 area:(NSString *)area  //页面区域标识
               bucket:(NSString *)bucket //推荐的算法策略
                 rank:(NSString *)rank  //点击视频在推荐区域的排序;
                  lid:(NSString *)lid   //直播id
             playUUid:(NSString *)playuuid;


// 推送统计
+ (void)addPushAction:(NSString *)msgid
          andPushType:(NSString *)pushType
       andmessageType:(NSString *)messagetype
               andPid:(NSString *)pid
               andVid:(NSString *)vid
               andZid:(NSString *)zid
        andCurrentUrl:(NSString *)currentUrl
    andOtherParameter:(NSDictionary *)otherParameter;

#ifdef LT_MERGE_FROM_IPAD_CLIENT
// 推送统计
+ (void)addPushAction:(NSString *)msgid
          andPushType:(NSString *)pushType
       andmessageType:(NSString *)messagetype
               andPid:(NSString *)pid
               andVid:(NSString *)vid
               andZid:(NSString *)zid
               andLid:(NSString *)lid
        andCurrentUrl:(NSString *)currentUrl
    andOtherParameter:(NSDictionary *)otherParameter;
#endif

+ (void)addPushAction:(NSString *)msgid
          andPushType:(NSString *)pushType
       andmessageType:(NSString *)messagetype
               andPid:(NSString *)pid
               andVid:(NSString *)vid
               andZid:(NSString *)zid
               andLid:(NSString *)lid
        andCurrentUrl:(NSString *)currentUrl
    andOtherParameter:(NSDictionary *)otherParameter;

+ (void)addPushAction:(NSString *)msgid;

// 播放错误上报
+ (void)addPlayFailedData:(LTDCPlayFailedCode)playFailedCode
                      cid:(NewMovieCid)cid
                      pid:(NSString *)pid
                      vid:(NSString *)vid
               currentUrl:(NSString *)cur_url;
+ (void)addLivePlayFailedData:(LTDCPlayFailedCode)playFailedCode
                   currentUrl:(NSString *)cur_url;

// 下载速度上报
+ (void)addDownloadSpeedData:(CGFloat)downloadSpeed
    andDownloadInterruptType:(LTDCDownloadInterruptType)interruptType;
#ifdef LT_IPAD_CLIENT
//ç¼å²æ¶é´ä¸æ¥
+ (void)addBufferTimeWithAdtime:(CGFloat)adTime
                    andPlayType:(PLAYING_TYPE)playType
            andGetVideoListTime:(CGFloat)videoListTime
            andGetVideoFileTime:(CGFloat)videoFileTime
              andGetCanPlayTime:(CGFloat)getPayInfoTime    //ä¸è¾æ¯å¦å¯çæ¥å£æ¶é´
             andGetAlbumPayInfo:(CGFloat)getAlbumPayInfoTime //ä¸è¾ä»è´¹ä¿¡æ¯æ¥å£æ¶é¿
                andGetAdPinTime:(CGFloat)getAdPinTime //å¹¿åæ¼æ¥æ¶é¿
              andGetPlayUrlTime:(CGFloat)getPlayUrlTime //æ­£å¼æ­æ¾å°åæ¶é¿
           andGetAdDispatchTime:(CGFloat)getAdDispatchTime
             andGetAdTheoryTime:(CGFloat)getAdTheoryTime
           andGetAdPlayLoadTime:(CGFloat)getAdPlayLoadTime
             andGetPlayLoadTime:(CGFloat)getplayLoadTime
            andGetADPreLoadTime:(CGFloat)getAdPreLoadTime
        andGetPlayerPreLoadTime:(CGFloat)getPlayerPreLoadTime
               andAllBufferTime:(CGFloat)allBufTime
                         andCid:(NSString *)cid
                         andPid:(NSString *)pid
                         andVid:(NSString *)vid
                         andZid:(NSString *)zid
                     andPlayUrl:(NSString *)playUrl
                       andAdUrl:(NSString *)adUrl;

+ (void)addBufferTimeWithAdtime:(CGFloat)adTime
                    andPlayType:(PLAYING_TYPE)playType
            andGetVideoListTime:(CGFloat)videoListTime
            andGetVideoFileTime:(CGFloat)videoFileTime
              andGetCanPlayTime:(CGFloat)getPayInfoTime    //ä¸è¾æ¯å¦å¯çæ¥å£æ¶é´
             andGetAlbumPayInfo:(CGFloat)getAlbumPayInfoTime //ä¸è¾ä»è´¹ä¿¡æ¯æ¥å£æ¶é¿
                andGetAdPinTime:(CGFloat)getAdPinTime //å¹¿åæ¼æ¥æ¶é¿
              andGetPlayUrlTime:(CGFloat)getPlayUrlTime //æ­£å¼æ­æ¾å°åæ¶é¿
           andGetAdDispatchTime:(CGFloat)getAdDispatchTime
             andGetAdTheoryTime:(CGFloat)getAdTheoryTime
           andGetAdPlayLoadTime:(CGFloat)getAdPlayLoadTime
             andGetPlayLoadTime:(CGFloat)getplayLoadTime
            andGetADPreLoadTime:(CGFloat)getAdPreLoadTime
        andGetPlayerPreLoadTime:(CGFloat)getPlayerPreLoadTime
               andAllBufferTime:(CGFloat)allBufTime
                         andCid:(NSString *)cid
                         andPid:(NSString *)pid
                         andVid:(NSString *)vid
                         andZid:(NSString *)zid
                     andPlayUrl:(NSString *)playUrl
                       andAdUrl:(NSString *)adUrl
                         pageID:(LTDCPageID)pageID
                       playUUid:(NSString *)playUUID;
#else


//缓冲时间上报
+ (void)addBufferTimeWithAdtime:(CGFloat)adTime
                    andPlayType:(PLAYING_TYPE)playType
            andGetVideoListTime:(CGFloat)videoListTime
            andGetVideoFileTime:(CGFloat)videoFileTime
              andGetCanPlayTime:(CGFloat)getPayInfoTime    //专辑是否可看接口时间
             andGetAlbumPayInfo:(CGFloat)getAlbumPayInfoTime //专辑付费信息接口时长
                andGetAdPinTime:(CGFloat)getAdPinTime //广告拼接时长
              andGetPlayUrlTime:(CGFloat)getPlayUrlTime //正式播放地址时长
           andGetAdDispatchTime:(CGFloat)getAdDispatchTime
             andGetAdTheoryTime:(CGFloat)getAdTheoryTime
           andGetAdPlayLoadTime:(CGFloat)getAdPlayLoadTime
             andGetPlayLoadTime:(CGFloat)getplayLoadTime
            andGetADPreLoadTime:(CGFloat)getAdPreLoadTime
        andGetPlayerPreLoadTime:(CGFloat)getPlayerPreLoadTime
               andAllBufferTime:(CGFloat)allBufTime
                         andCid:(NSString *)cid
                         andPid:(NSString *)pid
                         andVid:(NSString *)vid
                         andZid:(NSString *)zid
                     andPlayUrl:(NSString *)playUrl
                       andAdUrl:(NSString *)adUrl
            isPlayingLocalCache:(BOOL)isPlayingLocalCache;

+ (void)addBufferTimeWithAdtime:(CGFloat)adTime
                    andPlayType:(PLAYING_TYPE)playType
            andGetVideoListTime:(CGFloat)videoListTime
            andGetVideoFileTime:(CGFloat)videoFileTime
              andGetCanPlayTime:(CGFloat)getPayInfoTime    //专辑是否可看接口时间
             andGetAlbumPayInfo:(CGFloat)getAlbumPayInfoTime //专辑付费信息接口时长
                andGetAdPinTime:(CGFloat)getAdPinTime //广告拼接时长
              andGetPlayUrlTime:(CGFloat)getPlayUrlTime //正式播放地址时长
           andGetAdDispatchTime:(CGFloat)getAdDispatchTime
             andGetAdTheoryTime:(CGFloat)getAdTheoryTime
           andGetAdPlayLoadTime:(CGFloat)getAdPlayLoadTime
             andGetPlayLoadTime:(CGFloat)getplayLoadTime
            andGetADPreLoadTime:(CGFloat)getAdPreLoadTime
        andGetPlayerPreLoadTime:(CGFloat)getPlayerPreLoadTime
               andAllBufferTime:(CGFloat)allBufTime
                         andCid:(NSString *)cid
                         andPid:(NSString *)pid
                         andVid:(NSString *)vid
                         andZid:(NSString *)zid
                     andPlayUrl:(NSString *)playUrl
                       andAdUrl:(NSString *)adUrl
                         pageID:(LTDCPageID)pageID
                       playUUid:(NSString *)playUUID
            isPlayingLocalCache:(BOOL)isPlayingLocalCache
                   isUnicomFree:(BOOL)isUnicomFree;
#endif
// 2.0播放
+ (void)addLivingPlay:(LTDCPlayStage)playStage
             andError:(LTDCCodePlayExitError)error
          andUsedtime:(NSTimeInterval)usedTime
        andRetryCount:(NSInteger)retry
          andPlayType:(LTDCPlayType)ptype
           andPlayUrl:(NSString *)playUrl
          andProperty:(NSMutableArray *)py
           andStation:(NSString *)st
          andPlayUUID:(NSString *)playUUID
               andCid:(NSString *)cid
               andPid:(NSString *)pid
               andVid:(NSString *)vid
                andCh:(NSString *)ch
              andCode:(NSString *)code
                andLc:(NSString *)lc
               andRef:(NSString *)ref
      andNewParameter:(NSDictionary *)newParameter;

+ (void)addNormalPlay:(LTDCPlayStage)playStage
             andError:(LTDCCodePlayExitError)error
          andUsedtime:(NSTimeInterval)usedTime
               andCid:(NSString *)cid
               andPid:(NSString *)pid
               andVid:(NSString *)vid
          andVideoLen:(NSTimeInterval)vlen
        andRetryCount:(NSInteger)retry
          andPlayType:(LTDCPlayType)ptype
           andPlayUrl:(NSString *)playUrl
          andProperty:(NSMutableArray *)py
          andPlayUUID:(NSString *)playUUID
          andCodeRate:(VideoCodeType)videoCode
       andOfflineFlag:(BOOL)isPlayOffline
          andPlayFlag:(BOOL)isNeedPay
               andRef:(NSString *)ref
               andZid:(NSString *)zid
        andIsAutoPlay:(BOOL)isAutoPlay;

+ (void)addNormalPlay:(LTDCPlayStage)playStage
             andError:(LTDCCodePlayExitError)error
          andUsedtime:(NSTimeInterval)usedTime
               andCid:(NSString *)cid
               andPid:(NSString *)pid
               andVid:(NSString *)vid
          andVideoLen:(NSTimeInterval)vlen
        andRetryCount:(NSInteger)retry
          andPlayType:(LTDCPlayType)ptype
           andPlayUrl:(NSString *)playUrl
          andProperty:(NSMutableArray *)py
          andPlayUUID:(NSString *)playUUID
          andCodeRate:(VideoCodeType)videoCode
       andOfflineFlag:(BOOL)isPlayOffline
          andPlayFlag:(BOOL)isNeedPay
               andRef:(NSString *)ref
               andZid:(NSString *)zid
        andIsAutoPlay:(BOOL)isAutoPlay
      andNewParameter:(NSDictionary *)newParameter;  // 今后新添加的参数从该处添加

#ifdef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addNormalPlay:(LTDCPlayStage)playStage
             andError:(LTDCCodePlayExitError)error
          andUsedtime:(NSTimeInterval)usedTime
               andCid:(NSString *)cid
               andPid:(NSString *)pid
               andVid:(NSString *)vid
          andVideoLen:(NSTimeInterval)vlen
        andRetryCount:(NSInteger)retry
           andPlayUrl:(NSString *)playUrl
          andProperty:(NSMutableArray *)py
          andPlayUUID:(NSString *)playUUID
          andCodeRate:(VideoCodeType)videoCode
       andOfflineFlag:(BOOL)isPlayOffline
          andPlayFlag:(BOOL)isNeedPay
               andRef:(NSString *)ref
               andZid:(NSString *)zid
        andIsAutoPlay:(BOOL)isAutoPlay;
#endif

//曝光统计
+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid;
+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid
                   wz:(NSInteger)wz;
+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid
                   wz:(NSInteger)wz
            andPageID:(LTDCPageID)pageID;

//启动时长
+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime;

//启动指标上报
+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype
  andIsFromBackground:(BOOL)isFromBackground;

// 外部调起上报
+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype
  andIsFromBackground:(BOOL)isFromBackground
               andRef:(NSString *)ref;

#ifdef LT_MERGE_FROM_IPAD_CLIENT
//启动指标上报
+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype;
#endif
+ (void)addAcode:(LTDCActionCode)acode
           utime:(CGFloat)utime
          pageID:(LTDCPageID)pageID;

//下载统计
+(void)addDownloadStatictisWithVid:(NSString *)vid
                          withName:(NSString *)name;


//写错误日志文件
+(BOOL)writeToErrorLogFile:(NSString *)logContent;
+(BOOL)writeToErrorLogFile:(NSString *)errDescription logContent:(NSString *)logContent fileName:(char *)fileName line:(NSInteger)line;
+ (void)errorLog:(NSString *)format;
+ (void)infoLog:(NSString *)format;
//上传错误文件
+ (void)uploadErrorLogFileWithPhoneNum:(NSString *)phoneNum
                   withFeedBackContent:(NSString *)feedBackContent
                     completionHandler:(LTDataCompletionBlock)completionBlock
                          errorHandler:(LTDataErrorBlock)errorBlock;

/**
 *  产品反馈界面带上传图片
 *
 *  @param phoneNum        手机号码
 *  @param feedBackContent 反馈内容
 *  @param imagesArray     图片数组(NSData)
 *  @param completionBlock 成功回调
 *  @param errorBlock      失败回调
 */
+ (void)uploadErrorLogFileFromFeedbackWithPhoneNum:(NSString *)phoneNum
                               withFeedBackContent:(NSString *)feedBackContent
                                   withImagesArray:(NSArray *)imagesArray
                                 completionHandler:(LTDataCompletionBlock)completionBlock
                                      errorHandler:(LTDataErrorBlock)errorBlock;
+(void)uploadScreenShotText:(NSString *)text
                      image:(UIImage *)image
                        xid:(int)vid
                        pid:(int)pid
                        cid:(int)cid
                      htime:(NSString *)shotTime
                      completionHandler:(LTDataCompletionBlock)completionBlock
                      errorHandler:(LTDataErrorBlock)errorBlock;
//query统计
+ (void)addQueryDataWithSid:(NSString *)sid
                 searchType:(NSInteger)ty
              videoPosition:(NSInteger)pos
           clickedVideoInfo:(NSString *)clk
               queryContent:(NSString *)q
                       page:(NSInteger)p
                     Result:(NSString *)rt;

//  query ref
+ (NSString *)queryRefWithPageid:(LTDCPageID)pageid
                              fl:(LTDCActionPropertyCategory)fl
                              wz:(NSInteger)wz;

+ (NSString *)queryRefWithInfo:(LTStatisticInfo *)info;

+ (NSString *)queryPlayerRefWithPageid:(NSString *)pageid fl:(NSString *)fl wz:(NSInteger)wz;


//error统计
+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid;
+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid
      andDownloadUrl:(NSString *)DownloadUrl
       andRequestUrl:(NSString *)RequestUrl
          andPlayUrl:(NSString *)PlayUrl
           andPlayVt:(VideoCodeType)videoCode
       andLivingCode:(NSString *)code;

+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid
      andDownloadUrl:(NSString *)DownloadUrl
          andPlayUrl:(NSString *)PlayUrl
           andPlayVt:(VideoCodeType)videoCode
       andLivingCode:(NSString *)code
       andRequestUrl:(NSString *)requestUrl
       andStatusCode:(NSString *)statusCode
            andUtime:(NSString *)utime
         andPlayUUid:(NSString *)playuuid;
+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid
      andDownloadUrl:(NSString *)DownloadUrl
          andPlayUrl:(NSString *)PlayUrl
           andPlayVt:(VideoCodeType)videoCode
       andLivingCode:(NSString *)code
       andRequestUrl:(NSString *)requestUrl
       andStatusCode:(NSString *)statusCode
            andUtime:(NSString *)utime
         andPlayUUid:(NSString *)playuuid
      andisPlayError:(BOOL) isPlayError;
+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid
      andDownloadUrl:(NSString *)DownloadUrl
          andPlayUrl:(NSString *)PlayUrl
           andPlayVt:(VideoCodeType)videoCode
       andLivingCode:(NSString *)code
       andRequestUrl:(NSString *)requestUrl
       andStatusCode:(NSString *)statusCode
            andUtime:(NSString *)utime
         andPlayUUid:(NSString *)playuuid
      andisPlayError:(BOOL) isPlayError
     andExtendFields:(NSDictionary *)extendDic;

// crash数量上报
+ (void)addCrashDataWithCount:(NSInteger)crashCount;

#pragma mark Env
+ (void)addEnvData;

+ (NSString *)generateRandomValue;
+ (NSString *)getLiveCode:(NSString *)code;
+ (LTDCPageID)getPageID:(NSString *)chnnelCid;
+ (LTDCPageID)getPageIDByLiveType:(LTLiveListType)listType;
+(LTDCPageID)getPageIDFromRef:(NSString *)ref;
+ (void)setCrashlyticsUserInfo;
@end

@interface LTDataCenter (ThirdPartyDataStatistics)

+ (void)addBasicStatics;

@end

@interface LTLiveStatisticInfo : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *stramID;
@property(nonatomic,strong)NSString *streamCode;
@property(nonatomic,strong)NSString *ch;
@property(nonatomic,strong)NSString *lc;
@property(nonatomic,strong)NSString *level;
@property(nonatomic,strong)NSString *level1;
@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *ref;
@property(nonatomic,strong)NSString *liveString;
@property(nonatomic,strong)NSString *streamName;
@property(nonatomic,strong)NSString *livingPay;//直播是否为付费 1：付费，0：非付费
@property(nonatomic,strong)NSString *isPre;//直播是否为试看 1：试看，0：非试看

@end

