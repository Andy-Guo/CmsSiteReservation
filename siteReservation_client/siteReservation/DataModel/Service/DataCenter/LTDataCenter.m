//
//  LTDataCenter.m
//  LetvIphoneClient
//
//  Created by zhaochunyan on 13-9-2.
//
//

#import "LTDataCenter.h"
//#import "FileManager.h"
//#import "Flurry.h"
//#import "NSObject+ObjectEmpty.h"
//#import "NSString+HTTPExtensions.h"
#import "NSString+MovieInfo.h"
//#import "NSString+Date.h"
//#import "NSString+MD5.h"
#import "LTUserCenterEngine.h"
#import "LTRequestURLManager.h"
#import "AFAppDotNetAPIClient.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "EncryptHelper.h"
#import <LeTVMobileDataModel/LTDataInfo.h>
//#import "MobClick.h"
//#import "RCTBridgeModule.h"
#import <AdSupport/AdSupport.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#ifdef LT_IPAD_CLIENT


//@interface LTDataCenter()<RCTBridgeModule>
//
//@end

@implementation LTDataCenter

#pragma mark - react methods

//RCT_EXPORT_MODULE(LTDataCenter)
//
//RCT_EXPORT_METHOD(getErrorLogPath:(RCTResponseSenderBlock)callback) {
//    NSString * cachePath = [FileManager appLetvProtectedPath];
//    NSString * errorlogPath = [cachePath stringByAppendingPathComponent:ErrorLogText];
//    callback(@[errorlogPath]);
//}
//
//RCT_EXPORT_METHOD(getCDELogPath:(RCTResponseSenderBlock)callback) {
//    NSString * cachePath = [FileManager appLetvProtectedPath];
//    NSString * cdelogPath = [cachePath stringByAppendingPathComponent:CDELogText];
//    callback(@[cdelogPath]);
//}
//
//RCT_EXPORT_METHOD(writeToErrorLogFile:(NSString *)log) {
//    [[self class] writeToErrorLogFile:log];
//}

+ (NSString *)getTimeString
{
    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval=[currentDate timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%.0f", timeInterval];
}

#pragma mark - comm

+ (NSString *)urlFlagForStatisticsType:(LTDataCenterStatisticsType)statisticsType
{
    switch (statisticsType) {
        case LTDataCenterStatisticsTypeLogin:
        case LTDataCenterStatisticsTypeLogout:
            return LT_URL_DC_LOGIN_FLAG;
        case LTDataCenterStatisticsTypePlay:
            return LT_URL_DC_PLAY_FLAG;
        case LTDataCenterStatisticsTypeAction:
            return LT_URL_DC_ACTION_RT_FLAG;
        case LTDataCenterStatisticsTypeAdPlay:
            return LT_URL_DC_ACTION_AD_PLAY_FLAG;
            
        case LTDataCenterStatisticsTypeKVAction:
            return LT_URL_DC_KV_ACTION_FLAG;
        case LTDataCenterStatisticsTypeKVLogin:
        case LTDataCenterStatisticsTypeKVLogout:
            return LT_URL_DC_KV_LOGIN_FLAG;
        case LTDataCenterStatisticsTypeKVEnv:
            return LT_URL_DC_KV_ENV_FLAG;
        case LTDataCenterStatisticsTypeKVPlay:
            return LT_URL_DC_KV_PLAY_FLAG;
        case LTDataCenterStatisticsTypeKVAd:
            return LT_URL_DC_KV_AD_FLAG;
        case LTDataCenterStatisticsTypeKVQuery:
            return LT_URL_DC_KV_QUERY_FLAG;
        case LTDataCenterStatisticsTypeKVError:
            return LT_URL_DC_KV_ERROR_FLAG;
        default:
            break;
    }
    
    return @"";
}

+ (NSString *)formatContentWithRawData:(NSDictionary *)dictData
                       andRequiredKeys:(NSArray *)requiredKeys
{
    NSMutableArray *arrDataVerified = [NSMutableArray array];
    [dictData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            if ([requiredKeys containsObject:key]) {
                [arrDataVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                            key,
                                            LT_DATA_CENTER_KV_CONNECTOR,
                                            LT_DATA_CENTER_EMPTY_REQUIRED]];
            }
        }
        else{
            NSString *objValue = (NSString *)obj;
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PARAM_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrDataVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }];
    
    return [arrDataVerified componentsJoinedByString:LT_DATA_CENTER_PARAM_SEPARATOR];
}
//根据频道的cid得到pageID
+ (LTDCPageID)getPageID:(NSString *)chnnelCid
{
    if ([NSString isBlankString:chnnelCid]) {
        return LTDCPageIDUnKnown;
    }
    else
    {
        switch ([chnnelCid intValue]) {
            case NewCID_MOVIE:
                return LTDCPageIDMovie;
            case NewCID_TV:
                return LTDCPageIDTV;
            case NewCID_Entertainment:
                return LTDCPageIDEntertainment;
            case NewCID_Sport:
                return LTDCPageIDSport;
            case NewCID_Anime:
                return LTDCPageIDAnimate;
            case NewCID_Music:
                return LTDCPageIDMusic;
            case NewCID_TVProgram:
                return LTDCPageIDVariety;
            case NewCID_Car:
                return LTDCPageIDCar;
            case NewCID_Documentary:
                return LTDCPageIDDocumentary;
                
            case NewCID_Fasion:
                return LTDCPageIDFasion;
            case NewCID_Finacial:
                return LTDCPageIDFinacial;
            case NewCID_Tour:
                return LTDCPageIDTour;
            case NewCID_NBA:
                return LTDCPageIDNBA;
            case Newcid_Funny:
                return LTDCPageIDFunny;
            case NewCID_Kids:
                return LTDCPageIDKids;
            case NewCID_News:
                return LTDCPageIDNews;
            case NewCid_Vip:
                return LTDCPageIDVIP;
            case Newcid_Dolby:
                return LTDCPageIDDolby;
            case Newcid_H265:
                return LTDCPageIDH265;
            case NewCID_NewHome:
                return LTDCPageIDIndex;
            #ifdef LT_MERGE_FROM_IPAD_CLIENT
            case Newcid_AmericanDrama:
                return LTDCPageIDAmericanDrama;
            case Newcid_EPL:
                return LTDCPageIDEPL;
            case Newcid_BroadcastOnly:
                return LTDCPageIDBroadcastOnly;
            #endif
            default:
                return LTDCPageIDUnKnown;
        }
    }
}

+ (LTDCPageID)getPageIDByLiveType:(LTLiveListType)listType
{
    switch (listType) {
        case LTLiveListType_Hot:
            return LTDCPageIDLiveHot;
        case LTLiveListType_LunBo:
            return LTDCPageIDLiveLunbo;
        case LTLiveListType_WeiShi:
            return LTDCPageIDLiveWeishi;
        case LTLiveListType_Sports:
            return LTDCPageIDLiveSport;
        case LTLiveListType_Music:
            return LTDCPageIDLiveMusic;
        case LTLiveListType_Ent:
            return LTDCPageIDLiveEntertainment;
        case LTLiveListType_Brand:
            return LTDCPageIDLiveBrand;
        case LTLiveListType_Game:
            return LTDCPageIDLiveGame;
        case LTLiveListType_Information:
            return LTDCPageIDLiveInformation;
        case LTLiveListType_Finance:
            return LTDCPageIDLiveFinace;
        case LTLiveListType_Other:
            return LTDCPageIDLiveOthers;
        default:
            return LTDCPageIDUnKnown;
    }
}

+ (NSString *)getLiveCode:(NSString *)code
{
    NSDictionary *dictActionCode = @{
                                     @"flv_350"          : @"1",
                                     @"3gp_320X240"      : @"2",
                                     @"flv_enp"          : @"3",
                                     @"chinafilm_350"    : @"4",
                                     @"flv_vip"          : @"8",
                                     @"mp4"              : @"9",
                                     @"flv_live"         : @"10",
                                     @"union_low"        : @"11",
                                     @"union_high"       : @"12",
                                     @"mp4_800"          : @"13",
                                     @"flv_1000"         : @"16",
                                     @"flv_1300"         : @"17",
                                     @"flv_720p"         : @"18",
                                     @"mp4_1080p"        : @"19",
                                     @"flv_1080p6m"      : @"20",
                                     @"mp4_350"          : @"21",
                                     @"mp4_1300"         : @"22",
                                     @"mp4_800_db"       : @"23",
                                     @"mp4_1300_db"      : @"24",
                                     @"mp4_720p_db"      : @"25",
                                     @"mp4_1080p6m_db"   : @"26",
                                     @"flv_yuanhua"      : @"27",
                                     @"mp4_yuanhua"      : @"28",
                                     @"flv_720p_3d"      : @"29",
                                     @"mp4_720p_3d"      : @"30",
                                     @"flv_1080p6m_3d"   : @"31",
                                     @"mp4_1080p6m_3d"   : @"32",
                                     @"flv_1080p_3d"     : @"33",
                                     @"mp4_1080p_3d"     : @"34",
                                     @"flv_1080p3m"      : @"35",
                                     @"flv_4k"           : @"44",
                                     @"h265_flv_800"     : @"47",
                                     @"h265_flv_1300"    : @"48",
                                     @"h265_flv_720p"    : @"49",
                                     @"h265_flv_1080p"   : @"50",
                                     @"mp4_180"          : @"58",
                                    };
    
    id valueForCategory = [dictActionCode objectForKey:code];
    if (nil == valueForCategory) {
        return @"";
    }
    
    NSString *actionCode = (NSString *)valueForCategory;
    
    return actionCode;

}
+ (NSString *)generateRandomValue
{
    return [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000)];
}

+ (NSString *)getActionCodeByActionCategory:(LTDCActionPropertyCategory)apCategory
{
    NSDictionary *dictActionCode = @{
                                     // 首页
                                     @(LTDCActionPropertyCategoryLoginGuide)            :
                                         @"yd01",
                                     @(LTDCActionPropertyCategoryIndexFocus)            : @"11",
                                     @(LTDCActionPropertyCategoryIndexBlock)            : @"12",
                                     @(LTDCActionPropertyCategoryIndexAppexchange)      : @"13",
                                     @(LTDCActionPropertyCategoryIndexBlockPic)         : @"14",
                                     @(LTDCActionPropertyCategoryIndexBlockPlayHistory) : @"1211",
                                     @(LTDCActionPropertyCategoryIndexRecommentPic)      : @"17",
                                     @(LTDCActionPropertyCategoryIndexLive1)      : @"141",
                                     @(LTDCActionPropertyCategoryIndexLive2)      : @"142",
                                     @(LTDCActionPropertyCategoryIndexShow)              : @"19",
                                     @(LTDCActionPropertyCategoryIndexPlayRecordShow)              : @"1c",
                                     @(LTDCActionPropertyCategoryIndexImportRecommend)   : @"18",
                                     @(LTDCActionPropertyCategoryIndexSearch)           : @"1a",
                                     @(LTDCActionPropertyCategoryIndexLetvRecommend)    : @"1b",
                                     @(LTDCActionPropertyCategoryIndexRecordTip)       :@"1c",
                                     @(LTDCActionPropertyCategoryIndexInvitePopView):@"g12",
                                     @(LTDCActionPropertyCategoryIndexVipNotExpireRemindView):@"vp01",
                                     @(LTDCActionPropertyCategoryIndexVipHasExpireRemindView):@"vp02",
                                     @(LTDCActionPropertyCategoryIndexAppRecommend):@"17",
                                     //
                                     @(LTDCActionPropertyCategoryPopWoshiGeShou)        : @"a9",
                                     @(LTDCActionPropertyCategoryIndexChannel)          : @"a10",
                                     @(LTDCActionPropertyCategoryChannelWallEdit)       : @"a11",
                                     @(LTDCActionPropertyCategoryVipTrialInviteView)    : @"g16",
                                     @(LTDCActionPropertyCategoryVIPPromotionView)      : @"vp14",
                                     
                                     // 导航
                                     @(LTDCActionPropertyCategoryNavigationChannel)     : @"21",
                                     @(LTDCActionPropertyCategoryNavigationChannelMore) : @"219",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryNavigationChannelMoreList) : @"210",
                                     @(LTDCActionPropertyCategoryNavigationChart) : @"h81",
                                     #endif
                                     
                                     // 频道页
                                     @(LTDCActionPropertyCategoryChannelPage)           : @"211",
                                     @(LTDCActionPropertyCategoryChannelFocus)          : @"212",
                                     @(LTDCActionPropertyCategoryChannelBlock)          : @"213",
                                     @(LTDCActionPropertyCategoryChannelExchangeButton) : @"120",
                                     @(LTDCActionPropertyCategoryChannelSportHall)      : @"217",
                                     @(LTDCActionPropertyCategoryChannelSport)          : @"l15",
                                     @(LTDCActionPropertyCategoryChannelSubChannel)      : @"216",

                                      @(LTDCActionPropertyCategoryChannelSortViewNew)         : @"ft01",
                                     @(LTDCActionPropertyCategoryChannelManage)         : @"2116",
                                     @(LTDCActionPropertyCategorySportJiJin)            : @"2181",
                                     @(LTDCActionPropertyCategorySportSpecial)          : @"2182",
                                     @(LTDCActionPropertyCategorySportMore)             : @"2183",
                                     @(LTDCActionPropertyCategorySportFlag)             : @"2184",
                                     @(LTDCActionPropertyCategorySportTextLink)         : @"2185",
                                     @(LTDCActionPropertyCategoryChannelWall)           : @"c11",
                                     @(LTDCActionPropertyCategoryChannelSecond)         : @"h11",
                                     @(LTDCActionPropertyCategoryChannelSecondSearch):@"h12",
                                     @(LTDCActionPropertyCategoryChannelSecondFilter)   :@"h13",
                                     @(LTDCActionPropertyCategoryChannelSecondButtonFilter)   :@"h14",
                                     @(LTDCActionPropertyCategoryCustomEdit)            :@"cu01",
                                     // 搜索
                                     @(LTDCActionPropertyCategorySearchRecommendTab)    : @"d12",
                                     @(LTDCActionPropertyCategorySearchRecommendTab1Poster)    : @"d121",
                                     @(LTDCActionPropertyCategorySearchRecommendTab2Poster)    : @"d122",
                                     @(LTDCActionPropertyCategorySearchRecommendTab3Poster)    : @"d123",
                                     @(LTDCActionPropertyCategorySearchRecommendTab4Poster)    : @"d124",
                                     @(LTDCActionPropertyCategorySearchHotword)         : @"52",
                                     
                                     @(LTDCActionPropertyCategorySearchInput)           : @"511",
                                     @(LTDCActionPropertyCategorySearchGoSearch)        : @"d13",
                                     
                                     @(LTDCActionPropertyCategorySearchRelated)         : @"512",
                                     @(LTDCActionPropertyCategorySearchSugest)          : @"d14",
                                     @(LTDCActionPropertyCategorySearchSugestPlayBtn)   : @"d15",
                                     
                                     @(LTDCActionPropertyCategorySearchResult)          : @"513",
                                     @(LTDCActionPropertyCategorySearchGoBack)          : @"d11",
                                     @(LTDCActionPropertyCategorySearchH5ResultGoBack)          : @"d21",
                                     
                                     // TV推广
                                     @(LTDCActionPropertyCategoryTVPromoteSearchresult) : @"66",
                                     @(LTDCActionPropertyCategoryTVPromoteSetting)      : @"712",
                                     @(LTDCActionPropertyCategoryTVPromoteAppexchange)  : @"41",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayer)   : @"94",
                                     
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayerBottomView)
                                         : @"c67",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerWatchingFocus)
                                         : @"c676",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPicturePrecent)
                                         : @"c677",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayerBigTip)
                                         : @"c683",
                                     @(LTDCActionPropertyCategoryPlayerCenterChangeNetWork)
                                         : @"c684",
                                     
                                     @(LTDCActionPropertyCategoryPlayerCenterLookTimeClick)
                                         : @"c686",

                                     
                                     @(LTDCActionPropertyCategoryPlayerCenterPauseDownloadClick): @"c687",
                                     #endif
                                     @(LTDCActionPropertyCategoryPlayerCenterShow) : @"c68",
                                     @(LTDCActionPropertyCategoryPlayerTopView) : @"c65",
                                     @(LTDCActionPropertyCategoryPlayerNumberClick):@"c658",
                                     @(LTDCActionPropertyCategoryPlayer2KClick):@"l675",
                                     @(LTDCActionPropertyCategoryPlayerNoneWifiErrorClick):@"h31",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerLeft)   : @"a13",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerLeftBlock)  : @"a132",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPush)   : @"a16",
                                     @(LTDCActionPropertyCategoryTVPromotePlayer1080P)  : @"a17",
                                     @(LTDCActionPropertyCategoryTVPromotePlayer) :@"c675",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPushSuperTV):
                                         @"c654",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerAirPlayView)  : @"c6540",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerNotMatchSuperTV) : @"c6542",
                                     @(LTDCActionPropertyCategoryPlayerVolumeBar) : @"c663",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPush)   : @"c654",
                                     @(LTDCActionPropertyCategoryTVPromotePlayer1080P)  : @"a17",
                                     @(LTDCActionPropertyCategoryPlayer4KLearnMore)        : @"c6751",
                                     @(LTDCActionPropertyCategoryPlayer1080PLearnMore)   :@"c6752",
                                     #endif
                                     // 我是歌手
                                     @(LTDCActionPropertyCategorySearchResultWoShiGeShou): @"a31",
                                     
                                     // 直播
                                     @(LTDCActionPropertyCategoryLivingNavigation)      : @"31",
                                     @(LTDCActionPropertyCategoryLivingFocus)           : @"32",
                                     @(LTDCActionPropertyCategoryLivingHalfBottom)           :@"l21",
                                    //直播5.4
                                     @(LTDCActionPropertyCategoryLivingNavigationNew)      : @"c21",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition1)      : @"c22",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition2)      : @"c23",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition3)      : @"c24",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition4)      : @"c25",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition5)      : @"c26",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition6)      : @"c27",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition7)      : @"c28",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryTVPromotePlayer) :@"c675",
                                     #endif
                                     // 发现模块信息
                                     @(LTDCActionPropertyCategoryFindContentArea)         :@"di01"    ,
                                     @(LTDCActionPropertyCategoryFindToolArea)            :@"di02"   ,
                                     @(LTDCActionPropertyCategoryFindPopularizeArea)      :@"di03"    ,
                                     @(LTDCActionPropertyCategoryFindAppRecommendArea)    :@"di04"    ,
                                     
                                     // 播放页
                                     @(LTDCActionPropertyCategoryHalfPlayerVip)         :@"m01",
                                     @(LTDCActionPropertyCategoryHalfPlayerToolBar)     : @"92",
                                     @(LTDCActionPropertyCategoryHalfPlayerTabScroll)   : @"91",
                                     @(LTDCActionPropertyCategoryHalfPlayerTabBar)      : @"93",
                                     @(LTDCActionPropertyCategoryHalfPlayerKanqiu)      : @"96",
                                     @(LTDCActionPropertyCategoryHalfPlayerEpisode)      : @"922",
                                     @(LTDCActionPropertyCategoryHalfPlayerRelate)      : @"923",
                                     @(LTDCActionPropertyCategoryShareClick)      : @"h223",
                                     
                                      @(LTDCActionPropertyCategoryHalfPlayerSkipAd)      : @"c61",
                                      @(LTDCActionPropertyCategoryHalfPlayerPurChaseByTrial)      : @"c62",
                                      @(LTDCActionPropertyCategoryHalfPlayerTrialLogin)      : @"c63",
                                     @(LTDCActionPropertyCategoryPlayerDoubleClick)     : @"c64",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryPlayerSuperTVClick)
                                        : @"c6541",
                                     #endif
                                     @(LTDCActionPropertyCategoryPlayerGestureClick)
                                     :@"c66",
                                     @(LTDCActionPropertyCategoryHalfPlayerTrialView)   :@"c69",
                                     @(LTDCActionPropertyCategoryFULLPlayerTipJump)   :@"c76",

                                     @(LTDCActionPropertyCategoryPlayerVoteClick)       :
                                         @"c78",
                                     @(LTDCActionPropertyCategoryPlayerRightBlock)      : @"a133",
                                     @(LTDCActionPropertyCategoryFullScreen)            : @"a15",
                                     //边看边买
                                     @(LTDCActionPropertyCategoryPlayerLiveShopping)    : @"com01",
                                     @(LTDCActionPropertyCategoryPlayerLiveShoppingDetail) :
                                         @"com02",
                                     @(LTDCActionPropertyCategoryPlayerRightShoppingList) :
                                         @"com05",
                                     // 精选
                                     @(LTDCActionPropertyCategoryAppexchangeFocus)      : @"41",
                                     @(LTDCActionPropertyCategoryAppexchangeSeg1)       : @"42",
                                     @(LTDCActionPropertyCategoryAppexchangeSeg2)       : @"43",
                                     @(LTDCActionPropertyCategoryAppexchangeSeg3)       : @"44",
                                     @(LTDCActionPropertyCategoryAppexchangeSeg4)       : @"45",
                                     
                                     //
                                     @(LTDCActionPropertyCategoryMyLetv)                : @"72",
                                     @(LTDCActionPropertyCategoryMyLetvFav)             : @"83",
                                     @(LTDCActionPropertyCategoryMyLetvHeadUcNotLogin)  : @"71",
                                     @(LTDCActionPropertyCategoryMyLetvHeadUcLogin)     : @"81",
                                     @(LTDCActionPropertyCategoryMyLetvVipPayForIpad)   : @"712",
                                     @(LTDCActionPropertyCategoryCashierVipPayForIpad)         : @"7121",
                                     @(LTDCActionPropertyCategoryCashierSeniorVipPayForIpad)   : @"7122",
                                     @(LTDCActionPropertyCategoryMyLetvVipPay)          : @"713",
                                     @(LTDCActionPropertyCategoryMyLetvVoucherVip)      : @"7133",
                                     
                                     
                                     
                                     @(LTDCActionPropertyCategoryCashier)               : @"b3",
                                     @(LTDCActionPropertyCategoryCashierVipPay)         : @"b31",
                                     @(LTDCActionPropertyCategoryCashierSeniorVipPay)   : @"b32",
                                     @(LTDCActionPropertyCategoryCashierLogin)          : @"b33",
                                     
                                     @(LTDCActionPropertyCategorySetting)               : @"e51",//设置页面
                                     @(LTDCActionPropertyCategorySettingPlayPrior)      : @"e52",// 设置播放清晰度
                                     @(LTDCActionPropertyCategorySettingDownLoadPrior)  : @"e53",//设置页面下载清晰度
                                     @(LTDCActionPropertyCategorySettingDownLoadCount)  : @"e54",// 设置页面下载任务数
                                     @(LTDCActionPropertyCategorySettingDownLoadCache)  : @"e55",// 设置页面下载缓存。
                                     @(LTDCActionPropertyCategorySettingAboutOur)       : @"e56",//设置页面关于我们
                                     @(LTDCActionPropertyCategorySettingPersonalInfor)  : @"d38",//我的信息页面
                                     @(LTDCActionPropertyChannelSeach)                  : @"2b",//频道页顶部栏搜索
#if 0   //联通sdk 适配IPv6
                                     @(LTDCActionPropertyUnicomFlow)                    : @"h23",//联通流量包合作
                                     @(LTDCActionPropertyUnicomWo_Order)                : @"h51",//联通流量包订购相关。
                                     @(LTDCActionPropertyUnicomWo_InitHint)             : @"h64",//播放时候联通SDK初始化失败弹窗。
#endif

                                     @(LTDCActionPropertyCategoryNavigation)            : @"a2",
                                     @(LTDCActionPropertyCategoryIndexBlock1)           : @"121",
                                     @(LTDCActionPropertyCategoryIndexBlock1VIP)        : @"1212",
                                     
                                     @(LTDCActionPropertyCategoryDownloadNav)           : @"a42",
                                     @(LTDCActionPropertyCategoryDownloadDel)           : @"a41",
                                     @(LTDCActionPropertyCategoryDownloadOverClearAll)         : @"e32",
                                     @(LTDCActionPropertyCategoryDownloadingClearAll)         : @"e31",
                                     @(LTDCActionPropertyCategoryDownloadItunesClearAll)         : @"e33",
                                      @(LTDCActionPropertyCategoryLoginFailed)            : @"st01",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryDownloadingStateALL)    : @"e312",
                                     @(LTDCActionPropertyCategoryDownloadingButtonState)         : @"e311",
                                     @(LTDCActionPropertyCategoryDownloadDeleteAll)      : @"e38",
                                     @(LTDCActionPropertyCategoryDownloadMoreMoview)     : @"e321",
                                    
                                     #endif
                                     @(LTDCActionPropertyCategoryDownloadPageAction)    : @"a422",
                                     @(LTDCActionPropertyCategoryHalfPlayerDownload)    : @"a53",
                                     @(LTDCActionPropertyCategoryHalfPlayerManageDownload)  : @"a54",
                                     @(LTDCActionPropertyCategoryHalfPlayerLive)    : @"a55",
                                     @(LTDCActionPropertyCategoryScreenPlayerLive)    : @"a18",
                                     @(LTDCActionPropertyCategoryScreenPlayerLiveCode)    : @"a19",
                                     
                                     
                                     @(LTDCActionPropertyCategoryLoginPage)             : @"a6",
                                     @(LTDCActionPropertyCategoryPhoneRegisterPage)     : @"a8",
                                     @(LTDCActionPropertyCategoryEmailRegisterPage)     : @"a7",
                                     @(LTDCActionPropertyCategoryLetvLoginPage)         : @"a9",
                                     @(LTDCActionPropertyCategoryLetvForgetPwd)         : @"b1",
                                     @(LTDCActionPropertyCategoryLetvForgetPwdSendMsg)  : @"b2",
                                     
                                     @(LTDCActionPropertyCategoryLoginPage4Pad)         : @"a3",
                                     @(LTDCActionPropertyCategoryRegisterPage4Pad)      : @"a4",
                                     @(LTDCActionPropertyCategoryPhoneRegisterPage4Pad) : @"a5",
                                     @(LTDCActionPropertyCategoryEmailRegisterPage4Pad) : @"a6",
                                     @(LTDCActionPropertyCategoryDownloadUserLoginTip):@"a54",
                                     @(LTDCActionPropertyCategoryIndexLoginTip):@"215",
                                     @(LTDCActionPropertyCategoryIndexRenewVip):@"214",
                                     
                                     @(LTDCActionPropertyCategoryUpdate)               :@"c1",
                                      @(LTDCActionPropertyCategoryForceUpdate)         :@"e71",
                                     @(LTDCActionPropertyCategorySubject)               :@"c3",
                                     @(LTDCActionPropertyCategoryUpdateAndForceUpdate)  :@"sj",
                                     
                                     //登录界面
                                     @(LTDCActionPropertyLoginGoback)              :@"c71",
                                     @(LTDCActionPropertyLoginFromThirdParty)              :@"c72",
                                     @(LTDCActionPropertyLoginAction)              :@"c73",
                                     @(LTDCActionPropertyLoginAccessory)              :@"c74",
                                     @(LTDCActionPropertyLoginSuccess)              :@"c75",
                                     @(LTDCActionPropertyLoginHeadClick)            :@"d31",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDcActionPropertyLoginVipClick)             :@"c69",
                                     #endif
                                      //注册页面
                                      @(LTDCActionPropertyRegisterGoback)              :@"c81",
                                     @(LTDCActionPropertyRegisterFromThirdParty)       :@"c82",
                                     @(LTDCActionPropertyRegisterBy)                   :@"c83",
                                     @(LTDCActionPropertyRegisterByPhone)              :@"c831",
                                     @(LTDCActionPropertyRegisterByEmail)              :@"c832",
                                     @(LTDCActionPropertyRegisterByMessage)            :@"c833",
                                     @(LTDCActionPropertyRegisterPageShow)             :@"c834",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyRegisterLoginSucc)            :@"c84" ,
                                     #endif
                                     
                                     //找回密码
                                     @(LTDCActionPropertyFindPasswordFromMessage)       :@"c91",
                                     @(LTDCActionPropertyFindPasswordFromEMail)         :@"c92",
                                     @(LTDCActionPropertyFindPasswordPageShow)          :@"c93",
                                     
                                     //push
                                     @(LTDCActionPropertyPush)          :@"c5",
                                     @(LTDCActionPropertyPushShow)      :@"tc10",
                                     
                                     //我的-播放记录列表
                                     @(LTDCActionPropertyMyLetvPlayRecord)          :@"8a",
                                     @(LTDCActionPropertyMyLetvSettingClick)        :@"d32",
                                     @(LTDCActionPropertyMyLetvListClick)           :@"d33",
                                     @(LTDCActionPropertyMyLetvRecodeListClick)      :@"d35",
                                     @(LTDCActionPropertyMyLetvRecodeLoginClick)      :@"d36",
                                     @(LTDCActionPropertyMyLetvRecodeNextPlayClick)      :@"d37",
                                     @(LTDCActionPropertyPlayRecord)                :@"h71",
                                     @(LTDCActionPropertyCategoryHalfPlayerSurroundView):@"h26",
                                     @(LTDCActionPropertyCategoryHalfPlayerjuji):@"h27",
                                     @(LTDCActionPropertyCategoryHalfPlayerRelateView):@"h28",
                                     @(LTDCActionPropertyCategoryHalfPlayerFouceView):@"h25",
                                     @(LTDCActionPropertyPlayRecordList)            :@"h72",
                                     @(LTDCActionPropertyPlayHistoryBack)           :@"h73",
                                     
                                     //热点
                                      @(LTDCActionPropertyCategoryHotUp)          :@"c31",
                                      @(LTDCActionPropertyCategoryHotShareBtn)          :@"c32",
                                      @(LTDCActionPropertyCategoryHotShare)          :@"c321",
                                     
                                     //推荐专题
                                      @(LTDCActionPropertyRecommendSpecial)          :@"c41",
                                      @(LTDCActionPropertyFloatBall)                :@"g11",
                                      @(LTDCActionPropertyHotChannelPause)          :@"c331",
                                      @(LTDCActionPropertyHotChannelPlay)           :@"c332",
                                     //半屏播放页tab，底部导航，评论
                                      @(LTDCActionPropertyHalfPlayerTag)            :@"h21",
                                      @(LTDCActionPropertyHalfPlayerToolBar)        :@"h22",
                                     //分享成功fl
                                      @(LTDCActionPropertyShareSucces):          @"s10",
                                     @(LTDcActionPropertyCaptureShareClick):        @"sh20",
                                     @(LTDcActionPropertyCaptureShareSucces):          @"sh21",
                                      @(LTDCActionPropertyHalfPlayerComment)        :@"82",
                                     //半屏播放页 相关播放，相关系列、猜你喜欢
                                     @(LTDCActionPropertyEpisodePromotion)            :@"h212",
                                     //半屏播放页 相关播放，相关系列、猜你喜欢
                                     @(LTDCActionPropertyRelatedPlayAndFav)            :@"h2131",
                                     @(LTDCActionPropertyRelatedSeries)                :@"h2132",
                                     @(LTDCActionPropertyRelatedGuessYouLike)          :@"h2133",
                                     @(LTDCActionPropertyEpisodeSummary)               :@"h211",
                                     @(LTDCActionPropertyEpisodeClick)                 :@"h2122",
                                     @(LTDCActionPropertyCategoryChannelShowListViewPlay):@"dt01",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                    
                                     @(LTDcActionPropertyAddCommentClick)             :@"h24",
                                     @(LTDCActionPropertyReplyComment)                :@"h213",
                                     @(LTDCActionPropertySendComment)                 :@"h241",
                                     #endif
                                     //更多  分享
                                     @(LTDcActionPropertyShareMoreClick)              :@"h50",
                                     @(LTDcActionPropertyShareClick)                  :@"h52",
                                     //iphone 上 猜你喜欢 和评论发送
                                     @(LTDCActionPropertyRelated)                      :@"h214",
                                     @(LTDActionPropertyCommentSend)                   :@"803",
                                     @(LTDActionPropertyHalfLiveOrder)                 :@"l01",
                                     @(LTDActionPropertyHalfLive)                      :@"l02",
                                     @(LTDActionPropertyHalfLiveToolBar)               :@"l03",
                                     @(LTDActionPropertyHalfLivePayOrder)              :@"l04",
                                     @(LTDActionPropertyHalfLivePayConsumeHistory)     :@"l06",
                                     @(LTDCActionPropertyCategoryPlayerCenterDownloadbuffer) :@"687",
                                     @(LTDCActionPropertyCategoryPlayerSettingBindInfor)     :@"040",
                                     @(LTDcActionPropertyCategoryReplyClick)                 :@"85",
                                     @(LTDcActionPropertyCategoryPriseClick)                 :@"86",
                                     @(LTDcActionPropertyCategoryMoreClick)                  :@"87",
                                     @(LTDCActionPropertyCategoryHalfClickPrise)             :@"90",
                                     @(LTDActionPropertyHalfLiveToolBarSwitchOrder)    :@"l07",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayerBigTip)
                                     : @"c683",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayer3G) :@"c684",
                                     @(LTDCActionPropertyCategoryPlayerCenterLookTimeClick)
                                     : @"c686",
                                     @(LTDCActionPropertyCategoryPlayerCenterbuffer)
                                     : @"c687",
                                     @(LTDCActionPropertyCategoryPlayerCenterShow)
                                     : @"c68",
                                     @(LTDCActionPropertyCategoryPlayer4KLearnMore)        : @"c6751",
                                     @(LTDCActionPropertyCategoryPlayer1080PLearnMore)   :@"c6752",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayerBottomView)
                                     : @"c67",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPicturePrecent)
                                     : @"c677",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerWatchingFocus)
                                     : @"c676",
                                     @(LTDCActionPropertyCategoryPlayerTopView)
                                     : @"c65",
                                     @(LTDCActionPropertyCategoryPlayerTopPushView): @"c650",
                                     
                                     @(LTDCActionPropertyCategoryPlayerPlayBillView)
                                     :@"c657",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryDownloadSegement)   :@"e41",
                                     @(LTDCActionPropertyCategoryDownloadAddSuccess) :@"e42",
                                     @(LTDCActionPropertyCategoryDownloadForbid)     :@"e44",
                                     @(LTDCActionPropertyCategoryDownloadOther)      :@"e43",
                                      //登陆 注册
                                     @(LTDCActionPropertyCategoryMyPage)      :@"d34",
                                     #endif
                                     //全屏剧集点击
                                     @(LTDcActionPropertyFullScreenEpisodeSummary) : @"c656",
                                     @(LTDCActionPropertyCategoryPlayerLearnMore)  : @"c6541",
                                     //直播播放器
                                     @(LTDCActionPropertyLivingDefaultPlayer): @"l09",
                                     @(LTDCActionPropertyLivingFullPlayer): @"l08",
                                     
                                     //a播放记录
                                      #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyRecord):@"w10",
                                     @(LTDCActionPropertyRecordButton):@"w11",
                                     @(LTDCActionPropertyRecordTableDidSelect):@"w12",
                                     @(LTDCActionPropertyRecordLogin):@"w13",
                                     #endif
                                     //会员转移购买
                                     @(LTDCActionPropertyVipPayClick):@"vp06",
                                     @(LTDcActionPropertyVipClick)   :@"vp10",
                                     #ifndef  LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyPay):@"vp03",
                                     @(LTDCActionPropertyPayShow):@"vp04",
                                     @(LTDCActionPropertyMovePay):@"d30",
                                     @(LTDCActionPropertyLivePlay):@"l18",
                                     @(LTDCActionPropertyListLivePlay):@"l19",
                                     @(LTDCActionPropertyListClickLivePlay):@"l20",
                                   
                                     #else
                                     @(LTDCActionPropertyBuyMove):@"d30",
                                     @(LTDCActionPropertyShow):@"vp03",
                                     @(LTDCActionPropertyVipRemmond):@"vp04",
                                    
                                     
									 #endif
                                     @(LTDCActionPropertyLiveHalfToolBarView):@"l17",
                                     @(LTDCActionPropertyLiveHalfPlay):@"l12",
                                     @(LTDcActionPropertyLiveHalfTime):@"l11",
                                     @(LTDcActionPropertyLiveHalfPay) :@"l10",
                                     @(LTDcActionPropertyLiveHalfWeiShi) :@"l13",
                                     @(LTDcActionPropertyLiveHalfSprot) :@"l14",
                                     @(LTDcActionPropertyLiveHalfMusic) :@"l16",
                                     @(LTDcActionPropertyLiveDefaultRecommendView) :@"l60",
                                     @(LTDcActionPropertyLiveDefaultSelectedView) :@"l61",
                                     
                                     // 直播大厅轮播卫视（收藏、全部、历史）
                                     @(LTDcActionPropertyLiveHallTabSelected) :@"l40",
                                     @(LTDcActionPropertyLiveHallStoreUp) :@"l41",
                                     
                                     // 冷启动引导图后个人喜欢
                                     @(LTDCActionPropertyNewUserGuideLike) :@"ns01",
                                     
                                     @(LTDCActionPropertyTimeShiftBackIcon) :@"l51",
                                     
                                     // 弹幕
                                     @(LTDCActionPropertyDanmakuSendButtonAction) :@"c6810",
                                     @(LTDCActionPropertyDanmakuSyncButtonAction) :@"c77",
                                     
                                     // 直播弹幕
                                     @(LTDCActionPropertyLiveDanmakuOnOffButtonShow) :@"l65",
                                     @(LTDCActionPropertyLiveDanmakuOnOffButtonAction) :@"l658",
                                     @(LTDCActionPropertyLiveDanmakuSendButtonShow) :@"l68",
                                     @(LTDCActionPropertyLiveDanmakuSendButtonAction) :@"l681",
                                     // 截屏分享
                                     @(LTDCActionPropertyScreenShotPhotosShare)            :@"sh01",
                                     @(LTDCActionPropertyScreenShotPhotosTextClick)        :@"sh02",
                                     @(LTDCActionPropertyScreenShotPhotosSignClick)        :@"sh03",
                                     //明星页面
                                     @(LTDCActionPropertyStarInfo)                         :@"s03",
                                     @(LTDCActionPropertyStarCardActivity)                 :@"st1",
                                     @(LTDCActionPropertyStarCardStarIDVideo)              :@"st2",
                                     @(LTDCActionPropertyStarCardStarLiveVideo)            :@"st3",
                                     @(LTDCActionPropertyStarCardMusicVideo)               :@"st4",
                                     @(LTDCActionPropertyStarCardRingVideo)                :@"st5",
                                     @(LTDCActionAppStoreStar)
                                         :@"ev01",
                                     @(LTDCActionPropertyStarCardAlbumVideo)               :@"st6",
                                     @(LTDCActionPropertyStarCardNewsVideo)                :@"st7",
                                     @(LTDCActionPropertyDownloadAllVideo)
                                        :@"dl02",
                                     @(LTDCActionPropertyDownloadAllAlertShow)
                                        :@"dl03"
                                     };
    
    id valueForCategory = [dictActionCode objectForKey:@(apCategory)];
    if (nil == valueForCategory) {
        return @"";
    }
    
    NSString *actionCode = (NSString *)valueForCategory;
    
    return actionCode;
}

#pragma mark - cache

+ (LTDataCenterStatisticsType)getStatisticsTypeByCachedFilename:(NSString *)fileName
{
    NSArray *array = [fileName componentsSeparatedByString:LT_DC_CACHE_FILENAME_SEPARATOR];
    if (    nil == array
        ||  [array count] != 2) {
        return LTDataCenterStatisticsTypeError;
    }
    
    return (LTDataCenterStatisticsType)[array[0] integerValue];
}

+ (NSString *)cacheStatisticsWithType:(LTDataCenterStatisticsType)sType
                        andUrlContent:(NSString *)content
{

    @try {
        NSString *cachePath = [FileManager appDataCenterCachePath];
        
        if ([NSString isBlankString:cachePath] || LTDataCenterStatisticsTypeError == sType || LTDataCenterStatisticsTypeKVError == sType) {
            return @"";
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"SSS"];
        NSString *ms = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%ld%@%ld%@%ld", (long)LTDataCenterStatisticsTypeKVPlay, LT_DC_CACHE_FILENAME_SEPARATOR,(long)[[NSDate date] timeIntervalSince1970],ms,(long)arc4random()];
        NSString *fullPath = [cachePath stringByAppendingPathComponent:fileName];
        [content writeToFile:fullPath
                  atomically:YES
                    encoding:NSUTF8StringEncoding
                       error:nil];
        return fileName;

    }
    @catch (NSException *exception) {
        
    }

    return @"";
}

+ (NSString *)cacheStatisticsWithType:(LTDataCenterStatisticsType)sType
                           andRawData:(NSDictionary *)dictData
                      andRequiredKeys:(NSArray *)requiredKeys
{
    NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                  andRequiredKeys:requiredKeys];
    
    return [[self class] cacheStatisticsWithType:sType
                                   andUrlContent:strContent];
}

+ (void)sendCachedStatistics
{
//#ifdef LT_MERGE_FROM_IPAD_CLIENT
//    #ifndef LTMovieplayerFramework
//#endif
    if (![NetworkReachability connectedToNetwork]) {
        return;
    }
    
    NSMutableArray *arrayCachedFiles = [NSMutableArray array];
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSString *cachePath = [FileManager appDataCenterCachePath];
    NSArray *contents = [fm contentsOfDirectoryAtPath:cachePath error:nil];
    for (NSString *filename in contents) {
        if (    filename.length <= 0
            ||  [filename characterAtIndex:0] == '.') {
            continue;
        }
        NSString *path = [cachePath stringByAppendingPathComponent:filename];
        NSDictionary *attr = [fm attributesOfItemAtPath:path error:nil];
        if (!attr) {
            continue;
        }
        id fileType = [attr valueForKey:NSFileType];
        if (![fileType isEqual: NSFileTypeRegular]) {
            continue;
        }
        
        [arrayCachedFiles addObject:filename];
    }
    NSArray *orderFiles = [arrayCachedFiles sortedArrayUsingComparator:^(NSString * obj1, NSString * obj2){
        return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSInteger fileCount = 0;
    for (NSString *filename in orderFiles) {
        LTDataCenterStatisticsType stype = [[self class] getStatisticsTypeByCachedFilename:filename];
        if (stype == LTDataCenterStatisticsTypeError) {
            continue;
        }
        NSString *path = [cachePath stringByAppendingPathComponent:filename];
        NSData *data = [fm contentsAtPath:path];
        NSString *urlContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // 过滤play 动作本地日志的url
        NSRange rang = [urlContent rangeOfString:@"&ac="];
        if (stype == LTDataCenterStatisticsTypeKVPlay) {
            if (rang.location != NSNotFound && rang.length != NSNotFound) {
                fileCount++;
                [LTDataModelEngine sendStatistics:stype
                                      withUrlPath:urlContent
                                completionHandler:^{
                                    NSLog(@"data center, cached data upload success. %ld", (long)stype);
                                    [fm removeItemAtPath:path error:nil];
                                } errorHandler:^(NSError *error) {
                                    //
                                }];
            }
        }else
        {
            [LTDataModelEngine sendStatistics:stype
                                  withUrlPath:urlContent
                            completionHandler:^{
                                NSLog(@"data center, cached data upload success. %ld", (long)stype);
                                [fm removeItemAtPath:path error:nil];
                            } errorHandler:^(NSError *error) {
                                //
                            }];

        }
    }
//#ifdef LT_MERGE_FROM_IPAD_CLIENT
//    #endif
//#endif
}

#pragma mark - send
+ (void)sendStatisticsWithType:(LTDataCenterStatisticsType)sType
                 andUrlContent:(NSString *)content
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        // 动作日志不需要缓存
        BOOL isNeedCacheIfSendFailed = (    LTDataCenterStatisticsTypeAction != sType
                                        &&  LTDataCenterStatisticsTypeKVAction != sType);
        
        if (![NetworkReachability connectedToNetwork]) {
            if (isNeedCacheIfSendFailed) {
                [[self class] cacheStatisticsWithType:sType
                                        andUrlContent:content];
            }
            
            return;
        }
        
        [LTDataModelEngine sendStatistics:sType
                              withUrlPath:content
                        completionHandler:^{
//                            NSLog(@"data center, data upload success. %ld", (long)sType);
//                            NSLog(@"data center, content：=＝(%ld)＝＝ %@",(long) sType , content);
                        } errorHandler:^(NSError *error) {
                            if (isNeedCacheIfSendFailed) {
                                [[self class] cacheStatisticsWithType:sType
                                                        andUrlContent:content];
                            }
                        }];
    });

    return;
}

+ (void)sendActionStatisticsWithUrlContent:(NSString *)content
                             andActionCode:(LTDCActionCode)actionCode
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        
        BOOL isNeedCacheIfSendFailed = (LTDCActionCodeDownload == actionCode);
        
        if (![NetworkReachability connectedToNetwork]) {
            if (isNeedCacheIfSendFailed) {
                [[self class] cacheStatisticsWithType:LTDataCenterStatisticsTypeKVAction
                                        andUrlContent:content];
            }
            
            return;
        }
        
        [LTDataModelEngine sendStatistics:LTDataCenterStatisticsTypeKVAction
                              withUrlPath:content
                        completionHandler:^{
//                            NSLog(@"data center, data upload success. %ld", (long)LTDataCenterStatisticsTypeKVAction);
                        } errorHandler:^(NSError *error) {
                            if (isNeedCacheIfSendFailed) {
                                [[self class] cacheStatisticsWithType:LTDataCenterStatisticsTypeKVAction
                                                        andUrlContent:content];
                            }
                        }];
    });
    
    return;
}

+ (void)sendActionStatisticsWithRawData:(NSDictionary *)dictData
                        andRequiredKeys:(NSArray *)requiredKeys
                          andActionCode:(LTDCActionCode)actionCode
{
    NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                  andRequiredKeys:requiredKeys];
    
    [[self class] sendActionStatisticsWithUrlContent:strContent
                                       andActionCode:actionCode];
    
    return;
}

+ (void)sendStatisticsWithType:(LTDataCenterStatisticsType)sType
                    andRawData:(NSDictionary *)dictData
               andRequiredKeys:(NSArray *)requiredKeys
{
    NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                  andRequiredKeys:requiredKeys];
    
    [[self class] sendStatisticsWithType:sType
                           andUrlContent:strContent];
    
    return;
}

#pragma mark - login / logout

+ (void)login
{
    double lastLoginTime = [SettingManager getVirtualLoginTime];
    NSTimeInterval curTime = [[NSDate date] timeIntervalSince1970] * 1000;
    //不是同一天请求签到接口

    if (curTime - lastLoginTime < LT_DC_VALID_LOGIN_INTERVAL) {
        // 如果两次启动间隔小于1分钟，这两次启动会被视为1次启动
        
        // 清除缓存的上一次退出日志
        [[self class] removeLastLogoutData];
    }
    else{
        // 否则，一次新的启动
        [SettingManager setVirtualLoginTime:curTime];
        
        // 重置uuid
        NSString *did_client = [DeviceManager getDeviceUUID];
        NSString *loginUUID = [NSString stringWithFormat:@"%@_%@",
                               did_client,
                               [NSString stringWithFormat:@"%lld", (long long)curTime]];
        [SettingManager setVirtualLoginUUID:loginUUID];
        
        // 上报本次启动日志
        [[self class] addLoginData:LTDCLoginStatusLogin];
    }
    
    // set last logout filename empty.
    [SettingManager setLastLogoutFileName:@""];
    
    // 上报缓存的日志（包括上一次登出日志，以及缓存在本地的未上报成功过的日志）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        [self sendCachedStatistics];
    });
    
    return;
}

+ (void)logout
{
    [[self class] logout:LTDCPageIDUnKnown];
}

+ (void)logout:(LTDCPageID)pageID
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    // update user type to activity
    [LeTVSharedAppModule letv_AppDelegate_setLetvUserType:LetvUserActivity];
    
    //发送退出统计日志
    NSDictionary *dictAp = @{
                             @"time"    : [NSString formatStatisticCurrentTimeString],
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"pageid"  : pageid
                             };
    #ifndef LT_MERGE_FROM_IPAD_CLIENT
    [LTDataCenter addActionData:LTDCActionCodeQuit
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    #else /* !LT_MERGE_FROM_IPAD_CLIENT */
    [LTDataCenter addActionData:LTDCActionCodeQuit
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:nil];
    #endif /* LT_MERGE_FROM_IPAD_CLIENT */
    
    // 清除缓存的上一次退出日志
    [[self class] removeLastLogoutData];
    [SettingManager setLastLogoutFileName:@""];
    
    // 缓存退出日志，下一次启动的时候再上报
    NSString *fileName = [[self class] addLoginData:LTDCLoginStatusLogout];
    [SettingManager setLastLogoutFileName:fileName];
}

+ (void)loginToUserCenter
{
    // 上报一次login日志，不重新生成uuid
    [[self class] addLoginData:LTDCLoginStatusLogin];
    
    return;
}

+ (void)removeLastLogoutData
{
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    #ifndef LTMovieplayerFramework
#endif
    // 清除缓存的上一次登出日志
    NSString *lastLogoutFileName = [SettingManager getLastLogoutFileName];
    if ([NSString isBlankString:lastLogoutFileName]) {
        return;
    }
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSString *cachePath = [FileManager appDataCenterCachePath];
    NSString *path = [cachePath stringByAppendingPathComponent:lastLogoutFileName];
    if ([fm fileExistsAtPath:path]) {
        [fm removeItemAtPath:path error:nil];
    }
    
    return;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    #endif
#endif
}

#pragma mark - action

+ (void)addActionData:(LTDCCodeActionModule)module  // 模块码
            subModule:(int)subModule                // 子模块码
                  act:(LTDCCodeActionType)act       // 动作码
             adSystem:(NSString *)adSystem          // 广告系统
             codeRate:(VideoCodeType)codeRate       // 码率
              extInfo:(NSArray *)arrExt             // 扩展信息
{
    if (    module >= LTDCCodeActionModuleCount
        ||  act >= LTDCCodeActionTypeCount) {
        //NSLog(@"Invalid action code.");
        return;
    }
    
    // $1:nettype,上网类型 ex:wifi/3G
    NSString *strNetType = [NetworkReachability currentNetType];
    if ([NSString isBlankString:strNetType]) {
        strNetType = EMPTY_PARAM_VALUE;
    }
    
    // $2:uid,乐视网用户id
    NSString *alreadyLoginUid = [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID];
    NSString *strUid          = [NSString isBlankString:alreadyLoginUid] ? EMPTY_PARAM_VALUE : alreadyLoginUid;
    
    // auid
    // chenhao auid
    NSString *strAUID = [DeviceManager getIOSDeviceUUID];
    if ([NSString isBlankString:strAUID]) {
        strAUID = EMPTY_PARAM_VALUE;
    }
    
    // $3:act,动作码
    NSString *strActModule;
    if (module == LTDCCodeActionModuleEmpty) {
        strActModule = EMPTY_PARAM_VALUE;
    }
    else{
        if (module < 10) {
            strActModule = [NSString stringWithFormat:@"%ld", (long)module];
        }
        else{
            strActModule = [NSString stringWithFormat:@"%ld", (long)('a'+module-10)];
        }
    }
    NSString *strActSubModule;
    if (subModule == -1) {
        strActSubModule = EMPTY_PARAM_VALUE;
    }
    else{
        if (subModule < 10) {
            strActSubModule = [NSString stringWithFormat:@"%d", subModule];
        }
        else{
            strActSubModule = [NSString stringWithFormat:@"%c", 'a'+subModule-10];
        }
    }
    NSString *strActAction;
    if (act == LTDCCodeActionTypeEmpty) {
        strActAction = EMPTY_PARAM_VALUE;
    }
    else{
        if (act < 10) {
            strActAction = [NSString stringWithFormat:@"%ld", (long)act];
        }
        else{
            strActAction = [NSString stringWithFormat:@"%ld", (long)('a'+act-10)];
        }
    }
    NSString *strAct = [NSString stringWithFormat:@"%@%@%@", strActModule, strActSubModule, strActAction];
    if ([NSString isBlankString:strAct]) {
        strAct = EMPTY_PARAM_VALUE;
    }
    
    // $4:t,时间戳
    NSString *strTime =[NSString stringWithFormat:@"%ld", time(NULL)];
    
    // $5:uuid, (did_timestamp)登录时生成的uuid
    NSString *strUUID = [SettingManager getVirtualLoginUUID];
    if (    nil == strUUID
        ||  [NSString isBlankString:strUUID]) {
        strUUID = EMPTY_PARAM_VALUE;
    }
    
    // $6:ext,扩展信息cid_pid_vid;134（0或多个扩展信息，扩展信息以;"分号"分隔）
    NSInteger nCountExt = 0;
    NSString *strExt = @"";
    if (    nil != arrExt
        &&  [arrExt count] > 0) {
        nCountExt = [arrExt count];
        for (int i=0; i<nCountExt; i++) {
            NSString *subExt = arrExt[i];
            if (![NSString isBlankString:subExt]) {
                strExt = [strExt stringByAppendingFormat:@"%@", [subExt encodedURLString]];
            }
            else{
                strExt = [strExt stringByAppendingFormat:EMPTY_PARAM_VALUE];
            }
            
            if (i != nCountExt-1) {
                strExt = [strExt stringByAppendingFormat:@";"];
            }
        }
    }
    if ([NSString isBlankString:strExt]) {
        strExt = EMPTY_PARAM_VALUE;
    }
    else{
        strExt = [strExt stringByReplacingOccurrencesOfRegex:@"\\&" withString:@"}"];
        strExt = [strExt stringByReplacingOccurrencesOfRegex:@"\\?" withString:@"{"];
    }
    
    // $7:统计版本
    NSString *dcVersion = LT_DATA_CENTER_VERSION;
    NSString *app_client = CURRENT_PCODE;
    NSString *appver_client = CURRENT_VERSION;
    
    if ([NSString isBlankString:adSystem]) {
        adSystem = EMPTY_PARAM_VALUE;
    }
    
    NSString *strCodeRate = EMPTY_PARAM_VALUE;
    if (VIDEO_CODE_UNKNOWN != codeRate) {
        strCodeRate = [NSString stringWithFormat:@"%@", [NSString formatBitrateValue:codeRate]];
    }
    
    NSArray *paraArray = @[strNetType,          // 上网类型
                           strUid,              // 乐视网用户id
                           strAUID,             // iOS6.0版本读取的设备id
                           strAct,              // 动作码
                           strTime,             // 时间戳
                           strUUID,             // 登录时生成的uuid
                           strExt,              // 扩展信息
                           dcVersion,           // 日志上报版本
                           app_client,          // 产品线
                           appver_client,       // 应用版本
                           adSystem,            // 广告系统
                           strCodeRate          // 码率
                           ];
    
    NSString *strData = [paraArray componentsJoinedByString:@"&"];
    
    //    NSLog(@"datacenter-action---%@", strData);
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeAction
                           andUrlContent:strData];
    
    return;
}

+ (void)addActionData:(LTDCCodeActionModule)module  // 模块码
            subModule:(int)subModule                // 子模块码
                  act:(LTDCCodeActionType)act       // 动作码
              extInfo:(NSArray *)arrExt             // 扩展信息
{
    [[self class] addActionData:module
                      subModule:subModule
                            act:act
                       adSystem:nil
                       codeRate:VIDEO_CODE_UNKNOWN
                        extInfo:arrExt];
}
#ifdef LT_MERGE_FROM_IPAD_CLIENT
#warning ZhangQigang: 解耦, 数据类型, 接口需要移动到  MobileAdvertise
// 非贴片广告
+ (void)addADActionData:(LTDCCodeActionModule)module  // 模块码
                    act:(LTDCCodeActionType)act       // 动作码
                 adType:(NSInteger)advertiseType
                   adID:(NSString *)adid
                extInfo:(NSArray *)arrExt
               adSystem:(NSString *)adSystem
{
#if 0
    NSMutableArray *arrayAdExtraInfo = [NSMutableArray array];
    
    [arrayAdExtraInfo addObjectsFromArray:arrExt];
    
    NSString *adType=nil;
    switch (advertiseType) {
        case MovieAdvertiseType_Booting:
            adType=@"11";
            break;
        case MovieAdvertiseType_Focus:
        case MovieAdvertiseType_Focus2:
            adType=@"12";
            break;
        case MovieAdvertiseType_LiveText:
            adType=@"13";
            break;
        case MovieAdvertiseType_DetailBanner:
            adType=@"15";
            break;
        case MovieAdvertiseType_Search:
        case MovieAdvertiseType_KeyWords:
            adType=@"16";
            break;
        case MovieAdvertiseType_Alert:
            adType=@"17";
            break;
        case MovieAdvertiseType_Front:
        case MovieAdvertiseType_Front_Offline:
            adType=@"41";
            break;
        case MovieAdvertiseType_Behind:
            adType=@"42";
            break;
        case MovieAdvertiseType_Pause:
            adType=@"43";
            break;
        case MovieAdvertiseType_LiveFront:
            adType=@"44";
            break;
        default:
            break;
    }
    if (![NSString isBlankString:adType]) {
        if ([NSString isBlankString:adid]) {
            adid = EMPTY_PARAM_VALUE;
        }
        [arrayAdExtraInfo addObject:adType];
        [arrayAdExtraInfo addObject:adid];
    }
    
    [[self class] addActionData:module
                      subModule:9
                            act:act
                       adSystem:adSystem
                       codeRate:VIDEO_CODE_UNKNOWN
                        extInfo:arrayAdExtraInfo];
#endif
    return;
}

#pragma mark - adplay
// chenhao auid
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
               adSystem:(NSString *)adSystem
{
#if 0
    NSString *adType=nil;
    switch (advertiseType) {
        case MovieAdvertiseType_Front:
        case MovieAdvertiseType_Front_Offline:
        {
            if (AD_TYPE_IMAGE == adFormtType) {
                adType = @"41";
            }
            else if (   AD_TYPE_MP4 == adFormtType
                     || AD_TYPE_TS == adFormtType){
                adType = @"100";
            }
            else{
                adType = @"-";
            }
        }
            break;
        case MovieAdvertiseType_LiveFront:
        {
            if (AD_TYPE_IMAGE == adFormtType) {
                adType = @"44";
            }
            else if (   AD_TYPE_MP4 == adFormtType
                     || AD_TYPE_TS == adFormtType){
                adType = @"101";
            }
            else{
                adType = @"-";
            }
        }
            break;
        case MovieAdvertiseType_Behind:
        {
            if (AD_TYPE_IMAGE == adFormtType) {
                adType = @"42";
            }
            else if (   AD_TYPE_MP4 == adFormtType
                     || AD_TYPE_TS == adFormtType){
                adType = @"200";
            }
            else{
                adType = @"-";
            }
        }
            break;
        default:
        {
            adType = @"-";
        }
            break;
    }
    NSString *nettype  = [NetworkReachability currentNetType];
    NSString *alreadyLoginUid   = [SettingManager alreadyLoginUserID];
    NSString *strUid   = [NSString isBlankString:alreadyLoginUid] ? EMPTY_PARAM_VALUE : alreadyLoginUid;
    NSString *app_client    = CURRENT_PCODE;
    NSString *brand = LT_DEVICE_BRAND;
    NSString *appver_client = CURRENT_VERSION;
    
    NSString *m_adID=[NSString isBlankString:adID]?EMPTY_PARAM_VALUE:[NSString stringWithFormat:@"-_-_%@",adID];
    NSString *m_utime=[NSString isBlankString:utime]?EMPTY_PARAM_VALUE:utime;
    NSString *m_playTimeLen=[NSString isBlankString:playTimeLen]?EMPTY_PARAM_VALUE:playTimeLen;
    NSString *m_cid=[NSString isBlankString:cid]?EMPTY_PARAM_VALUE:cid;
    NSString *m_vid=[NSString isBlankString:vid]?EMPTY_PARAM_VALUE:vid;
    NSString *m_pid=[NSString isBlankString:pid]?EMPTY_PARAM_VALUE:pid;
    
    
    NSString *vinfo=[NSString stringWithFormat:@"%@_%@",m_pid,m_vid];
    NSString *m_videoLen=[NSString isBlankString:videoLen]?EMPTY_PARAM_VALUE:videoLen;
    NSTimeInterval ti=[[NSDate date]timeIntervalSince1970];
    NSString *ptid=[NSString stringWithFormat:@"%@_%0.f",[DeviceManager getDeviceUUID],ti];
    NSString *dcVersion = LT_DATA_CENTER_VERSION;
    
    NSString *strAUID = [DeviceManager getIOSDeviceUUID];
    if ([NSString isBlankString:strAUID]) {
        strAUID = EMPTY_PARAM_VALUE;
    }
    
    NSArray *paraArray = @[nettype,             // 1	nettype	上网类型
                           strUid,              // 2	uid	乐视网用户id
                           [NSString safeString:[SettingManager getVirtualLoginUUID]],  // 3	uuid
                           app_client,          // 4	app	产品线
                           brand,               // 5	brand	品牌
                           appver_client,       // 6	appver	客户端版本
                           adType,              // 7	adtype	广告位类型
                           m_adID,              // 8	adid	广告编号
                           action,              // 9	actionid	上报动作串
                           [NSString stringWithFormat:@"-_-_%@",clickTime],     // 10	clicknum	点击次数
                           m_utime,                                             // 11	utime	加载耗时
                           [NSString stringWithFormat:@"-_-_%@",adduration],    // 12	广告时长
                           [NSString stringWithFormat:@"-_-_%@",m_playTimeLen], // 13	playedTime	广告播放时长
                           m_cid,               // 14	cid	频道标识
                           vinfo,               // 15	vinfo	视频信息
                           m_videoLen,          // 16  vlen   视频时长
                           ptid,                // 17	ptid	播放时间标识
                           dcVersion,
                           adSystem,
                           strAUID
                           ];
    NSString *paraString = [paraArray componentsJoinedByString:@"&"];
    
    //    NSLog(@"datacenter-adplay---%@", paraString);
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeAdPlay
                           andUrlContent:paraString];
#endif
    return;
}
#endif

#pragma mark - error

+(void)addErrorDataWithAid:(NSString *)album_id
                       vid:(NSString *)vid
                     title:(NSString *)title
                 videoType:(NSString *)videoType
               originalUrl:(NSString *)original_url
                     ddUrl:(NSString *)dd_url
                    action:(ERROR_ACTION)act
                error_type:(ERROR_TYPE)errorType
{
    if ([NetworkReachability connectedToNetwork]) {
        album_id = [NSString safeString:album_id];
        vid = [NSString safeString:vid];
        title = [NSString safeString:title];
        videoType = [NSString safeString:videoType];
        original_url = [NSString safeString:original_url];
        dd_url = [NSString safeString:dd_url];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:album_id forKey:@"album_id"];
        [params setObject:vid forKey:@"vid"];
        [params setObject:title forKey:@"title"];
        [params setObject:videoType forKey:@"video_type"];
        [params setObject:[NetworkReachability currentNetType] forKey:@"net_type"];
        [params setObject:@"" forKey:@"net_speed"];
        [params setObject:original_url forKey:@"original_url"];
        [params setObject:dd_url forKey:@"dd_url"];
        [params setObject:[NSString stringWithFormat:@"%d", act] forKey:@"action"];
        [params setObject:[NSString stringWithFormat:@"%d", errorType] forKey:@"error_type"];
        [params setObject:@"" forKey:@"error_log"];
        [params setObject:@"ios" forKey:@"device_os"];
        [params setObject:[[UIDevice currentDevice] systemVersion] forKey:@"device_osversion"];
        [params setObject:@"apple" forKey:@"device_brand"];
        [params setObject:[[[UIDevice currentDevice] model] encodedURLParameterString] forKey:@"device_model"];
        
        NSLog(@"异常：%@",params);
        
        [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_ErrorUpload
                                   andDynamicValues:nil
                                      andHttpMethod:@"POST"
                                      andParameters:params
                                  completionHandler:^(NSDictionary *responseDic) {
                                      NSLog(@"error data upload success. %@", responseDic);
                                  } errorHandler:^(NSError *error) {
                                      NSLog(@"error data upload failed.");
                                  }];
        NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_ErrorUpload
                                                     andDynamicValues:nil];
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:nil];
        NSString *postString= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *uploadFileContent=[NSString stringWithFormat:@"urlModule:%d url:%@ params:%@",LTURLModule_ErrorUpload,url ,postString];
        [[self class] writeToErrorLogFile:uploadFileContent];
    }
    
    return;
    
}


#pragma mark -
#pragma mark -
#pragma mark - 2.0 统计

#pragma mark - Login

+ (NSString *)addLoginData:(LTDCLoginStatus)loginStatus
{
    LT_DC_FIELD_DEFINE(login, ver)      // 日志版本号
    LT_DC_FIELD_DEFINE(login, p1)       // 一级产品线代码
    LT_DC_FIELD_DEFINE(login, p2)       // 二级产品线代码
    LT_DC_FIELD_DEFINE(login, p3)       // 三级产品线代码
    LT_DC_FIELD_DEFINE(login, uid)      // 乐视网用户注册 ID
    LT_DC_FIELD_DEFINE(login, lc)       // Letv cookie
    LT_DC_FIELD_DEFINE(login, auid)     // 设备 ID
    LT_DC_FIELD_DEFINE(login, uuid)     // 用户访问的唯一标识
    LT_DC_FIELD_DEFINE(login, lp)       // 登录属性
    LT_DC_FIELD_DEFINE(login, ch)       // 登录渠道
    LT_DC_FIELD_DEFINE(login, ref)      // 登录来源
    LT_DC_FIELD_DEFINE(login, ts)       // Timestamp 登录时间 用秒数来表示
    LT_DC_FIELD_DEFINE(login, pcode)    // pcode
    LT_DC_FIELD_DEFINE(login, st)       // Status 登录状态 0:登录成功 1:退出登录
    LT_DC_FIELD_DEFINE(login, zid)      // 专题id
    LT_DC_FIELD_DEFINE(login, r)        // 随机数
    LT_DC_FIELD_DEFINE(login, nt)       // 网络类型
    LT_DC_FIELD_DEFINE(login, location)     // 用户的地址
    
    LT_DC_FIELD_DEFINE(env, mac)    // 设备 Mac 地址，，，，与login日志设备id对应
    LT_DC_FIELD_DEFINE(env, os)     // 操作系统
    LT_DC_FIELD_DEFINE(env, osv)    // 操作系统版本
    LT_DC_FIELD_DEFINE(env, app)    // 应用版本号
    LT_DC_FIELD_DEFINE(env, bd)     // 终端品牌
    LT_DC_FIELD_DEFINE(env, xh)     // 终端型号
    LT_DC_FIELD_DEFINE(env, ro)     // Resolution:分辨率
    LT_DC_FIELD_DEFINE(env, br)     // Browser 浏览器名称
    LT_DC_FIELD_DEFINE(env, ep)     // 环境属性
    LT_DC_FIELD_DEFINE(env, ssid)      // wifi标示
    LT_DC_FIELD_DEFINE(env, lo)      // 经度
    LT_DC_FIELD_DEFINE(env, la)      //  纬度
    LT_DC_FIELD_DEFINE(env, ctime)    // 新增的上报时间点
    
    id appdelegate = [UIApplication sharedApplication].delegate;
    NSString *user_flag = @"";
    
    if ([[LeTVAppModule sharedModule] isImplemented])
    {
        LetvUserType type = (LetvUserType)[[LeTVAppModule sharedModule] letv_AppDelegate_getLetvUserType];
        if (LetvUserNew == type) {
            user_flag = @"n";
        }
        else if (LetvUserUpgrade == type){
            user_flag = @"u";
        }
    }
    else
    {
        if ([appdelegate respondsToSelector:@selector(letvUserType)]) {
            LetvUserType type = (LetvUserType)[appdelegate performSelector:@selector(letvUserType)];
            if (LetvUserNew == type) {
                user_flag = @"n";
            }
            else if (LetvUserUpgrade == type){
                user_flag = @"u";
            }
        }
    }
    
    NSString *onlen = @"";
    if (LTDCLoginStatusLogout == loginStatus) {
        double loginTime = [SettingManager getVirtualLoginTime];
        NSTimeInterval curTime = [[NSDate date] timeIntervalSince1970];
        double sessionTime = curTime - loginTime;
        onlen = [NSString stringWithFormat:@"%.2f", sessionTime];
    }
    
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    
    NSUUID *idfa = [ASIdentifierManager sharedManager].advertisingIdentifier;
    NSString *idfaStr = [idfa UUIDString];
    if (idfaStr == nil) {
        idfaStr = @"";
    }

    NSDictionary *dictLp = @{
                             @"usertype"    : [NSString safeString:user_flag],
                             @"onlen"       : [NSString safeString:onlen],
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"model"       : [NSString safeString:platform],
                             @"idfa"        : [NSString safeString:idfaStr]
                             };
    NSMutableArray *arrayLpVerified = [NSMutableArray array];
    [dictLp enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            [arrayLpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        LT_DATA_CENTER_EMPTY_REQUIRED]];
        }
        else{
            NSString *objValue = (NSString *)obj;
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayLpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }];
    
    [arrayLpVerified addObject:[NSString stringWithFormat:@"app=%@",CURRENT_VERSION]];
    NSString *timeString = [[self class] getTimeString];
    
    CLLocation *currentLocation = [[GlobalMethods shareLocation] location];
    NSString *longitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    
    NSString *ssid = [[DeviceManager getCurrentWiFiSSID] encodedURLParameterString];
    if ([NSString empty:ssid]) {
        ssid = @"";
    }
    
    NSDictionary *dictData = @{s_login_ver    : LT_DATA_CENTER_KV_VERSION,
                               s_login_p1     : LT_DATA_CENTER_P1VALUE,
                               s_login_p2     : LT_DATA_CENTER_P2VALUE,
                               s_login_p3     : LT_DATA_CENTER_P3VALUE,
                               s_login_uid    : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_login_lc     : @"",
                               s_login_auid   : [DeviceManager getDeviceUUID],
                               s_login_uuid   : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_login_lp     : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_login_ch     : @"",
                               s_login_ref    : @"",
                               s_login_ts     : [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970])],
                               s_login_pcode  : CURRENT_PCODE,
                               s_login_st     : (LTDCLoginStatusLogin == loginStatus) ? @"0" : @"1",
                               s_login_zid    : @"",
                               s_login_r      : [[self class] generateRandomValue],
                               s_login_nt     : [NetworkReachability currentNetType],
                               s_login_location  : [[SettingManager getUserArea] encodedURLParameterString],
                               
                               s_env_mac      : [DeviceManager getDeviceUUID],
                               s_env_os       : LT_DATA_CENTER_OPSYSTEM,
                               s_env_osv      : [[UIDevice currentDevice] systemVersion],
                               s_env_app      : LT_DATA_CENTER_APPVERSION,
                               s_env_bd       : LT_DATA_CENTER_BRAND,
                               s_env_xh       : LT_DATA_CENTER_TERMINALTYPE,
                               s_env_ro       : [DeviceManager getDeviceResolution],
                               s_env_br       : LT_DATA_CENTER_BROWSER,
                               s_env_ep       : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_env_ssid     : ssid,
                               s_env_ctime   : timeString,
                               s_env_lo       : longitude,
                               s_env_la       : latitude
                               };
    
    NSArray *arrRequiredKeys = @[s_login_ver,
                                 s_login_p1,
                                 s_login_p2,
                                 s_login_uid,
                                 s_login_lc,
                                 s_login_auid,
                                 s_login_r,
                                 s_login_nt,
                                 s_env_mac,
                                 s_env_ep,
                                 s_env_lo,
                                 s_env_la,
                                 s_env_ssid
                                 ];
    
    switch (loginStatus) {
        case LTDCLoginStatusLogin:
        {
            [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVLogin
                                      andRawData:dictData
                                 andRequiredKeys:arrRequiredKeys];
            
            [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVEnv
                                      andRawData:dictData
                                 andRequiredKeys:arrRequiredKeys];
            return nil;
        }
            break;
        case LTDCLoginStatusLogout:
        {
//            return [[self class] cacheStatisticsWithType:LTDataCenterStatisticsTypeKVLogout
//                                              andRawData:dictData
//                                         andRequiredKeys:arrRequiredKeys];
            
            [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVLogin
                                      andRawData:dictData
                                 andRequiredKeys:arrRequiredKeys];
            
            [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVEnv
                                      andRawData:dictData
                                 andRequiredKeys:arrRequiredKeys];
        }
            
        default:
            break;
    }
    
    return nil;
    
}



#pragma mark Env
+ (void)addEnvData
{
    LT_DC_FIELD_DEFINE(login, ver)      // 日志版本号
    LT_DC_FIELD_DEFINE(login, p1)       // 一级产品线代码
    LT_DC_FIELD_DEFINE(login, p2)       // 二级产品线代码
    LT_DC_FIELD_DEFINE(login, p3)       // 三级产品线代码
    LT_DC_FIELD_DEFINE(login, uid)      // 乐视网用户注册 ID
    LT_DC_FIELD_DEFINE(login, lc)       // Letv cookie
    LT_DC_FIELD_DEFINE(login, auid)     // 设备 ID
    LT_DC_FIELD_DEFINE(login, uuid)     // 用户访问的唯一标识
    LT_DC_FIELD_DEFINE(login, lp)       // 登录属性
    LT_DC_FIELD_DEFINE(login, ch)       // 登录渠道
    LT_DC_FIELD_DEFINE(login, ref)      // 登录来源
    LT_DC_FIELD_DEFINE(login, ts)       // Timestamp 登录时间 用秒数来表示
    LT_DC_FIELD_DEFINE(login, pcode)    // pcode
    LT_DC_FIELD_DEFINE(login, st)       // Status 登录状态 0:登录成功 1:退出登录
    LT_DC_FIELD_DEFINE(login, zid)      // 专题id
    LT_DC_FIELD_DEFINE(login, r)        // 随机数
    LT_DC_FIELD_DEFINE(login, nt)       // 网络类型
    
    LT_DC_FIELD_DEFINE(env, mac)    // 设备 Mac 地址，，，，与login日志设备id对应
    LT_DC_FIELD_DEFINE(env, os)     // 操作系统
    LT_DC_FIELD_DEFINE(env, osv)    // 操作系统版本
    LT_DC_FIELD_DEFINE(env, app)    // 应用版本号
    LT_DC_FIELD_DEFINE(env, bd)     // 终端品牌
    LT_DC_FIELD_DEFINE(env, xh)     // 终端型号
    LT_DC_FIELD_DEFINE(env, ro)     // Resolution:分辨率
    LT_DC_FIELD_DEFINE(env, br)     // Browser 浏览器名称
    LT_DC_FIELD_DEFINE(env, ep)     // 环境属性
    LT_DC_FIELD_DEFINE(env, ssid)      // wifi标示
    LT_DC_FIELD_DEFINE(env, lo)      // 经度
    LT_DC_FIELD_DEFINE(env, la)      //  纬度
    
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    NSDictionary *dictEp = @{
                             @"model"       : [NSString safeString:platform],
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    NSMutableArray *arrayLpVerified = [NSMutableArray array];
    [dictEp enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            [arrayLpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        LT_DATA_CENTER_EMPTY_REQUIRED]];
        }
        else{
            NSString *objValue = (NSString *)obj;
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayLpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }];
    CLLocation *currentLocation = [[GlobalMethods shareLocation] location];
    NSString *longitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    NSDictionary *dictData = @{s_login_ver    : LT_DATA_CENTER_KV_VERSION,
                               s_login_p1     : LT_DATA_CENTER_P1VALUE,
                               s_login_p2     : LT_DATA_CENTER_P2VALUE,
                               s_login_p3     : LT_DATA_CENTER_P3VALUE,
                               s_login_uid    : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_login_lc     : @"",
                               s_login_auid   : [DeviceManager getDeviceUUID],
                               s_login_uuid   : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_login_lp     : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_login_ch     : @"",
                               s_login_ref    : @"",
                               s_login_ts     : [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970])],
                               s_login_pcode  : CURRENT_PCODE,
                               s_login_zid    : @"",
                               s_login_r      : [[self class] generateRandomValue],
                               s_login_nt     : [NetworkReachability currentNetType],
                               
                               s_env_mac      : [DeviceManager getDeviceUUID],
                               s_env_os       : LT_DATA_CENTER_OPSYSTEM,
                               s_env_osv      : [[UIDevice currentDevice] systemVersion],
                               s_env_app      : LT_DATA_CENTER_APPVERSION,
                               s_env_bd       : LT_DATA_CENTER_BRAND,
                               s_env_xh       : LT_DATA_CENTER_TERMINALTYPE,
                               s_env_ro       : [DeviceManager getDeviceResolution],
                               s_env_br       : LT_DATA_CENTER_BROWSER,
                               s_env_ep       : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_env_ssid     : [DeviceManager getCurrentWiFiSSID],
                               s_env_lo       : longitude,
                               s_env_la       : latitude
                               };
    
    NSArray *arrRequiredKeys = @[s_login_ver,
                                 s_login_p1,
                                 s_login_p2,
                                 s_login_uid,
                                 s_login_lc,
                                 s_login_auid,
                                 s_login_r,
                                 s_login_nt,
                                 s_env_mac,
                                 s_env_ep,
                                 s_env_lo,
                                 s_env_la,
                                 s_env_ssid
                                 ];
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVEnv
                              andRawData:dictData
                         andRequiredKeys:arrRequiredKeys];
}

#pragma mark - Error

+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              andVid:(NSString *)vid
       errorProperty:(NSDictionary *)ep
         andPlayUUid:(NSString *)playuuid
{
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        andVid:cid
                         andvt:@""
                 errorProperty:ep
                   andPlayUUid:playuuid];
}
+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              andVid:(NSString *)vid
               andvt:(NSString *)vt
       errorProperty:(NSDictionary *)ep
         andPlayUUid:(NSString *)playuuid
{
    if (![NetworkReachability connectedToNetwork]) {
        return;
    }
    
    LT_DC_FIELD_DEFINE(err, ver)     // 一级产品线代码
    LT_DC_FIELD_DEFINE(err, p1)     // 一级产品线代码
    LT_DC_FIELD_DEFINE(err, p2)     // 二级产品线代码
    LT_DC_FIELD_DEFINE(err, p3)     // 三级产品线代码
    LT_DC_FIELD_DEFINE(err, err)     // 错误代码
    LT_DC_FIELD_DEFINE(err, lc)     // Letv cookie
    LT_DC_FIELD_DEFINE(err, uuid)   // 登录时生成的 uuid
    LT_DC_FIELD_DEFINE(err, auid)   // auid
    LT_DC_FIELD_DEFINE(err, ip)     // IP地址
    LT_DC_FIELD_DEFINE(err, mac)    // 设备 Mac 地址，，，，与login日志设备id对应
    LT_DC_FIELD_DEFINE(err, nt)     // Net type:上网类型
    LT_DC_FIELD_DEFINE(err, os)     // 操作系统
    LT_DC_FIELD_DEFINE(err, osv)    // 操作系统版本
    LT_DC_FIELD_DEFINE(err, app)    // 应用版本号
    LT_DC_FIELD_DEFINE(err, bd)     // 终端品牌
    LT_DC_FIELD_DEFINE(err, xh)     // 终端型号
    LT_DC_FIELD_DEFINE(err, ro)     // Resolution:分辨率
    LT_DC_FIELD_DEFINE(err, br)     // Browser 浏览器名称
    LT_DC_FIELD_DEFINE(err, src)     // 用于区分不同日志上报的环境来源标识
    LT_DC_FIELD_DEFINE(err, ep)     // 环境属性
    LT_DC_FIELD_DEFINE(err, cid)
    LT_DC_FIELD_DEFINE(err, pid)
    LT_DC_FIELD_DEFINE(err, vid)
    LT_DC_FIELD_DEFINE(err, zid)     // 专题id
    LT_DC_FIELD_DEFINE(err, r)      // 随机数
    LT_DC_FIELD_DEFINE(err, vt)     // 播放的码流
    LT_DC_FIELD_DEFINE(err, et)     // 播放错误，其他错误不需要上报该字段
    
    
    NSString *playCode = [ep safeValueForKey:@"et"];
    NSMutableArray *arrayEpVerified = [NSMutableArray array];
    [ep enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            [arrayEpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        LT_DATA_CENTER_EMPTY_REQUIRED]];
        }
        else{
            NSString *objValue = (NSString *)obj;
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayEpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }];
    NSDictionary *dictData = @{
                               s_err_ver     : LT_DATA_CENTER_KV_VERSION_3,
                               s_err_p1     : LT_DATA_CENTER_P1VALUE,
                               s_err_p2     : LT_DATA_CENTER_P2VALUE,
                               s_err_p3     : LT_DATA_CENTER_P3VALUE,
                               s_err_err    : [NSString safeString:errorCode],
                               s_err_lc     : @"",
                               s_err_uuid   : [NSString isBlankString:playuuid]?[NSString safeString:[SettingManager getVirtualLoginUUID]]:playuuid,
                               s_err_auid   : [DeviceManager getDeviceUUID],
                               s_err_ip     : @"",
                               s_err_mac    : [DeviceManager getDeviceUUID],
                               s_err_nt     : [NetworkReachability currentNetType],
                               s_err_os     : LT_DATA_CENTER_OPSYSTEM,
                               s_err_osv    : [[UIDevice currentDevice] systemVersion],
                               s_err_app    : LT_DATA_CENTER_APPVERSION,
                               s_err_bd     : LT_DATA_CENTER_BRAND,
                               s_err_xh     : LT_DATA_CENTER_TERMINALTYPE,
                               s_err_ro     : [DeviceManager getDeviceResolution],
                               s_err_br     : LT_DATA_CENTER_BROWSER,
                               s_err_src    : @"",
                               s_err_ep     :  [[arrayEpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_err_cid    : [NSString safeString:cid],
                               s_err_pid    : [NSString safeString:pid],
                               s_err_vid    : [NSString safeString:vid],
                               s_err_zid    : @"",
                               s_err_r      : [[self class] generateRandomValue],
                               s_err_vt     : [NSString safeString:vt]
                               
                               };
    NSMutableDictionary *dictEp = [[NSMutableDictionary alloc] initWithDictionary:dictData];
    if (![NSString safeString:playCode]) {
        [dictEp setValue:playCode forKey:s_err_et];
    }
    NSArray *arrRequiredKeys = @[s_err_p1,
                                 s_err_p2,
                                 s_err_err,
                                 s_err_lc,
                                 s_err_uuid,
                                 s_err_ip,
                                 s_err_mac,
                                 s_err_nt,
                                 s_err_ep,
                                 s_err_cid,
                                 s_err_pid,
                                 s_err_vid,
                                 s_err_r];
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVError
                              andRawData:dictData
                         andRequiredKeys:arrRequiredKeys];
}

+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid
{
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        adnVid:vid
                andDownloadUrl:@""
                andRequestUrl:@""
                    andPlayUrl:@""
                     andPlayVt:VIDEO_CODE_UNKNOWN
                 andLivingCode:@""];
}

+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid
      andDownloadUrl:(NSString *)DownloadUrl
      andRequestUrl:(NSString *)RequestUrl
          andPlayUrl:(NSString *)PlayUrl
           andPlayVt:(VideoCodeType)videoCode
       andLivingCode:(NSString *)code

{
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        adnVid:vid
                andDownloadUrl:DownloadUrl
                    andPlayUrl:PlayUrl
                     andPlayVt:videoCode
                 andLivingCode:code
                 andRequestUrl:RequestUrl
                 andStatusCode:@""
                      andUtime:@""
                  andPlayUUid:nil];

}
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
{
    [self addErrorData:errorCode
                andCid:cid
                andPid:pid
                adnVid:vid
        andDownloadUrl:DownloadUrl
            andPlayUrl:PlayUrl
             andPlayVt:videoCode
         andLivingCode:code
         andRequestUrl:requestUrl
         andStatusCode:statusCode
              andUtime:utime
           andPlayUUid:playuuid
        andisPlayError:isPlayError
       andExtendFields:nil];
}

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
     andExtendFields:(NSDictionary *)extendDic
{
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    NSDictionary *dict = @{
                           @"model"       : [NSString safeString:platform],
                           @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                           @"time"        : [NSString formatStatisticCurrentTimeString],
                           @"url"         : [NSString safeString:requestUrl],
                           @"status"      : [NSString safeString:statusCode],
                           @"ut"          : [NSString safeString:utime]
                           };
    NSMutableDictionary *dictEp = [[NSMutableDictionary alloc] initWithDictionary:dict];
    
    if (extendDic && [extendDic isKindOfClass:[NSDictionary class]]) {
        [dictEp addEntriesFromDictionary:extendDic];
    }
    
    if (![NSString isBlankString:DownloadUrl])
    {
        [dictEp setObject:DownloadUrl forKey:@"downloadurl"];
    }
    if (isPlayError) {
        [dictEp setObject:errorCode forKey:@"et"];
    }
    if (![NSString isBlankString:PlayUrl])
    {
        [dictEp setObject:PlayUrl forKey:@"playurl"];
    }
    NSString *vt = @"";
    if (![NSString isBlankString:vt])
    {
        // vt
        switch (videoCode) {
            case VIDEO_CODE_ULD:
            {
                vt = @"58";
            }
                break;
            case VIDEO_CODE_HD:
            {
                vt = @"22";
            }
                break;
            case VIDEO_CODE_SD:
            {
                vt = @"13";
            }
                break;
            case VIDEO_CODE_LD:
            {
                vt = @"21";
            }
                break;
            case VIDEO_CODE_UNKNOWN:
            {
                if (![NSString isBlankString:code]) {
                    vt = [[self class] getLiveCode:code];
                }
            }
                break;
            default:
                break;
        }
    }
    
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        andVid:vid
                         andvt:vt
                 errorProperty:dictEp
                   andPlayUUid:playuuid];
}

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
{
    
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    NSDictionary *dict = @{
                           @"model"       : [NSString safeString:platform],
                           @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                           @"time"        : [NSString formatStatisticCurrentTimeString],
                           @"url"         : [NSString safeString:requestUrl],
                           @"status"      : [NSString safeString:statusCode],
                           @"ut"          : [NSString safeString:utime]
                           };
    NSMutableDictionary *dictEp = [[NSMutableDictionary alloc] initWithDictionary:dict];
    
    if (![NSString isBlankString:DownloadUrl])
    {
        [dictEp setObject:DownloadUrl forKey:@"downloadurl"];
    }
    
    if (![NSString isBlankString:PlayUrl])
    {
        [dictEp setObject:PlayUrl forKey:@"playurl"];
    }
    
    NSString *vt = @"";
    if (![NSString isBlankString:vt])
    {
        // vt
        switch (videoCode) {
            case VIDEO_CODE_ULD:
            {
                vt = @"58";
            }
                break;
            case VIDEO_CODE_HD:
            {
                vt = @"22";
            }
                break;
            case VIDEO_CODE_SD:
            {
                vt = @"13";
            }
                break;
            case VIDEO_CODE_LD:
            {
                vt = @"21";
            }
                break;
            case VIDEO_CODE_UNKNOWN:
            {
                if (![NSString isBlankString:code]) {
                    vt = [[self class] getLiveCode:code];
                }
            }
                break;
            default:
                break;
        }
    }
    
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        andVid:vid
                         andvt:vt
                 errorProperty:dictEp
                   andPlayUUid:playuuid];
}

+ (void)addCrashDataWithCount:(NSInteger)crashCount
{
    if (crashCount <= 0) {
        return;
    }
    
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    NSDictionary *dictEp = @{
                             @"model"       : [NSString safeString:platform],
                             @"cnt"         : [NSString stringWithFormat:@"%ld", (long)crashCount],
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addErrorData:@"20001"
                        andCid:nil
                        andPid:nil
                        andVid:nil
                 errorProperty:dictEp
                   andPlayUUid:nil];
}

#pragma mark Action
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
                 rank:(NSString *)rank  //点击视频在推荐区域的排序

{
    [LTDataCenter addActionData:acode
                 actionProperty:ap
                   actionResult:ar
                            cid:cid
                            pid:pid
                            vid:vid
                            zid:zid
                     currentUrl:cur_url
                           reid:reid
                           area:area
                         bucket:bucket
                           rank:rank
                            lid:nil];
}

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
{
    if ([NSString isBlankString:[SettingManager getVirtualLoginUUID]]) {
        return;
    }
    
    NSMutableArray *arrayApVerified = [NSMutableArray array];
    
    NSArray *allApkeys = [ap allKeys];
    NSArray *sortKeyArray = [allApkeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for(NSString *key in sortKeyArray)
    {
        
        NSString *obj =[ap objectForKey:key];
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            //
        }
        else{
            NSString *objValue = [NSString safeString:obj];
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayApVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }
    
    [arrayApVerified addObject:[NSString stringWithFormat:@"app=%@",CURRENT_VERSION]];
    
    LT_DC_FIELD_DEFINE(action, ver)
    LT_DC_FIELD_DEFINE(action, p1)
    LT_DC_FIELD_DEFINE(action, p2)
    LT_DC_FIELD_DEFINE(action, p3)
    LT_DC_FIELD_DEFINE(action, acode)
    LT_DC_FIELD_DEFINE(action, ap)
    LT_DC_FIELD_DEFINE(action, ar)
    LT_DC_FIELD_DEFINE(action, cid)
    LT_DC_FIELD_DEFINE(action, pid)
    LT_DC_FIELD_DEFINE(action, vid)
    LT_DC_FIELD_DEFINE(action, uid)
    LT_DC_FIELD_DEFINE(action, uuid)
    LT_DC_FIELD_DEFINE(action, lc)
    LT_DC_FIELD_DEFINE(action, cur_url)
    LT_DC_FIELD_DEFINE(action, ch)
    LT_DC_FIELD_DEFINE(action, pcode)
    LT_DC_FIELD_DEFINE(action, auid)
    LT_DC_FIELD_DEFINE(action, ilu)
    LT_DC_FIELD_DEFINE(action, zid)
    LT_DC_FIELD_DEFINE(action, reid)
    LT_DC_FIELD_DEFINE(action, area)
    LT_DC_FIELD_DEFINE(action, bucket)
    LT_DC_FIELD_DEFINE(action, rank)
    LT_DC_FIELD_DEFINE(action, r)
    LT_DC_FIELD_DEFINE(action, lid)
    LT_DC_FIELD_DEFINE(action, nt)     // Net type:上网类型

    
#ifndef LT_MERGE_FROM_IPAD_CLIENT    
    NSDictionary *dictData = @{
                               s_action_ver       : LT_DATA_CENTER_KV_VERSION_3,
                               s_action_p1        : LT_DATA_CENTER_P1VALUE,
                               s_action_p2        : LT_DATA_CENTER_P2VALUE,
                               s_action_p3        : LT_DATA_CENTER_P3VALUE,
                               s_action_acode     : [NSString stringWithFormat:@"%ld", (long)acode],
                               s_action_ap        : [[arrayApVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_action_ar        : [NSString stringWithFormat:@"%d", !ar],
                               s_action_cid       : [NSString safeString:cid],
                               s_action_pid       : [NSString safeString:pid],
                               s_action_vid       : [NSString safeString:vid],
                               s_action_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_action_uuid      : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_action_lc        : @"-",
                               s_action_cur_url   : [[NSString safeString:cur_url] encodedURLParameterString],
                               s_action_ch        : @"",
                               s_action_pcode     : CURRENT_PCODE,
                               s_action_auid      : [DeviceManager getDeviceUUID],
                               s_action_ilu       : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_action_zid       : [NSString safeStringForStatistic:zid],
                               s_action_reid      : [NSString safeString:reid],
                               s_action_area      : [NSString safeString:area],
                               s_action_bucket    : [NSString safeString:bucket],
                               s_action_rank      : [NSString safeString:rank],
                               s_action_r         : [[self class] generateRandomValue],
                               s_action_lid       : [NSString safeString:lid],
                               s_action_nt        : [NetworkReachability currentNetType]
                               };
    
    NSArray *arrRequiredKeys = @[s_action_ver,
                                 s_action_p1,
                                 s_action_p2,
                                 s_action_p3,
                                 s_action_cid,
                                 s_action_pid,
                                 s_action_vid,
                                 s_action_uid,
                                 s_action_uuid,
                                 s_action_lc,
                                 s_action_cur_url,
                                 s_action_auid,
                                 s_action_ilu,
                                 s_action_r,
                                 s_action_lid,
                                 s_action_nt];
#else /* LT_MERGE_FROM_IPAD_CLIENT */
    NSDictionary *dictData = @{
                               s_action_ver       : LT_DATA_CENTER_KV_VERSION_3,
                               s_action_p1        : LT_DATA_CENTER_P1VALUE,
                               s_action_p2        : LT_DATA_CENTER_P2VALUE,
                               s_action_p3        : LT_DATA_CENTER_P3VALUE,
                               s_action_acode     : [NSString stringWithFormat:@"%ld", (long)acode],
                               s_action_ap        : [[arrayApVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_action_ar        : [NSString stringWithFormat:@"%d", !ar],
                               s_action_cid       : [NSString safeString:cid],
                               s_action_pid       : [NSString safeString:pid],
                               s_action_vid       : [NSString safeString:vid],
                               s_action_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_action_uuid      : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_action_lc        : @"-",
                               s_action_cur_url   : [[NSString safeString:cur_url] encodedURLParameterString],
                               s_action_ch        : @"",
                               s_action_pcode     : CURRENT_PCODE,
                               s_action_auid      : [DeviceManager getDeviceUUID],
                               s_action_ilu       : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_action_zid       : [NSString safeStringForStatistic:zid],
                               s_action_reid      : [NSString safeString:reid],
                               s_action_area      : [NSString safeString:area],
                               s_action_bucket    : [NSString safeString:bucket],
                               s_action_rank      : [NSString safeString:rank],
                               s_action_r         : [[self class] generateRandomValue],
                               s_action_lid       : [NSString safeString:lid],
                               s_action_nt        : [NetworkReachability currentNetType],
                               };
    
    
    NSArray *arrRequiredKeys = @[s_action_ver,
                                 s_action_p1,
                                 s_action_p2,
                                 s_action_p3,
                                 s_action_cid,
                                 s_action_pid,
                                 s_action_vid,
                                 s_action_uid,
                                 s_action_uuid,
                                 s_action_lc,
                                 s_action_cur_url,
                                 s_action_auid,
                                 s_action_ilu,
                                 s_action_r,
                                 s_action_lid,
                                 s_action_nt];
#endif /* LT_MERGE_FROM_IPAD_CLIENT */
    [[self class] sendActionStatisticsWithRawData:dictData
                                  andRequiredKeys:arrRequiredKeys
                                    andActionCode:acode];
    
    if (acode==LTDCActionCodePlayFailed) {
        NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                      andRequiredKeys:arrRequiredKeys];
        
        [[self class] writeToErrorLogFile:strContent];
    }
    
    
    return;

 
}




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
             playUUid:(NSString *)playuuid
{
    if ([NSString isBlankString:playuuid]) {
        return;
    }
    
    NSMutableArray *arrayApVerified = [NSMutableArray array];
    
    NSArray *allApkeys = [ap allKeys];
    NSArray *sortKeyArray = [allApkeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for(NSString *key in sortKeyArray)
    {
        
        NSString *obj =[ap objectForKey:key];
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            //
        }
        else{
            NSString *objValue = [NSString safeString:obj];
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayApVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }
    
    [arrayApVerified addObject:[NSString stringWithFormat:@"app=%@",CURRENT_VERSION]];
    
    LT_DC_FIELD_DEFINE(action, ver)
    LT_DC_FIELD_DEFINE(action, p1)
    LT_DC_FIELD_DEFINE(action, p2)
    LT_DC_FIELD_DEFINE(action, p3)
    LT_DC_FIELD_DEFINE(action, acode)
    LT_DC_FIELD_DEFINE(action, ap)
    LT_DC_FIELD_DEFINE(action, ar)
    LT_DC_FIELD_DEFINE(action, cid)
    LT_DC_FIELD_DEFINE(action, pid)
    LT_DC_FIELD_DEFINE(action, vid)
    LT_DC_FIELD_DEFINE(action, uid)
    LT_DC_FIELD_DEFINE(action, uuid)
    LT_DC_FIELD_DEFINE(action, lc)
    LT_DC_FIELD_DEFINE(action, cur_url)
    LT_DC_FIELD_DEFINE(action, ch)
    LT_DC_FIELD_DEFINE(action, pcode)
    LT_DC_FIELD_DEFINE(action, auid)
    LT_DC_FIELD_DEFINE(action, ilu)
    LT_DC_FIELD_DEFINE(action, zid)
    LT_DC_FIELD_DEFINE(action, reid)
    LT_DC_FIELD_DEFINE(action, area)
    LT_DC_FIELD_DEFINE(action, bucket)
    LT_DC_FIELD_DEFINE(action, rank)
    LT_DC_FIELD_DEFINE(action, r)
    LT_DC_FIELD_DEFINE(action, lid)
    LT_DC_FIELD_DEFINE(action, nt)     // Net type:上网类型
    
    
#ifndef LT_MERGE_FROM_IPAD_CLIENT
    NSDictionary *dictData = @{
                               s_action_ver       : LT_DATA_CENTER_KV_VERSION_3,
                               s_action_p1        : LT_DATA_CENTER_P1VALUE,
                               s_action_p2        : LT_DATA_CENTER_P2VALUE,
                               s_action_p3        : LT_DATA_CENTER_P3VALUE,
                               s_action_acode     : [NSString stringWithFormat:@"%ld", (long)acode],
                               s_action_ap        : [[arrayApVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_action_ar        : [NSString stringWithFormat:@"%d", !ar],
                               s_action_cid       : [NSString safeString:cid],
                               s_action_pid       : [NSString safeString:pid],
                               s_action_vid       : [NSString safeString:vid],
                               s_action_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_action_uuid      : [NSString safeString:playuuid],
                               s_action_lc        : @"-",
                               s_action_cur_url   : [[NSString safeString:cur_url] encodedURLParameterString],
                               s_action_ch        : @"",
                               s_action_pcode     : CURRENT_PCODE,
                               s_action_auid      : [DeviceManager getDeviceUUID],
                               s_action_ilu       : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_action_zid       : [NSString safeStringForStatistic:zid],
                               s_action_reid      : [NSString safeString:reid],
                               s_action_area      : [NSString safeString:area],
                               s_action_bucket    : [NSString safeString:bucket],
                               s_action_rank      : [NSString safeString:rank],
                               s_action_r         : [[self class] generateRandomValue],
                               s_action_lid       : [NSString safeString:lid],
                               s_action_nt        : [NetworkReachability currentNetType]
                               };
    
    NSArray *arrRequiredKeys = @[s_action_ver,
                                 s_action_p1,
                                 s_action_p2,
                                 s_action_p3,
                                 s_action_cid,
                                 s_action_pid,
                                 s_action_vid,
                                 s_action_uid,
                                 s_action_uuid,
                                 s_action_lc,
                                 s_action_cur_url,
                                 s_action_auid,
                                 s_action_ilu,
                                 s_action_r,
                                 s_action_lid,
                                 s_action_nt];
#else /* LT_MERGE_FROM_IPAD_CLIENT */
    NSDictionary *dictData = @{
                               s_action_ver       : LT_DATA_CENTER_KV_VERSION_3,
                               s_action_p1        : LT_DATA_CENTER_P1VALUE,
                               s_action_p2        : LT_DATA_CENTER_P2VALUE,
                               s_action_p3        : LT_DATA_CENTER_P3VALUE,
                               s_action_acode     : [NSString stringWithFormat:@"%ld", (long)acode],
                               s_action_ap        : [[arrayApVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_action_ar        : [NSString stringWithFormat:@"%d", !ar],
                               s_action_cid       : [NSString safeString:cid],
                               s_action_pid       : [NSString safeString:pid],
                               s_action_vid       : [NSString safeString:vid],
                               s_action_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_action_uuid      : [NSString safeString:playuuid],
                               s_action_lc        : @"-",
                               s_action_cur_url   : [[NSString safeString:cur_url] encodedURLParameterString],
                               s_action_ch        : @"",
                               s_action_pcode     : CURRENT_PCODE,
                               s_action_auid      : [DeviceManager getDeviceUUID],
                               s_action_ilu       : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_action_zid       : [NSString safeStringForStatistic:zid],
                               s_action_reid      : [NSString safeString:reid],
                               s_action_area      : [NSString safeString:area],
                               s_action_bucket    : [NSString safeString:bucket],
                               s_action_rank      : [NSString safeString:rank],
                               s_action_r         : [[self class] generateRandomValue],
                               s_action_lid       : [NSString safeString:lid],
                               s_action_nt        : [NetworkReachability currentNetType],
                               };
    
    
    NSArray *arrRequiredKeys = @[s_action_ver,
                                 s_action_p1,
                                 s_action_p2,
                                 s_action_p3,
                                 s_action_cid,
                                 s_action_pid,
                                 s_action_vid,
                                 s_action_uid,
                                 s_action_uuid,
                                 s_action_lc,
                                 s_action_cur_url,
                                 s_action_auid,
                                 s_action_ilu,
                                 s_action_r,
                                 s_action_lid,
                                 s_action_nt];
#endif /* LT_MERGE_FROM_IPAD_CLIENT */
    [[self class] sendActionStatisticsWithRawData:dictData
                                  andRequiredKeys:arrRequiredKeys
                                    andActionCode:acode];
    
    if (acode==LTDCActionCodePlayFailed) {
        NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                      andRequiredKeys:arrRequiredKeys];
        
        [[self class] writeToErrorLogFile:strContent];
    }
    
    
    return;
    
    
}




+(void)addAction:(LTDCActionPropertyCategory)apc
        position:(NSInteger)wz
            name:(NSString *)name
           name1:(NSString *)name1
             cid:(NewMovieCid)cid
      currentUrl:(NSString *)cur_url
       isSuccess:(BOOL)ar
{
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeStringForStatistic:fl],
                             @"wz"      : [NSString stringWithFormat:@"%ld", (long)wz],
                             @"name"    : [NSString safeString:name],
                             @"name1"   : [NSString safeString:name1],
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    
    
}

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
        isSuccess:(BOOL)ar
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:acode
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}


+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar
{
    [LTDataCenter addAction:apc
                   position:wz
                       name:name
                        cid:cid
                        pid:nil
                        vid:nil
                 currentUrl:cur_url
                  isSuccess:ar];
}

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar
{
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                            @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:nil
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar
{
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    
    
}

//iphone v6.7 搜索运营词上报 sname
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
        isSuccess:(BOOL)ar
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"sname"    : [NSString safeString:sname],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
           pageID:(LTDCPageID)pageID
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}


+ (void)addActionOnly:(LTDCActionCode)acode
             position:(NSInteger)wzPosition
                 name:(NSString *)name
                   fl:(NSString *)fl
               pageid:(NSString *)pageid
        statisticInfo:(LTStatisticInfo *)statisticInfo {
    
    NSString *lid = [NSString safeString:statisticInfo.lid];
    if ([NSString empty:lid]) {
        lid = @"-";
    }
    
    NSString * wzPositionStr = (wzPosition < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wzPosition];
    NSString *uuid = [NSString safeString:[DeviceManager getIOSDeviceUUID]];
    
    NSMutableDictionary *dictAp = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString safeString:fl]         ,@"fl",
                                   wzPositionStr                    ,@"wz",
                                   [NSString safeString:name]       ,@"name",
                                   [NSString safeString:pageid]     ,@"pageid",
                                   uuid                             ,@"iosid",
                                  [NSString safeString:statisticInfo.hbid]                 ,@"hbid",
                                  [NSString safeStringForStatistic:statisticInfo.scidID]    ,@"scid",
                                   
                                   nil];
    NSString *key = @"vids";
    NSString *ids = @"";
    if (![NSString empty:statisticInfo.vids]) {
        ids = [NSString safeString:statisticInfo.vids];
    }
    else if (![NSString empty:statisticInfo.pids]) {
        key = @"pids";
        ids = [NSString safeString:statisticInfo.pids];
    }
    
    if (![NSString empty:ids]) {
        [dictAp setObject:ids forKey:key];
    }
    if (![NSString empty:statisticInfo.avg_speed]) {
        [dictAp setObject:statisticInfo.avg_speed forKey:@"avg_speed"];
    }
    
    if (![NSString empty:statisticInfo.rpid]) {
        [dictAp setObject:statisticInfo.rpid forKey:@"rpid"];
    }
    if (![NSString empty:statisticInfo.vip]) {
        [dictAp setObject:statisticInfo.vip forKey:@"vip"];
    }
    if (![NSString empty:statisticInfo.ispay]) {
        [dictAp setObject:statisticInfo.vip forKey:@"ispay"];
    }
    if (![NSString empty:statisticInfo.time]) {
        [dictAp setObject:statisticInfo.time forKey:@"time"];
    }
    if (![NSString empty:statisticInfo.ref]) {
        [dictAp setObject:statisticInfo.ref forKey:@"ref"];
    }
    if (![NSString empty:statisticInfo.vidlist]) {
        [dictAp setObject:statisticInfo.vidlist forKey:@"vidlist"];
    }
    
    [[self class] addActionData:acode
                 actionProperty:dictAp
                   actionResult:YES
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:@""
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:statisticInfo.reid
                           area:statisticInfo.area
                         bucket:statisticInfo.bucket
                           rank:statisticInfo.rank
                            lid:lid];
}

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
        isSuccess:(BOOL)ar
{
    NSString *pageid = [NSString fomatPageIDEnumCode:pageID];
    
    
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%d", wz]),
                             @"name"    : [NSString safeString:name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"scid"    : [NSString safeStringForStatistic:scidID],
                             @"streamID": [NSString safeString:lid],
                             @"fragid"  : [NSString safeString:fragId]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:nil];
}
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
        isSuccess:(BOOL)ar
{
    NSString *pageid = [NSString fomatPageIDEnumCode:pageID];
    
    
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"scid"    : [NSString safeStringForStatistic:scidID]
                         
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}


+ (void)addStatisticChannelWallFilter:(LTStatisticInfo *)statisticInfo{
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
//                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"time"    : [NSString safeString:statisticInfo.time],
                             @"scid"    : [NSString safeStringForStatistic:statisticInfo.scidID],
                             @"fragid"  : [NSString safeStringForStatistic:statisticInfo.fragId],
                             @"type" : [NSString safeString:statisticInfo.type],
                             @"ft" : [NSString safeString:statisticInfo.ft],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];

}

#ifndef LT_MERGE_FROM_IPAD_CLIENT

+ (void)addStatisticForAction:(LTStatisticInfo *)statisticInfo
{
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"time"    : [NSString safeString:statisticInfo.time],
                             @"scid"    : [NSString safeStringForStatistic:statisticInfo.scidID],
                             @"fragid"  : [NSString safeStringForStatistic:statisticInfo.fragId],
                             @"type"    : [NSString safeString:statisticInfo.type],
                             @"name1"   : [NSString safeString:statisticInfo.name1],
                             @"lc"      : ((statisticInfo.lc < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.lc]),
                             @"lcName"  : [NSString safeString:statisticInfo.lcName],
                             @"sorts"   : [NSString safeString:statisticInfo.sorts],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];

}

#else /* LT_MERGE_FROM_IPAD_CLIENT */
+ (void)addStatisticForAction:(LTStatisticInfo *)statisticInfo
{
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%d", statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"type"    : [NSString safeString:statisticInfo.type],
                             @"time"    : [NSString safeString:statisticInfo.time],
                             @"messagetype" : [NSString safeString:statisticInfo.messagetype],
                             @"fragid" : [NSString safeString:statisticInfo.fragId],
                             @"name1" : [NSString safeString:statisticInfo.name1],
                             @"scid"  :[NSString safeString:statisticInfo.scidID],
                             @"lc"      : ((statisticInfo.lc < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.lc]),
                             @"lcName"  : [NSString safeString:statisticInfo.lcName],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:[NSString safeString:statisticInfo.reid]
                           area:[NSString safeString:statisticInfo.area]
                         bucket:[NSString safeString:statisticInfo.bucket]
                           rank:[NSString safeString:statisticInfo.rank]
                            lid:[NSString safeString:statisticInfo.lid]];

}
#endif /* LT_MERGE_FROM_IPAD_CLIENT */

#ifndef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addStatistic:(LTStatisticInfo *)statisticInfo
{
    // @"time"    : [NSString safeString:statisticInfo.time],
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"type"    : [NSString safeString:statisticInfo.type],
                             @"messagetype" : [NSString safeString:statisticInfo.messagetype],
                             @"fragid" : [NSString safeString:statisticInfo.fragId],
                             @"scid"    : [NSString safeStringForStatistic:statisticInfo.scidID],
                             @"st"      : [NSString safeString:statisticInfo.st],
                             @"time": [NSString safeString:statisticInfo.time],
                             @"sk"  : [NSString safeString:statisticInfo.sk],
                             @"nt"  : [NSString safeString:statisticInfo.nt],
                             @"ps"  : [NSString safeString:statisticInfo.ps],
                             @"of"  : [NSString safeString:statisticInfo.of],
                             @"cl"  : [NSString safeString:statisticInfo.cl],
                             @"sh"  : [NSString safeString:statisticInfo.sh],
                             @"ref" : [NSString safeString:statisticInfo.ref],
                             @"kd"  : [NSString safeString:statisticInfo.kd],
                             @"ar"  : [NSString safeString:statisticInfo.ar],
                             @"nid" : [NSString safeString:statisticInfo.nid],
                             @"vids": [NSString safeString:statisticInfo.vids],
                             @"pids": [NSString safeString:statisticInfo.pids],
                             @"sorts"   : [NSString safeString:statisticInfo.sorts],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    [[self class] addActionData:statisticInfo.acode
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:[NSString safeString:statisticInfo.reid]
                           area:[NSString safeString:statisticInfo.area]
                         bucket:[NSString safeString:statisticInfo.bucket]
                           rank:[NSString safeString:statisticInfo.rank]
                            lid:[NSString safeString:statisticInfo.lid]];
    ;
    
}

#else /* LT_MERGE_FROM_IPAD_CLIENT */
+ (void)addStatistic:(LTStatisticInfo *)statisticInfo
{
    // @"time"    : [NSString safeString:statisticInfo.time],
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"type"    : [NSString safeString:statisticInfo.type],
                             @"messagetype" : [NSString safeString:statisticInfo.messagetype],
                             @"fragid" : [NSString safeString:statisticInfo.fragId],
                             @"scid"    : [NSString safeStringForStatistic:statisticInfo.scidID],
                             @"st"      : [NSString safeString:statisticInfo.st],
                             @"time": [NSString safeString:statisticInfo.time],
                             @"sk"  : [NSString safeString:statisticInfo.sk],
                             @"nt"  : [NSString safeString:statisticInfo.nt],
                             @"ps"  : [NSString safeString:statisticInfo.ps],
                             @"of"  : [NSString safeString:statisticInfo.of],
                             @"cl"  : [NSString safeString:statisticInfo.cl],
                             @"sh"  : [NSString safeString:statisticInfo.sh],
                             @"ref" : [NSString safeString:statisticInfo.ref],
                             @"kd"  : [NSString safeString:statisticInfo.kd],
                             @"ar"  : [NSString safeString:statisticInfo.ar],
                             @"nid" : [NSString safeString:statisticInfo.nid],
                             @"vids": [NSString safeString:statisticInfo.vids],
                             @"pids": [NSString safeString:statisticInfo.pids],
                             @"sorts"   : [NSString safeString:statisticInfo.sorts],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    [[self class] addActionData:statisticInfo.acode
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:[NSString safeString:statisticInfo.reid]
                           area:[NSString safeString:statisticInfo.area]
                         bucket:[NSString safeString:statisticInfo.bucket]
                           rank:[NSString safeString:statisticInfo.rank]
                            lid:[NSString safeString:statisticInfo.lid]];

}
#endif /* LT_MERGE_FROM_IPAD_CLIENT */

+ (void)addPushAction:(NSString *)msgid
{
    [[self class] addPushAction:msgid
                    andPushType:@""
                 andmessageType:@""
                         andPid:nil
                         andVid:nil
                         andZid:nil
                  andCurrentUrl:nil
              andOtherParameter:nil];
}

+ (void)addPushAction:(NSString *)msgid
          andPushType:(NSString *)pushType
       andmessageType:(NSString *)messagetype
               andPid:(NSString *)pid
               andVid:(NSString *)vid
               andZid:(NSString *)zid
        andCurrentUrl:(NSString *)currentUrl
    andOtherParameter:(NSDictionary *)otherParameter
{
     [[self class] addPushAction:msgid
                    andPushType:pushType
                 andmessageType:messagetype
                         andPid:pid
                         andVid:vid
                         andZid:zid
                         andLid:nil
                  andCurrentUrl:currentUrl
              andOtherParameter:otherParameter];
}

+ (void)addPushAction:(NSString *)msgid
          andPushType:(NSString *)pushType
       andmessageType:(NSString *)messagetype
               andPid:(NSString *)pid
               andVid:(NSString *)vid
               andZid:(NSString *)zid
               andLid:(NSString *)lid
        andCurrentUrl:(NSString *)currentUrl
    andOtherParameter:(NSDictionary *)otherParameter
{
    NSString *pageid =[NSString fomatPageIDEnumCode:LTDCPageIDPush]; // wyw add
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:LTDCActionPropertyPush];
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];

    NSDictionary* dic = @{
                          @"fl"      : [NSString safeString:fl],
                          @"msgid"      : [NSString safeString:msgid],
                          @"tk"      : [NSString safeString:[SettingManager deviceToken]],
                          @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                          @"pageid"  :  pageid,
                          @"ua"      :  platform
                          };
    NSMutableDictionary *dictAp = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    if (![NSString isBlankString:pushType]) {
        [dictAp setObject:pushType forKey:@"pushtype"];
    } else {
        [dictAp setObject:@"-" forKey:@"pushtype"];
    }
    
    if (![NSString isBlankString:messagetype]) {
        [dictAp setObject:messagetype forKey:@"messagetype"];
    }
    
    if (otherParameter != nil) {
        [dictAp addEntriesFromDictionary:otherParameter];
    }
    
    [[self class] addActionData:LTDCActionCodePush
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:pid
                            vid:vid
                            zid:zid
                     currentUrl:currentUrl
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:lid];

}

+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
{
    
}

+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype
  andIsFromBackground:(BOOL)isFromBackground
{
    [self addLaunchTime:utime
         andBootImgTime:BootImgTime
          andlautchType:ltype
    andIsFromBackground:isFromBackground
                 andRef:@""];
}

+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype
  andIsFromBackground:(BOOL)isFromBackground
               andRef:(NSString *)ref
{
    CGFloat time;
    NSString *utimeStr;
    NSDictionary *dictAp;
    
    if (LaunchType_BackGround == ltype || (ltype == LaunchType_First &&isFromBackground) || (ltype  == LaunchType_Other && isFromBackground)) {
        time = 0;
        utimeStr = [NSString stringWithFormat:@"%.2f",time];
        dictAp = @{
                   @"ut"      : utimeStr,
                   @"time"    : [NSString formatStatisticCurrentTimeString],
                   @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                   @"starttype" : [NSString stringWithFormat:@"%d", ltype],
                   @"pageid"  : @"-"
                   };
    } else {
        time = utime +BootImgTime;
        utimeStr =[NSString stringWithFormat:@"%.2f",time];
        NSString *type1 = [NSString stringWithFormat:@"%.2f",utime];
        NSString *type2 = [NSString stringWithFormat:@"%.2f",BootImgTime];
        dictAp = @{
                   @"ut"      : utimeStr,
                   @"type1"   : [NSString safeString:type1],
                   @"type2"   : [NSString safeString:type2],
                   @"time"    : [NSString formatStatisticCurrentTimeString],
                   @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                   @"starttype" : [NSString stringWithFormat:@"%d", ltype],
                   @"pageid"  : @"001",
                   @"ref"     : [NSString safeString:ref]
                   };
    }
    
    [LTDataCenter addActionData:LTDCActionCodeLaunch
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    NSLog(@"启动时长：%@",dictAp);
}


#ifdef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype
{
    CGFloat time;
    NSString *utimeStr;
    NSDictionary *dictAp;
    
    if (LaunchType_BackGround == ltype) {
        time = 0;
        utimeStr = [NSString stringWithFormat:@"%.2f",time];
        dictAp = @{
                   @"ut"      : utimeStr,
                   @"time"    : [NSString formatStatisticCurrentTimeString],
                   @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                   @"starttype" : [NSString stringWithFormat:@"%d", ltype],
                   @"pageid"  : @"-"
                   };
    } else {
        time = utime +BootImgTime;
        utimeStr =[NSString stringWithFormat:@"%.2f",time];
        NSString *type1 = [NSString stringWithFormat:@"%.2f",utime];
        NSString *type2 = [NSString stringWithFormat:@"%.2f",BootImgTime];
        dictAp = @{
                                 @"ut"      : utimeStr,
                                 @"type1"   : [NSString safeString:type1],
                                 @"type2"   : [NSString safeString:type2],
                                 @"time"    : [NSString formatStatisticCurrentTimeString],
                                 @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                                 @"starttype" : [NSString stringWithFormat:@"%d", ltype],
                                 @"pageid"  : @"001"
                                 };
    }
    
    [LTDataCenter addActionData:LTDCActionCodeLaunch
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:nil];

    NSLog(@"启动时长：%@",dictAp);
}
#endif /* LT_MERGE_FROM_IPAD_CLIENT */

//#ifndef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addLaunchTime:(CGFloat)utime
         andBootImgTime:(CGFloat)BootImgTime
         andBootImgTheoryTime:(CGFloat)bootImgTheoryTime
{
    [[self class] addLaunchTime:utime andBootImgTime:BootImgTime  andlautchType:LaunchType_Normal andIsFromBackground:NO];
}
//#else
//#endif
+ (void)addAcode:(LTDCActionCode)acode
              utime:(CGFloat)utime
          pageID:(LTDCPageID)pageID
{
     NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    NSString *utimeStr =[NSString stringWithFormat:@"%.2f",utime];
    if (utime<0) {
        utimeStr =@"";
    }
    NSDictionary *dictAp = @{
                             @"ut"      : utimeStr,
                             @"time"    : [NSString formatStatisticCurrentTimeString],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [LTDataCenter addActionData:acode
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    
    NSLog(@"acode中的ap日志:%@",dictAp);

}


//曝光统计
+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid
                   wz:(NSInteger)wz
{
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"-" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"          : [NSString safeString:fl],
                             @"wz"          : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                              @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeShow
                 actionProperty:dictAp
                   actionResult:YES
                            cid:strCid
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid
                   wz:(NSInteger)wz
            andPageID:(LTDCPageID)pageID
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"-" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"          : [NSString safeString:fl],
                             @"wz"          : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"pageid"      :pageid,
                              @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeShow
                 actionProperty:dictAp
                   actionResult:YES
                            cid:strCid
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid
{
    [[self class] addShowAction:apc
                            cid:cid
                             wz:-1];
}


//下载统计
+(void)addDownloadStatictisWithVid:(NSString *)vid
                          withName:(NSString *)name
{
    NSDictionary *dictAp = @{
                             @"name"        : [NSString safeString:name],
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeDownload
                 actionProperty:dictAp
                   actionResult:YES
                            cid:@""
                            pid:nil
                            vid:vid
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+(BOOL)writeToErrorLogFile:(NSString *)errDescription logContent:(NSString *)logContent fileName:(char *)fileName line:(NSInteger)line {
    NSString *content = [NSString stringWithFormat:@"CurrentVersion:%@, FileName:%s, line:%ld, errDescription:%@, logContent:%@", CURRENT_VERSION, fileName, (long)line, errDescription, logContent];
    
    return [LTDataCenter writeToErrorLogFile:content];
}

//写入错误日志文件
+(BOOL)writeToErrorLogFile:(NSString *)logContent
{
    if ([SettingManager isShowPlayerDebugLogView]) {
        [LeTVSharedAppModule letv_LTPlayControlLogView_addLogToView:logContent];
    }
    
//#if defined(LT_MERGE_FROM_IPAD_CLIENT) || defined(LTMovieplayerFramework)
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [FileManager appLetvProtectedPath];
    NSString * errorlogPath = [cachePath stringByAppendingPathComponent:ErrorLogText];
    
    //    NSDictionary* dict = @{
    //                           @"LogFile"      : [NSString safeString:logContent],   // 当前日志文件内容
    //                           @"TimeStamp"    : [NSDate date],    // 异常发生的时刻
    //                           };
    NSString *logString =[NSString stringWithFormat:@"%@##%@ \r\n\n",[NSString getCurrentSystemDateAccurateMS],[NSString safeString:logContent]];
    
    if ([fileManager fileExistsAtPath:errorlogPath]){
        //获取文件大小
        NSDictionary *dic=  [fileManager attributesOfItemAtPath:errorlogPath error:nil];
        NSNumber *fileNum = [dic objectForKey:NSFileSize];

        if ([fileNum floatValue]>1024*1024) {
            //        //文件最大1M，超过则删除超出1M部分的数据
            //        NSFileHandle *inFile = [NSFileHandle fileHandleForUpdatingAtPath:errorlogPath];
            //        if(inFile){
            //            [inFile seekToFileOffset:[fileNum floatValue]-1024*1024];
            //            NSData *readData=[inFile readDataToEndOfFile];
            //            [inFile closeFile];
            //
            //            NSString *result = [[NSString alloc] initWithData:readData  encoding:NSUTF8StringEncoding];
            //           [result writeToFile:errorlogPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            //
            //        }
            //客户端统一逻辑，为了运行性能，减少大文件的读写次数，超过1M，则删除文件
            [fileManager removeItemAtPath:errorlogPath error:nil];
            
        }
        
    }
    
    if (![fileManager fileExistsAtPath:errorlogPath]) {
        BOOL bResult = [logString writeToFile:errorlogPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        return bResult;
    }
    
    
    NSFileHandle  *outFile;
    NSData *buffer;
    
    outFile = [NSFileHandle fileHandleForWritingAtPath:errorlogPath];
    
    if(outFile == nil)
    {
        NSLog(@"Open of file for writing failed");
        return NO;
    }
    
    //找到并定位到outFile的末尾位置(在此后追加文件)
    [outFile seekToEndOfFile];
    
    
    //读取logString并且将其内容写到outFile中
    NSString *bs = [NSString stringWithFormat:@"%@",logString];
    buffer = [bs dataUsingEncoding:NSUTF8StringEncoding];
    
    [outFile writeData:buffer];
    
    //关闭读写文件
    [outFile closeFile];
//#endif
    return YES;
}

+ (void)infoLog:(NSString *)format{
    [LTDataCenter writeToErrorLogFile:format];
}

+ (void)errorLog:(NSString *)format{
    [LTDataCenter writeToErrorLogFile:format];
}

//上报的数据头增加机型信息：格式：手机品牌_手机型号_操作系统版本号 例如：iPhone_5S_7.0.1
+ (NSString *)getDataHeadModelInfo
{
    NSString * str = [NSString stringWithFormat:@"%@_%@",[DeviceManager getDeviceSpecificModel],[UIDevice currentDevice].systemVersion];
    return str;
}
+ (void)uploadErrorLogFileWithPhoneNum:(NSString *)phoneNum
                   withFeedBackContent:(NSString *)feedBackContent
                     completionHandler:(LTDataCompletionBlock)completionBlock
                          errorHandler:(LTDataErrorBlock)errorBlock
{
    NSString *did_client = [DeviceManager getDeviceUUID];
    //重新生成带时间戳的uuid
    NSString *uuid = [NSString stringWithFormat:@"%@_%@",
                      did_client,
                      [NSString stringWithFormat:@"%ld", time(NULL)]];
    NSString *rule =@"x6e2eAe2sB4ts1289wa2s";
    NSString *keyString =[NSString stringWithFormat:@"%@%@",uuid,rule];
    NSString *key =[NSString md5:keyString];
    NSString *urlPath;
    NSString *newFeedback = [NSString stringWithFormat:@"%@ %@",feedBackContent,[LTDataCenter getDataHeadModelInfo]];
//    NSString *unicodeString = [newFeedback stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
       if ([NSString isBlankString:phoneNum]) {
                urlPath =[NSString stringWithFormat:@"android/mod/mob/ctl/uploader/act/uploadedfile/uuid/%@/key/%@/pcode/%@/version/%@.mindex.html",uuid,key,CURRENT_PCODE,CURRENT_VERSION];
            }
        else{
              urlPath =[NSString stringWithFormat:@"android/mod/mob/ctl/uploader/act/uploadedfile/uuid/%@/mobile/%@/key/%@/pcode/%@/version/%@.mindex.html",uuid,phoneNum,key,CURRENT_PCODE,CURRENT_VERSION];
            }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [FileManager appLetvProtectedPath];
    NSString * errorlogPath = [cachePath stringByAppendingPathComponent:ErrorLogText];
    NSString * cdePath = [cachePath stringByAppendingPathComponent:CDELogText];
    if (![fileManager fileExistsAtPath:errorlogPath]){
        return;
    }
    dispatch_block_t reloadCDELogBlock = ^{
        if ([fileManager fileExistsAtPath:cdePath]) {
            AFAppDotNetAPIClient *cdeAFAppDotNetAPIClient =[[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://upload.app.m.letv.com/"]];
            
            [cdeAFAppDotNetAPIClient uploadFileWithUrlPath:urlPath withFilePath:cdePath withFeedBackContent:newFeedback success:^(NSURLSessionDataTask *operation, id responseObject) {
                if ([NSJSONSerialization isValidJSONObject:responseObject]) {
                    NSDictionary *result = responseObject[@"header"];
                    NSString *status = result[@"status"];
                    if (![status isEqualToString:@"1"])
                    {
                        NSString *errlog =[NSString stringWithFormat:@"url:%@ errorDict:%@",operation.originalRequest.URL,[responseObject description]];
                        [LTDataCenter writeToErrorLogFile:errlog];
                        
                    }
                    
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
        }
    };
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient =[[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://upload.app.m.letv.com/"]];
    
    [afAppDotNetAPIClient uploadFileWithUrlPath:urlPath withFilePath:errorlogPath withFeedBackContent:newFeedback success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (![NSJSONSerialization isValidJSONObject:responseObject]) {
            if (errorBlock) {
                errorBlock(nil);
            }
        }
        else{
            if (completionBlock) {
                NSDictionary *result = responseObject[@"header"];
                NSString *status = result[@"status"];
                if (![status isEqualToString:@"1"])
                {
                    NSString *errlog =[NSString stringWithFormat:@"url:%@ errorDict:%@",operation.originalRequest.URL,[responseObject description]];
                    [LTDataCenter writeToErrorLogFile:errlog];

                }
                completionBlock(responseObject);
            }
        }
        reloadCDELogBlock();
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (errorBlock) {
            errorBlock(nil);
        }
        reloadCDELogBlock();
    }];
}

+ (void)uploadErrorLogFileFromFeedbackWithPhoneNum:(NSString *)phoneNum
                               withFeedBackContent:(NSString *)feedBackContent
                                   withImagesArray:(NSArray *)imagesArray
                                 completionHandler:(LTDataCompletionBlock)completionBlock
                                      errorHandler:(LTDataErrorBlock)errorBlock {
    NSString *did_client = [DeviceManager getDeviceUUID];
    //重新生成带时间戳的uuid
    NSString *uuid = [NSString stringWithFormat:@"%@_%@",
                      did_client,
                      [NSString stringWithFormat:@"%ld", time(NULL)]];
    NSString *rule =@"x6e2eAe2sB4ts1289wa2s";
    NSString *keyString =[NSString stringWithFormat:@"%@%@",uuid,rule];
    NSString *key =[NSString md5:keyString];
    NSString *urlPath;
    NSString *newFeedback = [NSString stringWithFormat:@"%@ %@",feedBackContent,[LTDataCenter getDataHeadModelInfo]];
    //    NSString *unicodeString = [newFeedback stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
    if ([NSString isBlankString:phoneNum]) {
        urlPath =[NSString stringWithFormat:@"android/mod/mob/ctl/uploaderpic/act/uploadedfile/uuid/%@/key/%@/pcode/%@/version/%@.mindex.html",uuid,key,CURRENT_PCODE,CURRENT_VERSION];
    } else {
        urlPath =[NSString stringWithFormat:@"android/mod/mob/ctl/uploaderpic/act/uploadedfile/uuid/%@/mobile/%@/key/%@/pcode/%@/version/%@.mindex.html",uuid,phoneNum,key,CURRENT_PCODE,CURRENT_VERSION];
    }
    
    NSString *country = @"";
    NSString *location = @"";
    NSDictionary *locationDict = [SettingManager getLocationGeocoder];
    NSString *area = @"";
    if (locationDict != nil && [locationDict isKindOfClass:[NSDictionary class]]) {
        country = [locationDict safeValueForKey:@"country"];
        location = [locationDict safeValueForKey:@"location"];
    }
    
    NSDictionary *postParameters =  [NSDictionary dictionaryWithObjectsAndKeys:
                                     country, @"country",
                                     location, @"location",nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [FileManager appLetvProtectedPath];
    NSString * errorlogPath = [cachePath stringByAppendingPathComponent:ErrorLogText];
    NSString * cdePath = [cachePath stringByAppendingPathComponent:CDELogText];
    dispatch_block_t reloadCDELogBlock = ^{
        if ([fileManager fileExistsAtPath:cdePath]) {
            AFAppDotNetAPIClient *cdeAFAppDotNetAPIClient = nil;
            
//#ifdef DEBUG
//            if ([SettingManager isTestApi]) {
//                cdeAFAppDotNetAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://test2.m.letv.com/"]];
//            }
//            else {
//#endif
                cdeAFAppDotNetAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://upload.app.m.letv.com/"]];
//#ifdef DEBUG
//            }
//#endif
//            
            [cdeAFAppDotNetAPIClient uploadFileWithUrlPath:urlPath
                                              withFilePath:cdePath
                                                parameters:postParameters
                                       withFeedBackContent:newFeedback
                                                   success:^(NSURLSessionDataTask *operation, id responseObject) {
                if ([NSJSONSerialization isValidJSONObject:responseObject]) {
                    NSDictionary *result = responseObject[@"header"];
                    NSString *status = result[@"status"];
                    if (![status isEqualToString:@"1"])
                    {
                        NSString *errlog =[NSString stringWithFormat:@"url:%@ errorDict:%@",operation.originalRequest.URL,[responseObject description]];
                        [LTDataCenter writeToErrorLogFile:errlog];
                    }
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                LTLog(@"error:%@", error);
            }];
        }
    };
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient = nil;
//#ifdef DEBUG
//    if ([SettingManager isTestApi]) {
//        afAppDotNetAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://test2.m.letv.com/"]];
//    }
//    else {
//#endif
        afAppDotNetAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://upload.app.m.letv.com/"]];
//#ifdef DEBUG
//    }
//#endif
    
    [afAppDotNetAPIClient uploadFileFromFeedbackWithUrlPath:urlPath
                                               withFilePath:errorlogPath
                                                 parameters:postParameters
                                        withFeedBackContent:newFeedback
                                            withImagesArray:imagesArray
                                                    success:^(NSURLSessionDataTask *operation, id responseObject) {
                                                        if (![NSJSONSerialization isValidJSONObject:responseObject]) {
                                                            if (errorBlock) {
                                                                errorBlock(nil);
                                                            }
                                                        } else {
                                                            if (completionBlock) {
                                                                NSDictionary *result = responseObject[@"header"];
                                                                NSString *status = result[@"status"];
                                                                if (![status isEqualToString:@"1"])
                                                                {
                                                                    NSString *errlog =[NSString stringWithFormat:@"url:%@ errorDict:%@",operation.originalRequest.URL,[responseObject description]];
                                                                    [LTDataCenter writeToErrorLogFile:errlog];
                                                                    
                                                                }
                                                                completionBlock(responseObject);
                                                            }
                                                        }
                                                        reloadCDELogBlock();
                                                    }
                                                    failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                                        NSLog(@"response:%@", operation.responseString);
                                                        if (errorBlock) {
                                                            errorBlock(nil);
                                                        }
                                                        reloadCDELogBlock();
                                                    }];
}

+ (void)uploadScreenShotText:(NSString *)text image:(UIImage *)image xid:(int)vid pid:(int)pid cid:(int)cid htime:(NSString *)shotTime completionHandler:(LTDataCompletionBlock)completionBlock errorHandler:(LTDataErrorBlock)errorBlock{
    
    NSString *urlPath;
    NSString *urlHead;
    if ([SettingManager isTestApi]) {
        urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD_TEST;
        
#ifdef DEBUG
        if ([SettingManager isHK]) {
            urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD_HK_TEST;
        }
#endif
    }else{
        urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD;
    }
    urlPath =[NSString stringWithFormat:@"uploadhead/uploadimg?xid=%d&cid=%d&pid=%d&htime=%@&pcode=%@&version=%@",vid,cid,pid,shotTime,CURRENT_PCODE,CURRENT_VERSION];
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient =[[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:urlHead]];
    
    NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
    if(![NSString isBlankString:tk])
    {
        [afAppDotNetAPIClient setHttpHeader:@"TK" value:tk];
    }

    NSString * sso_tk = @"";
    if ([SettingManager isUserLogin])
    {
        sso_tk = [SettingManager userCenterTVToken];
        if ([NSString empty:sso_tk])
        {
            sso_tk = @"";
        }
    }
    [afAppDotNetAPIClient setHttpHeader:@"SSOTK" value:sso_tk];

    [afAppDotNetAPIClient uploadFileWithUrlPath:urlPath withContent:text withImage:image success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"response:%@", operation.response);
        if (![NSJSONSerialization isValidJSONObject:responseObject]) {
            if (errorBlock) {
                errorBlock(nil);
            }
        }else {
                if (completionBlock) {
                    completionBlock(responseObject);
                }

        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"response:%@", operation.response);
        if (errorBlock) {
            errorBlock(nil);
        }
    }];

}
// 播放错误上报
+ (void)addPlayFailedData:(LTDCPlayFailedCode)playFailedCode
                      cid:(NewMovieCid)cid
                      pid:(NSString *)pid
                      vid:(NSString *)vid
               currentUrl:(NSString *)cur_url
{
    NSString *strFailedCode = @"";
    switch (playFailedCode) {
        case LTDCPlayFailedCodeAlbumDetail:
            strFailedCode = @"1001";
            break;
        case LTDCPlayFailedCodeVideoDetail:
            strFailedCode = @"1002";
            break;
        case LTDCPlayFailedCodeVideoList:
            strFailedCode = @"1003";
            break;
        case LTDCPlayFailedCodeVideoFile:
            strFailedCode = @"1004";
            break;
        case LTDCPlayFailedCodeTimestamp:
            strFailedCode = @"1005";
            break;
        case LTDCPlayFailedCodeCloud:
            strFailedCode = @"1006";
            break;
        case LTDCPlayFailedCodeLoading:
            strFailedCode = @"1007";
            break;
        case LTDCPlayFailedCodeNetwork:
            strFailedCode = @"1008";
            break;
        case LTDCPlayFailedCodeUnknown:
            strFailedCode = @"1009";
            break;
        case LTDCPlayFailedCodeLiveIpForbid:
            strFailedCode = @"2001";
            break;
        case LTDCPlayFailedCodeLiveUrl:
            strFailedCode = @"2002";
            break;
        case LTDCPlayFailedCodeLiveTimestamp:
            strFailedCode = @"2003";
            break;
        case LTDCPlayFailedCodeLiveNetwork:
            strFailedCode = @"2004";
            break;
        case LTDCPlayFailedCodeLiveUnknown:
            strFailedCode = @"2005";
            break;
        default:
            break;
    }
    if ([NSString isBlankString:strFailedCode]) {
        return;
    }
    
    NSDictionary *dictAp = @{
                             @"ec"          : strFailedCode,
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    [[self class] addActionData:LTDCActionCodePlayFailed
                 actionProperty:dictAp
                   actionResult:YES
                            cid:[NSString safeString:strCid]
                            pid:pid
                            vid:vid
                            zid:nil
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    
    
    
}

+ (void)addLivePlayFailedData:(LTDCPlayFailedCode)playFailedCode
                   currentUrl:(NSString *)cur_url
{
    [[self class] addPlayFailedData:playFailedCode
                                cid:NewCID_UnDefine
                                pid:nil
                                vid:nil
                         currentUrl:cur_url];
}

// 下载速度上报
+ (void)addDownloadSpeedData:(CGFloat)downloadSpeed
    andDownloadInterruptType:(LTDCDownloadInterruptType)interruptType
{
    NSDictionary *dictAp = @{
                             @"speed"   : [NSString stringWithFormat:@"%.2f", downloadSpeed],
                             @"type"    : [NSString stringWithFormat:@"%ld", (long)interruptType],
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeDownload
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

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
{
    [[self class] addBufferTimeWithAdtime:adTime
                              andPlayType:playType
                      andGetVideoListTime:videoListTime
                      andGetVideoFileTime:videoFileTime
                        andGetCanPlayTime:getPayInfoTime
                       andGetAlbumPayInfo:getAlbumPayInfoTime
                          andGetAdPinTime:getAdPinTime
                        andGetPlayUrlTime:getPlayUrlTime
                     andGetAdDispatchTime:getAdDispatchTime
                       andGetAdTheoryTime:getAdTheoryTime
                     andGetAdPlayLoadTime:getAdPlayLoadTime
                       andGetPlayLoadTime:getplayLoadTime
                      andGetADPreLoadTime:getAdPreLoadTime
                  andGetPlayerPreLoadTime:getPlayerPreLoadTime
                         andAllBufferTime:allBufTime
                                   andCid:cid
                                   andPid:pid
                                   andVid:vid
                                   andZid:zid
                               andPlayUrl:playUrl
                                 andAdUrl:adUrl
                                   pageID:LTDCPageIDUnKnown playUUid:nil];
}

// 缓冲时间上报
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
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    NSLog(@"统计缓冲时长 adTime：%.2f  videoListTime(type4):%.2f videoFileTime(type5):%.2f getPayInfoTime(type6):%.2f  getAlbumPayInfoTime(type7):%.2f getAdPinTime(type8):%.2f  getPlayUrlTime(type9):%.2f GetAdDispatchTime(type11):%.2f  getAdTheoryTime(type12):%.2f getAdPlayLoadTime(type14):%.2f  andGetPlayLoadTime(type13):%.2f andGetADPreLoadTime:%.2f andGetPlayerPreLoadTime:%.2f allBufferTime(type10):%.2f",adTime,videoListTime,videoFileTime,getPayInfoTime,getAlbumPayInfoTime,getAdPinTime,getPlayUrlTime,getAdDispatchTime,getAdTheoryTime,getAdPlayLoadTime,getplayLoadTime,getAdPreLoadTime,getPlayerPreLoadTime,allBufTime);
    NSDictionary *dictAp = @{
                             @"type1"      : [NetworkReachability currentNetType],
                             @"type2"      : [NSString stringWithFormat:@"%d", playType],
                             @"type3"      : [NSString stringWithFormat:@"%.4f", adTime],
//                             @"type4"      : [NSString stringWithFormat:@"%.4f", videoListTime],
//                             @"type5"      : [NSString stringWithFormat:@"%.4f", videoFileTime],
//                             @"type6"      : [NSString stringWithFormat:@"%.4f", getPayInfoTime],
                             @"type7"      : [NSString stringWithFormat:@"%.4f", getAlbumPayInfoTime],
                             @"type8"      : [NSString stringWithFormat:@"%.4f", getAdPinTime],
                             @"type9"      : [NSString stringWithFormat:@"%.4f", getPlayUrlTime],
                             @"type10"     : [NSString stringWithFormat:@"%.4f", allBufTime],
                             @"type11"     : [NSString stringWithFormat:@"%.4f", getAdDispatchTime],
                             @"type12"     : [NSString stringWithFormat:@"%.4f", getAdTheoryTime],
                             @"type13"     : [NSString stringWithFormat:@"%.4f", getplayLoadTime],
                             @"type14"     : [NSString stringWithFormat:@"%.4f", getAdPlayLoadTime],
                             @"type15"     : [NSString stringWithFormat:@"%.4f", getAdPreLoadTime],
//                             @"type16"     : [NSString stringWithFormat:@"%.4f", getPlayerPreLoadTime],
                             @"playurl"    : [NSString safeString:playUrl],
                             @"adurl"      : [NSString safeString:adUrl],
                             @"iosid"      : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"pageid"     : pageid
                             };

    if (![NSString empty:vid]) {
        
        // 误差大于3，则认为是异常数据，不上报
        if (fabs(allBufTime - getAlbumPayInfoTime - getAdPinTime - getAdDispatchTime - getplayLoadTime - getPlayUrlTime) > 3) {
            
            NSString *bufferTime = [NSString stringWithFormat:@"播放流程---type10:%0.2f, type7:%0.2f, type8:%0.2f, type9：%0.2f, type11:%0.2f, type13:%0.2f, type15:%0.2f", allBufTime, getAlbumPayInfoTime, getAdPinTime, getPlayUrlTime, getAdDispatchTime, getplayLoadTime, getAdPreLoadTime];
            [LTDataCenter writeToErrorLogFile:bufferTime];
     
            return;
        }
    }
    
#ifdef DEBUG
    NSString *playLog = [NSString stringWithFormat:@"####PLAY#### type10:%.0f, type7:%.0f, type8:%.0f, type9:%.0f, type11:%.0f, type13:%.0f, type15:%.0f, type3:%.0f, type14:%.0f", allBufTime * 1000, getAlbumPayInfoTime * 1000, getAdPinTime * 1000, getPlayUrlTime * 1000, getAdDispatchTime * 1000, getplayLoadTime * 1000, getAdPreLoadTime * 1000, adTime * 1000, getAdPlayLoadTime * 1000];
    
    LTLogPlay(@"%@", playLog);
    CGFloat typeSum = getAlbumPayInfoTime * 1000 + getAdPinTime * 1000 + getPlayUrlTime * 1000 + getAdDispatchTime * 1000 + getAdDispatchTime * 1000 + getplayLoadTime * 1000 + getAdPreLoadTime * 1000 +
    adTime * 1000 + getAdPlayLoadTime * 1000;
    LTLog(@"!!!typesum %.0f", typeSum);
#endif
    
    if ([NSString isBlankString:playUUID]) {
        [[self class] addActionData:LTDCActionCodeBufferTime
                     actionProperty:dictAp
                       actionResult:YES
                                cid:cid
                                pid:pid
                                vid:vid
                                zid:zid
                         currentUrl:nil
                               reid:nil
                               area:nil
                             bucket:nil
                               rank:nil];
    }else{
        [LTDataCenter addActionData:LTDCActionCodeBufferTime
                     actionProperty:dictAp
                       actionResult:YES
                                cid:cid
                                pid:pid
                                vid:vid
                                zid:zid
                         currentUrl:nil
                               reid:nil
                               area:nil
                             bucket:nil
                               rank:nil
                                lid:nil playUUid:playUUID];
    }
}


#pragma mark Play
+ (void)addPlayDataWithPlayAction:(LTDCPlayStage)playStage
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
                       andStation:(NSString *)st
                      andPlayUUID:(NSString *)playUUID
                      andCodeRate:(VideoCodeType)videoCode
                   andOfflineFlag:(BOOL)isPlayOffline
                            andCh:(NSString *)ch
                    andLivingCode:(NSString *)code
                            andLc:(NSString *)lc
                           andRef:(NSString *)ref
                           andZid:(NSString *)zid
                    andIsAutoPlay:(BOOL)isAutoPlay
                     andParamters:(NSDictionary *)paramters
{
    LT_DC_FIELD_DEFINE(play, ver)
    LT_DC_FIELD_DEFINE(play, p1)
    LT_DC_FIELD_DEFINE(play, p2)
    LT_DC_FIELD_DEFINE(play, p3)
    LT_DC_FIELD_DEFINE(play, ac)        // 动作名称
    LT_DC_FIELD_DEFINE(play, err)       // 错误代码
    LT_DC_FIELD_DEFINE(play, pt)        // 播放时长 以秒为单位
    LT_DC_FIELD_DEFINE(play, ut)        // 动作耗时 以毫秒为单位
    LT_DC_FIELD_DEFINE(play, uid)
    LT_DC_FIELD_DEFINE(play, lc)
    LT_DC_FIELD_DEFINE(play, auid)
    LT_DC_FIELD_DEFINE(play, uuid)      // 一次播放过程，播放器生成唯一的UUID, 如果一次播放过程出现了切换码率，那么uuid的后缀加1
    LT_DC_FIELD_DEFINE(play, cid)
    LT_DC_FIELD_DEFINE(play, pid)
    LT_DC_FIELD_DEFINE(play, vid)
    LT_DC_FIELD_DEFINE(play, vlen)      // 视频时长 以秒为单位
    LT_DC_FIELD_DEFINE(play, ch)        // 渠道号
    LT_DC_FIELD_DEFINE(play, ry)        // 重试次数
    LT_DC_FIELD_DEFINE(play, ty)        // Type: 播放类型
    LT_DC_FIELD_DEFINE(play, vt)        // 播放器的vtype
    LT_DC_FIELD_DEFINE(play, url)       // 视频播放地址
    LT_DC_FIELD_DEFINE(play, ref)       // 播放页来源地址
    LT_DC_FIELD_DEFINE(play, pv)        // Player version: 播放器版本
    LT_DC_FIELD_DEFINE(play, py)        // Property: 播放属性
    LT_DC_FIELD_DEFINE(play, st)        // 轮播台
    LT_DC_FIELD_DEFINE(play, ilu)       // 是否为登陆用户
    LT_DC_FIELD_DEFINE(play, pcode)     // pcode
    LT_DC_FIELD_DEFINE(play, weid)      // 上报时获取js生成的页面weid
    LT_DC_FIELD_DEFINE(play, ap)        // 是否自动播放
    LT_DC_FIELD_DEFINE(play, zid)
    LT_DC_FIELD_DEFINE(play, lid)     //直播id  用于标识单场直播的唯一id    [播放类型如果是直播时，此参数为必填参数，其余情况可以为选填]
    LT_DC_FIELD_DEFINE(play, r)         // 随机数
    LT_DC_FIELD_DEFINE(play, nt)       //网络类型
    LT_DC_FIELD_DEFINE(play, bt)       //LTDCPlayStageBlock时候上报的bt字段，卡顿类型
    LT_DC_FIELD_DEFINE(play, ctime)    // 新增的上报时间点
    LT_DC_FIELD_DEFINE(play, prl)    // 是否预加载
    LT_DC_FIELD_DEFINE(play, cdev)    // CDE版本号
    LT_DC_FIELD_DEFINE(play, caid)    // CDE APP ID
    LT_DC_FIELD_DEFINE(play, pay)    // 收费还是免费
    LT_DC_FIELD_DEFINE(play, joint)    // 是否拼接广告
    LT_DC_FIELD_DEFINE(play, ipt)      // 起播类型
    
    // py
    
    NSInteger countPyParam = [py count];
    NSString *KeyValueJoinedString = @"=";
    NSString *componentsJoinedString = @"&";
    NSMutableArray *arrayKeyValues = [NSMutableArray array];
    
    //LTDCPlayStageBlock时上报卡顿
    NSString *blockType = @"";
    NSString *blockTime = @"";
 
    for (int i = 0; i+1 < countPyParam; i+=2)
    {
        NSString *key = py[i];
        NSString *value = py[i+1];
        
        if ([NSString isBlankString:key]) {
            continue;
        }
        if ([NSString isBlankString:value]) {
            value =@"-";
        }
        
        if (    ([value rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
            ||  ([value rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
            value = [value encodedURLParameterString];
        }
        
        if( playStage == LTDCPlayStageBlock){
            if ([key isEqualToString:@"bt"]) {
                blockType = value;
                continue;
            }
            if ([key isEqualToString:@"ut"]) {
                blockTime = value;
                continue;
            }
        }
        
        [arrayKeyValues addObject:[NSString stringWithFormat:
                                   @"%@%@%@",
                                   key,
                                   KeyValueJoinedString,
                                   value]];
    }
    
    [arrayKeyValues addObject:[NSString stringWithFormat:@"app=%@",CURRENT_VERSION]];
  
    NSString *pushmsg = [paramters safeValueForKey:@"pushmsg"];
    if (![NSString empty:pushmsg]) {
        [arrayKeyValues addObject:[NSString stringWithFormat:@"pushmsg=%@", pushmsg]];
    }
    
    NSString *formatPyString = [arrayKeyValues componentsJoinedByString:componentsJoinedString];
    
    // ac
    NSString *strPlayStage = @"";
    switch (playStage) {
        case LTDCPlayStageLaunch:
            strPlayStage = @"launch";
            break;
        case LTDCPlayStageInit:
            strPlayStage = @"init";
            break;
        case LTDCPlayStageGslb:
            strPlayStage = @"gslb";
            break;
        case LTDCPlayStageCload:
            strPlayStage = @"cload";
            break;
        case LTDCPlayStagePlay:
            strPlayStage = @"play";
            break;
        case LTDCPlayStageTime:
            strPlayStage = @"time";
            break;
        case LTDCPlayStageBlock:
            strPlayStage = @"block";
            break;
        case LTDCPlayStageEBlock:
            strPlayStage = @"eblock";
            break;
        case LTDCPlayStageTg:
            strPlayStage = @"tg";
             break;
//        case LTDCPlayStagePa:
//            strPlayStage = @"pa";
//             break;
        case LTDCPlayStageDrag:
            strPlayStage = @"drag";
             break;
//        case LTDCPlayStageCp:
//            strPlayStage = @"cp";
//            break;
        case LTDCPlayStageEnd:
            strPlayStage = @"end";
            break;
        case LTDCPlayStageFinish:
            strPlayStage = @"finish";
            break;
        default:
            break;
    }
    
    // time
    NSTimeInterval playTimeLen = 0;
    NSTimeInterval utime = 0;
    if (LTDCPlayStageTime == playStage) {
        playTimeLen = usedTime;
        if (playTimeLen <= 0) {
            // 播放时长为0，不上报
            return;
        }
        if (playTimeLen > 180){
            playTimeLen = 180;
        }
    }
    else{
        utime = usedTime;
    }
    
    // vt
    NSString *vt = [paramters safeValueForKey:@"vtype"];
    if ([NSString empty:vt]) {
        vt = [NSString safeString:code];
    }
    
    NSString *timeString = [[self class] getTimeString];
    NSString *pay = [paramters safeValueForKey:@"pay1"];
    NSString *joint = [paramters safeValueForKey:@"joint"];
    NSString *ipt = [paramters safeValueForKey:@"ipt"];
    
    NSDictionary *dictData = @{
                               s_play_ver       : LT_DATA_CENTER_KV_VERSION_3,
                               s_play_p1        : LT_DATA_CENTER_P1VALUE,
                               s_play_p2        : LT_DATA_CENTER_P2VALUE,
                               s_play_p3        : LT_DATA_CENTER_P3VALUE,
                               s_play_ac        : strPlayStage,
                               s_play_err       : [NSString stringWithFormat:@"%ld",(long) error],
                               s_play_pt        : (LTDCPlayStageTime == playStage) ? [NSString stringWithFormat:@"%lld", (long long)playTimeLen] : @"",
                               s_play_ut        : (playStage == LTDCPlayStageBlock) ? blockTime    : [NSString stringWithFormat:@"%lld", (long long)(1000 * utime)],
                               s_play_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_play_lc        : @"-",
                               s_play_auid      : [DeviceManager getDeviceUUID],
                               s_play_uuid      : playUUID,
                               s_play_cid       : [NSString safeString:cid],
                               s_play_pid       : [[NSString safeString:pid] encodedURLParameterString],
                               s_play_vid       : [[NSString safeString:vid] encodedURLParameterString],
                               s_play_vlen      : [NSString stringWithFormat:@"%lld", (long long)vlen],
                               s_play_ry        : [NSString stringWithFormat:@"%ld", (long)retry],
                               s_play_ty        : (ptype != LTDCPlayTypeUnknown) ? [NSString stringWithFormat:@"%ld", (long)ptype] : @"",
                               s_play_vt        : [NSString safeString:vt],
                               s_play_url       : [[NSString safeString:playUrl] encodedURLParameterString],
                               s_play_ref       : [[NSString safeString:ref] encodedURLParameterString],
                               s_play_pv        : CURRENT_VERSION,
                               s_play_py        : [formatPyString encodedURLParameterString],
                               s_play_st        : [[NSString safeString:st] encodedURLParameterString],
                               s_play_ilu       : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_play_pcode     : CURRENT_PCODE,
                               s_play_weid      : @"",
                               s_play_ap        : isAutoPlay?@"1":@"0",
                               s_play_zid       : [NSString safeStringForStatistic:zid],
                               s_play_lid       : [NSString safeString:lc],
                               s_play_r         : [[self class] generateRandomValue],
                               s_play_nt        : [NetworkReachability currentNetType],
                               s_play_ctime     : timeString,
                               s_play_ipt       : ipt
                               };
    
    NSMutableDictionary * allDictData = [[NSMutableDictionary alloc]initWithDictionary:dictData];
    NSString *cdeCaid = [NSString stringWithFormat:@"%d", CDE_APP_ID];
    if (playStage == LTDCPlayStageInit) {
        [allDictData setValue:[LTCDEModel getVersion] forKey:s_play_cdev];
        [allDictData setValue:[NSString safeString:cdeCaid] forKey:s_play_caid];
    }
    if (playStage == LTDCPlayStagePlay) {
        [allDictData setValue:pay forKey:s_play_pay];
        [allDictData setValue:joint forKey:s_play_joint];
        [allDictData setValue:@"0" forKey:s_play_prl];
    }
    if (playStage == LTDCPlayStageBlock) {
        [allDictData setValue:blockType forKey:s_play_bt];
    }
    
    NSArray *arrRequiredKeys = @[s_play_ver,
                                 s_play_p1,
                                 s_play_p2,
                                 s_play_ac,
                                 s_play_err,
                                 s_play_pt,
                                 s_play_ut,
                                 s_play_uid,
                                 s_play_lc,
                                 s_play_auid,
                                 s_play_uuid,
                                 s_play_cid,
                                 s_play_pid,
                                 s_play_vid,
                                 s_play_vlen,
                                 s_play_ry,
                                 s_play_ty,
                                 s_play_vt,
                                 s_play_url,
                                 s_play_ref,
                                 s_play_pv,
                                 s_play_ilu,
                                 s_play_ap,
                                 s_play_zid,
                                 s_play_lid,
                                 s_play_r,
                                 s_play_nt,
                                 s_play_ctime,
                                 s_play_ipt
                                 ];
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVPlay
                              andRawData:allDictData
                         andRequiredKeys:arrRequiredKeys];
}

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
      andNewParameter:(NSDictionary *)newParameter
{
    [[self class] addPlayDataWithPlayAction:playStage
                                   andError:error
                                andUsedtime:usedTime
                                     andCid:cid
                                     andPid:pid
                                     andVid:vid
                                andVideoLen:0
                              andRetryCount:retry
                                andPlayType:ptype
                                 andPlayUrl:playUrl
                                andProperty:py
                                 andStation:st
                                andPlayUUID:playUUID
                                andCodeRate:VIDEO_CODE_UNKNOWN
                             andOfflineFlag:NO
                                      andCh:ch
                              andLivingCode:code
                                      andLc:lc
                                     andRef:ref
                                     andZid:@""
                              andIsAutoPlay:NO
                               andParamters:newParameter];
}

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
      andNewParameter:(NSDictionary *)newParameter
{
    
    //    NSDictionary *dictPy = @{
    //                             @"offline"     : isPlayOffline ? @"1" : @"",
    //                             @"pay"         : isNeedPay ? @"1" : @"",
    //                             };
    
    NSString *pay1 = [newParameter safeValueForKey:@"pay1"];
    NSMutableArray *arrayPy =[NSMutableArray arrayWithObjects:
                              @"offline"     , isPlayOffline ? @"1" : @"",
                              @"pay"         , [NSString safeString:pay1],
                              nil];
    NSMutableArray *uploadPy=(![NSObject empty:py])?py:arrayPy;
    
        [[self class] addPlayDataWithPlayAction:playStage
                                       andError:error
                                    andUsedtime:usedTime
                                         andCid:cid
                                         andPid:pid
                                         andVid:vid
                                    andVideoLen:vlen
                                  andRetryCount:retry
                                    andPlayType:ptype
                                     andPlayUrl:playUrl
                                    andProperty:uploadPy
                                     andStation:nil
                                    andPlayUUID:playUUID
                                    andCodeRate:videoCode
                                 andOfflineFlag:isPlayOffline
                                          andCh:nil
                                  andLivingCode:nil
                                          andLc:nil
                                         andRef:ref
                                         andZid:zid
                                  andIsAutoPlay:isAutoPlay
                                   andParamters:newParameter];
}

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
{
    
}

#pragma mark advertise
+ (void)addAdvertiseData:(NSInteger)ac
            adProperties:(NSString *)properties
                     cid:(NSString *)cid
                     url:(NSString *)url
                  slotid:(NSString *)slotid
                    adid:(NSString *)adid
             materialUrl:(NSString *)murl
                     ref:(NSString *)ref
                    rcid:(NSString *)rcid
{
    LT_DC_FIELD_DEFINE(ad, ver)
    LT_DC_FIELD_DEFINE(ad, p1)
    LT_DC_FIELD_DEFINE(ad, p2)
    LT_DC_FIELD_DEFINE(ad, p3)
    LT_DC_FIELD_DEFINE(ad, ac)      // 0:pv; 1:click
    LT_DC_FIELD_DEFINE(ad, pp)      // 广告属性
    LT_DC_FIELD_DEFINE(ad, cid)     // 视频频道 ID 大媒资
    LT_DC_FIELD_DEFINE(ad, url)     // 当前页面 url
    LT_DC_FIELD_DEFINE(ad, slotid)  // 广告位 id
    LT_DC_FIELD_DEFINE(ad, adid)    // 广告 ID
    LT_DC_FIELD_DEFINE(ad, murl)    // Material url:素材地址
    LT_DC_FIELD_DEFINE(ad, uid)
    LT_DC_FIELD_DEFINE(ad, uuid)
    LT_DC_FIELD_DEFINE(ad, lc)
    LT_DC_FIELD_DEFINE(ad, ref)     // 页面来源
    LT_DC_FIELD_DEFINE(ad, rcid)    // 来源频道
    LT_DC_FIELD_DEFINE(ad, ch)      // 渠道
    LT_DC_FIELD_DEFINE(ad, pcode)
    LT_DC_FIELD_DEFINE(ad, auid)
    LT_DC_FIELD_DEFINE(ad, ilu)
    LT_DC_FIELD_DEFINE(ad, r)
    
    NSDictionary *dictData = @{s_ad_ver     : LT_DATA_CENTER_KV_VERSION_3,
                               s_ad_p1      : LT_DATA_CENTER_P1VALUE,
                               s_ad_p2      : LT_DATA_CENTER_P2VALUE,
                               s_ad_p3      : LT_DATA_CENTER_P3VALUE,
                               s_ad_ac      : [NSString stringWithFormat:@"%ld", (long)ac],
                               s_ad_pp      : [[NSString safeString:properties] encodedURLParameterString],
                               s_ad_cid     : cid,
                               s_ad_url     : url,
                               s_ad_slotid  : slotid,
                               s_ad_adid    : adid,
                               s_ad_murl    : murl,
                               s_ad_uid     : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_ad_uuid    : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_ad_lc      : @"",
                               s_ad_ref     : ref,
                               s_ad_rcid    : rcid,
                               s_ad_ch      : @"",
                               s_ad_pcode   : CURRENT_PCODE,
                               s_ad_auid    : [DeviceManager getDeviceUUID],
                               s_ad_ilu     : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_ad_r       : [[self class] generateRandomValue],
                               };
    
    NSArray *arrRequiredKeys = @[s_ad_ver,
                                 s_ad_p1,
                                 s_ad_p2,
                                 s_ad_cid,
                                 s_ad_url,
                                 s_ad_slotid,
                                 s_ad_adid,
                                 s_ad_murl,
                                 s_ad_uid,
                                 s_ad_uuid,
                                 s_ad_lc,
                                 s_ad_ref,
                                 s_ad_rcid,
                                 s_ad_auid,
                                 s_ad_ilu,
                                 s_ad_r,
                                 ];
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVAd
                              andRawData:dictData
                         andRequiredKeys:arrRequiredKeys];
}

#pragma mark query
+ (void)addQueryDataWithSid:(NSString *)sid
                 searchType:(NSInteger)ty
              videoPosition:(NSInteger)pos
           clickedVideoInfo:(NSString *)clk
               queryContent:(NSString *)q
                       page:(NSInteger)p
                     Result:(NSString *)rt
{
    LT_DC_FIELD_DEFINE(query, ver)
    LT_DC_FIELD_DEFINE(query, p1)
    LT_DC_FIELD_DEFINE(query, p2)
    LT_DC_FIELD_DEFINE(query, p3)
    LT_DC_FIELD_DEFINE(query, sid)
    LT_DC_FIELD_DEFINE(query, ty)
    LT_DC_FIELD_DEFINE(query, pos)
    LT_DC_FIELD_DEFINE(query, clk)
    LT_DC_FIELD_DEFINE(query, uid)
    LT_DC_FIELD_DEFINE(query, uuid)
    LT_DC_FIELD_DEFINE(query, lc)
    LT_DC_FIELD_DEFINE(query, auid)
    LT_DC_FIELD_DEFINE(query, ch)
    LT_DC_FIELD_DEFINE(query, ilu)
    LT_DC_FIELD_DEFINE(query, q)
    LT_DC_FIELD_DEFINE(query, p)
    LT_DC_FIELD_DEFINE(query, rt)
    LT_DC_FIELD_DEFINE(query, r)
    
    NSDictionary *dictData = @{s_query_ver      : LT_DATA_CENTER_KV_VERSION_3,
                               s_query_p1       : LT_DATA_CENTER_P1VALUE,
                               s_query_p2       : LT_DATA_CENTER_P2VALUE,
                               s_query_p3       : LT_DATA_CENTER_P3VALUE,
                               s_query_sid      : sid,
                               s_query_ty       : [NSString stringWithFormat:@"%ld", (long)ty],
                               s_query_pos      : [NSString stringWithFormat:@"%ld", (long)pos],
                               s_query_clk      : clk,
                               s_query_uid      : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_query_uuid     : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_query_lc       : @"",
                               s_query_auid     : [DeviceManager getDeviceUUID],
                               s_query_ch       : @"",
                               s_query_ilu      : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_query_q        : q,
                               s_query_p        : [NSString stringWithFormat:@"%ld", (long)p],
                               s_query_rt       : rt,
                               s_query_r        : [[self class] generateRandomValue],
                               };
    
    NSArray *arrRequiredKeys = @[s_query_ver,
                                 s_query_p1,
                                 s_query_p2,
                                 s_query_sid,
                                 s_query_ty,
                                 s_query_uid,
                                 s_query_uuid,
                                 s_query_lc,
                                 s_query_auid,
                                 s_query_ilu,
                                 s_query_q,
                                 s_query_p,
                                 s_query_rt,
                                 s_query_r,
                                 ];
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVQuery
                              andRawData:dictData
                         andRequiredKeys:arrRequiredKeys];
    
    NSLog(@"上报搜索日志，%@",dictData);
}

+ (NSString *)queryPlayerRefWithPageid:(NSString *)pageid fl:(NSString *)fl wz:(NSInteger)wz {
    
    NSString *pageIDTemp = [NSString safeString:pageid];
    NSString *flTemp = [NSString safeString:fl];
    
    if ([NSString empty:flTemp]) {
        flTemp = @"-";
    }
    
    return [NSString stringWithFormat:@"%@_%@_%ld_-_-", pageIDTemp, flTemp, (long)wz];
}

+ (NSString *)queryRefWithPageid:(LTDCPageID)pageid fl:(LTDCActionPropertyCategory)fl wz:(NSInteger)wz
{
    NSString *newPageId =[NSString fomatPageIDEnumCode:pageid];
    if ([NSString isBlankString:newPageId])newPageId = @"-";
    
    NSString *newFl = [LTDataCenter getActionCodeByActionCategory:fl];
    if ([NSString isBlankString:newFl])newFl = @"-";
    
    NSString *newWz = (wz < 0) ? @"-" : [NSString stringWithFormat:@"%ld",(long)wz];
    return [NSString stringWithFormat:@"%@_%@_%@_-_-",newPageId,newFl,newWz];
}

+ (NSString *)queryRefWithInfo:(LTStatisticInfo *)info {
    NSString *newPageId = [self getValueByDefault:[NSString fomatPageIDEnumCode:info.pageID]];
    
    NSString *newFl = [self getValueByDefault:[LTDataCenter getActionCodeByActionCategory:info.apc]];
    
    NSString *newWz = (info.wz < 0) ? @"-" : [NSString stringWithFormat:@"%ld",(long)info.wz];
    
    //scid
    NSString *newScid = [self getValueByDefault:info.scidID];
    
    //fragid
    NSString *newFragid = [self getValueByDefault:info.fragId];
    
    return [NSString stringWithFormat:@"%@_%@_%@_%@_%@",newPageId,newFl,newWz,newScid,newFragid];
}

+ (NSString *)getValueByDefault:(NSString *)value {
    if ([NSString isBlankString:value]) {
        return @"-";
    }
    return value;
}

+(LTDCPageID)getPageIDFromRef:(NSString *)ref
{
    NSString *newPageId =@"";
    NSArray *array =[ref componentsSeparatedByString:@"_"];
    if (array.count>0) {
        newPageId  =[array firstObject];
    }
    return [newPageId integerValue];
}
+ (void)setCrashlyticsUserInfo
{
    [[Crashlytics sharedInstance] setUserIdentifier:[DeviceManager getDeviceUUID]];
    NSInteger isLogin = [SettingManager getValueFromUserDefaults:kIsLogin];
    NSString *mailString = @"";
    NSString *telString = @"";
    
    NSDictionary *dictUserInfo = [SettingManager userCenterUserInfo];
    if ( dictUserInfo
        &&  [dictUserInfo isKindOfClass:[NSDictionary class]]
        &&  [dictUserInfo count] > 0) {
        
        NSString *strExistedPhone = dictUserInfo[@"mobile"];
        NSString *strExistedEmail = dictUserInfo[@"email"];
        
        if ( ![NSString isBlankString:strExistedPhone]) {
            telString = strExistedPhone;
        }
        if (![NSString isBlankString:strExistedPhone]) {
            mailString = strExistedEmail;
        }
        
    }
    if (isLogin) {
        [[Crashlytics sharedInstance] setUserName:[NSString stringWithFormat:@"%@_%@",[[LTUserCenterEngine userCenterEngine] alreadyLoginUserName],[[LTUserCenterEngine userCenterEngine] alreadyLoginUserID]]];
        [[Crashlytics sharedInstance] setUserName:[NSString stringWithFormat:@"%@_%@",telString,mailString]];
    }
    else{
        [[Crashlytics sharedInstance] setUserName:@""];
        [[Crashlytics sharedInstance] setUserName:@""];
    }
    
}
@end

#pragma mark -

@implementation LTDataCenter (ThirdPartyDataStatistics)

+ (void)addBasicStatics{
    
#pragma warning cfxiao:--解耦
#if 0
    // flurry
    [Flurry setSessionContinueSeconds:0];
    [Flurry setAppVersion:CURRENT_VERSION];
    [Flurry setSecureTransportEnabled:YES];
	[Flurry startSession:FLURRY_API_KEY];
    [Flurry setSessionReportsOnCloseEnabled:NO];
	[Flurry setUserID:[DeviceManager getDeviceUUID]];
    
    [Flurry logEvent:@"IOS version"
      withParameters:@{@"ios systerm version": [UIDevice currentDevice].systemVersion}];
#else
    if ([[LeTVAppModule sharedModule] isImplemented]) {
        [[LeTVAppModule sharedModule] letv_Flurry_setSessionContinueSeconds: 0];
        [[LeTVAppModule sharedModule] letv_Flurry_setAppVersion: CURRENT_VERSION];
        [[LeTVAppModule sharedModule] letv_Flurry_setSecureTransportEnabled: YES];
        [[LeTVAppModule sharedModule] letv_Flurry_startSession: FLURRY_API_KEY];
        [[LeTVAppModule sharedModule] letv_Flurry_setSessionReportOnCloseEnabled: NO];
        [[LeTVAppModule sharedModule] letv_Flurry_setUserID: [DeviceManager getDeviceUUID]];
        [[LeTVAppModule sharedModule] letv_Flurry_logEvent: @"IOS version"
                                                withParams: @{@"ios system version" : [UIDevice currentDevice].systemVersion}];
    } else {
        //[Flurry setSessionContinueSeconds:0];
        Class FlurryClass = NSClassFromString(@"Flurry");
        SEL selector = NSSelectorFromString(@"setSessionContinueSeconds:");
        if ([FlurryClass respondsToSelector:selector]) {
            NSMethodSignature *sig = [FlurryClass methodSignatureForSelector:selector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
            invocation.target = FlurryClass;
            invocation.selector = selector;
            int s = 0;
            [invocation setArgument:&s atIndex:2];
            [invocation invoke];
        }
        
        //[Flurry setAppVersion:CURRENT_VERSION];
        selector = NSSelectorFromString(@"setAppVersion:");
        if ([FlurryClass respondsToSelector:selector]) {
            [FlurryClass performSelector:selector withObject:CURRENT_VERSION];
        }
        
        //[Flurry setSecureTransportEnabled:YES];
        selector = NSSelectorFromString(@"setSecureTransportEnabled:");
        if ([FlurryClass respondsToSelector:selector]) {
            NSMethodSignature *sig = [FlurryClass methodSignatureForSelector:selector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
            invocation.target = FlurryClass;
            invocation.selector = selector;
            BOOL e = YES;
            [invocation setArgument:&e atIndex:2];
            [invocation invoke];
        }
        
        //[Flurry startSession:FLURRY_API_KEY];
        selector = NSSelectorFromString(@"startSession:");
        if ([FlurryClass respondsToSelector:selector]) {
            [FlurryClass performSelector:selector withObject:FLURRY_API_KEY];
        }
        
        //[Flurry setSessionReportsOnCloseEnabled:NO];
        selector = NSSelectorFromString(@"setSessionReportsOnCloseEnabled:");
        if ([FlurryClass respondsToSelector:selector]) {
            NSMethodSignature *sig = [FlurryClass methodSignatureForSelector:selector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
            invocation.target = FlurryClass;
            invocation.selector = selector;
            BOOL e = NO;
            [invocation setArgument:&e atIndex:2];
            [invocation invoke];
        }
        
        //[Flurry setUserID:[DeviceManager getDeviceUUID]];
        selector = NSSelectorFromString(@"setUserID:");
        if ([FlurryClass respondsToSelector:selector]) {
            [FlurryClass performSelector:selector withObject:[DeviceManager getDeviceUUID]];
        }
        
        //[Flurry logEvent:@"IOS version" withParameters:@{@"ios systerm version": [UIDevice currentDevice].systemVersion}];
        selector = NSSelectorFromString(@"logEvent:withParameters:");
        if ([FlurryClass respondsToSelector:selector]) {
            [FlurryClass performSelector:selector withObject:@"IOS version" withObject:@{@"ios systerm version": [UIDevice currentDevice].systemVersion}];
        }
    }
#endif
    
    // 友盟
    /*
     [MobClick startWithAppkey:UM_API_KEY
     reportPolicy:SEND_INTERVAL
     channelId:CURRENT_PCODE];
     */
    
}
@end

@implementation LTLiveStatisticInfo

@end
#else



//@interface LTDataCenter()<RCTBridgeModule>
//
//@end

@implementation LTDataCenter

#pragma mark - react methods

//RCT_EXPORT_MODULE(LTDataCenter)

//RCT_EXPORT_METHOD(getErrorLogPath:(RCTResponseSenderBlock)callback) {
//    NSString * cachePath = [FileManager appLetvProtectedPath];
//    NSString * errorlogPath = [cachePath stringByAppendingPathComponent:ErrorLogText];
//    callback(@[errorlogPath]);
//}
//
//RCT_EXPORT_METHOD(getCDELogPath:(RCTResponseSenderBlock)callback) {
//    NSString * cachePath = [FileManager appLetvProtectedPath];
//    NSString * cdelogPath = [cachePath stringByAppendingPathComponent:CDELogText];
//    callback(@[cdelogPath]);
//}
//
//RCT_EXPORT_METHOD(writeToErrorLogFile:(NSString *)log) {
//    [[self class] writeToErrorLogFile:log];
//}

#pragma mark - comm

+ (NSString *)urlFlagForStatisticsType:(LTDataCenterStatisticsType)statisticsType
{
    switch (statisticsType) {
        case LTDataCenterStatisticsTypeLogin:
        case LTDataCenterStatisticsTypeLogout:
            return LT_URL_DC_LOGIN_FLAG;
        case LTDataCenterStatisticsTypePlay:
            return LT_URL_DC_PLAY_FLAG;
        case LTDataCenterStatisticsTypeAction:
            return LT_URL_DC_ACTION_RT_FLAG;
        case LTDataCenterStatisticsTypeAdPlay:
            return LT_URL_DC_ACTION_AD_PLAY_FLAG;
            
        case LTDataCenterStatisticsTypeKVAction:
            return LT_URL_DC_KV_ACTION_FLAG;
        case LTDataCenterStatisticsTypeKVLogin:
        case LTDataCenterStatisticsTypeKVLogout:
            return LT_URL_DC_KV_LOGIN_FLAG;
        case LTDataCenterStatisticsTypeKVEnv:
            return LT_URL_DC_KV_ENV_FLAG;
        case LTDataCenterStatisticsTypeKVPlay:
            return LT_URL_DC_KV_PLAY_FLAG;
        case LTDataCenterStatisticsTypeKVAd:
            return LT_URL_DC_KV_AD_FLAG;
        case LTDataCenterStatisticsTypeKVQuery:
            return LT_URL_DC_KV_QUERY_FLAG;
        case LTDataCenterStatisticsTypeKVError:
            return LT_URL_DC_KV_ERROR_FLAG;
        default:
            break;
    }
    
    return @"";
}

+ (NSString *)formatContentWithRawData:(NSDictionary *)dictData
                       andRequiredKeys:(NSArray *)requiredKeys
{
    NSMutableArray *arrDataVerified = [NSMutableArray array];
    [dictData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            if ([requiredKeys containsObject:key]) {
                [arrDataVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                            key,
                                            LT_DATA_CENTER_KV_CONNECTOR,
                                            LT_DATA_CENTER_EMPTY_REQUIRED]];
            }
        }
        else{
            NSString *objValue = (NSString *)obj;
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PARAM_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrDataVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }];
    
    return [arrDataVerified componentsJoinedByString:LT_DATA_CENTER_PARAM_SEPARATOR];
}
//根据频道的cid得到pageID
+ (LTDCPageID)getPageID:(NSString *)chnnelCid
{
    if ([NSString isBlankString:chnnelCid]) {
        return LTDCPageIDUnKnown;
    }
    else
    {
        switch ([chnnelCid intValue]) {
            case NewCID_MOVIE:
                return LTDCPageIDMovie;
            case NewCID_TV:
                return LTDCPageIDTV;
            case NewCID_Entertainment:
                return LTDCPageIDEntertainment;
            case NewCID_Sport:
                return LTDCPageIDSport;
            case NewCID_Anime:
                return LTDCPageIDAnimate;
            case NewCID_Music:
                return LTDCPageIDMusic;
            case NewCID_TVProgram:
                return LTDCPageIDVariety;
            case NewCID_Car:
                return LTDCPageIDCar;
            case NewCID_Documentary:
                return LTDCPageIDDocumentary;
                
            case NewCID_Fasion:
                return LTDCPageIDFasion;
            case NewCID_Finacial:
                return LTDCPageIDFinacial;
            case NewCID_Tour:
                return LTDCPageIDTour;
            case NewCID_NBA:
                return LTDCPageIDNBA;
            case Newcid_Funny:
                return LTDCPageIDFunny;
            case NewCID_Kids:
                return LTDCPageIDKids;
            case NewCID_News:
                return LTDCPageIDNews;
            case NewCid_Vip:
                return LTDCPageIDVIP;
            case Newcid_Dolby:
                return LTDCPageIDDolby;
            case Newcid_H265:
                return LTDCPageIDH265;
            case NewCID_NewHome:
                return LTDCPageIDIndex;
            #ifdef LT_MERGE_FROM_IPAD_CLIENT
            case Newcid_AmericanDrama:
                return LTDCPageIDAmericanDrama;
            case Newcid_EPL:
                return LTDCPageIDEPL;
            case Newcid_BroadcastOnly:
                return LTDCPageIDBroadcastOnly;
            #endif
            default:
                return LTDCPageIDUnKnown;
        }
    }
}

+ (LTDCPageID)getPageIDByLiveType:(LTLiveListType)listType
{
    switch (listType) {
        case LTLiveListType_Hot:
            return LTDCPageIDLiveHot;
        case LTLiveListType_LunBo:
            return LTDCPageIDLiveLunbo;
        case LTLiveListType_WeiShi:
            return LTDCPageIDLiveWeishi;
        case LTLiveListType_Sports:
            return LTDCPageIDLiveSport;
        case LTLiveListType_Music:
            return LTDCPageIDLiveMusic;
        case LTLiveListType_Ent:
            return LTDCPageIDLiveEntertainment;
        case LTLiveListType_Brand:
            return LTDCPageIDLiveBrand;
        case LTLiveListType_Game:
            return LTDCPageIDLiveGame;
        case LTLiveListType_Information:
            return LTDCPageIDLiveInformation;
        case LTLiveListType_Finance:
            return LTDCPageIDLiveFinace;
        case LTLiveListType_Other:
            return LTDCPageIDLiveOthers;
        default:
            return LTDCPageIDUnKnown;
    }
}

+ (NSString *)getLiveCode:(NSString *)code
{
    NSDictionary *dictActionCode = @{
                                     @"flv_350"          : @"1",
                                     @"3gp_320X240"      : @"2",
                                     @"flv_enp"          : @"3",
                                     @"chinafilm_350"    : @"4",
                                     @"flv_vip"          : @"8",
                                     @"mp4"              : @"9",
                                     @"flv_live"         : @"10",
                                     @"union_low"        : @"11",
                                     @"union_high"       : @"12",
                                     @"mp4_800"          : @"13",
                                     @"flv_1000"         : @"16",
                                     @"flv_1300"         : @"17",
                                     @"flv_720p"         : @"18",
                                     @"mp4_1080p"        : @"19",
                                     @"flv_1080p6m"      : @"20",
                                     @"mp4_350"          : @"21",
                                     @"mp4_1300"         : @"22",
                                     @"mp4_800_db"       : @"23",
                                     @"mp4_1300_db"      : @"24",
                                     @"mp4_720p_db"      : @"25",
                                     @"mp4_1080p6m_db"   : @"26",
                                     @"flv_yuanhua"      : @"27",
                                     @"mp4_yuanhua"      : @"28",
                                     @"flv_720p_3d"      : @"29",
                                     @"mp4_720p_3d"      : @"30",
                                     @"flv_1080p6m_3d"   : @"31",
                                     @"mp4_1080p6m_3d"   : @"32",
                                     @"flv_1080p_3d"     : @"33",
                                     @"mp4_1080p_3d"     : @"34",
                                     @"flv_1080p3m"      : @"35",
                                     @"flv_4k"           : @"44",
                                     @"h265_flv_800"     : @"47",
                                     @"h265_flv_1300"    : @"48",
                                     @"h265_flv_720p"    : @"49",
                                     @"h265_flv_1080p"   : @"50",
                                     @"mp4_180"          : @"58",
                                    };
    
    id valueForCategory = [dictActionCode objectForKey:code];
    if (nil == valueForCategory) {
        return @"";
    }
    
    NSString *actionCode = (NSString *)valueForCategory;
    
    return actionCode;

}
+ (NSString *)getTimeString
{
    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval=[currentDate timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%.0f", timeInterval];
}

+ (NSString *)generateRandomValue
{
    // 12位随机数
    NSString *str = @"";
    for (int i = 0; i < 12; i ++) {
        int x = arc4random()%10;
        str = [str stringByAppendingFormat:@"%d",x];
    }
    return str;
    //return [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000)];
}

+ (NSString *)getActionCodeByActionCategory:(LTDCActionPropertyCategory)apCategory
{
    NSDictionary *dictActionCode = @{
                                     // 首页
                                     @(LTDCActionPropertyCategoryLoginGuide)            :
                                         @"yd01",
                                     @(LTDCActionPropertyCategoryIndexFocus)            : @"11",
                                     @(LTDCActionPropertyCategoryIndexBlock)            : @"12",
                                     @(LTDCActionPropertyCategoryIndexAppexchange)      : @"13",
                                     @(LTDCActionPropertyCategoryIndexBlockPic)         : @"14",
                                     @(LTDCActionPropertyCategoryIndexBlockPlayHistory) : @"1211",
                                     @(LTDCActionPropertyCategoryIndexRecommentPic)      : @"17",
                                     @(LTDCActionPropertyCategoryIndexLive1)      : @"141",
                                     @(LTDCActionPropertyCategoryIndexLive2)      : @"142",
                                     @(LTDCActionPropertyCategoryIndexShow)              : @"19",
                                     @(LTDCActionPropertyCategoryIndexPlayRecordShow)              : @"1c",
                                     @(LTDCActionPropertyCategoryIndexImportRecommend)   : @"18",
                                     @(LTDCActionPropertyCategoryIndexSearch)           : @"1a",
                                     @(LTDCActionPropertyCategoryIndexLetvRecommend)    : @"1b",
                                     @(LTDCActionPropertyCategoryIndexRecordTip)       :@"1c",
                                     @(LTDCActionPropertyCategoryIndexInvitePopView):@"g12",
                                     @(LTDCActionPropertyCategoryIndexVipNotExpireRemindView):@"vp01",
                                     @(LTDCActionPropertyCategoryIndexVipHasExpireRemindView):@"vp02",
                                     @(LTDCActionPropertyCategoryIndexAppRecommend):@"17",
                                     //
                                     @(LTDCActionPropertyCategoryPopWoshiGeShou)        : @"a9",
                                     @(LTDCActionPropertyCategoryIndexChannel)          : @"a10",
                                     @(LTDCActionPropertyCategoryChannelWallEdit)       : @"a11",
                                     @(LTDCActionPropertyCategoryVipTrialInviteView)    : @"g16",
                                     @(LTDCActionPropertyCategoryVIPPromotionView)      : @"vp14",
                                     // 导航
                                     @(LTDCActionPropertyCategoryNavigationChannel)     : @"21",
                                     @(LTDCActionPropertyCategoryNavigationChannelMore) : @"219",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryNavigationChannelMoreList) : @"210",
                                     @(LTDCActionPropertyCategoryNavigationChart) : @"h81",
                                     #endif
                                     
                                     // 频道页
                                     @(LTDCActionPropertyCategoryChannelPage)           : @"211",
                                     @(LTDCActionPropertyCategoryChannelFocus)          : @"212",
                                     @(LTDCActionPropertyCategoryChannelBlock)          : @"213",
                                     @(LTDCActionPropertyCategoryChannelExchangeButton) : @"120",
                                     @(LTDCActionPropertyCategoryChannelSportHall)      : @"217",
                                     @(LTDCActionPropertyCategoryChannelSport)          : @"l15",
                                     @(LTDCActionPropertyCategoryChannelSubChannel)      : @"216",

                                      @(LTDCActionPropertyCategoryChannelSortViewNew)         : @"ft01",
                                     @(LTDCActionPropertyCategoryChannelManage)         : @"2116",
                                     @(LTDCActionPropertyCategorySportJiJin)            : @"2181",
                                     @(LTDCActionPropertyCategorySportSpecial)          : @"2182",
                                     @(LTDCActionPropertyCategorySportMore)             : @"2183",
                                     @(LTDCActionPropertyCategorySportFlag)             : @"2184",
                                     @(LTDCActionPropertyCategorySportTextLink)         : @"2185",
                                     @(LTDCActionPropertyCategoryChannelWall)           : @"c11",
                                     @(LTDCActionPropertyCategoryChannelSecond)         : @"h11",
                                     @(LTDCActionPropertyCategoryChannelSecondSearch):@"h12",
                                     @(LTDCActionPropertyCategoryChannelSecondFilter)   :@"h13",
                                     @(LTDCActionPropertyCategoryChannelSecondButtonFilter)   :@"h14",
                                     @(LTDCActionPropertyCategoryCustomEdit)            :@"cu01",
                                     // 搜索
                                     @(LTDCActionPropertyCategorySearchRecommendTab)    : @"d12",
                                     @(LTDCActionPropertyCategorySearchRecommendTab1Poster)    : @"d121",
                                     @(LTDCActionPropertyCategorySearchRecommendTab2Poster)    : @"d122",
                                     @(LTDCActionPropertyCategorySearchRecommendTab3Poster)    : @"d123",
                                     @(LTDCActionPropertyCategorySearchRecommendTab4Poster)    : @"d124",
                                     @(LTDCActionPropertyCategorySearchHotword)         : @"52",
                                     
                                     @(LTDCActionPropertyCategorySearchInput)           : @"511",
                                     @(LTDCActionPropertyCategorySearchGoSearch)        : @"d13",
                                     
                                     @(LTDCActionPropertyCategorySearchRelated)         : @"512",
                                     @(LTDCActionPropertyCategorySearchSugest)          : @"d14",
                                     @(LTDCActionPropertyCategorySearchSugestPlayBtn)   : @"d15",
                                     
                                     @(LTDCActionPropertyCategorySearchResult)          : @"513",
                                     @(LTDCActionPropertyCategorySearchGoBack)          : @"d11",
                                     @(LTDCActionPropertyCategorySearchH5ResultGoBack)          : @"d21",
                                     
                                     // TV推广
                                     @(LTDCActionPropertyCategoryTVPromoteSearchresult) : @"66",
                                     @(LTDCActionPropertyCategoryTVPromoteSetting)      : @"712",
                                     @(LTDCActionPropertyCategoryTVPromoteAppexchange)  : @"41",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayer)   : @"94",
                                     
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayerBottomView)
                                         : @"c67",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerWatchingFocus)
                                         : @"c676",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPicturePrecent)
                                         : @"c677",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayerBigTip)
                                         : @"c683",
                                     @(LTDCActionPropertyCategoryPlayerCenterChangeNetWork)
                                         : @"c684",
                                     
                                     @(LTDCActionPropertyCategoryPlayerCenterLookTimeClick)
                                         : @"c686",

                                     
                                     @(LTDCActionPropertyCategoryPlayerCenterPauseDownloadClick): @"c687",
                                     #endif
                                     @(LTDCActionPropertyCategoryPlayerCenterShow) : @"c68",
                                     @(LTDCActionPropertyCategoryPlayerTopView) : @"c65",
                                     @(LTDCActionPropertyCategoryPlayerNumberClick):@"c658",
                                     @(LTDCActionPropertyCategoryPlayer2KClick):@"l675",
                                     @(LTDCActionPropertyCategoryPlayerNoneWifiErrorClick):@"h31",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerLeft)   : @"a13",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerLeftBlock)  : @"a132",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPush)   : @"a16",
                                     @(LTDCActionPropertyCategoryTVPromotePlayer1080P)  : @"a17",
                                     @(LTDCActionPropertyCategoryTVPromotePlayer) :@"c675",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPushSuperTV):
                                         @"c654",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerAirPlayView)  : @"c6540",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerNotMatchSuperTV) : @"c6542",
                                     @(LTDCActionPropertyCategoryPlayerVolumeBar) : @"c663",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPush)   : @"c654",
                                     @(LTDCActionPropertyCategoryTVPromotePlayer1080P)  : @"a17",
                                     @(LTDCActionPropertyCategoryPlayer4KLearnMore)        : @"c6751",
                                     @(LTDCActionPropertyCategoryPlayer1080PLearnMore)   :@"c6752",
                                     #endif
                                     // 我是歌手
                                     @(LTDCActionPropertyCategorySearchResultWoShiGeShou): @"a31",
                                     
                                     // 直播
                                     @(LTDCActionPropertyCategoryLivingNavigation)      : @"31",
                                     @(LTDCActionPropertyCategoryLivingFocus)           : @"32",
                                     @(LTDCActionPropertyCategoryLivingHalfBottom)           :@"l21",
                                    //直播5.4
                                     @(LTDCActionPropertyCategoryLivingNavigationNew)      : @"c21",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition1)      : @"c22",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition2)      : @"c23",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition3)      : @"c24",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition4)      : @"c25",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition5)      : @"c26",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition6)      : @"c27",
                                     @(LTDCActionPropertyCategoryLivingNavigationPosition7)      : @"c28",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryTVPromotePlayer) :@"c675",
                                     #endif
                                     // 发现模块信息
                                     @(LTDCActionPropertyCategoryFindContentArea)         :@"di01"    ,
                                     @(LTDCActionPropertyCategoryFindToolArea)            :@"di02"   ,
                                     @(LTDCActionPropertyCategoryFindPopularizeArea)      :@"di03"    ,
                                     @(LTDCActionPropertyCategoryFindAppRecommendArea)    :@"di04"    ,
                                     
                                     // 播放页
                                     @(LTDCActionPropertyCategoryHalfPlayerVip)         :@"m01",
                                     @(LTDCActionPropertyCategoryHalfPlayerToolBar)     : @"92",
                                     @(LTDCActionPropertyCategoryHalfPlayerTabScroll)   : @"91",
                                     @(LTDCActionPropertyCategoryHalfPlayerTabBar)      : @"93",
                                     @(LTDCActionPropertyCategoryHalfPlayerKanqiu)      : @"96",
                                     @(LTDCActionPropertyCategoryHalfPlayerEpisode)      : @"922",
                                     @(LTDCActionPropertyCategoryHalfPlayerRelate)      : @"923",
                                     @(LTDCActionPropertyCategoryShareClick)      : @"h223",
                                     
                                      @(LTDCActionPropertyCategoryHalfPlayerSkipAd)      : @"c61",
                                      @(LTDCActionPropertyCategoryHalfPlayerPurChaseByTrial)      : @"c62",
                                      @(LTDCActionPropertyCategoryHalfPlayerTrialLogin)      : @"c63",
                                     @(LTDCActionPropertyCategoryPlayerDoubleClick)     : @"c64",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryPlayerSuperTVClick)
                                        : @"c6541",
                                     #endif
                                     @(LTDCActionPropertyCategoryPlayerGestureClick)
                                     :@"c66",
                                     @(LTDCActionPropertyCategoryHalfPlayerTrialView)   :@"c69",
                                     @(LTDCActionPropertyCategoryFULLPlayerTipJump)   :@"c76",

                                     @(LTDCActionPropertyCategoryPlayerVoteClick)       :
                                         @"c78",
                                     @(LTDCActionPropertyCategoryPlayerRightBlock)      : @"a133",
                                     @(LTDCActionPropertyCategoryFullScreen)            : @"a15",
                                     //边看边买
                                     @(LTDCActionPropertyCategoryPlayerLiveShopping)    : @"com01",
                                     @(LTDCActionPropertyCategoryPlayerLiveShoppingDetail) :
                                         @"com02",
                                     @(LTDCActionPropertyCategoryPlayerRightShoppingList) :
                                         @"com05",
                                     // 精选
                                     @(LTDCActionPropertyCategoryAppexchangeFocus)      : @"41",
                                     @(LTDCActionPropertyCategoryAppexchangeSeg1)       : @"42",
                                     @(LTDCActionPropertyCategoryAppexchangeSeg2)       : @"43",
                                     @(LTDCActionPropertyCategoryAppexchangeSeg3)       : @"44",
                                     @(LTDCActionPropertyCategoryAppexchangeSeg4)       : @"45",
                                     
                                     //
                                     @(LTDCActionPropertyCategoryMyLetv)                : @"72",
                                     @(LTDCActionPropertyCategoryMyLetvFav)             : @"83",
                                     @(LTDCActionPropertyCategoryMyLetvHeadUcNotLogin)  : @"71",
                                     @(LTDCActionPropertyCategoryMyLetvHeadUcLogin)     : @"81",
                                     @(LTDCActionPropertyCategoryMyLetvVipPayForIpad)   : @"712",
                                     @(LTDCActionPropertyCategoryCashierVipPayForIpad)         : @"7121",
                                     @(LTDCActionPropertyCategoryCashierSeniorVipPayForIpad)   : @"7122",
                                     @(LTDCActionPropertyCategoryMyLetvVipPay)          : @"713",
                                     @(LTDCActionPropertyCategoryMyLetvVoucherVip)      : @"7133",
                                     
                                     
                                     
                                     @(LTDCActionPropertyCategoryCashier)               : @"b3",
                                     @(LTDCActionPropertyCategoryCashierVipPay)         : @"b321",
                                     @(LTDCActionPropertyCategoryCashierSeniorVipPay)   : @"b322",
                                     @(LTDCActionPropertyCategoryCashierLogin)          : @"b33",
                                     
                                     @(LTDCActionPropertyCategorySetting)               : @"e51",//设置页面
                                     @(LTDCActionPropertyCategorySettingPlayPrior)      : @"e52",// 设置播放清晰度
                                     @(LTDCActionPropertyCategorySettingDownLoadPrior)  : @"e53",//设置页面下载清晰度
                                     @(LTDCActionPropertyCategorySettingDownLoadCount)  : @"e54",// 设置页面下载任务数
                                     @(LTDCActionPropertyCategorySettingDownLoadCache)  : @"e55",// 设置页面下载缓存。
                                     @(LTDCActionPropertyCategorySettingAboutOur)       : @"e56",//设置页面关于我们
                                     @(LTDCActionPropertyCategorySettingPersonalInfor)  : @"d38",//我的信息页面
                                     @(LTDCActionPropertyChannelSeach)                  : @"2b",//频道页顶部栏搜索
#if 0   //联通sdk 适配IPv6
                                     @(LTDCActionPropertyUnicomFlow)                    : @"h23",//联通流量包合作
                                     @(LTDCActionPropertyUnicomWo_Order)                : @"h51",//联通流量包订购相关。
                                     @(LTDCActionPropertyUnicomWo_InitHint)             : @"h64",//播放时候联通SDK初始化失败弹窗。
#endif

                                     @(LTDCActionPropertyCategoryNavigation)            : @"a2",
                                     @(LTDCActionPropertyCategoryIndexBlock1)           : @"121",
                                     @(LTDCActionPropertyCategoryIndexBlock1VIP)        : @"1212",
                                     
                                     @(LTDCActionPropertyCategoryDownloadNav)           : @"a42",
                                     @(LTDCActionPropertyCategoryDownloadDel)           : @"a41",
                                     @(LTDCActionPropertyCategoryDownloadOverClearAll)         : @"e32",
                                     @(LTDCActionPropertyCategoryDownloadingClearAll)         : @"e31",
                                     @(LTDCActionPropertyCategoryDownloadItunesClearAll)         : @"e33",
                                      @(LTDCActionPropertyCategoryLoginFailed)            : @"st01",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryDownloadingStateALL)    : @"e312",
                                     @(LTDCActionPropertyCategoryDownloadingButtonState)         : @"e311",
                                     @(LTDCActionPropertyCategoryDownloadDeleteAll)      : @"e38",
                                     @(LTDCActionPropertyCategoryDownloadMoreMoview)     : @"e321",
                                    
                                     #endif
                                     @(LTDCActionPropertyCategoryDownloadPageAction)    : @"a422",
                                     @(LTDCActionPropertyCategoryHalfPlayerDownload)    : @"a53",
                                     @(LTDCActionPropertyCategoryHalfPlayerManageDownload)  : @"a54",
                                     @(LTDCActionPropertyCategoryHalfPlayerLive)    : @"a55",
                                     @(LTDCActionPropertyCategoryScreenPlayerLive)    : @"a18",
                                     @(LTDCActionPropertyCategoryScreenPlayerLiveCode)    : @"a19",
                                     
                                     
                                     @(LTDCActionPropertyCategoryLoginPage)             : @"a6",
                                     @(LTDCActionPropertyCategoryPhoneRegisterPage)     : @"a8",
                                     @(LTDCActionPropertyCategoryEmailRegisterPage)     : @"a7",
                                     @(LTDCActionPropertyCategoryLetvLoginPage)         : @"a9",
                                     @(LTDCActionPropertyCategoryLetvForgetPwd)         : @"b1",
                                     @(LTDCActionPropertyCategoryLetvForgetPwdSendMsg)  : @"b2",
                                     
                                     @(LTDCActionPropertyCategoryLoginPage4Pad)         : @"a3",
                                     @(LTDCActionPropertyCategoryRegisterPage4Pad)      : @"a4",
                                     @(LTDCActionPropertyCategoryPhoneRegisterPage4Pad) : @"a5",
                                     @(LTDCActionPropertyCategoryEmailRegisterPage4Pad) : @"a6",
                                     @(LTDCActionPropertyCategoryDownloadUserLoginTip):@"a54",
                                     @(LTDCActionPropertyCategoryIndexLoginTip):@"215",
                                     @(LTDCActionPropertyCategoryIndexRenewVip):@"214",
                                     
                                     @(LTDCActionPropertyCategoryUpdate)               :@"c1",
                                      @(LTDCActionPropertyCategoryForceUpdate)         :@"e71",
                                     @(LTDCActionPropertyCategorySubject)               :@"c3",
                                     @(LTDCActionPropertyCategoryUpdateAndForceUpdate)  :@"sj",
                                     
                                     //登录界面
                                     @(LTDCActionPropertyLoginGoback)              :@"c71",
                                     @(LTDCActionPropertyLoginFromThirdParty)              :@"c72",
                                     @(LTDCActionPropertyLoginAction)              :@"c73",
                                     @(LTDCActionPropertyLoginAccessory)              :@"c74",
                                     @(LTDCActionPropertyLoginSuccess)              :@"c75",
                                     @(LTDCActionPropertyLoginHeadClick)            :@"d31",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDcActionPropertyLoginVipClick)             :@"c69",
                                     #endif
                                     //图文投票分享点击
                                     @(LTDCActionPropertyGraphicVoteShare)              :@"c80",
                                      //注册页面
                                      @(LTDCActionPropertyRegisterGoback)              :@"c81",
                                     @(LTDCActionPropertyRegisterFromThirdParty)       :@"c82",
                                     @(LTDCActionPropertyRegisterBy)                   :@"c83",
                                     @(LTDCActionPropertyRegisterByPhone)              :@"c831",
                                     @(LTDCActionPropertyRegisterByEmail)              :@"c832",
                                     @(LTDCActionPropertyRegisterByMessage)            :@"c833",
                                     @(LTDCActionPropertyRegisterPageShow)             :@"c834",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyRegisterLoginSucc)            :@"c84" ,
                                     #endif
                                     
                                     //找回密码
                                     @(LTDCActionPropertyFindPasswordFromMessage)       :@"c91",
                                     @(LTDCActionPropertyFindPasswordFromEMail)         :@"c92",
                                     @(LTDCActionPropertyFindPasswordPageShow)          :@"c93",
                                     
                                     //push
                                     @(LTDCActionPropertyPush)          :@"c5",
                                     @(LTDCActionPropertyPushShow)      :@"tc10",
                                     
                                     //我的-播放记录列表
                                     @(LTDCActionPropertyMyLetvPlayRecord)          :@"d332",
                                     @(LTDCActionPropertyMyLetvSettingClick)        :@"d32",
                                     @(LTDCActionPropertyMyLetvListClick)           :@"d33",
                                     @(LTDCActionPropertyMyLetvRecodeListClick)      :@"d35",
                                     @(LTDCActionPropertyMyLetvRecodeLoginClick)      :@"d36",
                                     @(LTDCActionPropertyMyLetvRecodeNextPlayClick)      :@"d37",
                                     @(LTDCActionPropertyPlayRecord)                :@"h71",
                                     @(LTDCActionPropertyCategoryHalfPlayerSurroundView):@"h26",
                                     @(LTDCActionPropertyCategoryHalfPlayerjuji):@"h27",
                                     @(LTDCActionPropertyCategoryHalfPlayerRelateView):@"h28",
                                     @(LTDCActionPropertyCategoryHalfPlayerFouceView):@"h25",
                                     @(LTDCActionPropertyPlayRecordList)            :@"h72",
                                     @(LTDCActionPropertyPlayHistoryBack)           :@"h73",
                                     
                                     //热点
                                      @(LTDCActionPropertyCategoryHotUp)          :@"c31",
                                      @(LTDCActionPropertyCategoryHotShareBtn)          :@"c32",
                                      @(LTDCActionPropertyCategoryHotShare)          :@"c321",
                                     
                                     //推荐专题
                                      @(LTDCActionPropertyRecommendSpecial)          :@"c41",
                                      @(LTDCActionPropertyFloatBall)                :@"g11",
                                      @(LTDCActionPropertyHotChannelPause)          :@"c331",
                                      @(LTDCActionPropertyHotChannelPlay)           :@"c332",
                                     //半屏播放页tab，底部导航，评论
                                      @(LTDCActionPropertyHalfPlayerTag)            :@"h21",
                                      @(LTDCActionPropertyHalfPlayerToolBar)        :@"h22",
                                     //分享成功fl
                                      @(LTDCActionPropertyShareSucces):          @"s10",
                                     @(LTDcActionPropertyCaptureShareClick):        @"sh20",
                                     @(LTDcActionPropertyCaptureShareSucces):          @"sh21",
                                      @(LTDCActionPropertyHalfPlayerComment)        :@"82",
                                     //半屏播放页 相关播放，相关系列、猜你喜欢
                                     @(LTDCActionPropertyEpisodePromotion)            :@"h212",
                                     //半屏播放页 相关播放，相关系列、猜你喜欢
                                     @(LTDCActionPropertyRelatedPlayAndFav)            :@"h2131",
                                     @(LTDCActionPropertyRelatedSeries)                :@"h2132",
                                     @(LTDCActionPropertyRelatedGuessYouLike)          :@"h2133",
                                     @(LTDCActionPropertyEpisodeSummary)               :@"h211",
                                     @(LTDCActionPropertyEpisodeClick)                 :@"h2122",
                                     @(LTDCActionPropertyCategoryChannelShowListViewPlay):@"dt01",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                    
                                     @(LTDcActionPropertyAddCommentClick)             :@"h24",
                                     @(LTDCActionPropertyReplyComment)                :@"h213",
                                     @(LTDCActionPropertySendComment)                 :@"h241",
                                     #endif
                                     //更多  分享
                                     @(LTDcActionPropertyShareMoreClick)              :@"h50",
                                     @(LTDcActionPropertyShareClick)                  :@"h52",
                                     //iphone 上 猜你喜欢 和评论发送
                                     @(LTDCActionPropertyRelated)                      :@"h214",
                                     @(LTDActionPropertyCommentSend)                   :@"803",
                                     @(LTDActionPropertyHalfLiveOrder)                 :@"l01",
                                     @(LTDActionPropertyHalfLive)                      :@"l02",
                                     @(LTDActionPropertyHalfLiveToolBar)               :@"l03",
                                     @(LTDActionPropertyHalfLivePayOrder)              :@"l04",
                                     @(LTDActionPropertyHalfLivePayConsumeHistory)     :@"l06",
                                     @(LTDCActionPropertyCategoryPlayerCenterDownloadbuffer) :@"687",
                                     @(LTDCActionPropertyCategoryPlayerSettingBindInfor)     :@"040",
                                     @(LTDcActionPropertyCategoryReplyClick)                 :@"85",
                                     @(LTDcActionPropertyCategoryPriseClick)                 :@"86",
                                     @(LTDcActionPropertyCategoryMoreClick)                  :@"87",
                                     @(LTDCActionPropertyCategoryHalfClickPrise)             :@"90",
                                     @(LTDActionPropertyHalfLiveToolBarSwitchOrder)    :@"l07",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayerBigTip)
                                     : @"c683",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayer3G) :@"c684",
                                     @(LTDCActionPropertyCategoryPlayerCenterLookTimeClick)
                                     : @"c686",
                                     @(LTDCActionPropertyCategoryPlayerCenterbuffer)
                                     : @"c687",
                                     @(LTDCActionPropertyCategoryPlayerCenterShow)
                                     : @"c68",
                                     @(LTDCActionPropertyCategoryPlayer4KLearnMore)        : @"c6751",
                                     @(LTDCActionPropertyCategoryPlayer1080PLearnMore)   :@"c6752",
                                     @(LTDCActionPropertyCategoryTVPromoteHalfPlayerBottomView)
                                     : @"c67",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerPicturePrecent)
                                     : @"c677",
                                     @(LTDCActionPropertyCategoryTVPromotePlayerWatchingFocus)
                                     : @"c676",
                                     @(LTDCActionPropertyCategoryPlayerTopView)
                                     : @"c65",
                                     @(LTDCActionPropertyCategoryPlayerTopPushView): @"c650",
                                     
                                     @(LTDCActionPropertyCategoryPlayerPlayBillView)
                                     :@"c657",
                                     #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyCategoryDownloadSegement)   :@"e41",
                                     @(LTDCActionPropertyCategoryDownloadAddSuccess) :@"e42",
                                     @(LTDCActionPropertyCategoryDownloadForbid)     :@"e44",
                                     @(LTDCActionPropertyCategoryDownloadOther)      :@"e43",
                                      //登陆 注册
                                     @(LTDCActionPropertyCategoryMyPage)      :@"d34",
                                     #endif
                                     //全屏剧集点击
                                     @(LTDcActionPropertyFullScreenEpisodeSummary) : @"c656",
                                     @(LTDCActionPropertyCategoryPlayerLearnMore)  : @"c6541",
                                     //直播播放器
                                     @(LTDCActionPropertyLivingDefaultPlayer): @"l09",
                                     @(LTDCActionPropertyLivingFullPlayer): @"l08",
                                     
                                     //a播放记录
                                      #ifdef LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyRecord):@"w10",
                                     @(LTDCActionPropertyRecordButton):@"w11",
                                     @(LTDCActionPropertyRecordTableDidSelect):@"w12",
                                     @(LTDCActionPropertyRecordLogin):@"w13",
                                     #endif
                                     //会员转移购买
                                     @(LTDCActionPropertyVipPayClick):@"vp06",
                                     @(LTDcActionPropertyVipClick)   :@"vp10",
                                     #ifndef  LT_MERGE_FROM_IPAD_CLIENT
                                     @(LTDCActionPropertyPay):@"vp03",
                                     @(LTDCActionPropertyPayShow):@"vp04",
                                     @(LTDCActionPropertyMovePay):@"d30",
                                     @(LTDCActionPropertyLivePlay):@"l18",
                                     @(LTDCActionPropertyListLivePlay):@"l19",
                                     @(LTDCActionPropertyListClickLivePlay):@"l20",
                                   
                                     #else
                                     @(LTDCActionPropertyBuyMove):@"d30",
                                     @(LTDCActionPropertyShow):@"vp03",
                                     @(LTDCActionPropertyVipRemmond):@"vp04",
                                    
                                     
									 #endif
                                     @(LTDCActionPropertyLiveHalfToolBarView):@"l17",
                                     @(LTDCActionPropertyLiveHalfPlay):@"l12",
                                     @(LTDcActionPropertyLiveHalfTime):@"l11",
                                     @(LTDcActionPropertyLiveHalfPay) :@"l10",
                                     @(LTDcActionPropertyLiveHalfWeiShi) :@"l13",
                                     @(LTDcActionPropertyLiveHalfSprot) :@"l14",
                                     @(LTDcActionPropertyLiveHalfMusic) :@"l16",
                                     @(LTDcActionPropertyLiveDefaultRecommendView) :@"l60",
                                     @(LTDcActionPropertyLiveDefaultSelectedView) :@"l61",
                                     
                                     // 直播大厅轮播卫视（收藏、全部、历史）
                                     @(LTDcActionPropertyLiveHallTabSelected) :@"l40",
                                     @(LTDcActionPropertyLiveHallStoreUp) :@"l41",
                                     
                                     // 冷启动引导图后个人喜欢
                                     @(LTDCActionPropertyNewUserGuideLike) :@"ns01",
                                     
                                     @(LTDCActionPropertyTimeShiftBackIcon) :@"l51",
                                     
                                     // 弹幕
                                     @(LTDCActionPropertyDanmakuSendButtonAction) :@"c6810",
                                     @(LTDCActionPropertyDanmakuSyncButtonAction) :@"c77",
                                     
                                     // 直播弹幕
                                     @(LTDCActionPropertyLiveDanmakuOnOffButtonShow) :@"l65",
                                     @(LTDCActionPropertyLiveDanmakuOnOffButtonAction) :@"l658",
                                     @(LTDCActionPropertyLiveDanmakuSendButtonShow) :@"l68",
                                     @(LTDCActionPropertyLiveDanmakuSendButtonAction) :@"l681",
                                     // 截屏分享
                                     @(LTDCActionPropertyScreenShotPhotosShare)            :@"sh01",
                                     @(LTDCActionPropertyScreenShotPhotosTextClick)        :@"sh02",
                                     @(LTDCActionPropertyScreenShotPhotosSignClick)        :@"sh03",
                                     //明星页面
                                     @(LTDCActionPropertyStarInfo)                         :@"s03",
                                     @(LTDCActionPropertyStarCardActivity)                 :@"st1",
                                     @(LTDCActionPropertyStarCardStarIDVideo)              :@"st2",
                                     @(LTDCActionPropertyStarCardStarLiveVideo)            :@"st3",
                                     @(LTDCActionPropertyStarCardMusicVideo)               :@"st4",
                                     @(LTDCActionPropertyStarCardRingVideo)                :@"st5",
                                     @(LTDCActionAppStoreStar)
                                         :@"ev01",
                                     @(LTDCActionPropertyStarCardAlbumVideo)               :@"st6",
                                     @(LTDCActionPropertyStarCardNewsVideo)                :@"st7",
                                     };
    
    id valueForCategory = [dictActionCode objectForKey:@(apCategory)];
    if (nil == valueForCategory) {
        return @"";
    }
    
    NSString *actionCode = (NSString *)valueForCategory;
    
    return actionCode;
}

#pragma mark - cache

+ (LTDataCenterStatisticsType)getStatisticsTypeByCachedFilename:(NSString *)fileName
{
    NSArray *array = [fileName componentsSeparatedByString:LT_DC_CACHE_FILENAME_SEPARATOR];
    if (    nil == array
        ||  [array count] != 2) {
        return LTDataCenterStatisticsTypeError;
    }
    
    return (LTDataCenterStatisticsType)[array[0] integerValue];
}

+ (NSString *)cacheStatisticsWithType:(LTDataCenterStatisticsType)sType
                        andUrlContent:(NSString *)content
{

    @try {
        NSString *cachePath = [FileManager appDataCenterCachePath];
        
        if ([NSString isBlankString:cachePath] || LTDataCenterStatisticsTypeError == sType || LTDataCenterStatisticsTypeKVError == sType) {
            return @"";
        }
        BOOL isNeedCache =  sType == LTDataCenterStatisticsTypeKVAction ||
                            sType == LTDataCenterStatisticsTypeKVLogin ||
                            sType == LTDataCenterStatisticsTypeKVLogout ||
                            sType == LTDataCenterStatisticsTypeKVEnv ||
                            sType == LTDataCenterStatisticsTypeKVPlay;
        if (!isNeedCache) {
            return @"";
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"SSS"];
        NSString *ms = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%ld%@%ld%@%ld", (long)sType, LT_DC_CACHE_FILENAME_SEPARATOR,(long)[[NSDate date] timeIntervalSince1970],ms,(long)arc4random()];
        NSString *fullPath = [cachePath stringByAppendingPathComponent:fileName];
        [content writeToFile:fullPath
                  atomically:YES
                    encoding:NSUTF8StringEncoding
                       error:nil];
        return fileName;

    }
    @catch (NSException *exception) {
        
    }

    return @"";
}

+ (NSString *)cacheStatisticsWithType:(LTDataCenterStatisticsType)sType
                           andRawData:(NSDictionary *)dictData
                      andRequiredKeys:(NSArray *)requiredKeys
{
    NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                  andRequiredKeys:requiredKeys];
    
    return [[self class] cacheStatisticsWithType:sType
                                   andUrlContent:strContent];
}

+ (void)sendCachedStatistics
{
//#ifdef LT_MERGE_FROM_IPAD_CLIENT
//    #ifndef LTMovieplayerFramework
//#endif
    if (![NetworkReachability connectedToNetwork]) {
        return;
    }
    
    NSMutableArray *arrayCachedFiles = [NSMutableArray array];
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSString *cachePath = [FileManager appDataCenterCachePath];
    NSArray *contents = [fm contentsOfDirectoryAtPath:cachePath error:nil];
    for (NSString *filename in contents) {
        if (    filename.length <= 0
            ||  [filename characterAtIndex:0] == '.') {
            continue;
        }
        NSString *path = [cachePath stringByAppendingPathComponent:filename];
        NSDictionary *attr = [fm attributesOfItemAtPath:path error:nil];
        if (!attr) {
            continue;
        }
        id fileType = [attr valueForKey:NSFileType];
        if (![fileType isEqual: NSFileTypeRegular]) {
            continue;
        }
        
        [arrayCachedFiles addObject:filename];
    }
    NSArray *orderFiles = [arrayCachedFiles sortedArrayUsingComparator:^(NSString * obj1, NSString * obj2){
        return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSInteger fileCount = 0;
    for (NSString *filename in orderFiles) {
        LTDataCenterStatisticsType stype = [[self class] getStatisticsTypeByCachedFilename:filename];
        if (stype == LTDataCenterStatisticsTypeError) {
            continue;
        }
        NSString *path = [cachePath stringByAppendingPathComponent:filename];
        NSData *data = [fm contentsAtPath:path];
        NSString *urlContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // 过滤play 动作本地日志的url
        NSRange rang = [urlContent rangeOfString:@"&ac="];
        if (stype == LTDataCenterStatisticsTypeKVPlay) {
            if (rang.location != NSNotFound && rang.length != NSNotFound) {
                fileCount++;
                [LTDataModelEngine sendStatistics:stype
                                      withUrlPath:urlContent
                                completionHandler:^{
                                    NSLog(@"data center, cached data upload success. %ld", (long)stype);
                                    [fm removeItemAtPath:path error:nil];
                                } errorHandler:^(NSError *error) {
                                    //
                                }];
            }
        }else
        {
            [LTDataModelEngine sendStatistics:stype
                                  withUrlPath:urlContent
                            completionHandler:^{
                                NSLog(@"data center, cached data upload success. %ld", (long)stype);
                                [fm removeItemAtPath:path error:nil];
                            } errorHandler:^(NSError *error) {
                                //
                            }];

        }
    }
//#ifdef LT_MERGE_FROM_IPAD_CLIENT
//    #endif
//#endif
}

#pragma mark - send
+ (void)sendStatisticsWithType:(LTDataCenterStatisticsType)sType
                 andUrlContent:(NSString *)content
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        // 动作日志不需要缓存
        BOOL isNeedCacheIfSendFailed = (    LTDataCenterStatisticsTypeAction != sType
                                        &&  LTDataCenterStatisticsTypeKVAction != sType);
        
        if (![NetworkReachability connectedToNetwork]) {
            if (isNeedCacheIfSendFailed) {
                [[self class] cacheStatisticsWithType:sType
                                        andUrlContent:content];
            }
            
            return;
        }
        
        [LTDataModelEngine sendStatistics:sType
                              withUrlPath:content
                        completionHandler:^{
//                            NSLog(@"data center, data upload success. %ld", (long)sType);
//                            NSLog(@"data center, content：=＝(%ld)＝＝ %@",(long) sType , content);
                        } errorHandler:^(NSError *error) {
                            if (isNeedCacheIfSendFailed) {
                                [[self class] cacheStatisticsWithType:sType
                                                        andUrlContent:content];
                            }
                        }];
    });

    return;
}

+ (void)sendActionStatisticsWithUrlContent:(NSString *)content
                             andActionCode:(LTDCActionCode)actionCode
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        
        BOOL isNeedCacheIfSendFailed = (LTDCActionCodeLaunch == actionCode ||
                                        LTDCActionCodeQuit ==  actionCode);
        
        if (![NetworkReachability connectedToNetwork]) {
            if (isNeedCacheIfSendFailed) {
                [[self class] cacheStatisticsWithType:LTDataCenterStatisticsTypeKVAction
                                        andUrlContent:content];
            }
            
            return;
        }
        
        [LTDataModelEngine sendStatistics:LTDataCenterStatisticsTypeKVAction
                              withUrlPath:content
                        completionHandler:^{
//                            NSLog(@"data center, data upload success. %ld", (long)LTDataCenterStatisticsTypeKVAction);
                        } errorHandler:^(NSError *error) {
                            if (isNeedCacheIfSendFailed) {
                                [[self class] cacheStatisticsWithType:LTDataCenterStatisticsTypeKVAction
                                                        andUrlContent:content];
                            }
                        }];
    });
    
    return;
}

+ (void)sendActionStatisticsWithRawData:(NSDictionary *)dictData
                        andRequiredKeys:(NSArray *)requiredKeys
                          andActionCode:(LTDCActionCode)actionCode
{
    NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                  andRequiredKeys:requiredKeys];
    
    [[self class] sendActionStatisticsWithUrlContent:strContent
                                       andActionCode:actionCode];
    
    return;
}

+ (void)sendStatisticsWithType:(LTDataCenterStatisticsType)sType
                    andRawData:(NSDictionary *)dictData
               andRequiredKeys:(NSArray *)requiredKeys
{
    NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                  andRequiredKeys:requiredKeys];
    
    [[self class] sendStatisticsWithType:sType
                           andUrlContent:strContent];
    
    return;
}

#pragma mark - login / logout

+ (void)login
{
    double lastLoginTime = [SettingManager getVirtualLoginTime];
    NSTimeInterval curTime = [[NSDate date] timeIntervalSince1970] * 1000;
    //不是同一天请求签到接口
    
    if (curTime - lastLoginTime < LT_DC_VALID_LOGIN_INTERVAL) {
        // 如果两次启动间隔小于1分钟，这两次启动会被视为1次启动
        // 清除缓存的上一次退出日志
        [[self class] removeLastLogoutData];
    }
    else{
        // 否则，一次新的启动
        [SettingManager setVirtualLoginTime:curTime];
        
        // 重置uuid
        NSString *did_client = [DeviceManager getDeviceUUID];
        NSString *loginUUID = [NSString stringWithFormat:@"%@_%@",
                               did_client,
                               [NSString stringWithFormat:@"%lld", (long long)curTime]];
        [SettingManager setVirtualLoginUUID:loginUUID];
        // 上报本次启动日志
        [[self class] addLoginData:LTDCLoginStatusLogin];
    }
    
    // set last logout filename empty.
    [SettingManager setLastLogoutFileName:@""];
    
    // 上报缓存的日志（包括上一次登出日志，以及缓存在本地的未上报成功过的日志）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        [self sendCachedStatistics];
    });
    
    return;
}

+ (void)logout
{
    [[self class] logout:LTDCPageIDUnKnown];
}

+ (void)logout:(LTDCPageID)pageID
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    // update user type to activity
    [LeTVSharedAppModule letv_AppDelegate_setLetvUserType:LetvUserActivity];
    
    //发送退出统计日志
    NSDictionary *dictAp = @{
                             @"time"    : [NSString formatStatisticCurrentTimeString],
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"pageid"  : pageid
                             };
    #ifndef LT_MERGE_FROM_IPAD_CLIENT
    [LTDataCenter addActionData:LTDCActionCodeQuit
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    #else /* !LT_MERGE_FROM_IPAD_CLIENT */
    [LTDataCenter addActionData:LTDCActionCodeQuit
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:nil];
    #endif /* LT_MERGE_FROM_IPAD_CLIENT */
    
    // 清除缓存的上一次退出日志
    [[self class] removeLastLogoutData];
    [SettingManager setLastLogoutFileName:@""];
    
    // 缓存退出日志，下一次启动的时候再上报
    NSString *fileName = [[self class] addLoginData:LTDCLoginStatusLogout];
    [SettingManager setLastLogoutFileName:fileName];
}

+ (void)loginToUserCenter
{
    // 上报一次login日志，不重新生成uuid
    [[self class] addLoginData:LTDCLoginStatusLogin2UserCenter];
    
    return;
}

+ (void)removeLastLogoutData
{
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    #ifndef LTMovieplayerFramework
#endif
    // 清除缓存的上一次登出日志
    NSString *lastLogoutFileName = [SettingManager getLastLogoutFileName];
    if ([NSString isBlankString:lastLogoutFileName]) {
        return;
    }
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSString *cachePath = [FileManager appDataCenterCachePath];
    NSString *path = [cachePath stringByAppendingPathComponent:lastLogoutFileName];
    if ([fm fileExistsAtPath:path]) {
        [fm removeItemAtPath:path error:nil];
    }
    
    return;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    #endif
#endif
}

#pragma mark - action

+ (void)addActionData:(LTDCCodeActionModule)module  // 模块码
            subModule:(int)subModule                // 子模块码
                  act:(LTDCCodeActionType)act       // 动作码
             adSystem:(NSString *)adSystem          // 广告系统
             codeRate:(VideoCodeType)codeRate       // 码率
              extInfo:(NSArray *)arrExt             // 扩展信息
{
    if (    module >= LTDCCodeActionModuleCount
        ||  act >= LTDCCodeActionTypeCount) {
        //NSLog(@"Invalid action code.");
        return;
    }
    
    // $1:nettype,上网类型 ex:wifi/3G
    NSString *strNetType = [NetworkReachability currentNetType];
    if ([NSString isBlankString:strNetType]) {
        strNetType = EMPTY_PARAM_VALUE;
    }
    
    // $2:uid,乐视网用户id
    NSString *alreadyLoginUid = [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID];
    NSString *strUid          = [NSString isBlankString:alreadyLoginUid] ? EMPTY_PARAM_VALUE : alreadyLoginUid;
    
    // auid
    // chenhao auid
    NSString *strAUID = [DeviceManager getIOSDeviceUUID];
    if ([NSString isBlankString:strAUID]) {
        strAUID = EMPTY_PARAM_VALUE;
    }
    
    // $3:act,动作码
    NSString *strActModule;
    if (module == LTDCCodeActionModuleEmpty) {
        strActModule = EMPTY_PARAM_VALUE;
    }
    else{
        if (module < 10) {
            strActModule = [NSString stringWithFormat:@"%ld", (long)module];
        }
        else{
            strActModule = [NSString stringWithFormat:@"%ld", (long)('a'+module-10)];
        }
    }
    NSString *strActSubModule;
    if (subModule == -1) {
        strActSubModule = EMPTY_PARAM_VALUE;
    }
    else{
        if (subModule < 10) {
            strActSubModule = [NSString stringWithFormat:@"%d", subModule];
        }
        else{
            strActSubModule = [NSString stringWithFormat:@"%c", 'a'+subModule-10];
        }
    }
    NSString *strActAction;
    if (act == LTDCCodeActionTypeEmpty) {
        strActAction = EMPTY_PARAM_VALUE;
    }
    else{
        if (act < 10) {
            strActAction = [NSString stringWithFormat:@"%ld", (long)act];
        }
        else{
            strActAction = [NSString stringWithFormat:@"%ld", (long)('a'+act-10)];
        }
    }
    NSString *strAct = [NSString stringWithFormat:@"%@%@%@", strActModule, strActSubModule, strActAction];
    if ([NSString isBlankString:strAct]) {
        strAct = EMPTY_PARAM_VALUE;
    }
    
    // $4:t,时间戳
    NSString *strTime =[NSString stringWithFormat:@"%ld", time(NULL)];
    
    // $5:uuid, (did_timestamp)登录时生成的uuid
    NSString *strUUID = [SettingManager getVirtualLoginUUID];
    if (    nil == strUUID
        ||  [NSString isBlankString:strUUID]) {
        strUUID = EMPTY_PARAM_VALUE;
    }
    
    // $6:ext,扩展信息cid_pid_vid;134（0或多个扩展信息，扩展信息以;"分号"分隔）
    NSInteger nCountExt = 0;
    NSString *strExt = @"";
    if (    nil != arrExt
        &&  [arrExt count] > 0) {
        nCountExt = [arrExt count];
        for (int i=0; i<nCountExt; i++) {
            NSString *subExt = arrExt[i];
            if (![NSString isBlankString:subExt]) {
                strExt = [strExt stringByAppendingFormat:@"%@", [subExt encodedURLString]];
            }
            else{
                strExt = [strExt stringByAppendingFormat:EMPTY_PARAM_VALUE];
            }
            
            if (i != nCountExt-1) {
                strExt = [strExt stringByAppendingFormat:@";"];
            }
        }
    }
    if ([NSString isBlankString:strExt]) {
        strExt = EMPTY_PARAM_VALUE;
    }
    else{
        strExt = [strExt stringByReplacingOccurrencesOfRegex:@"\\&" withString:@"}"];
        strExt = [strExt stringByReplacingOccurrencesOfRegex:@"\\?" withString:@"{"];
    }
    
    // $7:统计版本
    NSString *dcVersion = LT_DATA_CENTER_VERSION;
    NSString *app_client = CURRENT_PCODE;
    NSString *appver_client = CURRENT_VERSION;
    
    if ([NSString isBlankString:adSystem]) {
        adSystem = EMPTY_PARAM_VALUE;
    }
    
    NSString *strCodeRate = EMPTY_PARAM_VALUE;
    if (VIDEO_CODE_UNKNOWN != codeRate) {
        strCodeRate = [NSString stringWithFormat:@"%@", [NSString formatBitrateValue:codeRate]];
    }
    
    NSArray *paraArray = @[strNetType,          // 上网类型
                           strUid,              // 乐视网用户id
                           strAUID,             // iOS6.0版本读取的设备id
                           strAct,              // 动作码
                           strTime,             // 时间戳
                           strUUID,             // 登录时生成的uuid
                           strExt,              // 扩展信息
                           dcVersion,           // 日志上报版本
                           app_client,          // 产品线
                           appver_client,       // 应用版本
                           adSystem,            // 广告系统
                           strCodeRate          // 码率
                           ];
    
    NSString *strData = [paraArray componentsJoinedByString:@"&"];
    
    //    NSLog(@"datacenter-action---%@", strData);
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeAction
                           andUrlContent:strData];
    
    return;
}

+ (void)addActionData:(LTDCCodeActionModule)module  // 模块码
            subModule:(int)subModule                // 子模块码
                  act:(LTDCCodeActionType)act       // 动作码
              extInfo:(NSArray *)arrExt             // 扩展信息
{
    [[self class] addActionData:module
                      subModule:subModule
                            act:act
                       adSystem:nil
                       codeRate:VIDEO_CODE_UNKNOWN
                        extInfo:arrExt];
}
#ifdef LT_MERGE_FROM_IPAD_CLIENT
#warning ZhangQigang: 解耦, 数据类型, 接口需要移动到  MobileAdvertise
// 非贴片广告
+ (void)addADActionData:(LTDCCodeActionModule)module  // 模块码
                    act:(LTDCCodeActionType)act       // 动作码
                 adType:(NSInteger)advertiseType
                   adID:(NSString *)adid
                extInfo:(NSArray *)arrExt
               adSystem:(NSString *)adSystem
{
#if 0
    NSMutableArray *arrayAdExtraInfo = [NSMutableArray array];
    
    [arrayAdExtraInfo addObjectsFromArray:arrExt];
    
    NSString *adType=nil;
    switch (advertiseType) {
        case MovieAdvertiseType_Booting:
            adType=@"11";
            break;
        case MovieAdvertiseType_Focus:
        case MovieAdvertiseType_Focus2:
            adType=@"12";
            break;
        case MovieAdvertiseType_LiveText:
            adType=@"13";
            break;
        case MovieAdvertiseType_DetailBanner:
            adType=@"15";
            break;
        case MovieAdvertiseType_Search:
        case MovieAdvertiseType_KeyWords:
            adType=@"16";
            break;
        case MovieAdvertiseType_Alert:
            adType=@"17";
            break;
        case MovieAdvertiseType_Front:
        case MovieAdvertiseType_Front_Offline:
            adType=@"41";
            break;
        case MovieAdvertiseType_Behind:
            adType=@"42";
            break;
        case MovieAdvertiseType_Pause:
            adType=@"43";
            break;
        case MovieAdvertiseType_LiveFront:
            adType=@"44";
            break;
        default:
            break;
    }
    if (![NSString isBlankString:adType]) {
        if ([NSString isBlankString:adid]) {
            adid = EMPTY_PARAM_VALUE;
        }
        [arrayAdExtraInfo addObject:adType];
        [arrayAdExtraInfo addObject:adid];
    }
    
    [[self class] addActionData:module
                      subModule:9
                            act:act
                       adSystem:adSystem
                       codeRate:VIDEO_CODE_UNKNOWN
                        extInfo:arrayAdExtraInfo];
#endif
    return;
}

#pragma mark - adplay
// chenhao auid
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
               adSystem:(NSString *)adSystem
{
#if 0
    NSString *adType=nil;
    switch (advertiseType) {
        case MovieAdvertiseType_Front:
        case MovieAdvertiseType_Front_Offline:
        {
            if (AD_TYPE_IMAGE == adFormtType) {
                adType = @"41";
            }
            else if (   AD_TYPE_MP4 == adFormtType
                     || AD_TYPE_TS == adFormtType){
                adType = @"100";
            }
            else{
                adType = @"-";
            }
        }
            break;
        case MovieAdvertiseType_LiveFront:
        {
            if (AD_TYPE_IMAGE == adFormtType) {
                adType = @"44";
            }
            else if (   AD_TYPE_MP4 == adFormtType
                     || AD_TYPE_TS == adFormtType){
                adType = @"101";
            }
            else{
                adType = @"-";
            }
        }
            break;
        case MovieAdvertiseType_Behind:
        {
            if (AD_TYPE_IMAGE == adFormtType) {
                adType = @"42";
            }
            else if (   AD_TYPE_MP4 == adFormtType
                     || AD_TYPE_TS == adFormtType){
                adType = @"200";
            }
            else{
                adType = @"-";
            }
        }
            break;
        default:
        {
            adType = @"-";
        }
            break;
    }
    NSString *nettype  = [NetworkReachability currentNetType];
    NSString *alreadyLoginUid   = [SettingManager alreadyLoginUserID];
    NSString *strUid   = [NSString isBlankString:alreadyLoginUid] ? EMPTY_PARAM_VALUE : alreadyLoginUid;
    NSString *app_client    = CURRENT_PCODE;
    NSString *brand = LT_DEVICE_BRAND;
    NSString *appver_client = CURRENT_VERSION;
    
    NSString *m_adID=[NSString isBlankString:adID]?EMPTY_PARAM_VALUE:[NSString stringWithFormat:@"-_-_%@",adID];
    NSString *m_utime=[NSString isBlankString:utime]?EMPTY_PARAM_VALUE:utime;
    NSString *m_playTimeLen=[NSString isBlankString:playTimeLen]?EMPTY_PARAM_VALUE:playTimeLen;
    NSString *m_cid=[NSString isBlankString:cid]?EMPTY_PARAM_VALUE:cid;
    NSString *m_vid=[NSString isBlankString:vid]?EMPTY_PARAM_VALUE:vid;
    NSString *m_pid=[NSString isBlankString:pid]?EMPTY_PARAM_VALUE:pid;
    
    
    NSString *vinfo=[NSString stringWithFormat:@"%@_%@",m_pid,m_vid];
    NSString *m_videoLen=[NSString isBlankString:videoLen]?EMPTY_PARAM_VALUE:videoLen;
    NSTimeInterval ti=[[NSDate date]timeIntervalSince1970];
    NSString *ptid=[NSString stringWithFormat:@"%@_%0.f",[DeviceManager getDeviceUUID],ti];
    NSString *dcVersion = LT_DATA_CENTER_VERSION;
    
    NSString *strAUID = [DeviceManager getIOSDeviceUUID];
    if ([NSString isBlankString:strAUID]) {
        strAUID = EMPTY_PARAM_VALUE;
    }
    
    NSArray *paraArray = @[nettype,             // 1	nettype	上网类型
                           strUid,              // 2	uid	乐视网用户id
                           [NSString safeString:[SettingManager getVirtualLoginUUID]],  // 3	uuid
                           app_client,          // 4	app	产品线
                           brand,               // 5	brand	品牌
                           appver_client,       // 6	appver	客户端版本
                           adType,              // 7	adtype	广告位类型
                           m_adID,              // 8	adid	广告编号
                           action,              // 9	actionid	上报动作串
                           [NSString stringWithFormat:@"-_-_%@",clickTime],     // 10	clicknum	点击次数
                           m_utime,                                             // 11	utime	加载耗时
                           [NSString stringWithFormat:@"-_-_%@",adduration],    // 12	广告时长
                           [NSString stringWithFormat:@"-_-_%@",m_playTimeLen], // 13	playedTime	广告播放时长
                           m_cid,               // 14	cid	频道标识
                           vinfo,               // 15	vinfo	视频信息
                           m_videoLen,          // 16  vlen   视频时长
                           ptid,                // 17	ptid	播放时间标识
                           dcVersion,
                           adSystem,
                           strAUID
                           ];
    NSString *paraString = [paraArray componentsJoinedByString:@"&"];
    
    //    NSLog(@"datacenter-adplay---%@", paraString);
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeAdPlay
                           andUrlContent:paraString];
#endif
    return;
}
#endif

#pragma mark - error

+(void)addErrorDataWithAid:(NSString *)album_id
                       vid:(NSString *)vid
                     title:(NSString *)title
                 videoType:(NSString *)videoType
               originalUrl:(NSString *)original_url
                     ddUrl:(NSString *)dd_url
                    action:(ERROR_ACTION)act
                error_type:(ERROR_TYPE)errorType
{
    if ([NetworkReachability connectedToNetwork]) {
        album_id = [NSString safeString:album_id];
        vid = [NSString safeString:vid];
        title = [NSString safeString:title];
        videoType = [NSString safeString:videoType];
        original_url = [NSString safeString:original_url];
        dd_url = [NSString safeString:dd_url];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:album_id forKey:@"album_id"];
        [params setObject:vid forKey:@"vid"];
        [params setObject:title forKey:@"title"];
        [params setObject:videoType forKey:@"video_type"];
        [params setObject:[NetworkReachability currentNetType] forKey:@"net_type"];
        [params setObject:@"" forKey:@"net_speed"];
        [params setObject:original_url forKey:@"original_url"];
        [params setObject:dd_url forKey:@"dd_url"];
        [params setObject:[NSString stringWithFormat:@"%d", act] forKey:@"action"];
        [params setObject:[NSString stringWithFormat:@"%d", errorType] forKey:@"error_type"];
        [params setObject:@"" forKey:@"error_log"];
        [params setObject:@"ios" forKey:@"device_os"];
        [params setObject:[[UIDevice currentDevice] systemVersion] forKey:@"device_osversion"];
        [params setObject:@"apple" forKey:@"device_brand"];
        [params setObject:[[[UIDevice currentDevice] model] encodedURLParameterString] forKey:@"device_model"];
        
        NSLog(@"异常：%@",params);
        
        [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_ErrorUpload
                                   andDynamicValues:nil
                                      andHttpMethod:@"POST"
                                      andParameters:params
                                  completionHandler:^(NSDictionary *responseDic) {
                                      NSLog(@"error data upload success. %@", responseDic);
                                  } errorHandler:^(NSError *error) {
                                      NSLog(@"error data upload failed.");
                                  }];
        NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_ErrorUpload
                                                     andDynamicValues:nil];
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:nil];
        NSString *postString= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *uploadFileContent=[NSString stringWithFormat:@"urlModule:%d url:%@ params:%@",LTURLModule_ErrorUpload,url ,postString];
        [[self class] writeToErrorLogFile:uploadFileContent];
    }
    
    return;
    
}


#pragma mark -
#pragma mark -
#pragma mark - 2.0 统计

#pragma mark - Login

+ (NSString *)addLoginData:(LTDCLoginStatus)loginStatus
{
    LT_DC_FIELD_DEFINE(login, p1)       // 一级产品线代码
    LT_DC_FIELD_DEFINE(login, p2)       // 二级产品线代码
    LT_DC_FIELD_DEFINE(login, p3)       // 三级产品线代码
    LT_DC_FIELD_DEFINE(login, uid)      // 乐视网用户注册 ID
    LT_DC_FIELD_DEFINE(login, lc)       // Letv cookie
    LT_DC_FIELD_DEFINE(login, auid)     // 设备 ID
    LT_DC_FIELD_DEFINE(login, uuid)     // 用户访问的唯一标识
    LT_DC_FIELD_DEFINE(login, lp)       // 登录属性
    LT_DC_FIELD_DEFINE(login, ch)       // 登录渠道
    LT_DC_FIELD_DEFINE(login, ref)      // 登录来源
    LT_DC_FIELD_DEFINE(login, ts)       // Timestamp 登录时间 用秒数来表示
    LT_DC_FIELD_DEFINE(login, pcode)    // pcode
    LT_DC_FIELD_DEFINE(login, st)       // Status 登录状态 0:登录成功 1:退出登录
    LT_DC_FIELD_DEFINE(login, zid)      // 专题id
    LT_DC_FIELD_DEFINE(login, r)        // 随机数
    LT_DC_FIELD_DEFINE(login, nt)       // 网络类型
    LT_DC_FIELD_DEFINE(login, location)     // 用户的地址
    
    LT_DC_FIELD_DEFINE(env, mac)    // 设备 Mac 地址，，，，与login日志设备id对应
    LT_DC_FIELD_DEFINE(env, os)     // 操作系统
    LT_DC_FIELD_DEFINE(env, osv)    // 操作系统版本
    LT_DC_FIELD_DEFINE(env, app)    // 应用版本号
    LT_DC_FIELD_DEFINE(env, bd)     // 终端品牌
    LT_DC_FIELD_DEFINE(env, xh)     // 终端型号
    LT_DC_FIELD_DEFINE(env, ro)     // Resolution:分辨率
    LT_DC_FIELD_DEFINE(env, br)     // Browser 浏览器名称
    LT_DC_FIELD_DEFINE(env, ep)     // 环境属性
    LT_DC_FIELD_DEFINE(env, ssid)      // wifi标示
    LT_DC_FIELD_DEFINE(env, lo)      // 经度
    LT_DC_FIELD_DEFINE(env, la)      //  纬度
    LT_DC_FIELD_DEFINE(env, ctime)    // 新增的上报时间点
    
    id appdelegate = [UIApplication sharedApplication].delegate;
    NSString *user_flag = @"";
    
    if ([[LeTVAppModule sharedModule] isImplemented])
    {
        LetvUserType type = (LetvUserType)[[LeTVAppModule sharedModule] letv_AppDelegate_getLetvUserType];
        if (LetvUserNew == type) {
            user_flag = @"n";
        }
        else if (LetvUserUpgrade == type){
            user_flag = @"u";
        }
    }
    else
    {
        if ([appdelegate respondsToSelector:@selector(letvUserType)]) {
            LetvUserType type = (LetvUserType)[appdelegate performSelector:@selector(letvUserType)];
            if (LetvUserNew == type) {
                user_flag = @"n";
            }
            else if (LetvUserUpgrade == type){
                user_flag = @"u";
            }
        }
    }
    
    NSString *onlen = @"";
    if (LTDCLoginStatusLogout == loginStatus) {
        double loginTime = [SettingManager getVirtualLoginTime];
        NSTimeInterval curTime = [[NSDate date] timeIntervalSince1970];
        double sessionTime = curTime - loginTime;
        onlen = [NSString stringWithFormat:@"%.2f", sessionTime];
    }
    
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    
    NSUUID *idfa = [ASIdentifierManager sharedManager].advertisingIdentifier;
    NSString *idfaStr = [idfa UUIDString];
    if (idfaStr == nil) {
        idfaStr = @"";
    }

    NSDictionary *dictLp = @{
                             @"usertype"    : [NSString safeString:user_flag],
                             @"onlen"       : [NSString safeString:onlen],
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"sysstatus"   : [DeviceManager getDeviceOpenPush]
                             };
    NSMutableArray *arrayLpVerified = [NSMutableArray array];
    [dictLp enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            [arrayLpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        LT_DATA_CENTER_EMPTY_REQUIRED]];
        }
        else{
            NSString *objValue = (NSString *)obj;
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayLpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }];
    
    [arrayLpVerified addObject:[NSString stringWithFormat:@"app=%@",CURRENT_VERSION]];
    NSString *timeString = [[self class] getTimeString];
    
    NSString *longitude = [SettingManager getLocaionLongitude];
    NSString *latitude = [SettingManager getLocationLatitude];

    NSString *ssid = [[DeviceManager getCurrentWiFiSSID] encodedURLParameterString];
    if ([NSString empty:ssid]) {
        ssid = @"";
    }

#ifndef LT_MERGE_FROM_IPAD_CLIENT
    
    NSString *msiteFrom = [NSString safeString:[LTDataInfo sharedInstance].msiteFrom];
    
    NSDictionary *dictData = @{
                               s_login_p1     : LT_DATA_CENTER_P1VALUE,
                               s_login_p2     : LT_DATA_CENTER_P2VALUE,
                               s_login_p3     : LT_DATA_CENTER_P3VALUE,
                               s_login_uid    : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_login_lc     : @"",
                               s_login_auid   : [DeviceManager getDeviceUUID],
                               s_login_uuid   : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_login_lp     : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_login_ch     : @"letv",
                               s_login_ref    : msiteFrom,
                               s_login_ts     : [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970])],
                               s_login_pcode  : CURRENT_PCODE,
                               s_login_st     : [NSString stringWithFormat:@"%d", loginStatus],
                               s_login_r      : [[self class] generateRandomValue],
                               s_login_nt     : [NetworkReachability currentNetType],
                               s_login_location  : [[SettingManager getUserArea] encodedURLParameterString],
                               
                               s_env_mac      : [DeviceManager getDeviceUUID],
                               s_env_os       : LT_DATA_CENTER_OPSYSTEM,
                               s_env_osv      : [[UIDevice currentDevice] systemVersion],
                               s_env_app      : LT_DATA_CENTER_APPVERSION,
                               s_env_bd       : LT_DATA_CENTER_BRAND,
                               s_env_xh       : LT_DATA_CENTER_TERMINALTYPE,
                               s_env_ro       : [DeviceManager getDeviceResolution],
                               s_env_br       : LT_DATA_CENTER_BROWSER,
                               s_env_ep       : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_env_ssid     : ssid,
                               s_env_ctime   : timeString,
                               s_env_lo       : longitude,
                               s_env_la       : latitude,
                               @"app_name"    : APP_NAME_ForData,
                               @"model"       : [[NSString safeString:platform] encodedURLParameterString],
                               @"idfa"        : [NSString safeString:idfaStr],
                               @"stime"       : timeString,
                               @"install_id"  : [NSString safeString:[DeviceManager getInstallid]],
                               };
    
    
    [LTDataInfo sharedInstance].msiteFrom = @"";
    
    NSArray *arrRequiredKeys = @[
                                 s_login_p1,
                                 s_login_p2,
                                 s_login_uid,
                                 s_login_lc,
                                 s_login_auid,
                                 s_login_r,
                                 s_login_nt,
                                 s_env_mac,
                                 s_env_ep,
                                 s_env_lo,
                                 s_env_la,
                                 s_env_ssid
                                 ];
#else /* LT_MERGE_FROM_IPAD_CLIENT */
    NSDictionary *dictData = @{s_login_ver    : LT_DATA_CENTER_KV_VERSION_3,
                               s_login_p1     : LT_DATA_CENTER_P1VALUE,
                               s_login_p2     : LT_DATA_CENTER_P2VALUE,
                               s_login_p3     : LT_DATA_CENTER_P3VALUE,
                               s_login_uid    : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_login_lc     : @"",
                               s_login_auid   : [DeviceManager getDeviceUUID],
                               s_login_uuid   : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_login_lp     : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_login_ch     : @"",
                               s_login_ref    : @"",
                               s_login_ts     : [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970])],
                               s_login_pcode  : CURRENT_PCODE,
                               s_login_st     : [NSString stringWithFormat:@"%d", loginStatus],
                               s_login_zid    : @"",
                               s_login_r      : [[self class] generateRandomValue],
                               
                               };
    
    NSArray *arrRequiredKeys = @[
                                 s_login_p1,
                                 s_login_p2,
                                 s_login_uid,
                                 s_login_lc,
                                 s_login_auid,
                                 s_login_r,
                                 ];
#endif /* LT_MERGE_FROM_IPAD_CLIENT */
    
    switch (loginStatus) {
        case LTDCLoginStatusLogin:
        case LTDCLoginStatusLogin2UserCenter:
        {
            [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVLogin
                                      andRawData:dictData
                                 andRequiredKeys:arrRequiredKeys];
            
            [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVEnv
                                      andRawData:dictData
                                 andRequiredKeys:arrRequiredKeys];
            return nil;
        }
            break;
        case LTDCLoginStatusLogout:
        {
//            return [[self class] cacheStatisticsWithType:LTDataCenterStatisticsTypeKVLogout
//                                              andRawData:dictData
//                                         andRequiredKeys:arrRequiredKeys];
            
            [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVLogin
                                      andRawData:dictData
                                 andRequiredKeys:arrRequiredKeys];
            
            [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVEnv
                                      andRawData:dictData
                                 andRequiredKeys:arrRequiredKeys];
        }
            
        default:
            break;
    }
    
    return nil;
    
}

#pragma mark Env
+ (void)addEnvData
{
    LT_DC_FIELD_DEFINE(login, p1)       // 一级产品线代码
    LT_DC_FIELD_DEFINE(login, p2)       // 二级产品线代码
    LT_DC_FIELD_DEFINE(login, p3)       // 三级产品线代码
    LT_DC_FIELD_DEFINE(login, uid)      // 乐视网用户注册 ID
    LT_DC_FIELD_DEFINE(login, lc)       // Letv cookie
    LT_DC_FIELD_DEFINE(login, auid)     // 设备 ID
    LT_DC_FIELD_DEFINE(login, uuid)     // 用户访问的唯一标识
    LT_DC_FIELD_DEFINE(login, lp)       // 登录属性
    LT_DC_FIELD_DEFINE(login, ch)       // 登录渠道
    LT_DC_FIELD_DEFINE(login, ref)      // 登录来源
    LT_DC_FIELD_DEFINE(login, ts)       // Timestamp 登录时间 用秒数来表示
    LT_DC_FIELD_DEFINE(login, pcode)    // pcode
    LT_DC_FIELD_DEFINE(login, st)       // Status 登录状态 0:登录成功 1:退出登录
    LT_DC_FIELD_DEFINE(login, zid)      // 专题id
    LT_DC_FIELD_DEFINE(login, r)        // 随机数
    LT_DC_FIELD_DEFINE(login, nt)       // 网络类型
    
    LT_DC_FIELD_DEFINE(env, mac)    // 设备 Mac 地址，，，，与login日志设备id对应
    LT_DC_FIELD_DEFINE(env, os)     // 操作系统
    LT_DC_FIELD_DEFINE(env, osv)    // 操作系统版本
    LT_DC_FIELD_DEFINE(env, app)    // 应用版本号
    LT_DC_FIELD_DEFINE(env, bd)     // 终端品牌
    LT_DC_FIELD_DEFINE(env, xh)     // 终端型号
    LT_DC_FIELD_DEFINE(env, ro)     // Resolution:分辨率
    LT_DC_FIELD_DEFINE(env, br)     // Browser 浏览器名称
    LT_DC_FIELD_DEFINE(env, ep)     // 环境属性
    LT_DC_FIELD_DEFINE(env, ssid)      // wifi标示
    LT_DC_FIELD_DEFINE(env, lo)      // 经度
    LT_DC_FIELD_DEFINE(env, la)      //  纬度
    
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    NSUUID *idfa = [ASIdentifierManager sharedManager].advertisingIdentifier;
    NSString *idfaStr = [idfa UUIDString];
    if (idfaStr == nil) {
        idfaStr = @"";
    }
    NSString *timeString = [[self class] getTimeString];
    
    NSDictionary *dictEp = @{
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    NSMutableArray *arrayLpVerified = [NSMutableArray array];
    [dictEp enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            [arrayLpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        LT_DATA_CENTER_EMPTY_REQUIRED]];
        }
        else{
            NSString *objValue = (NSString *)obj;
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayLpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }];

    NSString *longitude = [SettingManager getLocaionLongitude];
    NSString *latitude = [SettingManager getLocationLatitude];
    
    NSDictionary *dictData = @{
                               s_login_p1     : LT_DATA_CENTER_P1VALUE,
                               s_login_p2     : LT_DATA_CENTER_P2VALUE,
                               s_login_p3     : LT_DATA_CENTER_P3VALUE,
                               s_login_uid    : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_login_lc     : @"",
                               s_login_auid   : [DeviceManager getDeviceUUID],
                               s_login_uuid   : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_login_lp     : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_login_ch     : @"letv",
                               s_login_ref    : @"",
                               s_login_ts     : [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970])],
                               s_login_pcode  : CURRENT_PCODE,
                               s_login_r      : [[self class] generateRandomValue],
                               s_login_nt     : [NetworkReachability currentNetType],
                               
                               s_env_mac      : [DeviceManager getDeviceUUID],
                               s_env_os       : LT_DATA_CENTER_OPSYSTEM,
                               s_env_osv      : [[UIDevice currentDevice] systemVersion],
                               s_env_app      : LT_DATA_CENTER_APPVERSION,
                               s_env_bd       : LT_DATA_CENTER_BRAND,
                               s_env_xh       : LT_DATA_CENTER_TERMINALTYPE,
                               s_env_ro       : [DeviceManager getDeviceResolution],
                               s_env_br       : LT_DATA_CENTER_BROWSER,
                               s_env_ep       : [[arrayLpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_env_ssid     : [DeviceManager getCurrentWiFiSSID],
                               s_env_lo       : longitude,
                               s_env_la       : latitude,
                               @"app_name"    : APP_NAME_ForData,
                               @"model"       : [NSString safeString:platform],
                               @"idfa"        : [NSString safeString:idfaStr],
                               @"stime"       : timeString,
                               @"install_id"  : [NSString safeString:[DeviceManager getInstallid]],
                               };
    
    NSArray *arrRequiredKeys = @[
                                 s_login_p1,
                                 s_login_p2,
                                 s_login_uid,
                                 s_login_lc,
                                 s_login_auid,
                                 s_login_r,
                                 s_login_nt,
                                 s_env_mac,
                                 s_env_ep,
                                 s_env_lo,
                                 s_env_la,
                                 s_env_ssid
                                 ];
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVEnv
                              andRawData:dictData
                         andRequiredKeys:arrRequiredKeys];
}

#pragma mark - Error

+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              andVid:(NSString *)vid
       errorProperty:(NSDictionary *)ep
         andPlayUUid:(NSString *)playuuid
{
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        andVid:cid
                         andvt:@""
                 errorProperty:ep
                   andPlayUUid:playuuid];
}
+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              andVid:(NSString *)vid
               andvt:(NSString *)vt
       errorProperty:(NSDictionary *)ep
         andPlayUUid:(NSString *)playuuid
{
    if (![NetworkReachability connectedToNetwork]) {
        return;
    }
    
    LT_DC_FIELD_DEFINE(err, p1)     // 一级产品线代码
    LT_DC_FIELD_DEFINE(err, p2)     // 二级产品线代码
    LT_DC_FIELD_DEFINE(err, p3)     // 三级产品线代码
    LT_DC_FIELD_DEFINE(err, err)     // 错误代码
    LT_DC_FIELD_DEFINE(err, lc)     // Letv cookie
    LT_DC_FIELD_DEFINE(err, uuid)   // 登录时生成的 uuid
    LT_DC_FIELD_DEFINE(err, auid)   // auid
    LT_DC_FIELD_DEFINE(err, ip)     // IP地址
    LT_DC_FIELD_DEFINE(err, mac)    // 设备 Mac 地址，，，，与login日志设备id对应
    LT_DC_FIELD_DEFINE(err, nt)     // Net type:上网类型
    LT_DC_FIELD_DEFINE(err, os)     // 操作系统
    LT_DC_FIELD_DEFINE(err, osv)    // 操作系统版本
    LT_DC_FIELD_DEFINE(err, app)    // 应用版本号
    LT_DC_FIELD_DEFINE(err, bd)     // 终端品牌
    LT_DC_FIELD_DEFINE(err, xh)     // 终端型号
    LT_DC_FIELD_DEFINE(err, ro)     // Resolution:分辨率
    LT_DC_FIELD_DEFINE(err, br)     // Browser 浏览器名称
    LT_DC_FIELD_DEFINE(err, src)     // 用于区分不同日志上报的环境来源标识
    LT_DC_FIELD_DEFINE(err, ep)     // 环境属性
    LT_DC_FIELD_DEFINE(err, cid)
    LT_DC_FIELD_DEFINE(err, pid)
    LT_DC_FIELD_DEFINE(err, vid)
    LT_DC_FIELD_DEFINE(err, zid)     // 专题id
    LT_DC_FIELD_DEFINE(err, r)      // 随机数
    LT_DC_FIELD_DEFINE(err, vt)     // 播放的码流
    LT_DC_FIELD_DEFINE(err, et)     // 播放错误，其他错误不需要上报该字段
    
    
    NSString *playCode = [ep safeValueForKey:@"et"];
    NSUUID *idfa = [ASIdentifierManager sharedManager].advertisingIdentifier;
    NSString *idfaStr = [idfa UUIDString];
    if (idfaStr == nil) {
        idfaStr = @"";
    }
    NSString *timeString = [[self class] getTimeString];
    NSMutableArray *arrayEpVerified = [NSMutableArray array];
    [ep enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            [arrayEpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        LT_DATA_CENTER_EMPTY_REQUIRED]];
        }
        else{
            NSString *objValue = (NSString *)obj;
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayEpVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }];
    NSDictionary *dictData = @{
                               s_err_p1     : LT_DATA_CENTER_P1VALUE,
                               s_err_p2     : LT_DATA_CENTER_P2VALUE,
                               s_err_p3     : LT_DATA_CENTER_P3VALUE,
                               s_err_err    : [NSString safeString:errorCode],
                               s_err_lc     : @"",
                               s_err_uuid   : [NSString isBlankString:playuuid]?[NSString safeString:[SettingManager getVirtualLoginUUID]]:playuuid,
                               s_err_auid   : [DeviceManager getDeviceUUID],
                               s_err_ip     : @"",
                               s_err_mac    : [DeviceManager getDeviceUUID],
                               s_err_nt     : [NetworkReachability currentNetType],
                               s_err_os     : LT_DATA_CENTER_OPSYSTEM,
                               s_err_osv    : [[UIDevice currentDevice] systemVersion],
                               s_err_app    : LT_DATA_CENTER_APPVERSION,
                               s_err_bd     : LT_DATA_CENTER_BRAND,
                               s_err_xh     : LT_DATA_CENTER_TERMINALTYPE,
                               s_err_ro     : [DeviceManager getDeviceResolution],
                               s_err_br     : LT_DATA_CENTER_BROWSER,
                               s_err_src    : @"",
                               s_err_ep     :  [[arrayEpVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_err_cid    : [NSString safeString:cid],
                               s_err_pid    : [NSString safeString:pid],
                               s_err_vid    : [NSString safeString:vid],
                               s_err_r      : [[self class] generateRandomValue],
                               s_err_vt     : [NSString safeString:vt],
                               @"app_name"  : APP_NAME_ForData,
                               @"ch"        : @"letv",
                               @"idfa"      : [NSString safeString:idfaStr],
                               @"stime"     : timeString,
                               @"ctime"     : timeString,
                               @"pcode"     : CURRENT_PCODE,
                               @"uid"       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               @"install_id": [NSString safeString:[DeviceManager getInstallid]],
                               };
    NSMutableDictionary *dictEp = [[NSMutableDictionary alloc] initWithDictionary:dictData];
    if (![NSString safeString:playCode]) {
        [dictEp setValue:playCode forKey:s_err_et];
    }
    NSArray *arrRequiredKeys = @[s_err_p1,
                                 s_err_p2,
                                 s_err_err,
                                 s_err_lc,
                                 s_err_uuid,
                                 s_err_ip,
                                 s_err_mac,
                                 s_err_nt,
                                 s_err_ep,
                                 s_err_cid,
                                 s_err_pid,
                                 s_err_vid,
                                 s_err_r];
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVError
                              andRawData:dictData
                         andRequiredKeys:arrRequiredKeys];
}

+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid
{
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        adnVid:vid
                andDownloadUrl:@""
                andRequestUrl:@""
                    andPlayUrl:@""
                     andPlayVt:VIDEO_CODE_UNKNOWN
                 andLivingCode:@""];
}

+ (void)addErrorData:(NSString *)errorCode
              andCid:(NSString *)cid
              andPid:(NSString *)pid
              adnVid:(NSString *)vid
      andDownloadUrl:(NSString *)DownloadUrl
      andRequestUrl:(NSString *)RequestUrl
          andPlayUrl:(NSString *)PlayUrl
           andPlayVt:(VideoCodeType)videoCode
       andLivingCode:(NSString *)code

{
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        adnVid:vid
                andDownloadUrl:DownloadUrl
                    andPlayUrl:PlayUrl
                     andPlayVt:videoCode
                 andLivingCode:code
                 andRequestUrl:RequestUrl
                 andStatusCode:@""
                      andUtime:@""
                  andPlayUUid:nil];

}
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
{
    [self addErrorData:errorCode
                andCid:cid
                andPid:pid
                adnVid:vid
        andDownloadUrl:DownloadUrl
            andPlayUrl:PlayUrl
             andPlayVt:videoCode
         andLivingCode:code
         andRequestUrl:requestUrl
         andStatusCode:statusCode
              andUtime:utime
           andPlayUUid:playuuid
        andisPlayError:isPlayError
       andExtendFields:nil];
}

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
     andExtendFields:(NSDictionary *)extendDic
{
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    NSDictionary *dict = @{
                           @"model"       : [NSString safeString:platform],
                           @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                           @"time"        : [NSString formatStatisticCurrentTimeString],
                           @"url"         : [NSString safeString:requestUrl],
                           @"status"      : [NSString safeString:statusCode],
                           @"ut"          : [NSString safeString:utime]
                           };
    NSMutableDictionary *dictEp = [[NSMutableDictionary alloc] initWithDictionary:dict];
    
    if (extendDic && [extendDic isKindOfClass:[NSDictionary class]]) {
        [dictEp addEntriesFromDictionary:extendDic];
    }
    
    if (![NSString isBlankString:DownloadUrl])
    {
        [dictEp setObject:DownloadUrl forKey:@"downloadurl"];
    }
    if (isPlayError) {
        [dictEp setObject:errorCode forKey:@"et"];
    }
    if (![NSString isBlankString:PlayUrl])
    {
        [dictEp setObject:PlayUrl forKey:@"playurl"];
    }
    NSString *vt = @"";
    if (![NSString isBlankString:vt])
    {
        // vt
        switch (videoCode) {
            case VIDEO_CODE_ULD:
            {
                vt = @"58";
            }
                break;
            case VIDEO_CODE_HD:
            {
                vt = @"22";
            }
                break;
            case VIDEO_CODE_SD:
            {
                vt = @"13";
            }
                break;
            case VIDEO_CODE_LD:
            {
                vt = @"21";
            }
                break;
            case VIDEO_CODE_UNKNOWN:
            {
                if (![NSString isBlankString:code]) {
                    vt = [[self class] getLiveCode:code];
                }
            }
                break;
            default:
                break;
        }
    }
    
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        andVid:vid
                         andvt:vt
                 errorProperty:dictEp
                   andPlayUUid:playuuid];
}

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
{
    
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    NSDictionary *dict = @{
                           @"model"       : [NSString safeString:platform],
                           @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                           @"time"        : [NSString formatStatisticCurrentTimeString],
                           @"url"         : [NSString safeString:requestUrl],
                           @"status"      : [NSString safeString:statusCode],
                           @"ut"          : [NSString safeString:utime]
                           };
    NSMutableDictionary *dictEp = [[NSMutableDictionary alloc] initWithDictionary:dict];
    
    if (![NSString isBlankString:DownloadUrl])
    {
        [dictEp setObject:DownloadUrl forKey:@"downloadurl"];
    }
    
    if (![NSString isBlankString:PlayUrl])
    {
        [dictEp setObject:PlayUrl forKey:@"playurl"];
    }
    
    NSString *vt = @"";
    if (![NSString isBlankString:vt])
    {
        // vt
        switch (videoCode) {
            case VIDEO_CODE_ULD:
            {
                vt = @"58";
            }
                break;
            case VIDEO_CODE_HD:
            {
                vt = @"22";
            }
                break;
            case VIDEO_CODE_SD:
            {
                vt = @"13";
            }
                break;
            case VIDEO_CODE_LD:
            {
                vt = @"21";
            }
                break;
            case VIDEO_CODE_UNKNOWN:
            {
                if (![NSString isBlankString:code]) {
                    vt = [[self class] getLiveCode:code];
                }
            }
                break;
            default:
                break;
        }
    }
    
    [[self class] addErrorData:errorCode
                        andCid:cid
                        andPid:pid
                        andVid:vid
                         andvt:vt
                 errorProperty:dictEp
                   andPlayUUid:playuuid];
}

+ (void)addCrashDataWithCount:(NSInteger)crashCount
{
    if (crashCount <= 0) {
        return;
    }
    
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];
    NSDictionary *dictEp = @{
                             @"model"       : [NSString safeString:platform],
                             @"cnt"         : [NSString stringWithFormat:@"%ld", (long)crashCount],
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addErrorData:@"20001"
                        andCid:nil
                        andPid:nil
                        andVid:nil
                 errorProperty:dictEp
                   andPlayUUid:nil];
}

#pragma mark Action
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
                 rank:(NSString *)rank  //点击视频在推荐区域的排序

{
    [LTDataCenter addActionData:acode
                 actionProperty:ap
                   actionResult:ar
                            cid:cid
                            pid:pid
                            vid:vid
                            zid:zid
                     currentUrl:cur_url
                           reid:reid
                           area:area
                         bucket:bucket
                           rank:rank
                            lid:nil];
}

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
{
    if ([NSString isBlankString:[SettingManager getVirtualLoginUUID]]) {
        return;
    }
    
    NSMutableArray *arrayApVerified = [NSMutableArray array];
    
    NSArray *allApkeys = [ap allKeys];
    NSArray *sortKeyArray = [allApkeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for(NSString *key in sortKeyArray)
    {
        
        NSString *obj =[ap objectForKey:key];
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            //
        }
        else{
            NSString *objValue = [NSString safeString:obj];
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayApVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }
    
    [arrayApVerified addObject:[NSString stringWithFormat:@"app=%@",CURRENT_VERSION]];
    
    LT_DC_FIELD_DEFINE(action, p1)
    LT_DC_FIELD_DEFINE(action, p2)
    LT_DC_FIELD_DEFINE(action, p3)
    LT_DC_FIELD_DEFINE(action, acode)
    LT_DC_FIELD_DEFINE(action, ap)
    LT_DC_FIELD_DEFINE(action, ar)
    LT_DC_FIELD_DEFINE(action, cid)
    LT_DC_FIELD_DEFINE(action, pid)
    LT_DC_FIELD_DEFINE(action, vid)
    LT_DC_FIELD_DEFINE(action, uid)
    LT_DC_FIELD_DEFINE(action, uuid)
    LT_DC_FIELD_DEFINE(action, lc)
    LT_DC_FIELD_DEFINE(action, cur_url)
    LT_DC_FIELD_DEFINE(action, ch)
    LT_DC_FIELD_DEFINE(action, pcode)
    LT_DC_FIELD_DEFINE(action, auid)
    LT_DC_FIELD_DEFINE(action, zid)
    LT_DC_FIELD_DEFINE(action, reid)
    LT_DC_FIELD_DEFINE(action, area)
    LT_DC_FIELD_DEFINE(action, bucket)
    LT_DC_FIELD_DEFINE(action, rank)
    LT_DC_FIELD_DEFINE(action, r)
    LT_DC_FIELD_DEFINE(action, lid)
    LT_DC_FIELD_DEFINE(action, nt)     // Net type:上网类型
    LT_DC_FIELD_DEFINE(action, ctime)
    
    
    NSUUID *idfa = [ASIdentifierManager sharedManager].advertisingIdentifier;
    NSString *idfaStr = [idfa UUIDString];
    if (idfaStr == nil) {
        idfaStr = @"";
    }
    
#ifndef LT_MERGE_FROM_IPAD_CLIENT
    NSString *timeString = [[self class] getTimeString];
    NSDictionary *dictData = @{
                               s_action_p1        : LT_DATA_CENTER_P1VALUE,
                               s_action_p2        : LT_DATA_CENTER_P2VALUE,
                               s_action_p3        : LT_DATA_CENTER_P3VALUE,
                               s_action_acode     : [NSString stringWithFormat:@"%ld", (long)acode],
                               s_action_ap        : [[arrayApVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_action_ar        : [NSString stringWithFormat:@"%d", !ar],
                               s_action_cid       : [NSString safeString:cid],
                               s_action_pid       : [NSString safeString:pid],
                               s_action_vid       : [NSString safeString:vid],
                               s_action_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_action_uuid      : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_action_lc        : @"-",
                               s_action_cur_url   : [[NSString safeString:cur_url] encodedURLParameterString],
                               s_action_ch        : @"letv",
                               s_action_pcode     : CURRENT_PCODE,
                               s_action_auid      : [DeviceManager getDeviceUUID],
                               s_action_zid       : [NSString safeStringForStatistic:zid],
                               s_action_reid      : [NSString safeString:reid],
                               s_action_area      : [NSString safeString:area],
                               s_action_bucket    : [NSString safeString:bucket],
                               s_action_rank      : [NSString safeString:rank],
                               s_action_r         : [[self class] generateRandomValue],
                               s_action_lid       : [NSString safeString:lid],
                               s_action_nt        : [NetworkReachability currentNetType],
                               s_action_ctime     : timeString,
                               @"app_name"        : APP_NAME_ForData,
                               @"stime"           : timeString,
                               @"idfa"            : [NSString safeString:idfaStr],
                               @"app"             : LT_DATA_CENTER_APPVERSION,
                               @"install_id"      : [NSString safeString:[DeviceManager getInstallid]],
                               };
    
    NSArray *arrRequiredKeys = @[
                                 s_action_p1,
                                 s_action_p2,
                                 s_action_p3,
                                 s_action_cid,
                                 s_action_pid,
                                 s_action_vid,
                                 s_action_uid,
                                 s_action_uuid,
                                 s_action_lc,
                                 s_action_cur_url,
                                 s_action_auid,
                                 s_action_r,
                                 s_action_lid,
                                 s_action_nt];
#else /* LT_MERGE_FROM_IPAD_CLIENT */
    NSDictionary *dictData = @{
                               s_action_ver       : LT_DATA_CENTER_KV_VERSION_3,
                               s_action_p1        : LT_DATA_CENTER_P1VALUE,
                               s_action_p2        : LT_DATA_CENTER_P2VALUE,
                               s_action_p3        : LT_DATA_CENTER_P3VALUE,
                               s_action_acode     : [NSString stringWithFormat:@"%ld", (long)acode],
                               s_action_ap        : [[arrayApVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_action_ar        : [NSString stringWithFormat:@"%d", !ar],
                               s_action_cid       : [NSString safeString:cid],
                               s_action_pid       : [NSString safeString:pid],
                               s_action_vid       : [NSString safeString:vid],
                               s_action_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_action_uuid      : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_action_lc        : @"-",
                               s_action_cur_url   : [[NSString safeString:cur_url] encodedURLParameterString],
                               s_action_ch        : @"",
                               s_action_pcode     : CURRENT_PCODE,
                               s_action_auid      : [DeviceManager getDeviceUUID],
                               s_action_ilu       : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_action_zid       : [NSString safeStringForStatistic:zid],
                               s_action_reid      : [NSString safeString:reid],
                               s_action_area      : [NSString safeString:area],
                               s_action_bucket    : [NSString safeString:bucket],
                               s_action_rank      : [NSString safeString:rank],
                               s_action_r         : [[self class] generateRandomValue],
                               s_action_lid       : [NSString safeString:lid],
                               };
    
    
    NSArray *arrRequiredKeys = @[s_action_ver,
                                 s_action_p1,
                                 s_action_p2,
                                 s_action_p3,
                                 s_action_cid,
                                 s_action_pid,
                                 s_action_vid,
                                 s_action_uid,
                                 s_action_uuid,
                                 s_action_lc,
                                 s_action_cur_url,
                                 s_action_auid,
                                 s_action_ilu,
                                 s_action_r,
                                 s_action_lid];
#endif /* LT_MERGE_FROM_IPAD_CLIENT */
    [[self class] sendActionStatisticsWithRawData:dictData
                                  andRequiredKeys:arrRequiredKeys
                                    andActionCode:acode];
    
    if (acode==LTDCActionCodePlayFailed) {
        NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                      andRequiredKeys:arrRequiredKeys];
        
        [[self class] writeToErrorLogFile:strContent];
    }
    
    
    return;

 
}




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
             playUUid:(NSString *)playuuid
{
    if ([NSString isBlankString:playuuid]) {
        return;
    }
    
    NSMutableArray *arrayApVerified = [NSMutableArray array];
    
    NSArray *allApkeys = [ap allKeys];
    NSArray *sortKeyArray = [allApkeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for(NSString *key in sortKeyArray)
    {
        
        NSString *obj =[ap objectForKey:key];
        if (    [NSObject empty:obj]
            ||  [NSString isBlankString:obj]) {
            //
        }
        else{
            NSString *objValue = [NSString safeString:obj];
            if (    ([objValue rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
                ||  ([objValue rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
                objValue = [objValue encodedURLParameterString];
            }
            [arrayApVerified addObject:[NSString stringWithFormat:@"%@%@%@",
                                        key,
                                        LT_DATA_CENTER_KV_CONNECTOR,
                                        objValue]];
        }
    }
    
    [arrayApVerified addObject:[NSString stringWithFormat:@"app=%@",CURRENT_VERSION]];
    
    LT_DC_FIELD_DEFINE(action, p1)
    LT_DC_FIELD_DEFINE(action, p2)
    LT_DC_FIELD_DEFINE(action, p3)
    LT_DC_FIELD_DEFINE(action, acode)
    LT_DC_FIELD_DEFINE(action, ap)
    LT_DC_FIELD_DEFINE(action, ar)
    LT_DC_FIELD_DEFINE(action, cid)
    LT_DC_FIELD_DEFINE(action, pid)
    LT_DC_FIELD_DEFINE(action, vid)
    LT_DC_FIELD_DEFINE(action, uid)
    LT_DC_FIELD_DEFINE(action, uuid)
    LT_DC_FIELD_DEFINE(action, lc)
    LT_DC_FIELD_DEFINE(action, cur_url)
    LT_DC_FIELD_DEFINE(action, ch)
    LT_DC_FIELD_DEFINE(action, pcode)
    LT_DC_FIELD_DEFINE(action, auid)
    LT_DC_FIELD_DEFINE(action, zid)
    LT_DC_FIELD_DEFINE(action, reid)
    LT_DC_FIELD_DEFINE(action, area)
    LT_DC_FIELD_DEFINE(action, bucket)
    LT_DC_FIELD_DEFINE(action, rank)
    LT_DC_FIELD_DEFINE(action, r)
    LT_DC_FIELD_DEFINE(action, lid)
    LT_DC_FIELD_DEFINE(action, nt)     // Net type:上网类型
    LT_DC_FIELD_DEFINE(action, ctime)
    
    NSUUID *idfa = [ASIdentifierManager sharedManager].advertisingIdentifier;
    NSString *idfaStr = [idfa UUIDString];
    if (idfaStr == nil) {
        idfaStr = @"";
    }
    
#ifndef LT_MERGE_FROM_IPAD_CLIENT
    NSString *timeString = [[self class] getTimeString];
    NSDictionary *dictData = @{
                               s_action_p1        : LT_DATA_CENTER_P1VALUE,
                               s_action_p2        : LT_DATA_CENTER_P2VALUE,
                               s_action_p3        : LT_DATA_CENTER_P3VALUE,
                               s_action_acode     : [NSString stringWithFormat:@"%ld", (long)acode],
                               s_action_ap        : [[arrayApVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_action_ar        : [NSString stringWithFormat:@"%d", !ar],
                               s_action_cid       : [NSString safeString:cid],
                               s_action_pid       : [NSString safeString:pid],
                               s_action_vid       : [NSString safeString:vid],
                               s_action_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_action_uuid      : [NSString safeString:playuuid],
                               s_action_lc        : @"-",
                               s_action_cur_url   : [[NSString safeString:cur_url] encodedURLParameterString],
                               s_action_ch        : @"letv",
                               s_action_pcode     : CURRENT_PCODE,
                               s_action_auid      : [DeviceManager getDeviceUUID],
                               s_action_zid       : [NSString safeStringForStatistic:zid],
                               s_action_reid      : [NSString safeString:reid],
                               s_action_area      : [NSString safeString:area],
                               s_action_bucket    : [NSString safeString:bucket],
                               s_action_rank      : [NSString safeString:rank],
                               s_action_r         : [[self class] generateRandomValue],
                               s_action_lid       : [NSString safeString:lid],
                               s_action_nt        : [NetworkReachability currentNetType],
                               s_action_ctime     : timeString,
                               @"app_name"        : APP_NAME_ForData,
                               @"stime"           : timeString,
                               @"idfa"            : [NSString safeString:idfaStr],
                               @"app"             : LT_DATA_CENTER_APPVERSION,
                               @"install_id"      : [NSString safeString:[DeviceManager getInstallid]],
                               };
    
    NSArray *arrRequiredKeys = @[
                                 s_action_p1,
                                 s_action_p2,
                                 s_action_p3,
                                 s_action_cid,
                                 s_action_pid,
                                 s_action_vid,
                                 s_action_uid,
                                 s_action_uuid,
                                 s_action_lc,
                                 s_action_cur_url,
                                 s_action_auid,
                                 s_action_r,
                                 s_action_lid,
                                 s_action_nt];
#else /* LT_MERGE_FROM_IPAD_CLIENT */
    NSDictionary *dictData = @{
                               s_action_ver       : LT_DATA_CENTER_KV_VERSION_3,
                               s_action_p1        : LT_DATA_CENTER_P1VALUE,
                               s_action_p2        : LT_DATA_CENTER_P2VALUE,
                               s_action_p3        : LT_DATA_CENTER_P3VALUE,
                               s_action_acode     : [NSString stringWithFormat:@"%ld", (long)acode],
                               s_action_ap        : [[arrayApVerified componentsJoinedByString:LT_DATA_CENTER_PROPERTY_SEPARATOR] encodedURLParameterString],
                               s_action_ar        : [NSString stringWithFormat:@"%d", !ar],
                               s_action_cid       : [NSString safeString:cid],
                               s_action_pid       : [NSString safeString:pid],
                               s_action_vid       : [NSString safeString:vid],
                               s_action_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_action_uuid      : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_action_lc        : @"-",
                               s_action_cur_url   : [[NSString safeString:cur_url] encodedURLParameterString],
                               s_action_ch        : @"",
                               s_action_pcode     : CURRENT_PCODE,
                               s_action_auid      : [DeviceManager getDeviceUUID],
                               s_action_ilu       : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_action_zid       : [NSString safeStringForStatistic:zid],
                               s_action_reid      : [NSString safeString:reid],
                               s_action_area      : [NSString safeString:area],
                               s_action_bucket    : [NSString safeString:bucket],
                               s_action_rank      : [NSString safeString:rank],
                               s_action_r         : [[self class] generateRandomValue],
                               s_action_lid       : [NSString safeString:lid],
                               };
    
    
    NSArray *arrRequiredKeys = @[s_action_ver,
                                 s_action_p1,
                                 s_action_p2,
                                 s_action_p3,
                                 s_action_cid,
                                 s_action_pid,
                                 s_action_vid,
                                 s_action_uid,
                                 s_action_uuid,
                                 s_action_lc,
                                 s_action_cur_url,
                                 s_action_auid,
                                 s_action_ilu,
                                 s_action_r,
                                 s_action_lid];
#endif /* LT_MERGE_FROM_IPAD_CLIENT */
    [[self class] sendActionStatisticsWithRawData:dictData
                                  andRequiredKeys:arrRequiredKeys
                                    andActionCode:acode];
    
    if (acode==LTDCActionCodePlayFailed) {
        NSString *strContent = [[self class] formatContentWithRawData:dictData
                                                      andRequiredKeys:arrRequiredKeys];
        
        [[self class] writeToErrorLogFile:strContent];
    }
    
    
    return;
    
    
}




+(void)addAction:(LTDCActionPropertyCategory)apc
        position:(NSInteger)wz
            name:(NSString *)name
           name1:(NSString *)name1
             cid:(NewMovieCid)cid
      currentUrl:(NSString *)cur_url
       isSuccess:(BOOL)ar
{
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeStringForStatistic:fl],
                             @"wz"      : [NSString stringWithFormat:@"%ld", (long)wz],
                             @"name"    : [NSString safeString:name],
                             @"name1"   : [NSString safeString:name1],
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    
    
}

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
        isSuccess:(BOOL)ar
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:acode
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}


+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar
{
    [LTDataCenter addAction:apc
                   position:wz
                       name:name
                        cid:cid
                        pid:nil
                        vid:nil
                 currentUrl:cur_url
                  isSuccess:ar];
}

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar
{
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                            @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:nil
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar
{
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    
    
}

//iphone v6.7 搜索运营词上报 sname
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
        isSuccess:(BOOL)ar
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"sname"    : [NSString safeString:sname],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+ (void)addAction:(LTDCActionPropertyCategory)apc
         position:(NSInteger)wz
             name:(NSString *)name
              cid:(NewMovieCid)cid
              pid:(NSString *)pid
              vid:(NSString *)vid
              zid:(NSString *)zid
           pageID:(LTDCPageID)pageID
       currentUrl:(NSString *)cur_url
        isSuccess:(BOOL)ar
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}


+ (void)addActionOnly:(LTDCActionCode)acode
             position:(NSInteger)wzPosition
                 name:(NSString *)name
                   fl:(NSString *)fl
               pageid:(NSString *)pageid
        statisticInfo:(LTStatisticInfo *)statisticInfo {
    
    NSString *lid = [NSString safeString:statisticInfo.lid];
    if ([NSString empty:lid]) {
        lid = @"-";
    }
    
    NSString * wzPositionStr = (wzPosition < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wzPosition];
    NSString *uuid = [NSString safeString:[DeviceManager getIOSDeviceUUID]];
    
    NSMutableDictionary *dictAp = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString safeString:fl]         ,@"fl",
                                   wzPositionStr                    ,@"wz",
                                   [NSString safeString:name]       ,@"name",
                                   [NSString safeString:pageid]     ,@"pageid",
                                   uuid                             ,@"iosid",
                                  [NSString safeString:statisticInfo.hbid]                 ,@"hbid",
                                  [NSString safeStringForStatistic:statisticInfo.scidID]    ,@"scid",
                                   
                                   nil];
    NSString *key = @"vids";
    NSString *ids = @"";
    if (![NSString empty:statisticInfo.vids]) {
        ids = [NSString safeString:statisticInfo.vids];
    }
    else if (![NSString empty:statisticInfo.pids]) {
        key = @"pids";
        ids = [NSString safeString:statisticInfo.pids];
    }
    
    if (![NSString empty:ids]) {
        [dictAp setObject:ids forKey:key];
    }
    if (![NSString empty:statisticInfo.avg_speed]) {
        [dictAp setObject:statisticInfo.avg_speed forKey:@"avg_speed"];
    }
    
    if (![NSString empty:statisticInfo.rpid]) {
        [dictAp setObject:statisticInfo.rpid forKey:@"rpid"];
    }
    if (![NSString empty:statisticInfo.vip]) {
        [dictAp setObject:statisticInfo.vip forKey:@"vip"];
    }
    if (![NSString empty:statisticInfo.ispay]) {
        [dictAp setObject:statisticInfo.vip forKey:@"ispay"];
    }
    if (![NSString empty:statisticInfo.time]) {
        [dictAp setObject:statisticInfo.time forKey:@"time"];
    }
    if (![NSString empty:statisticInfo.ref]) {
        [dictAp setObject:statisticInfo.ref forKey:@"ref"];
    }
    if (![NSString empty:statisticInfo.vidlist]) {
        [dictAp setObject:statisticInfo.vidlist forKey:@"vidlist"];
    }
    if (![NSString empty:statisticInfo.ty]) {
        [dictAp setObject:statisticInfo.ty forKey:@"ty"];
    }
    if (![NSString empty:statisticInfo.sc]) {
        [dictAp setObject:statisticInfo.sc forKey:@"sc"];
    }
    if (![NSString empty:statisticInfo.fragId]) {
        [dictAp setObject:statisticInfo.fragId forKey:@"fragid"];
    }
    if (![NSString empty:statisticInfo.quittype]) {
        [dictAp setObject:statisticInfo.quittype forKey:@"quittype"];
    }
    
    [[self class] addActionData:acode
                 actionProperty:dictAp
                   actionResult:YES
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:@""
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:statisticInfo.reid
                           area:statisticInfo.area
                         bucket:statisticInfo.bucket
                           rank:statisticInfo.rank
                            lid:lid];
}

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
        isSuccess:(BOOL)ar
{
    NSString *pageid = [NSString fomatPageIDEnumCode:pageID];
    
    
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%d", wz]),
                             @"name"    : [NSString safeString:name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"scid"    : [NSString safeStringForStatistic:scidID],
                             @"streamID": [NSString safeString:lid],
                             @"fragid"  : [NSString safeString:fragId]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:nil];
}
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
        isSuccess:(BOOL)ar
{
    NSString *pageid = [NSString fomatPageIDEnumCode:pageID];
    
    
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"scid"    : [NSString safeStringForStatistic:scidID]
                         
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:ar
                            cid:[NSString safeString:strCid]
                            pid:[NSString safeString:pid]
                            vid:[NSString safeString:vid]
                            zid:[NSString safeString:zid]
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

#ifndef LT_MERGE_FROM_IPAD_CLIENT

+ (void)addStatisticChannelWallFilter:(LTStatisticInfo *)statisticInfo{
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
//                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"time"    : [NSString safeString:statisticInfo.time],
                             @"scid"    : [NSString safeStringForStatistic:statisticInfo.scidID],
                             @"fragid"  : [NSString safeStringForStatistic:statisticInfo.fragId],
                             @"type" : [NSString safeString:statisticInfo.type],
                             @"ft" : [NSString safeString:statisticInfo.ft],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];

}

+ (void)addStatisticForAction:(LTStatisticInfo *)statisticInfo
{
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"time"    : [NSString safeString:statisticInfo.time],
                             @"scid"    : [NSString safeStringForStatistic:statisticInfo.scidID],
                             @"fragid"  : [NSString safeStringForStatistic:statisticInfo.fragId],
                             @"type"    : [NSString safeString:statisticInfo.type],
                             @"name1"   : [NSString safeString:statisticInfo.name1],
                             @"lc"      : ((statisticInfo.lc < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.lc]),
                             @"lcName"  : [NSString safeString:statisticInfo.lcName],
                             @"sorts"   : [NSString safeString:statisticInfo.sorts],
                             @"ty"      : [NSString safeString:statisticInfo.ty],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    
    NSString *lid = [NSString safeString:statisticInfo.lid];
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:lid];

}

#else /* LT_MERGE_FROM_IPAD_CLIENT */
+ (void)addStatisticForAction:(LTStatisticInfo *)statisticInfo
{
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%d", statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"type"    : [NSString safeString:statisticInfo.type],
                             @"time"    : [NSString safeString:statisticInfo.time],
                             @"messagetype" : [NSString safeString:statisticInfo.messagetype],
                             @"fragid" : [NSString safeString:statisticInfo.fragId],
                             @"name1" : [NSString safeString:statisticInfo.name1],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    [[self class] addActionData:LTDCActionCodeClick
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:[NSString safeString:statisticInfo.reid]
                           area:[NSString safeString:statisticInfo.area]
                         bucket:[NSString safeString:statisticInfo.bucket]
                           rank:[NSString safeString:statisticInfo.rank]
                            lid:[NSString safeString:statisticInfo.lid]];

}
#endif /* LT_MERGE_FROM_IPAD_CLIENT */

#ifndef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addStatistic:(LTStatisticInfo *)statisticInfo
{
    // @"time"    : [NSString safeString:statisticInfo.time],
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"type"    : [NSString safeString:statisticInfo.type],
                             @"messagetype" : [NSString safeString:statisticInfo.messagetype],
                             @"fragid" : [NSString safeString:statisticInfo.fragId],
                             @"scid"    : [NSString safeStringForStatistic:statisticInfo.scidID],
                             @"st"      : [NSString safeString:statisticInfo.st],
                             @"time": [NSString safeString:statisticInfo.time],
                             @"sk"  : [NSString safeString:statisticInfo.sk],
                             @"nt"  : [NSString safeString:statisticInfo.nt],
                             @"ps"  : [NSString safeString:statisticInfo.ps],
                             @"of"  : [NSString safeString:statisticInfo.of],
                             @"cl"  : [NSString safeString:statisticInfo.cl],
                             @"sh"  : [NSString safeString:statisticInfo.sh],
                             @"ref" : [NSString safeString:statisticInfo.ref],
                             @"kd"  : [NSString safeString:statisticInfo.kd],
                             @"ar"  : [NSString safeString:statisticInfo.ar],
                             @"nid" : [NSString safeString:statisticInfo.nid],
                             @"vids": [NSString safeString:statisticInfo.vids],
                             @"pids": [NSString safeString:statisticInfo.pids],
                             @"sorts"   : [NSString safeString:statisticInfo.sorts],
                             @"sc"  :[NSString safeString:statisticInfo.sc],
                             @"ty"  : [NSString safeString:statisticInfo.ty],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    [[self class] addActionData:statisticInfo.acode
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:[NSString safeString:statisticInfo.reid]
                           area:[NSString safeString:statisticInfo.area]
                         bucket:[NSString safeString:statisticInfo.bucket]
                           rank:[NSString safeString:statisticInfo.rank]
                            lid:[NSString safeString:statisticInfo.lid]];
    ;
    
}

#else /* LT_MERGE_FROM_IPAD_CLIENT */
+ (void)addStatistic:(LTStatisticInfo *)statisticInfo
{
    // @"time"    : [NSString safeString:statisticInfo.time],
    NSString *pageid =[NSString fomatPageIDEnumCode:statisticInfo.pageID];
    
    if (LTDCActionPropertyFloatBall==statisticInfo.apc && LTDCPageIDUnKnown == statisticInfo.pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:statisticInfo.apc];
    if(statisticInfo.apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((statisticInfo.wz < 0) ? @"" : [NSString stringWithFormat:@"%d", statisticInfo.wz]),
                             @"name"    : [NSString safeString:statisticInfo.name],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"type"    : [NSString safeString:statisticInfo.type],
                             @"messagetype" : [NSString safeString:statisticInfo.messagetype],
                             @"ar"  : [NSString safeString:statisticInfo.ar],
                             @"fragid" : [NSString safeString:statisticInfo.fragId],
                             @"scid"    : [NSString safeStringForStatistic:statisticInfo.scidID],
                             @"flag"    : [NSString safeString:statisticInfo.flag]
                             };
    [[self class] addActionData:statisticInfo.acode
                 actionProperty:dictAp
                   actionResult:statisticInfo.isSuccess
                            cid:[NSString safeString:statisticInfo.cid]
                            pid:[NSString safeString:statisticInfo.pid]
                            vid:[NSString safeString:statisticInfo.vid]
                            zid:[NSString safeString:statisticInfo.zid]
                     currentUrl:[NSString safeString:statisticInfo.cur_url]
                           reid:[NSString safeString:statisticInfo.reid]
                           area:[NSString safeString:statisticInfo.area]
                         bucket:[NSString safeString:statisticInfo.bucket]
                           rank:[NSString safeString:statisticInfo.rank]
                            lid:[NSString safeString:statisticInfo.lid]];

}
#endif /* LT_MERGE_FROM_IPAD_CLIENT */

+ (void)addPushAction:(NSString *)msgid
{
    [[self class] addPushAction:msgid
                    andPushType:@""
                 andmessageType:@""
                         andPid:nil
                         andVid:nil
                         andZid:nil
                  andCurrentUrl:nil
              andOtherParameter:nil];
}

+ (void)addPushAction:(NSString *)msgid
          andPushType:(NSString *)pushType
       andmessageType:(NSString *)messagetype
               andPid:(NSString *)pid
               andVid:(NSString *)vid
               andZid:(NSString *)zid
        andCurrentUrl:(NSString *)currentUrl
    andOtherParameter:(NSDictionary *)otherParameter
{
     [[self class] addPushAction:msgid
                    andPushType:pushType
                 andmessageType:messagetype
                         andPid:pid
                         andVid:vid
                         andZid:zid
                         andLid:nil
                  andCurrentUrl:currentUrl
              andOtherParameter:otherParameter];
}

+ (void)addPushAction:(NSString *)msgid
          andPushType:(NSString *)pushType
       andmessageType:(NSString *)messagetype
               andPid:(NSString *)pid
               andVid:(NSString *)vid
               andZid:(NSString *)zid
               andLid:(NSString *)lid
        andCurrentUrl:(NSString *)currentUrl
    andOtherParameter:(NSDictionary *)otherParameter
{
    NSString *pageid =[NSString fomatPageIDEnumCode:LTDCPageIDPush]; // wyw add
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:LTDCActionPropertyPush];
    NSString *platform = [DeviceManager getSysInfoByName:"hw.machine"];

    NSDictionary* dic = @{
                          @"fl"      : [NSString safeString:fl],
                          @"msgid"      : [NSString safeString:msgid],
                          @"tk"      : [NSString safeString:[SettingManager deviceToken]],
                          @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                          @"pageid"  :  pageid,
                          @"ua"      :  platform
                          };
    NSMutableDictionary *dictAp = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    if (![NSString isBlankString:pushType]) {
        [dictAp setObject:pushType forKey:@"pushtype"];
    } else {
        [dictAp setObject:@"-" forKey:@"pushtype"];
    }
    
    if (![NSString isBlankString:messagetype]) {
        [dictAp setObject:messagetype forKey:@"messagetype"];
    }
    
    if (otherParameter != nil) {
        [dictAp addEntriesFromDictionary:otherParameter];
    }
    
    [[self class] addActionData:LTDCActionCodePush
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:pid
                            vid:vid
                            zid:zid
                     currentUrl:currentUrl
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:lid];

}

+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
{
    
}

+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype
  andIsFromBackground:(BOOL)isFromBackground
{
    [self addLaunchTime:utime
         andBootImgTime:BootImgTime
          andlautchType:ltype
    andIsFromBackground:isFromBackground
                 andRef:@""];
}

+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype
  andIsFromBackground:(BOOL)isFromBackground
               andRef:(NSString *)ref
{
    CGFloat time;
    NSString *utimeStr;
    NSDictionary *dictAp;
    
    if (utime != 0) {
        
        NSString *logInfo = [NSString stringWithFormat:@"####LaunchTime#### launchTime:%.02f, launchType:%ld", utime, ltype];
        
        LTLog(logInfo);
    }
    
    if (LaunchType_BackGround == ltype || (ltype == LaunchType_First &&isFromBackground) || (ltype  == LaunchType_Other && isFromBackground)) {
        time = 0;
        utimeStr = [NSString stringWithFormat:@"%.2f",time];
        dictAp = @{
                   @"ut"      : utimeStr,
                   @"time"    : [NSString formatStatisticCurrentTimeString],
                   @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                   @"starttype" : [NSString stringWithFormat:@"%d", ltype],
                   @"pageid"  : @"-"
                   };
    } else {
        time = utime +BootImgTime;
        utimeStr =[NSString stringWithFormat:@"%.2f",time];
        NSString *type1 = [NSString stringWithFormat:@"%.2f",utime];
        NSString *type2 = [NSString stringWithFormat:@"%.2f",BootImgTime];
        dictAp = @{
                   @"ut"      : utimeStr,
                   @"type1"   : [NSString safeString:type1],
                   @"type2"   : [NSString safeString:type2],
                   @"time"    : [NSString formatStatisticCurrentTimeString],
                   @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                   @"starttype" : [NSString stringWithFormat:@"%d", ltype],
                   @"pageid"  : @"001",
                   @"ref"     : [NSString safeString:ref]
                   };
    }
    
    [LTDataCenter addActionData:LTDCActionCodeLaunch
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    NSLog(@"启动时长：%@",dictAp);
}


#ifdef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addLaunchTime:(CGFloat)utime
       andBootImgTime:(CGFloat)BootImgTime
        andlautchType:(LaunchType)ltype
{
    CGFloat time;
    NSString *utimeStr;
    NSDictionary *dictAp;
    
    if (LaunchType_BackGround == ltype) {
        time = 0;
        utimeStr = [NSString stringWithFormat:@"%.2f",time];
        dictAp = @{
                   @"ut"      : utimeStr,
                   @"time"    : [NSString formatStatisticCurrentTimeString],
                   @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                   @"starttype" : [NSString stringWithFormat:@"%d", ltype],
                   @"pageid"  : @"-"
                   };
    } else {
        time = utime +BootImgTime;
        utimeStr =[NSString stringWithFormat:@"%.2f",time];
        NSString *type1 = [NSString stringWithFormat:@"%.2f",utime];
        NSString *type2 = [NSString stringWithFormat:@"%.2f",BootImgTime];
        dictAp = @{
                                 @"ut"      : utimeStr,
                                 @"type1"   : [NSString safeString:type1],
                                 @"type2"   : [NSString safeString:type2],
                                 @"time"    : [NSString formatStatisticCurrentTimeString],
                                 @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                                 @"starttype" : [NSString stringWithFormat:@"%d", ltype],
                                 @"pageid"  : @"001"
                                 };
    }
    
    [LTDataCenter addActionData:LTDCActionCodeLaunch
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil
                            lid:nil];

    NSLog(@"启动时长：%@",dictAp);
}
#endif /* LT_MERGE_FROM_IPAD_CLIENT */

//#ifndef LT_MERGE_FROM_IPAD_CLIENT
+ (void)addLaunchTime:(CGFloat)utime
         andBootImgTime:(CGFloat)BootImgTime
         andBootImgTheoryTime:(CGFloat)bootImgTheoryTime
{
    [[self class] addLaunchTime:utime andBootImgTime:BootImgTime  andlautchType:LaunchType_Normal andIsFromBackground:NO];
}
//#else
//#endif
+ (void)addAcode:(LTDCActionCode)acode
              utime:(CGFloat)utime
          pageID:(LTDCPageID)pageID
{
     NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    NSString *utimeStr =[NSString stringWithFormat:@"%.2f",utime];
    if (utime<0) {
        utimeStr =@"";
    }
    NSDictionary *dictAp = @{
                             @"ut"      : utimeStr,
                             @"time"    : [NSString formatStatisticCurrentTimeString],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [LTDataCenter addActionData:acode
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    
    NSLog(@"acode中的ap日志:%@",dictAp);

}


//曝光统计
+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid
                   wz:(NSInteger)wz
{
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"-" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"          : [NSString safeString:fl],
                             @"wz"          : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                              @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeShow
                 actionProperty:dictAp
                   actionResult:YES
                            cid:strCid
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid
                   wz:(NSInteger)wz
            andPageID:(LTDCPageID)pageID
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    if (LTDCActionPropertyFloatBall==apc && LTDCPageIDUnKnown == pageID) {
        pageid = @"-";
    }
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:apc];
    if(apc ==LTDCActionPropertyCategoryUndefine){
        fl =@"";
    }
    NSString *strCid = (NewCID_UnDefine == cid) ? @"-" : [NSString stringWithFormat:@"%d", cid];
    NSDictionary *dictAp = @{
                             @"fl"          : [NSString safeString:fl],
                             @"wz"          : ((wz < 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"pageid"      :pageid,
                              @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeShow
                 actionProperty:dictAp
                   actionResult:YES
                            cid:strCid
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+ (void)addShowAction:(LTDCActionPropertyCategory)apc
                  cid:(NewMovieCid)cid
{
    [[self class] addShowAction:apc
                            cid:cid
                             wz:-1];
}


//下载统计
+(void)addDownloadStatictisWithVid:(NSString *)vid
                          withName:(NSString *)name
{
    NSDictionary *dictAp = @{
                             @"name"        : [NSString safeString:name],
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeDownload
                 actionProperty:dictAp
                   actionResult:YES
                            cid:@""
                            pid:nil
                            vid:vid
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

+(BOOL)writeToErrorLogFile:(NSString *)errDescription logContent:(NSString *)logContent fileName:(char *)fileName line:(NSInteger)line {
    NSString *content = [NSString stringWithFormat:@"CurrentVersion:%@, FileName:%s, line:%ld, errDescription:%@, logContent:%@", CURRENT_VERSION, fileName, (long)line, errDescription, logContent];
    
    return [LTDataCenter writeToErrorLogFile:content];
}

//写入错误日志文件
+(BOOL)writeToErrorLogFile:(NSString *)logContent
{
    if ([SettingManager isShowPlayerDebugLogView]) {
        [LeTVSharedAppModule letv_LTPlayControlLogView_addLogToView:logContent];
    }
    
//#if defined(LT_MERGE_FROM_IPAD_CLIENT) || defined(LTMovieplayerFramework)
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [FileManager appLetvProtectedPath];
    NSString * errorlogPath = [cachePath stringByAppendingPathComponent:ErrorLogText];
    
    //    NSDictionary* dict = @{
    //                           @"LogFile"      : [NSString safeString:logContent],   // 当前日志文件内容
    //                           @"TimeStamp"    : [NSDate date],    // 异常发生的时刻
    //                           };
    NSString *logString =[NSString stringWithFormat:@"%@##%@ \r\n\n",[NSString getCurrentSystemDateAccurateMS],[NSString safeString:logContent]];
    
    if ([fileManager fileExistsAtPath:errorlogPath]){
        //获取文件大小
        NSDictionary *dic=  [fileManager attributesOfItemAtPath:errorlogPath error:nil];
        NSNumber *fileNum = [dic objectForKey:NSFileSize];

        if ([fileNum floatValue]>1024*1024) {
            //        //文件最大1M，超过则删除超出1M部分的数据
            //        NSFileHandle *inFile = [NSFileHandle fileHandleForUpdatingAtPath:errorlogPath];
            //        if(inFile){
            //            [inFile seekToFileOffset:[fileNum floatValue]-1024*1024];
            //            NSData *readData=[inFile readDataToEndOfFile];
            //            [inFile closeFile];
            //
            //            NSString *result = [[NSString alloc] initWithData:readData  encoding:NSUTF8StringEncoding];
            //           [result writeToFile:errorlogPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            //
            //        }
            //客户端统一逻辑，为了运行性能，减少大文件的读写次数，超过1M，则删除文件
            [fileManager removeItemAtPath:errorlogPath error:nil];
            
        }
        
    }
    
    if (![fileManager fileExistsAtPath:errorlogPath]) {
        BOOL bResult = [logString writeToFile:errorlogPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        return bResult;
    }
    
    
    NSFileHandle  *outFile;
    NSData *buffer;
    
    outFile = [NSFileHandle fileHandleForWritingAtPath:errorlogPath];
    
    if(outFile == nil)
    {
        NSLog(@"Open of file for writing failed");
        return NO;
    }
    
    //找到并定位到outFile的末尾位置(在此后追加文件)
    [outFile seekToEndOfFile];
    
    
    //读取logString并且将其内容写到outFile中
    NSString *bs = [NSString stringWithFormat:@"%@",logString];
    buffer = [bs dataUsingEncoding:NSUTF8StringEncoding];
    
    [outFile writeData:buffer];
    
    //关闭读写文件
    [outFile closeFile];
//#endif
    return YES;
}

+ (void)infoLog:(NSString *)format{
    [LTDataCenter writeToErrorLogFile:format];
}

+ (void)errorLog:(NSString *)format{
    [LTDataCenter writeToErrorLogFile:format];
}

//上报的数据头增加机型信息：格式：手机品牌_手机型号_操作系统版本号 例如：iPhone_5S_7.0.1
+ (NSString *)getDataHeadModelInfo
{
    NSString * str = [NSString stringWithFormat:@"%@_%@",[DeviceManager getDeviceSpecificModel],[UIDevice currentDevice].systemVersion];
    return str;
}
+ (void)uploadErrorLogFileWithPhoneNum:(NSString *)phoneNum
                   withFeedBackContent:(NSString *)feedBackContent
                     completionHandler:(LTDataCompletionBlock)completionBlock
                          errorHandler:(LTDataErrorBlock)errorBlock
{
    NSString *did_client = [DeviceManager getDeviceUUID];
    //重新生成带时间戳的uuid
    NSString *uuid = [NSString stringWithFormat:@"%@_%@",
                      did_client,
                      [NSString stringWithFormat:@"%ld", time(NULL)]];
    NSString *rule =@"x6e2eAe2sB4ts1289wa2s";
    NSString *keyString =[NSString stringWithFormat:@"%@%@",uuid,rule];
    NSString *key =[NSString md5:keyString];
    NSString *urlPath;
    NSString *newFeedback = [NSString stringWithFormat:@"%@ %@",feedBackContent,[LTDataCenter getDataHeadModelInfo]];
//    NSString *unicodeString = [newFeedback stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
       if ([NSString isBlankString:phoneNum]) {
                urlPath =[NSString stringWithFormat:@"android/mod/mob/ctl/uploader/act/uploadedfile/uuid/%@/key/%@/pcode/%@/version/%@.mindex.html",uuid,key,CURRENT_PCODE,CURRENT_VERSION];
            }
        else{
              urlPath =[NSString stringWithFormat:@"android/mod/mob/ctl/uploader/act/uploadedfile/uuid/%@/mobile/%@/key/%@/pcode/%@/version/%@.mindex.html",uuid,phoneNum,key,CURRENT_PCODE,CURRENT_VERSION];
            }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [FileManager appLetvProtectedPath];
    NSString * errorlogPath = [cachePath stringByAppendingPathComponent:ErrorLogText];
    NSString * cdePath = [cachePath stringByAppendingPathComponent:CDELogText];
    if (![fileManager fileExistsAtPath:errorlogPath]){
        return;
    }
    dispatch_block_t reloadCDELogBlock = ^{
        if ([fileManager fileExistsAtPath:cdePath]) {
            AFAppDotNetAPIClient *cdeAFAppDotNetAPIClient =[[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://upload.app.m.letv.com/"]];
            
            [cdeAFAppDotNetAPIClient uploadFileWithUrlPath:urlPath withFilePath:cdePath withFeedBackContent:newFeedback success:^(NSURLSessionDataTask *operation, id responseObject) {
                if ([NSJSONSerialization isValidJSONObject:responseObject]) {
                    NSDictionary *result = responseObject[@"header"];
                    NSString *status = result[@"status"];
                    if (![status isEqualToString:@"1"])
                    {
                        NSString *errlog =[NSString stringWithFormat:@"url:%@ errorDict:%@",operation.currentRequest.URL,[responseObject description]];
                        [LTDataCenter writeToErrorLogFile:errlog];
                        
                    }
                    
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
        }
    };
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient =[[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://upload.app.m.letv.com/"]];
    
    [afAppDotNetAPIClient uploadFileWithUrlPath:urlPath withFilePath:errorlogPath withFeedBackContent:newFeedback success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (![NSJSONSerialization isValidJSONObject:responseObject]) {
            if (errorBlock) {
                errorBlock(nil);
            }
        }
        else{
            if (completionBlock) {
                NSDictionary *result = responseObject[@"header"];
                NSString *status = result[@"status"];
                if (![status isEqualToString:@"1"])
                {
                    NSString *errlog =[NSString stringWithFormat:@"url:%@ errorDict:%@",operation.currentRequest.URL,[responseObject description]];
                    [LTDataCenter writeToErrorLogFile:errlog];

                }
                completionBlock(responseObject);
            }
        }
        reloadCDELogBlock();
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (errorBlock) {
            errorBlock(nil);
        }
        reloadCDELogBlock();
    }];
}

+ (void)uploadErrorLogFileFromFeedbackWithPhoneNum:(NSString *)phoneNum
                               withFeedBackContent:(NSString *)feedBackContent
                                   withImagesArray:(NSArray *)imagesArray
                                 completionHandler:(LTDataCompletionBlock)completionBlock
                                      errorHandler:(LTDataErrorBlock)errorBlock {
    NSString *did_client = [DeviceManager getDeviceUUID];
    //重新生成带时间戳的uuid
    NSString *uuid = [NSString stringWithFormat:@"%@_%@",
                      did_client,
                      [NSString stringWithFormat:@"%ld", time(NULL)]];
    NSString *rule =@"x6e2eAe2sB4ts1289wa2s";
    NSString *keyString =[NSString stringWithFormat:@"%@%@",uuid,rule];
    NSString *key =[NSString md5:keyString];
    NSString *urlPath;
    NSString *newFeedback = [NSString stringWithFormat:@"%@ %@",feedBackContent,[LTDataCenter getDataHeadModelInfo]];
    //    NSString *unicodeString = [newFeedback stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
    if ([NSString isBlankString:phoneNum]) {
        urlPath =[NSString stringWithFormat:@"android/mod/mob/ctl/uploaderpic/act/uploadedfile/uuid/%@/key/%@/pcode/%@/version/%@.mindex.html",uuid,key,CURRENT_PCODE,CURRENT_VERSION];
    } else {
        urlPath =[NSString stringWithFormat:@"android/mod/mob/ctl/uploaderpic/act/uploadedfile/uuid/%@/mobile/%@/key/%@/pcode/%@/version/%@.mindex.html",uuid,phoneNum,key,CURRENT_PCODE,CURRENT_VERSION];
    }
    
    NSString *country = @"";
    NSString *location = @"";
    NSDictionary *locationDict = [SettingManager getLocationGeocoder];
    NSString *area = @"";
    if (locationDict != nil && [locationDict isKindOfClass:[NSDictionary class]]) {
        country = [locationDict safeValueForKey:@"country"];
        location = [locationDict safeValueForKey:@"location"];
    }
    
    NSDictionary *postParameters =  [NSDictionary dictionaryWithObjectsAndKeys:
                                     country, @"country",
                                     location, @"location",nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [FileManager appLetvProtectedPath];
    NSString * errorlogPath = [cachePath stringByAppendingPathComponent:ErrorLogText];
    NSString * cdePath = [cachePath stringByAppendingPathComponent:CDELogText];
    dispatch_block_t reloadCDELogBlock = ^{
        if ([fileManager fileExistsAtPath:cdePath]) {
            AFAppDotNetAPIClient *cdeAFAppDotNetAPIClient = nil;
            
//#ifdef DEBUG
//            if ([SettingManager isTestApi]) {
//                cdeAFAppDotNetAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://test2.m.letv.com/"]];
//            }
//            else {
//#endif
                cdeAFAppDotNetAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://upload.app.m.letv.com/"]];
//#ifdef DEBUG
//            }
//#endif
//            
            [cdeAFAppDotNetAPIClient uploadFileWithUrlPath:urlPath
                                              withFilePath:cdePath
                                                parameters:postParameters
                                       withFeedBackContent:newFeedback
                                                   success:^(NSURLSessionDataTask *operation, id responseObject) {
                if ([NSJSONSerialization isValidJSONObject:responseObject]) {
                    NSDictionary *result = responseObject[@"header"];
                    NSString *status = result[@"status"];
                    if (![status isEqualToString:@"1"])
                    {
                        NSString *errlog =[NSString stringWithFormat:@"url:%@ errorDict:%@",operation.currentRequest.URL,[responseObject description]];
                        [LTDataCenter writeToErrorLogFile:errlog];
                    }
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                LTLog(@"error:%@", error);
            }];
        }
    };
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient = nil;
//#ifdef DEBUG
//    if ([SettingManager isTestApi]) {
//        afAppDotNetAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://test2.m.letv.com/"]];
//    }
//    else {
//#endif
        afAppDotNetAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://upload.app.m.letv.com/"]];
//#ifdef DEBUG
//    }
//#endif
    
    [afAppDotNetAPIClient uploadFileFromFeedbackWithUrlPath:urlPath
                                               withFilePath:errorlogPath
                                                 parameters:postParameters
                                        withFeedBackContent:newFeedback
                                            withImagesArray:imagesArray
                                                    success:^(NSURLSessionDataTask *operation, id responseObject) {
                                                        if (![NSJSONSerialization isValidJSONObject:responseObject]) {
                                                            if (errorBlock) {
                                                                errorBlock(nil);
                                                            }
                                                        } else {
                                                            if (completionBlock) {
                                                                NSDictionary *result = responseObject[@"header"];
                                                                NSString *status = result[@"status"];
                                                                if (![status isEqualToString:@"1"])
                                                                {
                                                                    NSString *errlog =[NSString stringWithFormat:@"url:%@ errorDict:%@",operation.currentRequest.URL,[responseObject description]];
                                                                    [LTDataCenter writeToErrorLogFile:errlog];
                                                                    
                                                                }
                                                                completionBlock(responseObject);
                                                            }
                                                        }
                                                        reloadCDELogBlock();
                                                    }
                                                    failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                                        if (errorBlock) {
                                                            errorBlock(nil);
                                                        }
                                                        reloadCDELogBlock();
                                                    }];
}

+ (void)uploadScreenShotText:(NSString *)text image:(UIImage *)image xid:(int)vid pid:(int)pid cid:(int)cid htime:(NSString *)shotTime completionHandler:(LTDataCompletionBlock)completionBlock errorHandler:(LTDataErrorBlock)errorBlock{
    
    NSString *urlPath;
    NSString *urlHead;
    if ([SettingManager isTestApi]) {
        urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD_TEST;
        
#ifdef DEBUG
        if ([SettingManager isHK]) {
            urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD_HK_TEST;
        }
#endif
    }else{
        urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD;
    }
    urlPath =[NSString stringWithFormat:@"uploadhead/uploadimg?xid=%d&cid=%d&pid=%d&htime=%@&pcode=%@&version=%@",vid,cid,pid,shotTime,CURRENT_PCODE,CURRENT_VERSION];
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient =[[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:urlHead]];
    
    NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
    if(![NSString isBlankString:tk])
    {
        [afAppDotNetAPIClient setHttpHeader:@"TK" value:tk];
    }

    NSString * sso_tk = @"";
    if ([SettingManager isUserLogin])
    {
        sso_tk = [SettingManager userCenterTVToken];
        if ([NSString empty:sso_tk])
        {
            sso_tk = @"";
        }
    }
    [afAppDotNetAPIClient setHttpHeader:@"SSOTK" value:sso_tk];

    [afAppDotNetAPIClient uploadFileWithUrlPath:urlPath withContent:text withImage:image success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (![NSJSONSerialization isValidJSONObject:responseObject]) {
            if (errorBlock) {
                errorBlock(nil);
            }
        }else {
                if (completionBlock) {
                    completionBlock(responseObject);
                }

        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (errorBlock) {
            errorBlock(nil);
        }
    }];

}
// 播放错误上报
+ (void)addPlayFailedData:(LTDCPlayFailedCode)playFailedCode
                      cid:(NewMovieCid)cid
                      pid:(NSString *)pid
                      vid:(NSString *)vid
               currentUrl:(NSString *)cur_url
{
    NSString *strFailedCode = @"";
    switch (playFailedCode) {
        case LTDCPlayFailedCodeAlbumDetail:
            strFailedCode = @"1001";
            break;
        case LTDCPlayFailedCodeVideoDetail:
            strFailedCode = @"1002";
            break;
        case LTDCPlayFailedCodeVideoList:
            strFailedCode = @"1003";
            break;
        case LTDCPlayFailedCodeVideoFile:
            strFailedCode = @"1004";
            break;
        case LTDCPlayFailedCodeTimestamp:
            strFailedCode = @"1005";
            break;
        case LTDCPlayFailedCodeCloud:
            strFailedCode = @"1006";
            break;
        case LTDCPlayFailedCodeLoading:
            strFailedCode = @"1007";
            break;
        case LTDCPlayFailedCodeNetwork:
            strFailedCode = @"1008";
            break;
        case LTDCPlayFailedCodeUnknown:
            strFailedCode = @"1009";
            break;
        case LTDCPlayFailedCodeLiveIpForbid:
            strFailedCode = @"2001";
            break;
        case LTDCPlayFailedCodeLiveUrl:
            strFailedCode = @"2002";
            break;
        case LTDCPlayFailedCodeLiveTimestamp:
            strFailedCode = @"2003";
            break;
        case LTDCPlayFailedCodeLiveNetwork:
            strFailedCode = @"2004";
            break;
        case LTDCPlayFailedCodeLiveUnknown:
            strFailedCode = @"2005";
            break;
        default:
            break;
    }
    if ([NSString isBlankString:strFailedCode]) {
        return;
    }
    
    NSDictionary *dictAp = @{
                             @"ec"          : strFailedCode,
                             @"iosid"       : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    NSString *strCid = (NewCID_UnDefine == cid) ? @"" : [NSString stringWithFormat:@"%d", cid];
    [[self class] addActionData:LTDCActionCodePlayFailed
                 actionProperty:dictAp
                   actionResult:YES
                            cid:[NSString safeString:strCid]
                            pid:pid
                            vid:vid
                            zid:nil
                     currentUrl:cur_url
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
    
    
    
}

+ (void)addLivePlayFailedData:(LTDCPlayFailedCode)playFailedCode
                   currentUrl:(NSString *)cur_url
{
    [[self class] addPlayFailedData:playFailedCode
                                cid:NewCID_UnDefine
                                pid:nil
                                vid:nil
                         currentUrl:cur_url];
}

// 下载速度上报
+ (void)addDownloadSpeedData:(CGFloat)downloadSpeed
    andDownloadInterruptType:(LTDCDownloadInterruptType)interruptType
{
    NSDictionary *dictAp = @{
                             @"speed"   : [NSString stringWithFormat:@"%.2f", downloadSpeed],
                             @"type"    : [NSString stringWithFormat:@"%ld", (long)interruptType],
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [[self class] addActionData:LTDCActionCodeDownload
                 actionProperty:dictAp
                   actionResult:YES
                            cid:nil
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:nil
                           area:nil
                         bucket:nil
                           rank:nil];
}

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
            isPlayingLocalCache:(BOOL)isPlayingLocalCache
{
    [[self class] addBufferTimeWithAdtime:adTime
                              andPlayType:playType
                      andGetVideoListTime:videoListTime
                      andGetVideoFileTime:videoFileTime
                        andGetCanPlayTime:getPayInfoTime
                       andGetAlbumPayInfo:getAlbumPayInfoTime
                          andGetAdPinTime:getAdPinTime
                        andGetPlayUrlTime:getPlayUrlTime
                     andGetAdDispatchTime:getAdDispatchTime
                       andGetAdTheoryTime:getAdTheoryTime
                     andGetAdPlayLoadTime:getAdPlayLoadTime
                       andGetPlayLoadTime:getplayLoadTime
                      andGetADPreLoadTime:getAdPreLoadTime
                  andGetPlayerPreLoadTime:getPlayerPreLoadTime
                         andAllBufferTime:allBufTime
                                   andCid:cid
                                   andPid:pid
                                   andVid:vid
                                   andZid:zid
                               andPlayUrl:playUrl
                                 andAdUrl:adUrl
                                   pageID:LTDCPageIDUnKnown playUUid:nil
                      isPlayingLocalCache:isPlayingLocalCache
                             isUnicomFree:NO];
}

// 缓冲时间上报
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
                   isUnicomFree:(BOOL)isUnicomFree
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    NSLog(@"统计缓冲时长 adTime：%.2f  videoListTime(type4):%.2f videoFileTime(type5):%.2f getPayInfoTime(type6):%.2f  getAlbumPayInfoTime(type7):%.2f getAdPinTime(type8):%.2f  getPlayUrlTime(type9):%.2f GetAdDispatchTime(type11):%.2f  getAdTheoryTime(type12):%.2f getAdPlayLoadTime(type14):%.2f  andGetPlayLoadTime(type13):%.2f andGetADPreLoadTime:%.2f andGetPlayerPreLoadTime:%.2f allBufferTime(type10):%.2f",adTime,videoListTime,videoFileTime,getPayInfoTime,getAlbumPayInfoTime,getAdPinTime,getPlayUrlTime,getAdDispatchTime,getAdTheoryTime,getAdPlayLoadTime,getplayLoadTime,getAdPreLoadTime,getPlayerPreLoadTime,allBufTime);
    NSDictionary *dictAp = @{
                             @"type1"      : [NetworkReachability currentNetType],
                             @"type2"      : [NSString stringWithFormat:@"%d", playType],
                             @"type3"      : [NSString stringWithFormat:@"%.4f", adTime],
//                             @"type4"      : [NSString stringWithFormat:@"%.4f", videoListTime],
//                             @"type5"      : [NSString stringWithFormat:@"%.4f", videoFileTime],
//                             @"type6"      : [NSString stringWithFormat:@"%.4f", getPayInfoTime],
                             @"type7"      : [NSString stringWithFormat:@"%.4f", getAlbumPayInfoTime],
                             @"type8"      : [NSString stringWithFormat:@"%.4f", getAdPinTime],
                             @"type9"      : [NSString stringWithFormat:@"%.4f", getPlayUrlTime],
                             @"type10"     : [NSString stringWithFormat:@"%.4f", allBufTime],
                             @"type11"     : [NSString stringWithFormat:@"%.4f", getAdDispatchTime],
                             @"type12"     : [NSString stringWithFormat:@"%.4f", getAdTheoryTime],
                             @"type13"     : [NSString stringWithFormat:@"%.4f", getplayLoadTime],
                             @"type14"     : [NSString stringWithFormat:@"%.4f", getAdPlayLoadTime],
                             @"type15"     : [NSString stringWithFormat:@"%.4f", getAdPreLoadTime],
//                             @"type16"     : [NSString stringWithFormat:@"%.4f", getPlayerPreLoadTime],
                             @"playurl"    : [NSString safeString:playUrl],
                             @"adurl"      : [NSString safeString:adUrl],
                             @"iosid"      : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                             @"pageid"     : pageid,
                             @"ty"         : isPlayingLocalCache ? @"3" : @"0", // 0点播，3缓存
                             @"isad"       : (adUrl.length > 0) ? @"1" : @"0", // 1有广告，2无广告
                             @"isuni"      : isUnicomFree ? @"1" : @"0"
                             };
    if (playType == PLAYING_TYPE_LIVE ||
        playType == PLAYING_TYPE_LIVE_CHANNEL) {
        dictAp = @{
                   @"type1"      : [NetworkReachability currentNetType],
                   @"type7"      : [NSString stringWithFormat:@"%.4f", getAlbumPayInfoTime],
                   @"type9"      : [NSString stringWithFormat:@"%.4f", getPlayUrlTime],
                   @"type10"     : [NSString stringWithFormat:@"%.4f", allBufTime],
                   @"type13"     : [NSString stringWithFormat:@"%.4f", getplayLoadTime],
                   @"type15"     : [NSString stringWithFormat:@"%.4f", getAdPreLoadTime],
                   //                             @"type16"     : [NSString stringWithFormat:@"%.4f", getPlayerPreLoadTime],
                   @"playurl"    : [NSString safeString:playUrl],
                   @"adurl"      : [NSString safeString:adUrl],
                   @"iosid"      : [NSString safeString:[DeviceManager getIOSDeviceUUID]],
                   @"pageid"     : pageid,
                   @"ty"         : (playType == PLAYING_TYPE_LIVE) ? @"1" : @"2", // 1直播，2轮播卫视
                   @"isad"       : (adUrl.length > 0) ? @"1" : @"0", // 1有广告，2无广告
                   @"isuni"      : isUnicomFree ? @"1" : @"0"
                   };
    }
    if (![NSString empty:vid]) {
        
        // 误差大于3，则认为是异常数据，不上报
        if (fabs(allBufTime - getAlbumPayInfoTime - getAdPinTime - getAdDispatchTime - getplayLoadTime - getPlayUrlTime) > 3) {
            
            NSString *bufferTime = [NSString stringWithFormat:@"播放流程---type10:%0.2f, type7:%0.2f, type8:%0.2f, type9：%0.2f, type11:%0.2f, type13:%0.2f, type15:%0.2f", allBufTime, getAlbumPayInfoTime, getAdPinTime, getPlayUrlTime, getAdDispatchTime, getplayLoadTime, getAdPreLoadTime];
            [LTDataCenter writeToErrorLogFile:bufferTime];
     
            return;
        }
    }
    
#ifdef DEBUG
    NSString *playLog = [NSString stringWithFormat:@"####PLAY#### type10:%.0f, type7:%.0f, type8:%.0f, type9:%.0f, type11:%.0f, type13:%.0f, type15:%.0f, type3:%.0f, type14:%.0f", allBufTime * 1000, getAlbumPayInfoTime * 1000, getAdPinTime * 1000, getPlayUrlTime * 1000, getAdDispatchTime * 1000, getplayLoadTime * 1000, getAdPreLoadTime * 1000, adTime * 1000, getAdPlayLoadTime * 1000];
    
    LTLog(@"%@", playLog);
    CGFloat typeSum = getAlbumPayInfoTime * 1000 + getAdPinTime * 1000 + getPlayUrlTime * 1000 + getAdDispatchTime * 1000 + getAdDispatchTime * 1000 + getplayLoadTime * 1000 + getAdPreLoadTime * 1000 +
    adTime * 1000 + getAdPlayLoadTime * 1000;
    LTLog(@"!!!typesum %.0f", typeSum);
#endif
    
    if ([NSString isBlankString:playUUID]) {
        [[self class] addActionData:LTDCActionCodeBufferTime
                     actionProperty:dictAp
                       actionResult:YES
                                cid:cid
                                pid:pid
                                vid:vid
                                zid:zid
                         currentUrl:nil
                               reid:nil
                               area:nil
                             bucket:nil
                               rank:nil];
    }else{
        [LTDataCenter addActionData:LTDCActionCodeBufferTime
                     actionProperty:dictAp
                       actionResult:YES
                                cid:cid
                                pid:pid
                                vid:vid
                                zid:zid
                         currentUrl:nil
                               reid:nil
                               area:nil
                             bucket:nil
                               rank:nil
                                lid:nil playUUid:playUUID];
    }
}


#pragma mark Play
+ (void)addPlayDataWithPlayAction:(LTDCPlayStage)playStage
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
                       andStation:(NSString *)st
                      andPlayUUID:(NSString *)playUUID
                      andCodeRate:(VideoCodeType)videoCode
                   andOfflineFlag:(BOOL)isPlayOffline
                            andCh:(NSString *)ch
                    andLivingCode:(NSString *)code
                            andLc:(NSString *)lc
                           andRef:(NSString *)ref
                           andZid:(NSString *)zid
                    andIsAutoPlay:(BOOL)isAutoPlay
                     andParamters:(NSDictionary *)paramters
{

    LT_DC_FIELD_DEFINE(play, p1)
    LT_DC_FIELD_DEFINE(play, p2)
    LT_DC_FIELD_DEFINE(play, p3)
    LT_DC_FIELD_DEFINE(play, ac)        // 动作名称
    LT_DC_FIELD_DEFINE(play, err)       // 错误代码
    LT_DC_FIELD_DEFINE(play, pt)        // 播放时长 以秒为单位
    LT_DC_FIELD_DEFINE(play, ut)        // 动作耗时 以毫秒为单位
    LT_DC_FIELD_DEFINE(play, uid)
    LT_DC_FIELD_DEFINE(play, lc)
    LT_DC_FIELD_DEFINE(play, auid)
    LT_DC_FIELD_DEFINE(play, uuid)      // 一次播放过程，播放器生成唯一的UUID, 如果一次播放过程出现了切换码率，那么uuid的后缀加1
    LT_DC_FIELD_DEFINE(play, cid)
    LT_DC_FIELD_DEFINE(play, pid)
    LT_DC_FIELD_DEFINE(play, vid)
    LT_DC_FIELD_DEFINE(play, vlen)      // 视频时长 以秒为单位
    LT_DC_FIELD_DEFINE(play, ch)        // 渠道号
    LT_DC_FIELD_DEFINE(play, ry)        // 重试次数
    LT_DC_FIELD_DEFINE(play, ty)        // Type: 播放类型
    LT_DC_FIELD_DEFINE(play, vt)        // 播放器的vtype
    LT_DC_FIELD_DEFINE(play, url)       // 视频播放地址
    LT_DC_FIELD_DEFINE(play, ref)       // 播放页来源地址
    LT_DC_FIELD_DEFINE(play, pv)        // Player version: 播放器版本
    LT_DC_FIELD_DEFINE(play, py)        // Property: 播放属性
    LT_DC_FIELD_DEFINE(play, st)        // 轮播台
    LT_DC_FIELD_DEFINE(play, pcode)     // pcode
    LT_DC_FIELD_DEFINE(play, weid)      // 上报时获取js生成的页面weid
    LT_DC_FIELD_DEFINE(play, ap)        // 是否自动播放
    LT_DC_FIELD_DEFINE(play, zid)
    LT_DC_FIELD_DEFINE(play, lid)     //直播id  用于标识单场直播的唯一id    [播放类型如果是直播时，此参数为必填参数，其余情况可以为选填]
    LT_DC_FIELD_DEFINE(play, r)         // 随机数
    LT_DC_FIELD_DEFINE(play, nt)       //网络类型
    LT_DC_FIELD_DEFINE(play, bt)       //LTDCPlayStageBlock时候上报的bt字段，卡顿类型
    LT_DC_FIELD_DEFINE(play, ctime)    // 新增的上报时间点
    LT_DC_FIELD_DEFINE(play, prl)    // 是否预加载
    LT_DC_FIELD_DEFINE(play, cdev)    // CDE版本号
    LT_DC_FIELD_DEFINE(play, caid)    // CDE APP ID
    LT_DC_FIELD_DEFINE(play, pay)    // 收费还是免费
    LT_DC_FIELD_DEFINE(play, joint)    // 是否拼接广告
    LT_DC_FIELD_DEFINE(play, ipt)      // 起播类型
    
    // py
    
    NSInteger countPyParam = [py count];
    NSString *KeyValueJoinedString = @"=";
    NSString *componentsJoinedString = @"&";
    NSMutableArray *arrayKeyValues = [NSMutableArray array];
    
    //LTDCPlayStageBlock时上报卡顿
    NSString *blockType = @"";
    NSString *blockTime = @"";
 
    for (int i = 0; i+1 < countPyParam; i+=2)
    {
        NSString *key = py[i];
        NSString *value = py[i+1];
        
        if ([NSString isBlankString:key]) {
            continue;
        }
        if ([NSString isBlankString:value]) {
            value =@"-";
        }
        
        if (    ([value rangeOfString:LT_DATA_CENTER_PROPERTY_SEPARATOR].length > 0)
            ||  ([value rangeOfString:LT_DATA_CENTER_KV_CONNECTOR].length > 0)) {
            value = [value encodedURLParameterString];
        }
        
        if( playStage == LTDCPlayStageBlock){
            if ([key isEqualToString:@"bt"]) {
                blockType = value;
                continue;
            }
            if ([key isEqualToString:@"ut"]) {
                blockTime = value;
                continue;
            }
        }
        
        [arrayKeyValues addObject:[NSString stringWithFormat:
                                   @"%@%@%@",
                                   key,
                                   KeyValueJoinedString,
                                   value]];
    }
    
    [arrayKeyValues addObject:[NSString stringWithFormat:@"app=%@",CURRENT_VERSION]];
  
    NSString *pushmsg = [paramters safeValueForKey:@"pushmsg"];
    if (![NSString empty:pushmsg]) {
        [arrayKeyValues addObject:[NSString stringWithFormat:@"pushmsg=%@", pushmsg]];
    }
    
    NSString *formatPyString = [arrayKeyValues componentsJoinedByString:componentsJoinedString];
    
    // ac
    NSString *strPlayStage = @"";
    switch (playStage) {
        case LTDCPlayStageLaunch:
            strPlayStage = @"launch";
            break;
        case LTDCPlayStageInit:
            strPlayStage = @"init";
            break;
        case LTDCPlayStageGslb:
            strPlayStage = @"gslb";
            break;
        case LTDCPlayStageCload:
            strPlayStage = @"cload";
            break;
        case LTDCPlayStagePlay:
            strPlayStage = @"play";
            break;
        case LTDCPlayStageTime:
            strPlayStage = @"time";
            break;
        case LTDCPlayStageBlock:
            strPlayStage = @"block";
            break;
        case LTDCPlayStageEBlock:
            strPlayStage = @"eblock";
            break;
        case LTDCPlayStageTg:
            strPlayStage = @"tg";
             break;
//        case LTDCPlayStagePa:
//            strPlayStage = @"pa";
//             break;
        case LTDCPlayStageDrag:
            strPlayStage = @"drag";
             break;
//        case LTDCPlayStageCp:
//            strPlayStage = @"cp";
//            break;
        case LTDCPlayStageEnd:
            strPlayStage = @"end";
            break;
        case LTDCPlayStageFinish:
            strPlayStage = @"finish";
            break;
        case LTDCPlayStageADStart:
            strPlayStage = @"ac_start";
            break;
        case LTDCPlayStageADEnd:
            strPlayStage = @"ac_end";
            break;
        case LTDCPlayStagePA:
            strPlayStage = @"pa";
            break;
        case LTDCPlayStageResume:
            strPlayStage = @"resume";
            break;
        default:
            break;
    }
    
    // time
    NSTimeInterval playTimeLen = 0;
    NSTimeInterval utime = 0;
    if (LTDCPlayStageTime == playStage) {
        playTimeLen = usedTime;
        if (playTimeLen <= 0) {
            // 播放时长为0，不上报
            return;
        }
        if (playTimeLen > 180){
            playTimeLen = 180;
        }
    }
    else{
        utime = usedTime;
    }
    
    // vt
    NSString *vt = [paramters safeValueForKey:@"vtype"];
    if ([NSString empty:vt]) {
        vt = [NSString safeString:code];
    }

    NSString *timeString = [[self class] getTimeString];
    NSString *pay = [paramters safeValueForKey:@"pay1"];
    NSString *joint = [paramters safeValueForKey:@"joint"];
    NSString *ipt = [paramters safeValueForKey:@"ipt"];
    
    NSUUID *idfa = [ASIdentifierManager sharedManager].advertisingIdentifier;
    NSString *idfaStr = [idfa UUIDString];
    if (idfaStr == nil) {
        idfaStr = @"";
    }
    
    NSDictionary *dictData = @{
                               s_play_p1        : LT_DATA_CENTER_P1VALUE,
                               s_play_p2        : LT_DATA_CENTER_P2VALUE,
                               s_play_p3        : LT_DATA_CENTER_P3VALUE,
                               s_play_ac        : strPlayStage,
                               s_play_err       : [NSString stringWithFormat:@"%ld",(long) error],
                               s_play_pt        : (LTDCPlayStageTime == playStage) ? [NSString stringWithFormat:@"%lld", (long long)playTimeLen] : @"",
                               s_play_ut        : (playStage == LTDCPlayStageBlock) ? blockTime    : [NSString stringWithFormat:@"%lld", (long long)(1000 * utime)],
                               s_play_uid       : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_play_lc        : @"-",
                               s_play_auid      : [DeviceManager getDeviceUUID],
                               s_play_uuid      : playUUID,
                               s_play_cid       : [NSString safeString:cid],
                               s_play_pid       : [[NSString safeString:pid] encodedURLParameterString],
                               s_play_vid       : [[NSString safeString:vid] encodedURLParameterString],
                               s_play_vlen      : [NSString stringWithFormat:@"%lld", (long long)vlen],
                               s_play_ry        : [NSString stringWithFormat:@"%ld", (long)retry],
                               s_play_ty        : (ptype != LTDCPlayTypeUnknown) ? [NSString stringWithFormat:@"%ld", (long)ptype] : @"",
                               s_play_vt        : [NSString safeString:vt],
                               s_play_url       : [[NSString safeString:playUrl] encodedURLParameterString],
                               s_play_ref       : [[NSString safeString:ref] encodedURLParameterString],
                               s_play_pv        : CURRENT_VERSION,
                               s_play_py        : [formatPyString encodedURLParameterString],
                               s_play_st        : [[NSString safeString:st] encodedURLParameterString],
                               s_play_pcode     : CURRENT_PCODE,
                               s_play_weid      : @"",
                               s_play_ap        : isAutoPlay?@"1":@"0",
                               s_play_zid       : [NSString safeStringForStatistic:zid],
                               s_play_lid       : [NSString safeString:lc],
                               s_play_r         : [[self class] generateRandomValue],
                               s_play_nt        : [NetworkReachability currentNetType],
                               s_play_ctime     : timeString,
                               s_play_ipt       : ipt,
                               s_play_ch        : @"letv",
                               @"app_name"      : APP_NAME_ForData,
                               @"stime"         : timeString,
                               @"idfa"          : [NSString safeString:idfaStr],
                               @"app"           : LT_DATA_CENTER_APPVERSION,
                               @"owner"         : @"1",
                               @"install_id"    : [NSString safeString:[DeviceManager getInstallid]],
                               };
    
    NSMutableDictionary * allDictData = [[NSMutableDictionary alloc]initWithDictionary:dictData];
    NSString *cdeCaid = [NSString stringWithFormat:@"%d", CDE_APP_ID];
    if (playStage == LTDCPlayStageInit) {
        [allDictData setValue:[LTCDEModel getVersion] forKey:s_play_cdev];
        [allDictData setValue:[NSString safeString:cdeCaid] forKey:s_play_caid];
    }
    if (playStage == LTDCPlayStagePlay) {
        [allDictData setValue:pay forKey:s_play_pay];
        [allDictData setValue:joint forKey:s_play_joint];
        [allDictData setValue:@"0" forKey:s_play_prl];
    }
    if (playStage == LTDCPlayStageBlock) {
        [allDictData setValue:blockType forKey:s_play_bt];
    }
    
    NSArray *arrRequiredKeys = @[
                                 s_play_p1,
                                 s_play_p2,
                                 s_play_ac,
                                 s_play_err,
                                 s_play_pt,
                                 s_play_ut,
                                 s_play_uid,
                                 s_play_lc,
                                 s_play_auid,
                                 s_play_uuid,
                                 s_play_cid,
                                 s_play_pid,
                                 s_play_vid,
                                 s_play_vlen,
                                 s_play_ry,
                                 s_play_ty,
                                 s_play_vt,
                                 s_play_url,
                                 s_play_ref,
                                 s_play_pv,
                                 s_play_ap,
                                 s_play_zid,
                                 s_play_lid,
                                 s_play_r,
                                 s_play_nt,
                                 s_play_ctime,
                                 s_play_ipt
                                 ];
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVPlay
                              andRawData:allDictData
                         andRequiredKeys:arrRequiredKeys];
}

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
      andNewParameter:(NSDictionary *)newParameter
{
    [[self class] addPlayDataWithPlayAction:playStage
                                   andError:error
                                andUsedtime:usedTime
                                     andCid:cid
                                     andPid:pid
                                     andVid:vid
                                andVideoLen:0
                              andRetryCount:retry
                                andPlayType:ptype
                                 andPlayUrl:playUrl
                                andProperty:py
                                 andStation:st
                                andPlayUUID:playUUID
                                andCodeRate:VIDEO_CODE_UNKNOWN
                             andOfflineFlag:NO
                                      andCh:ch
                              andLivingCode:code
                                      andLc:lc
                                     andRef:ref
                                     andZid:@""
                              andIsAutoPlay:NO
                               andParamters:newParameter];
}

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
      andNewParameter:(NSDictionary *)newParameter
{
    
    //    NSDictionary *dictPy = @{
    //                             @"offline"     : isPlayOffline ? @"1" : @"",
    //                             @"pay"         : isNeedPay ? @"1" : @"",
    //                             };
    
    NSString *pay1 = [newParameter safeValueForKey:@"pay1"];
    NSMutableArray *arrayPy =[NSMutableArray arrayWithObjects:
                              @"offline"     , isPlayOffline ? @"1" : @"",
                              @"pay"         , [NSString safeString:pay1],
                              nil];
    NSMutableArray *uploadPy=(![NSObject empty:py])?py:arrayPy;
    
        [[self class] addPlayDataWithPlayAction:playStage
                                       andError:error
                                    andUsedtime:usedTime
                                         andCid:cid
                                         andPid:pid
                                         andVid:vid
                                    andVideoLen:vlen
                                  andRetryCount:retry
                                    andPlayType:ptype
                                     andPlayUrl:playUrl
                                    andProperty:uploadPy
                                     andStation:nil
                                    andPlayUUID:playUUID
                                    andCodeRate:videoCode
                                 andOfflineFlag:isPlayOffline
                                          andCh:nil
                                  andLivingCode:nil
                                          andLc:nil
                                         andRef:ref
                                         andZid:zid
                                  andIsAutoPlay:isAutoPlay
                                   andParamters:newParameter];
}

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
{
    
}

#pragma mark advertise
+ (void)addAdvertiseData:(NSInteger)ac
            adProperties:(NSString *)properties
                     cid:(NSString *)cid
                     url:(NSString *)url
                  slotid:(NSString *)slotid
                    adid:(NSString *)adid
             materialUrl:(NSString *)murl
                     ref:(NSString *)ref
                    rcid:(NSString *)rcid
{
    LT_DC_FIELD_DEFINE(ad, ver)
    LT_DC_FIELD_DEFINE(ad, p1)
    LT_DC_FIELD_DEFINE(ad, p2)
    LT_DC_FIELD_DEFINE(ad, p3)
    LT_DC_FIELD_DEFINE(ad, ac)      // 0:pv; 1:click
    LT_DC_FIELD_DEFINE(ad, pp)      // 广告属性
    LT_DC_FIELD_DEFINE(ad, cid)     // 视频频道 ID 大媒资
    LT_DC_FIELD_DEFINE(ad, url)     // 当前页面 url
    LT_DC_FIELD_DEFINE(ad, slotid)  // 广告位 id
    LT_DC_FIELD_DEFINE(ad, adid)    // 广告 ID
    LT_DC_FIELD_DEFINE(ad, murl)    // Material url:素材地址
    LT_DC_FIELD_DEFINE(ad, uid)
    LT_DC_FIELD_DEFINE(ad, uuid)
    LT_DC_FIELD_DEFINE(ad, lc)
    LT_DC_FIELD_DEFINE(ad, ref)     // 页面来源
    LT_DC_FIELD_DEFINE(ad, rcid)    // 来源频道
    LT_DC_FIELD_DEFINE(ad, ch)      // 渠道
    LT_DC_FIELD_DEFINE(ad, pcode)
    LT_DC_FIELD_DEFINE(ad, auid)
    LT_DC_FIELD_DEFINE(ad, ilu)
    LT_DC_FIELD_DEFINE(ad, r)
    
    NSDictionary *dictData = @{s_ad_ver     : LT_DATA_CENTER_KV_VERSION_3,
                               s_ad_p1      : LT_DATA_CENTER_P1VALUE,
                               s_ad_p2      : LT_DATA_CENTER_P2VALUE,
                               s_ad_p3      : LT_DATA_CENTER_P3VALUE,
                               s_ad_ac      : [NSString stringWithFormat:@"%ld", (long)ac],
                               s_ad_pp      : [[NSString safeString:properties] encodedURLParameterString],
                               s_ad_cid     : cid,
                               s_ad_url     : url,
                               s_ad_slotid  : slotid,
                               s_ad_adid    : adid,
                               s_ad_murl    : murl,
                               s_ad_uid     : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_ad_uuid    : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_ad_lc      : @"",
                               s_ad_ref     : ref,
                               s_ad_rcid    : rcid,
                               s_ad_ch      : @"",
                               s_ad_pcode   : CURRENT_PCODE,
                               s_ad_auid    : [DeviceManager getDeviceUUID],
                               s_ad_ilu     : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_ad_r       : [[self class] generateRandomValue],
                               };
    
    NSArray *arrRequiredKeys = @[s_ad_ver,
                                 s_ad_p1,
                                 s_ad_p2,
                                 s_ad_cid,
                                 s_ad_url,
                                 s_ad_slotid,
                                 s_ad_adid,
                                 s_ad_murl,
                                 s_ad_uid,
                                 s_ad_uuid,
                                 s_ad_lc,
                                 s_ad_ref,
                                 s_ad_rcid,
                                 s_ad_auid,
                                 s_ad_ilu,
                                 s_ad_r,
                                 ];
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVAd
                              andRawData:dictData
                         andRequiredKeys:arrRequiredKeys];
}

#pragma mark query
+ (void)addQueryDataWithSid:(NSString *)sid
                 searchType:(NSInteger)ty
              videoPosition:(NSInteger)pos
           clickedVideoInfo:(NSString *)clk
               queryContent:(NSString *)q
                       page:(NSInteger)p
                     Result:(NSString *)rt
{
    LT_DC_FIELD_DEFINE(query, ver)
    LT_DC_FIELD_DEFINE(query, p1)
    LT_DC_FIELD_DEFINE(query, p2)
    LT_DC_FIELD_DEFINE(query, p3)
    LT_DC_FIELD_DEFINE(query, sid)
    LT_DC_FIELD_DEFINE(query, ty)
    LT_DC_FIELD_DEFINE(query, pos)
    LT_DC_FIELD_DEFINE(query, clk)
    LT_DC_FIELD_DEFINE(query, uid)
    LT_DC_FIELD_DEFINE(query, uuid)
    LT_DC_FIELD_DEFINE(query, lc)
    LT_DC_FIELD_DEFINE(query, auid)
    LT_DC_FIELD_DEFINE(query, ch)
    LT_DC_FIELD_DEFINE(query, ilu)
    LT_DC_FIELD_DEFINE(query, q)
    LT_DC_FIELD_DEFINE(query, p)
    LT_DC_FIELD_DEFINE(query, rt)
    LT_DC_FIELD_DEFINE(query, r)
    
    NSDictionary *dictData = @{s_query_ver      : LT_DATA_CENTER_KV_VERSION_3,
                               s_query_p1       : LT_DATA_CENTER_P1VALUE,
                               s_query_p2       : LT_DATA_CENTER_P2VALUE,
                               s_query_p3       : LT_DATA_CENTER_P3VALUE,
                               s_query_sid      : sid,
                               s_query_ty       : [NSString stringWithFormat:@"%ld", (long)ty],
                               s_query_pos      : [NSString stringWithFormat:@"%ld", (long)pos],
                               s_query_clk      : clk,
                               s_query_uid      : [[LTUserCenterEngine userCenterEngine] alreadyLoginUserID],
                               s_query_uuid     : [NSString safeString:[SettingManager getVirtualLoginUUID]],
                               s_query_lc       : @"",
                               s_query_auid     : [DeviceManager getDeviceUUID],
                               s_query_ch       : @"",
                               s_query_ilu      : [NSString stringWithFormat:@"%d", ![SettingManager isUserLogin]],
                               s_query_q        : q,
                               s_query_p        : [NSString stringWithFormat:@"%ld", (long)p],
                               s_query_rt       : rt,
                               s_query_r        : [[self class] generateRandomValue],
                               };
    
    NSArray *arrRequiredKeys = @[s_query_ver,
                                 s_query_p1,
                                 s_query_p2,
                                 s_query_sid,
                                 s_query_ty,
                                 s_query_uid,
                                 s_query_uuid,
                                 s_query_lc,
                                 s_query_auid,
                                 s_query_ilu,
                                 s_query_q,
                                 s_query_p,
                                 s_query_rt,
                                 s_query_r,
                                 ];
    
    [[self class] sendStatisticsWithType:LTDataCenterStatisticsTypeKVQuery
                              andRawData:dictData
                         andRequiredKeys:arrRequiredKeys];
    
    NSLog(@"上报搜索日志，%@",dictData);
}

+ (NSString *)queryPlayerRefWithPageid:(NSString *)pageid fl:(NSString *)fl wz:(NSInteger)wz {
    
    NSString *pageIDTemp = [NSString safeString:pageid];
    NSString *flTemp = [NSString safeString:fl];
    
    if ([NSString empty:flTemp]) {
        flTemp = @"-";
    }
    
    return [NSString stringWithFormat:@"%@_%@_%ld_-_-", pageIDTemp, flTemp, (long)wz];
}

+ (NSString *)queryRefWithPageid:(LTDCPageID)pageid fl:(LTDCActionPropertyCategory)fl wz:(NSInteger)wz
{
    NSString *newPageId =[NSString fomatPageIDEnumCode:pageid];
    if ([NSString isBlankString:newPageId])newPageId = @"-";
    
    NSString *newFl = [LTDataCenter getActionCodeByActionCategory:fl];
    if ([NSString isBlankString:newFl])newFl = @"-";
    
    NSString *newWz = (wz < 0) ? @"-" : [NSString stringWithFormat:@"%ld",(long)wz];
    return [NSString stringWithFormat:@"%@_%@_%@_-_-",newPageId,newFl,newWz];
}

+ (NSString *)queryRefWithInfo:(LTStatisticInfo *)info {
    NSString *newPageId = [self getValueByDefault:[NSString fomatPageIDEnumCode:info.pageID]];
    
    NSString *newFl = [self getValueByDefault:[LTDataCenter getActionCodeByActionCategory:info.apc]];
    
    NSString *newWz = (info.wz < 0) ? @"-" : [NSString stringWithFormat:@"%ld",(long)info.wz];
    
    //scid
    NSString *newScid = [self getValueByDefault:info.scidID];
    
    //fragid
    NSString *newFragid = [self getValueByDefault:info.fragId];
    
    return [NSString stringWithFormat:@"%@_%@_%@_%@_%@",newPageId,newFl,newWz,newScid,newFragid];
}

+ (NSString *)getValueByDefault:(NSString *)value {
    if ([NSString isBlankString:value]) {
        return @"-";
    }
    return value;
}

+(LTDCPageID)getPageIDFromRef:(NSString *)ref
{
    NSString *newPageId =@"";
    NSArray *array =[ref componentsSeparatedByString:@"_"];
    if (array.count>0) {
        newPageId  =[array firstObject];
    }
    return [newPageId integerValue];
}
+ (void)setCrashlyticsUserInfo
{
    [CrashlyticsKit setUserIdentifier:[DeviceManager getDeviceUUID]];
    NSInteger isLogin = [SettingManager getValueFromUserDefaults:kIsLogin];
    NSString *mailString = @"";
    NSString *telString = @"";
    
    NSDictionary *dictUserInfo = [SettingManager userCenterUserInfo];
    if ( dictUserInfo
        &&  [dictUserInfo isKindOfClass:[NSDictionary class]]
        &&  [dictUserInfo count] > 0) {
        
        NSString *strExistedPhone = dictUserInfo[@"mobile"];
        NSString *strExistedEmail = dictUserInfo[@"email"];
        
        if ( ![NSString isBlankString:strExistedPhone]) {
            telString = strExistedPhone;
        }
        if (![NSString isBlankString:strExistedPhone]) {
            mailString = strExistedEmail;
        }
        
    }
    if (isLogin) {
        [CrashlyticsKit setUserName:[NSString stringWithFormat:@"%@_%@",[[LTUserCenterEngine userCenterEngine] alreadyLoginUserName],[[LTUserCenterEngine userCenterEngine] alreadyLoginUserID]]];
        [CrashlyticsKit setUserName:[NSString stringWithFormat:@"%@_%@",telString,mailString]];
    }
    else{
        [CrashlyticsKit setUserName:@""];
        [CrashlyticsKit setUserName:@""];
    }
    
}
@end

#pragma mark -

@implementation LTDataCenter (ThirdPartyDataStatistics)

+ (void)addBasicStatics{    
    // 友盟
    /*
     [MobClick startWithAppkey:UM_API_KEY
     reportPolicy:SEND_INTERVAL
     channelId:CURRENT_PCODE];
     */
    
}
@end

@implementation LTLiveStatisticInfo

@end
#endif
