//
//  LTRequestURLManager.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-4-18.
//
//

#ifdef LT_IPAD_CLIENT

#import "LTRequestURLDefine.h"

#import "LTRequestURLManager.h"
//#import "NSString+MD5.h"
//#import "NSString+HTTPExtensions.h"

@implementation LTRequestURLManager

+ (LTRequestURLInfo *)getURLInfoByType:(LTURLModule)urlModule
{
    LTRequestURLInfo *urlRequest = [[LTRequestURLInfo alloc] init];
    switch (urlModule) {

        case LTURLModule_Live_GetAllOrderData:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"getAllBookChannel",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"action",      @"book",
                                    @"ch",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_HalfScreen_PageCardXMLData:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"pagecard",
                                    @"act",@"index",
                                    @"pcversion",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_MyConcern:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/followlist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"type" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize" ,   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_AddConcern:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/follow?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"followid" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type" ,        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_CancelConcern:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/cancel?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"followid" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type" ,        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IsConcernStar:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/followcheck?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"followid" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type" ,        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_IsConcernStarlist:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/followchecklist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"followid" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type" ,        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_MyNew:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlHeadPath = @"profilepad/index?",
#else
            urlRequest.urlHeadPath = @"profile/index?",
#endif
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
            //专题
        case LTURLModule_SpecialTopic:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"subjectlist",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_FindTopic:
        {
            //LT_REQUEST_URL_STATIC_HEAD_MEIZI
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"discover",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Recommend_Personalized:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"home55",
                                    @"act",         @"index",
#ifndef LT_IPAD_CLIENT
                                    @"isnew",       LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Recommend_Personalized_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"home55",
                                    @"act",         @"index",
#ifndef LT_IPAD_CLIENT
                                    @"isnew",       LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
            //首页标签
        case LTURLModule_Recommend_Tag:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"mainstatic",
                                    @"mod",         @"mob",
                                    @"ctl",         @"dict",
                                    @"act",         @"index",
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Recommend_APP_INDEX:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"exchange",
                                    @"act",         @"bottom",
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Recommend_APP_POP:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"exchangepop",
                                    @"act",         @"pop",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_NewIndex:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"padhome",
                                    @"act",         @"index",
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Recommend_Live:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"homelive541",
                                    @"act",         @"operation",
                                    @"ct",          @"all",
                                    @"t",           @"d",
                                    @"home",        @"1",
#ifdef LT_MERGE_FROM_IPAD_CLIENT
                                    @"dev_id",      @"%@",
#endif
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Recommend_New_Live:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomByAll",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Recommend_CMS:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"block",
                                    @"act",         @"index",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Recommend_Launch_Logo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"bootimg",
                                    @"act",         @"index",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_PlayerHalfPageList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/cards?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
            break;
        }
        case LTURLModule_Recommend_Promotion:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"liveNew",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IndexRecommend:  //首页推荐
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"minfo",@"ctl",@"recommend",@"act",@"index",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_DetailRecommend:  //详情推荐（猜你喜欢）
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/relate?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;

        case LTURLModule_Recommend_BlockExchange:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindex55",
                                    @"act",         @"more",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"language",    LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pageid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"fragid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;

        case LTURLModule_Location_Geo:  //经纬度上传
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"geo",
                                    @"act",         @"index",
                                    @"longitude",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_ApiStatus:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"apistatus",
                                    @"act",         @"index",
                                    @"osversion",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"accesstype",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"resolution",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"brand",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"model",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Upgrade:
        {
            // 与apistatus用一个接口，只传pcode和version两个参数
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"apistatus",
                                    @"act",         @"index",
                                    @"osversion",   LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"accesstype",  LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"resolution",  LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"brand",       LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"model",       LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelinfo",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_NewList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelinfocms",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_NewList_5_9:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelinfopageidblock",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_NewList_6_5:
        {
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"channel?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Channel_NewList_5_5:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelinfopageid",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_New_Live:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomByChannel",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_ChannelVideoTotal:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelvideototal",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Index:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindex55",
                                    @"act",         @"index",
                                    @"pageid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vip",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page_num",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"area",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Index_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindex55",
                                    @"act",         @"index",
                                    @"pageid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page_num",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"area",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Channel_IndexZt:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindexzt",
                                    @"act",         @"index",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY, // fixme
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Filter:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"filter/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];


        }
            break;

        case LTURLModule_Channel_Filter_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"filter/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;
        case LTURLModule_Channel_Filter_Pad_57:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"filter",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Type:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"type",
                                    @"act",         @"index",
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY, // fixme
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Album:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum60",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",            LT_REQUEST_URL_DYNAMIC_VALUE ,//所有筛选分类
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"ph",          @"420003,420004",           //播放平台
#else
                                    @"ph",          @"420005,420006",           //播放平台
#endif
                                    @"pt",          LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",          LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",          [NSString stringWithFormat:@"%d", PER_PAGE_NUM],                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }

            break;
        case LTURLModule_Channel_Video:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listvideo60",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",          LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                     @"",           LT_REQUEST_URL_DYNAMIC_VALUE,  //所有筛选分类
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"ph",          @"420003,420004",           //播放平台
#else
                                    @"ph",          @"420005,420006",           //播放平台
#endif
                                    @"pt",          LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",          LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",          [NSString stringWithFormat:@"%d", PER_PAGE_NUM],                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Video_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"mob",
                                    @"ctl",         @"listvideo60",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",          LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",           LT_REQUEST_URL_DYNAMIC_VALUE,  //所有筛选分类
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"ph",          @"420003,420004",           //播放平台
#else
                                    @"ph",          @"420005,420006",           //播放平台
#endif
                                    @"pt",          LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",          LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",          [NSString stringWithFormat:@"%d", PER_PAGE_NUM],                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;

        case LTURLModule_Channel_Album_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum60",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",            LT_REQUEST_URL_DYNAMIC_VALUE ,//所有筛选分类
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"ph",          @"420003,420004",           //播放平台
#else
                                    @"ph",          @"420005,420006",           //播放平台
#endif
                                    @"pt",          LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",          LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",          [NSString stringWithFormat:@"%d", PER_PAGE_NUM],                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }

            break;
        case LTURLModule_Chart:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"dayplaytopchannel",
                                    @"act",         @"index",
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Sub_Chart:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"dayplaytop",
                                    @"act",         @"index",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Subject:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"special",
                                    @"act",         @"index",
                                    @"sid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_SpecialList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"speciallist",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_SpecialDetail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"specialdetail",
                                    @"sid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Subject_Detail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"subject",
                                    @"act",         @"detail",
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,   // type，测试时使用，正式传空即可
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_HotVideos:
        {

            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"hotpoint/hotpoint?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mpt",         @"420003",
                                    @"page_id",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pages",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                    nil];
        }
            break;

        case LTURLModule_HotVideosCategery:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"hotpoint/listhotpoint?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
            break;

        case LTURLModule_Play_Recommend:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"playrecommend",
                                    @"act",         @"index",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Play_SurroundVideo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/outer?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_Album_Video_PlayCount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"getPidsInfo",
                                    @"act",         @"index",
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ids",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#endif
        case LTURLModule_Detail_VRS_Album:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"album",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Detail_VRS_Video:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"video",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Album_Pay:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"albumpay",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_Album_Video_PlayCount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"getPidsInfo",
                                    @"act",         @"index",
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ids",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#endif
        case LTURLModule_Album_VideoList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"videolist",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"b",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"s",           [NSString stringWithFormat:@"%d", LT_VIDEOLIST_REQUEST_NUM],
                                    @"o",           LT_REQUEST_URL_DYNAMIC_VALUE,   // -1:按着集数升序; 1:按着集数降序.默认为:-1
                                    @"m",           LT_REQUEST_URL_DYNAMIC_VALUE,   // 1:合并; 0:不合并
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Album_VideoList_prevue:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"getprevuevideolist",
                                    @"act",         @"index",
                                    @"pid",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"s",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_FileInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"videofile",
                                    @"act",         @"index",
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"mmsid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
//#ifndef LT_MERGE_FROM_IPAD_CLIENT    //ipad 也需要降码流
                                    @"levelType",   @"1",//新版降码流策略
//#endif
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_FileInfoPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"minfo",
                                    @"ctl",         @"videofile",
                                    @"act",         @"index",
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"mmsid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //#ifndef LT_MERGE_FROM_IPAD_CLIENT    //ipad 也需要降码流
                                    @"levelType",   @"1",//新版降码流策略
                                    //#endif
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_VF:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_VF_And_Advertise:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rate",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"AD_IPDX",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"adParameter",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"adPath",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vastTag",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_Introduction:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/desc?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
//                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_VideoList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/vlist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"year",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"month",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagenum",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pagesize",    [NSString stringWithFormat:@"%d", LT_VIDEOLIST_REQUEST_NUM],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLMOdule_Video_UrlParse:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Parse;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"termid",         @"2",
                                    @"pay",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"iscpn",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uinfo",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"token",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uuid",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ostype",          @"macos",
                                    @"hwtype",          KHWName,
                                    nil];
        }
            break;
        case LTURLModule_Search_Hotword:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"hotwords",
                                    @"act",         @"index",
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Related:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"suggest",
                                    @"act",         @"index",
                                    @"keyword",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Init:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchinit",
                                    @"act",         @"index",
                                    @"markid",      @"0",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Mixed_Search:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchmix",
                                    @"act",         @"index",
                                    @"anum",        @"8",   // 最多取8个专辑
                                    @"ver",         @"%@",  // 是否返回专题信息，custom - 是
                                    @"ph",          @"420002,420003,420004,-131",
                                    @"wd",          @"%@",  // 搜索关键词
                                    @"cg",          @"%@",  // 分类
                                    @"pn",          @"%@",  // 页数
                                    @"ps",          @"30",  // 返回结果个数
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchmix",
                                    @"act",         @"index",
                                    @"anum",        @"8",   // 最多取8个专辑
                                    @"ver",         @"%@",  // 是否返回专题信息，custom - 是
                                    @"ph",          @"420002,420005,420006,-131",
                                    @"wd",          @"%@",  // 搜索关键词
                                    @"cg",          @"%@",  // 分类
                                    @"pn",          @"%@",  // 页数
                                    @"ps",          @"30",  // 返回结果个数
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Search_Star_Works:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchstar",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420003,420004,-131",
                                    @"sr",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchstar",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420005,420006,-131",
                                    @"sr",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Search_Star_Album:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchalbum",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420003,420004,-131",
                                    @"sa",          @"%@",
                                    @"cg",          @"%@",
                                    @"pn",          @"%@",
                                    @"ps",          @"30",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchalbum",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420005,420006,-131",
                                    @"sa",          @"%@",
                                    @"cg",          @"%@",
                                    @"pn",          @"%@",
                                    @"ps",          @"30",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Search_Star_Video:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchvideo",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420003,420004",
                                    @"wd",          @"%@",
                                    @"cg",          @"%@",
                                    @"pn",          @"%@",
                                    @"ps",          @"30",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchvideo",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420005,420006",
                                    @"wd",          @"%@",
                                    @"cg",          @"%@",
                                    @"pn",          @"%@",
                                    @"ps",          @"30",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Search_Video_Source:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchsrc",
                                    @"act",         @"srclist",
                                    @"dt",          @"1",
                                    @"src",         @"%@",
                                    @"id",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_OuterNet_VideoList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchsrc",
                                    @"act",         @"videolist",
                                    @"dt",          @"1",
                                    @"site",        @"%@",
                                    @"id",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Recommend:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchrecommend",
                                    @"act",         @"index",
                                    //@"num",         @"10", // 这里默认10
                                    @"devid",       @"%@",
                                    @"uid",         @"%@",
                                    @"history",     @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Suggest: // wyw add
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"suggest",
                                    @"act",         @"list",
                                    @"p",           @"mobile",
                                    @"t",           @"all",
                                    @"q",           @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
//#ifndef LT_MERGE_FROM_IPAD_CLIENT       //ipad 直播 也需要这些接口
// 直播大厅新接口
        case LTURLModule_Live_Hot_SortHotLives:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"sortHotLive",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Live_Hot_DefaultLive:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"hotLive",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

            // iphone  直播大厅体娱音 － 接口参数
        case LTURLModule_Live_New_LiveList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoom",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

            // pad 直播大厅体娱音 －直播厅时间列表接口
        case LTURLModule_Live_New_LiveSportMusic_Een_List:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomDateList",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"step",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"direction",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
            // pad 直播大厅 体育娱乐音乐 二级 特定日期数据获取接口
        case LTURLModule_Live_New_LiveS_M_E_SubList:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomByDate",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"date",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_LiveHollList_General:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"getChannelliveBystatus",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"beginDate",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"endDate",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"hasPay",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"order",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_LunBo_WeiShi_ChannelList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"channel",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"signal",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"subtype",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Live_LunBo_WeiShi_PreCurNextBillList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"preCurNextPlayBill",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"channelIds",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channelType", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_LunBo_WeiShi_CurrentBillList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"currentPlayBill",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"channelIds",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_ChannelStream:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"stream",
                                    @"act",             @"index",
                                    @"clientId",        [self liveClientId],
                                    @"channelId",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"withAllStreams",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"isPay",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_MIGU_ChannelStream:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"getMiguUrl",
                                    @"act",             @"index",
                                    @"clientId",        [self liveClientId],
                                    @"channelId",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rateLevel",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_BillListIncremental:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"incrementalPlayBill",
                                    @"act",             @"index",
                                    @"clientId",        [self liveClientId],
                                    @"programId",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"direction",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_New_SearchByLiveID:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"liveInfoByID",
                                    @"act",             @"index",
                                    @"id",              LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",        [self liveClientId],
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_AppleWatch_LiveList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"liveRoomByAllForWatch",
                                    @"act",             @"index",
                                    @"clientId",        [self liveClientId],
                                    @"num",             @"20",
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_CMS_Reccommend:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"block",
                                    @"act",         @"index",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
//#endif
        case LTURLModule_Live_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"livechannel",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_LunboList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"channel",
                                    @"ct",          @"letv",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_WeishiList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"channel",
                                    @"ct",          @"tv",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_LiveList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"operation",
                                    @"ct",          @"%@",
                                    @"d",           @"%@",
                                    @"t",           @"%@",
                                    @"home",        @"%@",
                                    @"dev_id",      @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_Bill:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"liveepg",
                                    @"act",         @"index",
                                    @"c",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"d",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY, // fixme
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_ChannelBill:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"channelInfo",
                                    @"ce",          @"%@",
                                    @"d",           @"%@",
                                    @"dev_id",      @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_Live_Batch_Validate:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"livebatchvalidate",
                                    @"act",           @"index",
                                    @"liveids",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];

        }
            break;
#endif
        case LTURLModule_Live_PlayingBill:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"currentliveepg",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_ChannelInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"livechannel",
                                    @"act",         @"channelInfo",
                                    @"c",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_Focus:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"livefocus",
                                    @"act",         @"index",
                                    @"id",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_SeverTime:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"getDate",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_LiveTm:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"timeexpirestamp",
                                    @"act",         @"timeExpireStamp",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_CanPlay:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"canplay",
                                    @"streamId",    @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_GetLiveUrlByScode:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"liveurl",
                                    @"act",         @"geturl",
                                    @"scode",        @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Live_Authority:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"livevalidate",
                                    @"act",         @"index",
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"liveid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"streamId",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"splatId",     [self liveClientId],
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"flag",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_UseTicket:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"liveuseticket",
                                    @"act",         @"index",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tickettype",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;

        case LTURLModule_Live_TicketInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"livegetticket",
                                    @"act",         @"index",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;


        case LTURLModule_Live_LivingPrice:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"livepackage",
                                    @"act",         @"index",
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"isteam",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_GetLiveOrderID:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"paymentorderid",
                                    @"act",         @"index",
                                    @"productid",   @"1001",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Live_GetLiveOrderIDAudit:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"paymentorderid",
                                    @"act",         @"index",
                                    @"productid",   @"1001",
                                    @"audit",       @"1",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"add",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"dev_token",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"play_time",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"p_name",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel_code",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel_name",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel_type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"live_id",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Del:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"del",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Close:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"close",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Open:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"open",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Clean:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"clean",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"add",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Del:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"del",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Close:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"close",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Open:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"open",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Clean:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"clean",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IOSDevice:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"stat",
                                    @"ctl",         @"iosdevice",
                                    @"act",         @"add",
                                    @"ip",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"name",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sysname",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sysver",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"model",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"lmodel",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"app_type",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"app_version", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"dev_token",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"longitude",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_About:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"version",
                                    @"ctl",         @"about",
                                    @"act",         @"ourinfo",
                                    @"language",    LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Alert_Info:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"message",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Audit:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"audit",
                                    @"ctl",         @"audit",
                                    @"act",         @"indexv1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_ErrorUpload:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"stat",
                                    @"ctl",         @"videostat",
                                    @"act",         @"add",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Feedback:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"feedback",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Ad_Config:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"advertisementnew",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Ad_Combine:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"advertisementpin",
                                    @"act",         @"index",
                                    @"ad_url",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"video_url",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip1",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip2",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_UC_SMSMobile:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;

            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    /*  接口参数修改*/

                                    //下发短信接口加密key：poi345
                                    @"mod",         @"sso",
                                    @"ctl",         @"clientSendMsg",
                                    @"act",         @"index",
                                    @"mobile",      LT_REQUEST_URL_DYNAMIC_VALUE,
#ifndef LT_IPAD_CLIENT
                                    @"captchaValue",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"captchaId",   LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,

                                    //新加的参数
                                    @"plat",        @"mobile_tv",
                                    @"action",      @"reg",
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
#ifndef LT_IPAD_CLIENT
        case LTURLModule_UC_VertiCode:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"getCaptcha",
                                    @"act",         @"index",
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_PhoneNumRegistered:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"mobilecheck",
                                    @"act",         @"index",
                                    @"mobile",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#endif
        case LTURLModule_UC_ChangeEmail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"sendBindEmail",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"email",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ChangeMobile:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"modifyMobile",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ChangePassword:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"sso",
                                    @"ctl",         @"modifyPwd",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_CheckEmailExists:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"checkEmailExists",
                                    @"email",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_CheckMobileExists:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"checkMobileExists",
                                    @"mobile",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_GenerateOrderID:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"getOrderId",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_Login:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"newLogin",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ThirdPartyLogin:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"thirdUserLogin",
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_Register:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            /* iPhone>=5.6 之后 ， 新给的注册接口
             http://dynamic.user.app.m.letv.com/android/dynamic.php?mod=sso&ctl=addUser&act=index&pcode={$pcode}&version={$version}
             所以要把参数改成下面的*/
//#ifdef LT_MERGE_FROM_IPAD_CLIENT
//             urlRequest.urlParams = [NSMutableArray arrayWithObjects:
//             @"mod",         @"passport",
//             @"ctl",         @"index",
//             @"act",         @"addUser",
//             @"gender",      @"0",
//             @"registService",@"mapp",
//             @"partnerUID",  LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
//             @"pcode",       CURRENT_PCODE,
//             @"version",     CURRENT_VERSION,
//             nil];
//#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod" ,        @"sso",
                                    @"ctl" ,        @"addUser",
                                    @"act" ,        @"index",
                                    @"pcode" ,      CURRENT_PCODE,
                                    @"version" ,    CURRENT_VERSION,
                                    nil];
//#endif
        }
            break;
        case LTURLModule_UC_MovieAvaiable:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"getService",
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"end",         @"4",
                                    @"storepath",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_Pay:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"offline",
                                    @"deptno",      @"130",
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"commodity",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"price",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"merOrder",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"payType",     @"ledian",
                                    @"service",     @"consume",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_PayResult:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"getPayResult",
                                    @"merOrder",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_QueryLePoint:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"queryrecord",
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"query",       @"02",
                                    @"day",         @"0",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_QueryVIP:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"vip",
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"end",         @"4", // 只有ipad调用，默认传4
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UserInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"getUserByTk",
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UserInfoPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"protobuf",    @"1",
                                    @"act",         @"getUserByTk",
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UpdataNickName:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"updateuser/index?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:

                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"nickname",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;

        case LTURLModule_UC_Consume:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"saleNew",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ConsumePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"saleNew",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case LTURLModule_UC_ConsumeAudit:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"saleNew",
                                    @"audit",       @"1",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_ConsumeAuditPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"saleNew",
                                    @"protobuf",    @"1",
                                    @"audit",       @"1",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_DeviceUidVipInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"vipinfo",
                                    @"act",         @"index",
                                    @"end",         @"4",
                                    @"audit",       @"1",
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;

        case LTURLModule_UC_BindAccount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"synchronOrder",
                                    @"act",         @"index",
                                    @"viptype",     @"1",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"virid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uuid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_UC_GetDeviveUserInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"payExtraGet",
                                    @"act",         @"index",
                                    @"viptype",     @"1",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_UC_LiveAmount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"liveAmount",
                                    @"act",         @"index",
                                    @"viptype",     @"1",
                                    @"tickettype",  @"1",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;

        case LTURLModule_UC_ChatHistory:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"chatGethistory",
                                    @"act",         @"index",
                                    @"roomId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"server",      @"true",
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ChatHistoryPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"chatGethistory",
                                    @"act",         @"index",
                                    @"roomId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"server",      @"true",
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_ChatSendMessage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"chatSendmessage",
                                    @"act",         @"index",
                                    @"roomId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"message",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"color",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"font",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"position",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"forhost",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vtkey",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"from",        kDanmakuSourceArg,
                                    nil];
        }
            break;
        case LTURLModule_UC_ChatSendMessagePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"chatSendmessage",
                                    @"act",         @"index",
                                    @"roomId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"message",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"color",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"font",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"position",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"forhost",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vtkey",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"from",        kDanmakuSourceArg,
                                    nil];
        }
            break;

        case LTURLModule_UC_Recharge:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"queryrecord",
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"starttime",   LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"endtime",     LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"query",       @"00",
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"deptid",      LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"productid",   LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_VERTIFY_TOKEN:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"clientCheckTicket",
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_GetAll:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        [LT_REQUEST_URL_DYNAMIC_VALUE isEqualToString:@""]?@"1":LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    @"20",
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_GetAllPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        [LT_REQUEST_URL_DYNAMIC_VALUE isEqualToString:@""]?@"1":LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    @"20",
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_GetByPage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_GetFirst:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        @"1",
                                    @"pagesize",    @"1",
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_PageSize:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        @"1",
                                    @"pagesize",    @"@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_SubmitSingle:
        {
            //TODO: ZhangQigang 增加 videoType 的字段上传 -- 服务器知道 video 的类型, 不需要上传.
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"add",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"nvid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vtype",       @"1",
                                    @"from",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"htime",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"longitude",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"upgc",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_SubmitMore:
        {
            //TODO: ZhangQigang 增加 videoType 字段上传 -- 服务器知道 video 的类型, 不需要上传.
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"import",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_Delete:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"del",
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"flush",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"idstr",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"backdata",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"upgc",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_GetPoint:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"getPoint",
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_Search:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"search",
                                    @"pids",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vids",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_GetAllFavrite://获得追剧列表
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"follow",
                                    @"act",         @"list",
                                    @"page",        @"1",
                                    @"pagesize",    @"1000",
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_DeleteFavrite://删除追剧
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"follow",
                                    @"act",         @"delete",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_SubmitFavrite://添加追剧
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"follow",
                                    @"act",         @"add",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"iostoken",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"fromtype",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_SubmitFavriteMore://批量上传追剧收藏
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"follow",
                                    @"act",         @"dump",
//                                    @"data",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_QRCode_Submit:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"submitQRCode",
                                    @"guid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Shake_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"shake",
                                    @"act",         @"add",
                                    @"aid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uuid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playtime",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vtype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"longitude",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Shake_Get:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"shake",
                                    @"act",         @"get",
                                    @"uuid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"longitude",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_Product:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"index",
                                    @"act",         @"product",
                                    @"device",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_OrderID:
        case LTURLModule_IAP_OrderID_Test:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"index",
                                    @"act",         @"newPay",
                                    @"ptype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"end",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"subend",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     @"3",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_OrderID_Test_Notlogin:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"index",
                                    @"act",         @"newPay",
                                    @"ptype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"end",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"subend",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     @"3",
                                    @"audit",       @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_IAP_HK_OrderID:
        case LTURLModule_IAP_HK_OrderID_Test:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",                  @"iappay",
                                    @"ctl",                  @"index",
                                    @"act",                  @"orderId",
                                    @"productid",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",                  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",                  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"price",                LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"itemamt",              LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_id",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_name",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_desc",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"merchant_business_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"currency",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"my_order_type",        @"SDK",
                                    @"pcode",                CURRENT_PCODE,
                                    @"version",              CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_HK_OrderID_Test_Notlogin:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",                  @"iappay",
                                    @"ctl",                  @"index",
                                    @"act",                  @"orderId",
                                    @"productid",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",                  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",                  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"price",                LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"itemamt",              LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_id",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_name",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_desc",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"merchant_business_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"currency",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"my_order_type",        @"SDK",
                                    @"pcode",                CURRENT_PCODE,
                                    @"version",              CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_IAP_ProductId:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"productList",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_IAP_ProductId_Pre:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"payPackagePre",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;



        case LTURLModule_IAP_Receipt:
        case LTURLModule_IAP_Receipt_Test:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"index",
                                    @"act",         @"offline",
                                    nil];
        }
        break;


        case LTURLModule_Share_PlayUrl:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",             @"linkshare",
                                    @"act",           @"index",
                                    @"pcode",     CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
        break;
        case LTURLModule_Recommend_APP:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",             @"exchange",
                                    @"act",           @"index",
                                    @"exchid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    @"30",
                                    @"pcode",     CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Report_ASIdentifier:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"iosidfa",
                                    @"act",         @"index",
                                    @"idfa",        @"%@",
                                    @"key",         @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Get_TimeStamp:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"timestamp",
                                    @"act",         @"timestamp",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Get_Promotion_Info:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"spread",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_SendBackPwdEmail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"sendBackPwdEmail",
                                    @"email",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_SearchVoucher:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",          @"passport",
                                    @"ctl",          @"index",
                                    @"act",          @"queryServlet",
                                    @"uname",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",        CURRENT_PCODE,
                                    @"version",      CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UseVoucher:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"yuanxian/updTicket?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"name",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_VoucherList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"yuanxian/myTickets?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_VoucherListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"yuanxian/myTickets?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",      @"1",
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;

// TO REMOVE: 更新接口，和iPhone获取观影券一致
#if 0
        case LTURLModule_UC_VoucherList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",           @"passport",
                                    @"ctl",           @"index",
                                    @"act",           @"queryServletList",
                                    @"userId",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"size",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_VoucherListIPad_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",           @"passport",
                                    @"ctl",           @"index",
                                    @"act",           @"queryServletList",
                                    @"protobuf",      @"1",
                                    @"userId",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"size",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
#endif
        case LTURLModule_UC_CommendForVip:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",           @"passport",
                                    @"ctl",           @"index",
                                    @"act",           @"praiseactivity",
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_AppCheckin:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"checkin",
                                    @"act",           @"index",
                                    @"did",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sig",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_UC_AppCheckin_V56:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",           @"mob",
                                    @"ctl",           @"floatball",
                                    @"act",           @"index",
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];

        }
            break;
#endif
        case LTURLModule_UC_SSOLoginSina:
        {
            NSString * deviceModel=UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone?@"iphone":@"ipad";
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"appssosina",
                                    @"act",           @"index",
                                    @"access_token",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"equipType",     deviceModel,
                                    @"equipID",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"plat",          @"mobile_tv",
                                    @"softID",        CURRENT_VERSION,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"imei",          @"",
                                    @"mac",           [NSString safeString:[NSString macaddress]],
                                    @"openid",        LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    nil];
        }
            break;
        case LTURLModule_UC_SSOLoginQQ:
        {
            NSString * deviceModel=UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone?@"iphone":@"ipad";
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"appssoqq",
                                    @"act",           @"index",
                                    @"appkey",        [[LeTVAppModule sharedModule]letv_LTShareFrameWorkGetTencentAPPKey],
                                    @"access_token",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"openid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"plat",          @"mobile_tv",
                                    @"equipType",     deviceModel,
                                    @"equipID",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"softID",        CURRENT_VERSION,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"imei",          @"",
                                    @"mac",           [NSString safeString:[NSString macaddress]],
#endif
                                    nil];
        }
            break;

        case LTURLModule_UC_SSOLoginWX:
        {
            NSString * deviceModel=UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone?@"iphone":@"ipad";
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"appssoweixin",
                                    @"act",           @"index",
                                    @"access_token",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"openid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"plat",          @"mobile_tv",
                                    @"equipType",     deviceModel,
                                    @"equipID",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"softID",        CURRENT_VERSION,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"imei",          @"",
                                    @"mac",           [NSString safeString:[NSString macaddress]],
#endif
                                    nil];
        }
            break;


        case LTURLModule_UC_UnloginSystemMessage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/unlogin?";
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:@"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,nil];
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_loginSystemMessage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/loginsysmes?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"is_read",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_singleMessage_read:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/readMessage?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"msg_id",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_loginCommentMessage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/loginreplymes?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"is_read",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
        }
            break;
        case LTURLModule_UC_loginCommentMessage_delete:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/deletemessage?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"id",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
        }
            break;
        case LTURLModule_UC_loginReplyedCommentMessage_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/index?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"type",@"video",
                                    @"source",@"Iphone",
                                    @"ctype",@"",
                                    @"rows",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"commentid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];

        }
            break;
        case LTURLModule_UC_startUnreadMessage:
        {
            /*
             platform	平台：1、PC端+移动端 2、PC端 3、移动端  支持多平台筛选 例如 platform=1,2,3	 	数值型	是
             from	来源，支持传多个值，  例如 2,3,4	 	整形	是
             sso_tk	用户登录后产生的token值	 	字符串	是	 header里接收
             pcode	产品代码	 	字符串	是	GET提交
             version	版本号
             */
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/unreadcount?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"platform",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
        }
            break;
        case LTURLModule_UC_allMessage_read:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/readall?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"from",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
        }
            break;
        case LTURLModule_Get_VIP_Video_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindexvip",
                                    @"act",         @"index",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Get_VIP_Privilege_Info:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"vipproduct",
                                    @"act",         @"index",
                                    @"up",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"svip",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Comment_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rows",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;
        case  LTURLModule_Comment_ListPB:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
#ifndef LT_IPAD_CLIENT
                                    @"voteFlag",    LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"htime",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rows",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;

        case LTURLModule_Comment_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/add?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"voteFlag",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"htime",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Comment_AddPB:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/add?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"voteFlag",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"htime",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;
        case LTURLModule_Comment_Reply:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/reply?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"replyid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;
        case LTURLModule_Comment_ReplyPB:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/reply?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"replyid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;
        case LTURLModule_Comment_Reply_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/replylist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",         LT_REQUEST_URL_DYNAMIC_VALUE,      // 页数
                                    @"rows",        @"20",     // 每页的条数
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,  // 评论ID
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;
        case LTURLModule_Comment_Reply_ListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/replylist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",         LT_REQUEST_URL_DYNAMIC_VALUE,      // 页数
                                    @"rows",        @"20",     // 每页的条数
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,  // 评论ID
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case LTURLModule_Comment_Like:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/like?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"attr",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;
        case LTURLModule_Comment_LikePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/like?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"attr",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case  LTURLModule_Comment_VoteList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/votelist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case  LTURLModule_Comment_VoteListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/votelist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case LTURLModule_Comment_Vote:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"id",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Comment_VotePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"id",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;

        case LTURLModule_Comment_Number:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/commnum?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,nil];

        }
            break;
        case LTURLModule_Comment_NumberPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/commnum?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;

        case LTURLModule_Integretion_Rules:
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"credit",
                                    @"act",@"getactioninfo",
                                    @"action", @"sharevideo,video,startmapp",
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
            break;
        case LTURLModule_Integretion_Task:// 此接口暂时弃用
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"credit",
                                    @"act",@"check",
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];

            break;
        case LTURLModule_Integretion_Action:
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"credit",
                                    @"act",@"add",
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"desc",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"action",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];

            break;
        case LTURLModule_Top_Game_Data:

            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType  = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"topmatches",
                                    @"act",@"index",
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
            break;

        case LTURLModule_Hot_PraiseOrDown:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"hotpoint/addupdown?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"did",     [DeviceManager getDeviceUUID],
                                    @"vid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"act",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    nil];
            break;

        case LTURLModule_Hot_Praise_Count:
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"vote",
                                    @"act",@"num",
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    @"id",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
            break;

        case LTScoreRecord:
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"credit",
                                    @"act",@"getActionProgress",
                                    @"action", @"sharevideo,video,startmapp",
                                    @"count",@"1",
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];

            break;


            //我的页面焦点图,版块ID: 1480
        case LTURLModule_My_FocusView:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType  = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"block",
                                    @"act",@"index",
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"id",LT_REQUEST_URL_DYNAMIC_VALUE,
#else
                                    @"id",@"1480",
#endif
                                    nil];
            break;
        case LTURLModule_Album_VideoList_ByDate:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"videolistbydate",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"year",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"month",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"videoType",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Get_WaterMark:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"waterMark",
                                    @"act",@"index",
                                    @"cid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"liveid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Fav_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/add?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"play_id",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"video_id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_type", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from_type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;

        case LTURLModule_Fav_Delete:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/delete?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"play_id",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"video_id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_type", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];

        }
            break;

        case LTURLModule_Fav_MultiDelete:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/multidelete?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"favorite_id",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];

        }
            break;

        case LTURLModule_Fav_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/listfavorite?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"category",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_type",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from_type",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",           [DeviceManager getDeviceUUID],
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    @"source",          kSourceArg,
                                    nil];

        }
            break;

        case LTURLModule_Fav_IsFav:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/isfavorite?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"play_id",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"video_id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_type",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",           [DeviceManager getDeviceUUID],
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    @"source",          kSourceArg,
                                    nil];

        }
            break;

        case LTURLModule_Fav_Dump://Post
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/dump?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];

        }
            break;
        case LTURLModule_Shot_TextShare_Get:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"sharewords",
                                    @"act",          @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_STAR_Video_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:

                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"id" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_STAR_Video_ListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",        @"1",
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"id" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Shot_Icons_CMS:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"shareimg?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:

                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"uid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;



        case LTURLModule_STAR_VOTE:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"device_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version",   CURRENT_VERSION,
                                    @"pcode",     CURRENT_PCODE,
                                    nil];
        }
            break;

        case LTURLModule_Star_History_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star/starranking?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"nums" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"starttime" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Star_Ranklist:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star/starrank?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"id" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"n" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;

        case LTURLModule_RedPacket_StaringUp:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/package?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"userid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_RedPacket_PaySuccess:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/order?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userType",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"orderId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;

        case LTURLModule_RedPacket_PaySucCallBack:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/callback?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"orderId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;

        case LTURLModule_RedPacket_Position:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/position?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_LiveHall_SearchByDate:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"date",LT_REQUEST_URL_DYNAMIC_VALUE
                                    ,nil];
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channel",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        nil];
            break;
        case LTURLModule_LiveHall_GetCurrentInfo:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams =  nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channel",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        nil];
            break;
        case LTURLModule_LiveHall_GetIncremental:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams =  [NSMutableArray arrayWithObjects:
                                     @"id",LT_REQUEST_URL_DYNAMIC_VALUE
                                     ,nil];
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channel",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        nil];
            break;
        case LTURLModule_Live_GetLiveChannel:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams =  nil;

            break;
        case LTURLModule_Live_GetLiveChannelByThirdParty:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams =  [NSMutableArray arrayWithObjects:
                                     @"signal",LT_REQUEST_URL_DYNAMIC_VALUE,
                                     @"withTest",LT_REQUEST_URL_DYNAMIC_VALUE
                                     ,nil];
            break;
        case LTURLModule_Live_GetChannelStream:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE
                                        ,nil];
            break;
        case LTURLModule_Live_GetSnapShot:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE
                                        ,nil];
            break;
        case LTURLModule_Live_GetCurrentBillList1:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"channelIds",LT_REQUEST_URL_DYNAMIC_VALUE
                                    ,nil];
            break;
        case LTURLModule_Live_GetCurrentDayBillList:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE
                                        ,nil];
            break;
        case LTURLModule_Live_GetBillListIncremental:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"direction",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        @"programId",LT_REQUEST_URL_DYNAMIC_VALUE
                                        ,nil];

            break;
        case LTURLModule_Live_GetBillListPlayingInfo:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        nil];
            break;
        case LTURLModule_Live_GetCurrentBillList2:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"channelIds",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
            urlRequest.urlHeadParams = nil;
            break;
        case LTURLModule_Live_Livehall_GetPlayerInfo:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            break;
        case LTURLModule_Live_Livehall_sortHotLives:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            break;

#endif
        case LTURLModule_Danmaku_Get:
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"danmu_list",
                                    @"act",@"index",
                                    @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"amount", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
            break;
        case LTURLModule_Danmaku_GetPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"danmu_list",
                                    @"act",@"index",
                                    @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"amount", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
            break;
        case LTURLModule_Danmaku_Send:
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"danmu_add",
                                    @"act",@"index",
                                    @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"txt", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"color",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"x",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"y",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"font",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"position",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    @"from",kDanmakuSourceArg,
                                    nil];
            break;
        case LTURLModule_RedPacket_StaringUpPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/package?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"userid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_RedPacket_PaySuccessPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/order?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userType",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"orderId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;
        case LTURLModule_RedPacket_PaySucCallBackPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/callback?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"orderId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;
        case LTURLModule_Danmaku_SendPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"danmu_add",
                                    @"act",@"index",
                                    @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"txt", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"color",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"x",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"y",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"font",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"position",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    @"from",kDanmakuSourceArg,
                                    nil];
            break;
        case LTURLModule_Danmaku_IsDanmaku:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/isDanmaku?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;
        case LTURLModule_Danmaku_IsDanmakuPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/isDanmaku?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;

        case LTURLModule_HotPatch:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"iphonehotpatch",
                                    @"act", @"index",
                                    @"patchNo", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;
        case LTURLModule_HotPatchPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"mod", @"mob",
                                    @"ctl", @"iphonehotpatch",
                                    @"act", @"index",
                                    @"patchNo", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;

        case LTURLModule_PageCard:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"pagecard",
                                    @"act", @"index",
                                    @"pcversion", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;
        case LTURLModule_LoadingPoster:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"tm", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tss", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"pid", LT_REQUEST_URL_DYNAMIC_VALUE, nil];
            break;
        case LTURLModule_LiveVoteList:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/livevotevid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,nil];

            break;
        case LTURLModule_Votelist:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/demandvotevid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,nil];
            break;
        case LTURLModule_Vote:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"version", CURRENT_VERSION,
                                    @"id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,nil];
            break;
        case LTURLModule_GetLivingOnlineNum:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"live/livenum?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"group", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetLiveShoppingProduct:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"buybystreamid",
                                    @"streamId", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_liveAddProductToCart:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"addinbuycart",
                                    @"purType", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pids", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"user_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"streamId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rs", @"2014",
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetLiveShoppingCartCount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"getbuycartnum",
                                    @"user_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetProductAttentionCount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"totalcount",
                                    @"streamId", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"startingtime", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"duration", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_VideoPraiseOrStep:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/updown?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"act", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid", [NSString safeString:[SettingManager alreadyLoginUserID]],
                                    @"did", [DeviceManager getDeviceUUID],nil];
            break;

        case LTURLModule_IsBadWord:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"badword/index?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"word",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,
                                     nil];
        }
            break;
        case LTURLModule_GetClientIP:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"ip",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
            break;
        }
        case LTURLModule_Comment_AllKeyboardList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"emoji?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid", [DeviceManager getDeviceUUID],
                                    @"protobuf",    @"1",
                                    nil];
            break;
        }
        case LTURLModule_FindTopicPB:
        {
            //LT_REQUEST_URL_STATIC_HEAD_MEIZI
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"discover",
                                    @"act",         @"index",
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;


        case LTURLModule_Live_SeverTimePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"getDate",
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_VF_And_AdvertisePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rate",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"jailbreak",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"AD_IPDX",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"adParameter",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"adPath",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vastTag",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_GetLiveShoppingProductPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"buybystreamid",
                                    @"streamId", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetLiveShoppingCartCountPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"getbuycartnum",
                                    @"user_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_liveAddProductToCartPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"addinbuycart",
                                    @"purType", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pids", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"user_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"streamId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rs", @"2014",
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_LiveVoteListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/livevotevid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,nil];
        }
            break;
        case LTURLModule_VotePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"version", CURRENT_VERSION,
                                    @"id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;

        case LTURLModule_MyNewPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlHeadPath = @"profilepad/index?",
#else
            urlRequest.urlHeadPath = @"profile/index?",
#endif
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_IAP_ProductIdPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"iappay",
                                    @"ctl",         @"productList",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;

        case LTURLModule_Live_UseTicketPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"pay",
                                    @"ctl",         @"liveuseticket",
                                    @"act",         @"index",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tickettype",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Live_TicketInfoPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"pay",
                                    @"ctl",         @"livegetticket",
                                    @"act",         @"index",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Get_VIP_Privilege_InfoPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"minfo",
                                    @"ctl",         @"vipproduct",
                                    @"act",         @"index",
                                    @"up",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"svip",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_Home_SortHotLives:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveHome",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
         }
            break;
        case LTURLModule_VIP_Channel_Filter:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"filtervip/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];


        }
            break;

        case LTURLModule_VIP_Channel_Filter_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"filtervip/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
           
        case LTURLModule_Live_AllLiveList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"getAllLiveRoom",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"action",      @"live",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
            
        case LTURLModule_Live_WonderLookBack:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveReplay",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
            
        default:
            break;
    }

    if (urlModule != LTURLMOdule_Video_UrlParse ) {
        if ([urlRequest.urlParams isKindOfClass:[NSMutableArray class]]) {

            NSArray *lang = [NSArray arrayWithObjects:@"lang", [NSString getPreferredLanguage], nil];
            [urlRequest.urlParams addObjectsFromArray:lang];

            NSString *region = [SettingManager getLocationCountryCode];
            if ([NSString isBlankString:region]) {
                region = @"CN";
            }
            NSArray *regions = [NSArray arrayWithObjects:@"region", region, nil];
            [urlRequest.urlParams addObjectsFromArray:regions];
        }
    }

    return urlRequest;
}

+ (NSString *)getUrlHeadByUrlModule:(LTURLModule)urlModule
{
    LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];

    LTRequestURLType urlType = urlInfo.urlType;
    LTRequestURLDomainType urlDomainType = urlInfo.urlDomainType;
    NSString *urlHead = @"";

    BOOL bSettingTest = [SettingManager isTestApi];

    BOOL bForced2Test = (LTURLModule_IAP_Receipt_Test == urlModule);
    BOOL bForced2Product = (LTURLModule_ApiStatus == urlModule);
    
#ifdef DEBUG
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kTestAPIKey]) {
        BOOL isTestApi = [[NSUserDefaults standardUserDefaults] boolForKey:kTestAPIKey];
        
        if (isTestApi) {
            bForced2Product = NO;
        }
    }
#endif

    BOOL bUseTestAPI = (    (bSettingTest && !bForced2Product)
                        ||  bForced2Test
                        );

    if (bUseTestAPI) {

        urlHead = LT_REQUEST_URL_TEST_HEAD;

#if DEBUG
        // 如果是DEBUG模式，并且用户是香港，则使用香港的测试环境
        if ([SettingManager isHK]) {
            urlHead = LT_REQUEST_URL_HK_TEST_HEAD;
        }
#endif

//#ifndef LT_MERGE_FROM_IPAD_CLIENT             //ipad 也需要直播新接口
        if (urlType ==LTRequestURL_LiveNew) {
            urlHead = LT_REQUEST_URL_LIVE_NEW_HEAD;
        }
//#endif
        else if (urlType == LTRequestURL_PlayCombine) {
            urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD_TEST;

#if DEBUG
            if ([SettingManager isHK]) {
                urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD_HK_TEST;
            }
#endif
        }
    }
    else{
        switch (urlType) {
            case LTRequestURL_Dynamic:
            {
                switch (urlDomainType) {
                    case LTRequestURLDomainTypeSearch:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_SEARCH;
                        break;
                    case LTRequestURLDomainTypeMeizi:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_MEIZI;
                        break;
                    case LTRequestURLDomainTypePay:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_PAY;
                        break;
                    case LTRequestURLDomainTypeUser:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_USER;
                        break;
                    case LTRequestURLDomainTypeRecommend:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_RECOMMEND;
                        break;
                    case LTRequestURLDomainTypeLive:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_LIVE;
                        break;
                    case LTRequestURLDomainTypeNormal:
                    default:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD;
                        break;
                }
            }
                break;
            case LTRequestURL_Static:
            {
                switch (urlDomainType) {
                    case LTRequestURLDomainTypeSearch:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_SEARCH;
                        break;
                    case LTRequestURLDomainTypeMeizi:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_MEIZI;
                        break;
                    case LTRequestURLDomainTypePay:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_PAY;
                        break;
                    case LTRequestURLDomainTypeUser:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_USER;
                        break;
                    case LTRequestURLDomainTypeRecommend:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_RECOMMEND;
                        break;
                    case LTRequestURLDomainTypeLive:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_LIVE;
                        break;
                    case LTRequestURLDomainTypeNormal:
                    default:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD;
                        break;
                }
            }
                break;
//#ifndef LT_MERGE_FROM_IPAD_CLIENT
            case LTRequestURL_LiveNew:
            {
                urlHead = LT_REQUEST_URL_LIVE_NEW_HEAD;
            }
                break;
//#endif

            case LTRequestURL_PlayCombine:
            {
                urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD;
                break;
            }
            default:
                break;
        }
    }

    return urlHead;

}

+ (NSString *)formatRequestURL:(LTRequestURLInfo *)urlInfo
                  andUrlModule:(LTURLModule)urlModule
              andDynamicValues:(NSArray *)arrayDynamicValues
{
    return [LTRequestURLManager formatRequestURL:urlInfo
                                    andUrlModule:urlModule
                                andDynamicValues:arrayDynamicValues
                                andUrlHeadValues:nil];

}

+ (NSString *)formatRequestURL:(LTRequestURLInfo *)urlInfo
                  andUrlModule:(LTURLModule)urlModule
              andDynamicValues:(NSArray *)arrayDynamicValues
              andUrlHeadValues:(NSArray *)arrayUrlHeadValues
{

    LTRequestURLType urlType = urlInfo.urlType;
    NSString *urlHead = @"";

    NSMutableArray *dynamicValuesArray = [NSMutableArray arrayWithArray:arrayDynamicValues];

    switch (urlType) {
        case LTRequestURL_Dynamic:
        case LTRequestURL_Static:
        case LTRequestURL_LiveNew:
        case LTRequestURL_PlayCombine:
        {
            urlHead = [self getUrlHeadByUrlModule:urlModule];
        }
            break;
        case LTRequestURL_Parse:
        {
            urlHead = [NSString stringWithFormat:@"%@&", dynamicValuesArray[0]];
            [dynamicValuesArray removeObjectAtIndex:0];
        }
            break;
        default:
            break;
    }

    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
                                                   andDynamicValues:dynamicValuesArray
                                                   andUrlHeadValues:arrayUrlHeadValues];


    return [NSString stringWithFormat:
            @"%@%@",
            urlHead,
            urlPath];

}

+ (NSString *)formatRequestURLByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues
{
    LTRequestURLInfo *requestInfo = [LTRequestURLManager getURLInfoByType:urlModule];


    return [LTRequestURLManager formatRequestURL:requestInfo
                                    andUrlModule:urlModule
                                andDynamicValues:arrayDynamicValues];

}

+ (NSString *)formatRequestURLByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues
                      andUrlHeadValues:(NSArray *)arrayUrlHeadValues
{
    LTRequestURLInfo *requestInfo = [LTRequestURLManager getURLInfoByType:urlModule];


    return [LTRequestURLManager formatRequestURL:requestInfo
                                    andUrlModule:urlModule
                                andDynamicValues:arrayDynamicValues
                                andUrlHeadValues:arrayUrlHeadValues];
}

+ (LTURLModule)getUrlModuleByUrl:(NSString *)urlString
{
    for (LTURLModule urlModule = LTURLModule_Begin; urlModule < LTURLModule_End; urlModule++) {

        NSString * urlHead = [self getUrlHeadByUrlModule:urlModule];

        if (![urlString hasPrefix:urlHead]) {
            continue;
        }

        LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];
        NSMutableArray *arrayParam = urlInfo.urlParams;

        NSString *KeyValueJoinedString = @"";

        switch (urlInfo.urlType) {
            case LTRequestURL_Dynamic:
            case LTRequestURL_Parse:
            case LTRequestURL_LiveNew:
            case LTRequestURL_PlayCombine:
            {
                KeyValueJoinedString = @"=";
            }
                break;
            case LTRequestURL_Static:
            {
                KeyValueJoinedString = @"/";
            }
                break;
            default:
                break;
        }

        BOOL isMatched = YES;
        NSInteger countParam = [arrayParam count];
        if (countParam < 2) {
            isMatched = NO;
        }
        for (int i = 0; i+1 < countParam; i+=2) {
            NSString *key = arrayParam[i];
            NSString *value = arrayParam[i+1];
            if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
                continue;
            }
            if ([NSString isBlankString:value]) {
                continue;
            }
            if ([NSString isBlankString:key]) {
                KeyValueJoinedString =@"";
            }
            NSString *currKeyValuePair = [NSString stringWithFormat:
                                          @"%@%@%@",
                                          key,
                                          KeyValueJoinedString,
                                          value];

            if ([urlString rangeOfString:currKeyValuePair].length <= 0) {
                isMatched = NO;
                break;
            }
        }

        if (isMatched) {
            return urlModule;
        }
    }

    return LTURLModule_Unknown;
}

+ (LTURLModule)getUrlModuleByUrl:(NSString *)urlString
                       fromIndex:(NSInteger)fromIndex
                         toIndex:(NSInteger)toIndex
{
    for (LTURLModule urlModule = fromIndex; urlModule < toIndex; urlModule++) {

        NSString * urlHead = [self getUrlHeadByUrlModule:urlModule];

        if (![urlString hasPrefix:urlHead]) {
            continue;
        }

        LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];
        NSMutableArray *arrayParam = urlInfo.urlParams;

        NSString *KeyValueJoinedString = @"";

        switch (urlInfo.urlType) {
            case LTRequestURL_Dynamic:
            case LTRequestURL_Parse:
            case LTRequestURL_PlayCombine:
            {
                KeyValueJoinedString = @"=";
            }
                break;
            case LTRequestURL_Static:
            {
                KeyValueJoinedString = @"/";
            }
                break;
            default:
                break;
        }

        BOOL isMatched = YES;
        NSInteger countParam = [arrayParam count];
        if (countParam < 2) {
            isMatched = NO;
        }
        for (int i = 0; i+1 < countParam; i+=2) {
            NSString *key = arrayParam[i];
            NSString *value = arrayParam[i+1];
            if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
                continue;
            }
            if ([NSString isBlankString:value]) {
                continue;
            }
            if ([NSString isBlankString:key]) {
                KeyValueJoinedString =@"";
            }
            NSString *currKeyValuePair = [NSString stringWithFormat:
                                          @"%@%@%@",
                                          key,
                                          KeyValueJoinedString,
                                          value];

            if ([urlString rangeOfString:currKeyValuePair].length <= 0) {
                isMatched = NO;
                break;
            }
        }

        if (isMatched) {
            return urlModule;
        }
    }

    return LTURLModule_Unknown;
}

+ (LTRequestURLType)getRequestURLTypeByModule:(LTURLModule)urlModule
{
    LTRequestURLInfo *requestInfo = [LTRequestURLManager getURLInfoByType:urlModule];
    return requestInfo.urlType;
}

+ (LTRequestURLDomainType)getRequestURLDomainTypeByModule:(LTURLModule)urlModule
{
    LTRequestURLInfo *requestInfo = [LTRequestURLManager getURLInfoByType:urlModule];
    return requestInfo.urlDomainType;
}

+ (NSString *)getRequestPathByModule:(LTURLModule)urlModule
                    andDynamicValues:(NSArray *)arrayDynamicValues
{
    LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];

    LTRequestURLType urlType = urlInfo.urlType;
    NSMutableArray *arrayParam = urlInfo.urlParams;
    NSMutableArray *dynamicValuesArray = [NSMutableArray arrayWithArray:arrayDynamicValues];

    NSString *KeyValueJoinedString = @"";
    NSString *componentsJoinedString = @"";
    NSString *urlTail = @"";
    NSString *urlHead = @"";

    switch (urlType) {
        case LTRequestURL_Dynamic:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = @"dynamic.php?";
            urlTail = LT_REQUEST_URL_DYNAMIC_TAIL;
        }
            break;
        case LTRequestURL_Static:
        {
            KeyValueJoinedString = @"/";
            componentsJoinedString = @"/";
            urlTail = LT_REQUEST_URL_STATIC_TAIL;
        }
            break;
        case LTRequestURL_Parse:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
        }
            break;
        case LTRequestURL_LiveNew:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [LTRequestURLManager getLiveNewHeaderByModule:urlModule andDynamicValues:dynamicValuesArray];
            urlTail = LT_REQUEST_URL_DYNAMIC_TAIL;
        }
            break;
        case LTRequestURL_PlayCombine:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [NSString safeString:urlInfo.urlHeadPath];
            urlTail = LT_REQUEST_URL_PLAY_COMBINE_TAIL;
        }
            break;
        default:
            break;
    }

    NSInteger countParam = [arrayParam count];
    NSInteger countDynamicParam = [dynamicValuesArray count];
    NSMutableArray *arrayKeyValues = [NSMutableArray array];

    NSInteger valuePos = 0;
    for (int i = 0; i+1 < countParam; i+=2) {
        NSString *key = arrayParam[i];
        NSString *value = arrayParam[i+1];
        if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
            if (valuePos >= countDynamicParam) {
                NSLog(@"LTRequestURLManager, param num error");
                continue;
            }
            NSString *strValue = dynamicValuesArray[valuePos];
            valuePos ++;
            if ([NSString isBlankString:strValue]) {
                continue;
            }
            value = [NSString stringWithFormat:
                     LT_REQUEST_URL_DYNAMIC_VALUE,
                     strValue];
        }
        if ([NSString isBlankString:value]) {
            continue;
        }
        NSString *newKeyValueJoinedString =KeyValueJoinedString;
        if ([NSString isBlankString:key]) {
            newKeyValueJoinedString =@"";
        }

        [arrayKeyValues addObject:[NSString stringWithFormat:
                                   @"%@%@%@",
                                   key,
                                   newKeyValueJoinedString,
                                   value]];
    }

    NSString *formatUrlParams = [arrayKeyValues componentsJoinedByString:componentsJoinedString];

    return [NSString stringWithFormat:
            @"%@%@%@",
            urlHead,
            formatUrlParams,
            urlTail];
}

#if 0
extern NSString * AFPercentEscapedStringFromString(NSString *string);
#endif

+ (NSString *)getRequestPathByModule:(LTURLModule)urlModule
                    andDynamicValues:(NSArray *)arrayDynamicValues
                    andUrlHeadValues:(NSArray *)arrayUrlHeadValues

{
    LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];

    LTRequestURLType urlType = urlInfo.urlType;
    NSMutableArray *arrayParam = urlInfo.urlParams;
    NSMutableArray *dynamicValuesArray = [NSMutableArray arrayWithArray:arrayDynamicValues];
    NSMutableArray *urlHeadValuesArray = [NSMutableArray arrayWithArray:arrayUrlHeadValues];

    NSString *KeyValueJoinedString = @"";
    NSString *componentsJoinedString = @"";
    NSString *urlTail = @"";
    NSString *urlHead = @"";

    switch (urlType) {
        case LTRequestURL_Dynamic:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = @"dynamic.php?";
            urlTail = LT_REQUEST_URL_DYNAMIC_TAIL;
        }
            break;
        case LTRequestURL_Static:
        {
            KeyValueJoinedString = @"/";
            componentsJoinedString = @"/";
            urlTail = LT_REQUEST_URL_STATIC_TAIL;
        }
            break;
        case LTRequestURL_Parse:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
        }
            break;
        case LTRequestURL_LiveNew:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [LTRequestURLManager getLiveNewHeaderByModule:urlModule andDynamicValues:urlHeadValuesArray];
            urlTail = LT_REQUEST_URL_DYNAMIC_TAIL;
        }
            break;

        case LTRequestURL_PlayCombine:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [NSString safeString:urlInfo.urlHeadPath];
            urlTail = LT_REQUEST_URL_PLAY_COMBINE_TAIL;
        }
            break;
        default:
            break;
    }

    NSInteger countParam = [arrayParam count];
    NSInteger countDynamicParam = [dynamicValuesArray count];
    NSMutableArray *arrayKeyValues = [NSMutableArray array];

    NSInteger valuePos = 0;
    for (int i = 0; i+1 < countParam; i+=2) {
        NSString *key = arrayParam[i];
        NSString *value = arrayParam[i+1];
        if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
            if (valuePos >= countDynamicParam) {
                NSLog(@"LTRequestURLManager, param num error");
                continue;
            }
            NSString *strValue = dynamicValuesArray[valuePos];
#if 0
            if (strValue.length) {
                strValue = AFPercentEscapedStringFromString(strValue);
            }
#endif
            valuePos ++;
            if ([NSString isBlankString:strValue]) {
                continue;
            }
            value = [NSString stringWithFormat:
                     LT_REQUEST_URL_DYNAMIC_VALUE,
                     strValue];
        }
        if ([NSString isBlankString:value]) {
            continue;
        }
        NSString *newKeyValueJoinedString =KeyValueJoinedString;
        if ([NSString isBlankString:key]) {
            newKeyValueJoinedString =@"";
        }

        [arrayKeyValues addObject:[NSString stringWithFormat:
                                   @"%@%@%@",
                                   key,
                                   newKeyValueJoinedString,
                                   value]];
    }

    NSString *formatUrlParams = [arrayKeyValues componentsJoinedByString:componentsJoinedString];

    return [NSString stringWithFormat:
            @"%@%@%@",
            urlHead,
            formatUrlParams,
            urlTail];

}

+ (NSString *)getLiveNewHeaderByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues
{
    LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];
    NSMutableArray *arrayUrlHeadParam = urlInfo.urlHeadParams;
    NSMutableArray *urlHeadValuesArray = [NSMutableArray arrayWithArray:arrayDynamicValues];

    NSInteger countParam = [arrayUrlHeadParam count];
    NSInteger countDynamicParam = [urlHeadValuesArray count];


    NSInteger valuePos = 0;
    for (int i = 0; i+1 < countParam; i+=2) {
        //        NSString *key = arrayUrlHeadParam[i];
        NSString *value = arrayUrlHeadParam[i+1];
        if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
            if (valuePos >= countDynamicParam) {
                NSLog(@"LTRequestURLManager, param num error");
                continue;
            }
            NSString *strValue = urlHeadValuesArray[valuePos];
            valuePos ++;
            if ([NSString isBlankString:strValue]) {
                continue;
            }
            value = [NSString stringWithFormat:
                     LT_REQUEST_URL_DYNAMIC_VALUE,
                     strValue];
        }
        if ([NSString isBlankString:value]) {
            continue;
        }

        arrayUrlHeadParam[i+1] =value;
    }

    switch (urlModule) {
        case LTURLModule_LiveHall_SearchByDate:
        {
            NSString *channel =@"sports";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channel"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channel = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/liveRoom/%@/specialDate/%@?",channel,[self liveClientId]];
        }

            break;
        case LTURLModule_LiveHall_GetCurrentInfo:
        {
            NSString *channel =@"sports";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channel"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channel = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/liveRoom/%@/current/%@",channel,[self liveClientId]];
        }
            break;
        case LTURLModule_LiveHall_GetIncremental:
        {
            NSString *channel =@"sports";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channel"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channel = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/liveRoom/%@/incremental/%@",channel,[self liveClientId]];
        }
            break;
        case LTURLModule_Live_GetLiveChannel:
            return [NSString stringWithFormat:@"v1/channel/letv/100/%@?signal=5,7",[self liveClientId]];
            break;
        case LTURLModule_Live_GetLiveChannelByThirdParty:
            return [NSString stringWithFormat:@"v1/channel/third/100/%@?",[self liveClientId]];
            break;
        case LTURLModule_Live_GetChannelStream:
        {
            NSString *channelId =@"";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channelId"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channelId = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/stream/%@/%@?withAllStreams=1",[self liveClientId],channelId];
        }
            break;
        case LTURLModule_Live_GetSnapShot:
        {
            NSString *channelId =@"";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channelId"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channelId = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/channel/snapshot/%@.jpg",channelId];
        }
            break;
        case LTURLModule_Live_GetCurrentBillList1:
            return [NSString stringWithFormat:@"v1/playbill/current/%@?",[self liveClientId]];
            break;
        case LTURLModule_Live_GetCurrentDayBillList:
        {
            NSString *channelId =@"";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channelId"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channelId = arrayUrlHeadParam[i+1];
                }
            }

            return [NSString stringWithFormat:@"v1/playbill/wholeday/%@/%@",[self liveClientId],channelId];
        }
            break;
        case LTURLModule_Live_GetBillListIncremental:
        {
            NSString *programId =@"";
            NSString *direction =@"1";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"programId"]&&(i!=arrayUrlHeadParam.count -1)) {
                    programId = arrayUrlHeadParam[i+1];
                }
                if ([str isEqualToString:@"direction"]&&(i!=arrayUrlHeadParam.count -1)) {
                    direction = arrayUrlHeadParam[i+1];
                }

            }

            return [NSString stringWithFormat:@"v1/playbill/incremental/%@/%@/%@",[self liveClientId],direction,programId];
        }
            break;
        case LTURLModule_Live_GetBillListPlayingInfo:
        {
            NSString *vid =@"";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"vid"]&&(i!=arrayUrlHeadParam.count -1)) {
                    vid = arrayUrlHeadParam[i+1];
                }
            }

            return [NSString stringWithFormat:@"v1/playbill/vrs/100/%@/%@",[self liveClientId],vid];
        }
            break;
        case LTURLModule_Live_GetCurrentBillList2:
        {
            return [NSString stringWithFormat:@"v1/playbill/current2/%@?",[self liveClientId]];
        }
            break;
        case LTURLModule_Live_Livehall_GetPlayerInfo:
        {
            if ([SettingManager isTestApi]) {
                return [NSString stringWithFormat:@"v1/liveRoom/terminal/hotLive/%@?test=1",[self liveClientId]];
            } else {
                return [NSString stringWithFormat:@"v1/liveRoom/terminal/hotLive/%@",[self liveClientId]];
            }
        }
            break;
        case LTURLModule_Live_Livehall_sortHotLives:
        {
            if ([SettingManager isTestApi]) {
                return [NSString stringWithFormat:@"v1/liveRoom/terminal/sortHotLives/%@?test=1",[self liveClientId]];
            } else {
                return [NSString stringWithFormat:@"v1/liveRoom/terminal/sortHotLives/%@",[self liveClientId]];
            }
        }
            break;
        default:
            break;
    }

    return @"";
}

+ (NSString *)liveClientId {
    NSString *liveClientId = LT_LIVE_CLIENTID;
    if ([SettingManager isHK]) {
#ifdef LT_IPAD_CLIENT
        liveClientId = @"1060419007";
#else
        liveClientId = @"1060419005";
#endif
    }
    return liveClientId;
}


@end
#else

#import "LTRequestURLDefine.h"

#import "LTRequestURLManager.h"
//#import "NSString+MD5.h"
//#import "NSString+HTTPExtensions.h"

@implementation LTRequestURLManager

+ (LTRequestURLInfo *)getURLInfoByType:(LTURLModule)urlModule
{
    LTRequestURLInfo *urlRequest = [[LTRequestURLInfo alloc] init];
    switch (urlModule) {

        case LTURLModule_HalfScreen_PageCardXMLData:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"pagecard",
                                    @"act",@"index",
                                    @"pcversion",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_MyConcern:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/followlist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"type" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize" ,   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_AddConcern:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/follow?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"followid" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type" ,        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_CancelConcern:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/cancel?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"followid" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type" ,        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IsConcernStar:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/followcheck?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"followid" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type" ,        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_IsConcernStarlist:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"follow/followchecklist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"followid" ,       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type" ,        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_MyNew:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlHeadPath = @"profilepad/index?",
#else
            urlRequest.urlHeadPath = @"profile/index?",
#endif
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
            //专题
        case LTURLModule_SpecialTopic:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"subjectlist",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_SpecialTopicPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"subjectlist",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }

            break;
        case LTURLModule_FindTopic:
        {
            //LT_REQUEST_URL_STATIC_HEAD_MEIZI
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"discover",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Recommend_Personalized:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"home55",
                                    @"act",         @"index",
#ifndef LT_IPAD_CLIENT
                                    @"isnew",       LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Recommend_Personalized_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"home55",
                                    @"act",         @"index",
#ifndef LT_IPAD_CLIENT
                                    @"isnew",       LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
            //首页标签
        case LTURLModule_Recommend_Tag:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"mainstatic",
                                    @"mod",         @"mob",
                                    @"ctl",         @"dict",
                                    @"act",         @"index",
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Recommend_APP_INDEX:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"exchange",
                                    @"act",         @"bottom",
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Recommend_APP_POP:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"exchangepop",
                                    @"act",         @"pop",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_NewIndex:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"padhome",
                                    @"act",         @"index",
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Recommend_Live:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"homelive541",
                                    @"act",         @"operation",
                                    @"ct",          @"all",
                                    @"t",           @"d",
                                    @"home",        @"1",
#ifdef LT_MERGE_FROM_IPAD_CLIENT
                                    @"dev_id",      @"%@",
#endif
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Recommend_New_Live:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomByAll",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Recommend_CMS:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"block",
                                    @"act",         @"index",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Recommed_Promotion:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"block",
                                    @"act",         @"index",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Recommend_Launch_Logo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"bootimg",
                                    @"act",         @"index",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_PlayerHalfPageList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/cards?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
            break;
        }
        case LTURLModule_Recommend_Promotion:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"liveNew",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Recommend_Live_Block:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"homeLiveBlock",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Recommend_BlockExchange:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindex55",
                                    @"act",         @"more",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"language",    LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pageid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"fragid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;

        case LTURLModule_IndexRecommend:  //首页推荐
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"minfo",@"ctl",@"recommend",@"act",@"index",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_DetailRecommend:  //详情推荐（猜你喜欢）
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/relate?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Location_Geo:  //经纬度上传
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"geo",
                                    @"act",         @"index",
                                    @"longitude",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_ApiStatus:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"apistatus",
                                    @"act",         @"index",
                                    @"osversion",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"accesstype",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"resolution",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"brand",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"model",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Upgrade:
        {
            // 与apistatus用一个接口，只传pcode和version两个参数
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"apistatus",
                                    @"act",         @"index",
                                    @"osversion",   LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"accesstype",  LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"resolution",  LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"brand",       LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"model",       LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelinfo",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_NewList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelinfocms",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_NewList_5_9:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelinfopageidblock",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_NewList_6_5:
        {
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"channel?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Channel_NewList_5_5:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelinfopageid",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_New_Live:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomByChannel",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_ChannelVideoTotal:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelvideototal",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Channel_Index:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindex55",
                                    @"act",         @"index",
                                    @"pageid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vip",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page_num",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"area",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Index_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindex55",
                                    @"act",         @"index",
                                    @"pageid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"history",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"provinceid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"districtid",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"citylevel",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"location",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page_num",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"area",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Channel_IndexZt:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindexzt",
                                    @"act",         @"index",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY, // fixme
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Filter:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"filter/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];


        }
            break;

        case LTURLModule_Channel_Filter_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"filter/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;
        case LTURLModule_VIP_Channel_Filter:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"filtervip/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];


        }
            break;

        case LTURLModule_VIP_Channel_Filter_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"filtervip/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;
        case LTURLModule_Channel_Filter_Pad_57:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"filter",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Type:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"type",
                                    @"act",         @"index",
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY, // fixme
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Album:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum60",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",            LT_REQUEST_URL_DYNAMIC_VALUE ,//所有筛选分类
                                    @"ph",          @"420003,420004",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",            LT_REQUEST_URL_DYNAMIC_VALUE ,//所有筛选分类
                                    @"ph",          @"420005,420006",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }

            break;

        case LTURLModule_Channel_Dolby_Album:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum60",
                                    @"act",         @"index",
                                    @"src",         @"1", // 来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"sc",            LT_REQUEST_URL_DYNAMIC_VALUE ,// 子分类
                                    @"ar",            LT_REQUEST_URL_DYNAMIC_VALUE, // 地区
                                    @"yr",            LT_REQUEST_URL_DYNAMIC_VALUE, //年份
                                    @"vt",            @"180001", // video type，杜比频道的值
                                    @"cv",            LT_REQUEST_URL_DYNAMIC_VALUE, // 码流
                                    @"ag",            LT_REQUEST_URL_DYNAMIC_VALUE, // 年龄
                                    @"isend",         LT_REQUEST_URL_DYNAMIC_VALUE, // 是否结束
                                    @"st",            LT_REQUEST_URL_DYNAMIC_VALUE, // style
                                    @"ph",          @"420003,420004",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"or",     LT_REQUEST_URL_DYNAMIC_VALUE, // 排序字段
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",            LT_REQUEST_URL_DYNAMIC_VALUE ,//所有筛选分类
                                    @"ph",          @"420005,420006",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }

            break;
        case LTURLModule_Channel_Dolby_Video:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listvideo60",
                                    @"act",         @"index",
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"sc",            LT_REQUEST_URL_DYNAMIC_VALUE ,// 子分类
                                    @"ar",            LT_REQUEST_URL_DYNAMIC_VALUE, // 地区
                                    @"yr",            LT_REQUEST_URL_DYNAMIC_VALUE, //年份
                                    @"vt",            @"180001", // video type，杜比频道的值
                                    @"cv",            LT_REQUEST_URL_DYNAMIC_VALUE, // 码流
                                    @"ag",            LT_REQUEST_URL_DYNAMIC_VALUE, // 年龄
                                    @"isend",         LT_REQUEST_URL_DYNAMIC_VALUE, // 是否结束
                                    @"st",            LT_REQUEST_URL_DYNAMIC_VALUE, // style
                                    @"ph",          @"420003,420004",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"or",     LT_REQUEST_URL_DYNAMIC_VALUE, // 排序字段
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"10",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",            LT_REQUEST_URL_DYNAMIC_VALUE ,//所有筛选分类
                                    @"ph",          @"420005,420006",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }

            break;
            
        case LTURLModule_Channel_FeedFLow:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"upgc/index?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE, // 请求数目
                                    @"apt",         @"mobile",
                                    @"pg",          @"hot",
                                    @"md",          @"hot",
                                    nil];
        }
            break;
        case LTURLModule_Channel_FeedFlow_Up:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"upgc/updown?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"act",         @"1",
                                    nil];
        }
            break;
        case LTURLModule_Channel_FeedFlow_Instant_Statistic:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"upgc/memact?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"sid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"iid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"alg",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"req_id",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apt",         @"mobile",
                                    @"pg",          @"hot",
                                    @"md",          @"hot",
                                    nil];
        }
            break;
        case LTURLModule_Channel_FeedFlow_Offline_Statistic:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"upgc/memactOutline?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"action",      @"click",
                                    @"sid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"req_id",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apt",         @"mobile",
                                    @"pg",          @"hot",
                                    @"md",          @"hot",
                                    @"videolist",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Channel_Video:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listvideo60",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",         LT_REQUEST_URL_DYNAMIC_VALUE,  //所有筛选分类
                                    @"ph",          @"420003,420004",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listvideo",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",         LT_REQUEST_URL_DYNAMIC_VALUE,  //所有筛选分类
                                    @"ph",          @"420005,420006",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Channel_Video_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"mob",
                                    @"ctl",         @"listvideo60",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",          LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",           LT_REQUEST_URL_DYNAMIC_VALUE,  //所有筛选分类
                                    @"ph",          @"420003,420004",           //播放平台
                                    @"pt",          LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",          LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",          @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listvideo",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",         LT_REQUEST_URL_DYNAMIC_VALUE,  //所有筛选分类
                                    @"ph",          @"420005,420006",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;

        case LTURLModule_Channel_Album_PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum60",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",          LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",            LT_REQUEST_URL_DYNAMIC_VALUE ,//所有筛选分类
                                    @"ph",          @"420003,420004",           //播放平台
                                    @"pt",          LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",          LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",          @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"listalbum",
                                    @"act",         @"index",
                                    @"src",         @"1",   //来源 1站内 2 站外
                                    @"cg",         LT_REQUEST_URL_DYNAMIC_VALUE,  //分类
                                    @"",            LT_REQUEST_URL_DYNAMIC_VALUE ,//所有筛选分类
                                    @"ph",          @"420005,420006",           //播放平台
                                    @"pt",     LT_REQUEST_URL_DYNAMIC_VALUE,   //付费平台
                                    @"pn",        LT_REQUEST_URL_DYNAMIC_VALUE,   //指定第几页
                                    @"ps",         @"30",                    //每页多少个结果
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }

            break;
        case LTURLModule_Chart:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"dayplaytopchannel",
                                    @"act",         @"index",
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Sub_Chart:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"dayplaytop",
                                    @"act",         @"index",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Subject:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"special",
                                    @"act",         @"index",
                                    @"sid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_SpecialList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"speciallist",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_SpecialDetail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"specialdetail",
                                    @"sid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Subject_Detail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"subject",
                                    @"act",         @"detail",
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,   // type，测试时使用，正式传空即可
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_HotVideos:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"hotpoint/hotpoint?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mpt",         @"420003",
                                    @"page_id",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pages",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_HotVideosPB:
        {

            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"hotpoint/hotpoint?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mpt",         @"420003",
                                    @"page_id",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pages",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_HotVideosCategery:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"hotpoint/listhotpoint?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
            break;

        case LTURLModule_Play_Recommend:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"playrecommend",
                                    @"act",         @"index",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Play_SurroundVideo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/outer?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_Album_Video_PlayCount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"getPidsInfo",
                                    @"act",         @"index",
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ids",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#endif
        case LTURLModule_Detail_VRS_Album:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"album",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Detail_VRS_Video:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"video",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Album_Pay:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"albumpay",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_Album_Video_PlayCount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"getPidsInfo",
                                    @"act",         @"index",
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ids",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#endif
        case LTURLModule_Album_VideoList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"videolist",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"b",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"s",           [NSString stringWithFormat:@"%d", LT_VIDEOLIST_REQUEST_NUM],
                                    @"o",           LT_REQUEST_URL_DYNAMIC_VALUE,   // -1:按着集数升序; 1:按着集数降序.默认为:-1
                                    @"m",           LT_REQUEST_URL_DYNAMIC_VALUE,   // 1:合并; 0:不合并
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Album_VideoList_prevue:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"getprevuevideolist",
                                    @"act",         @"index",
                                    @"pid",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"s",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_FileInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"videofile",
                                    @"act",         @"index",
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"mmsid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //#ifndef LT_MERGE_FROM_IPAD_CLIENT    //ipad 也需要降码流
                                    @"levelType",   @"1",//新版降码流策略
                                    //#endif
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_FileInfoPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"minfo",
                                    @"ctl",         @"videofile",
                                    @"act",         @"index",
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"mmsid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //#ifndef LT_MERGE_FROM_IPAD_CLIENT    //ipad 也需要降码流
                                    @"levelType",   @"1",//新版降码流策略
                                    //#endif
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_VF:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rate",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_VF_And_Advertise:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rate",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"AD_IPDX",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"adParameter",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"adPath",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vastTag",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_Introduction:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/desc?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_VideoList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/vlist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"year",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"month",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagenum",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pagesize",    [NSString stringWithFormat:@"%d", LT_VIDEOLIST_REQUEST_NUM],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLMOdule_Video_UrlParse:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Parse;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"termid",         @"2",
                                    @"pay",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"iscpn",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uinfo",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"token",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uuid",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ostype",          @"macos",
                                    @"hwtype",          KHWName,
                                    nil];
        }
            break;
        case LTURLModule_Search_Hotword:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"hotwords",
                                    @"act",         @"index",
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Related:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"suggest",
                                    @"act",         @"index",
                                    @"keyword",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Init:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchinit",
                                    @"act",         @"index",
                                    @"markid",      @"0",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Mixed_Search:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchmix",
                                    @"act",         @"index",
                                    @"anum",        @"8",   // 最多取8个专辑
                                    @"ver",         @"%@",  // 是否返回专题信息，custom - 是
                                    @"ph",          @"420002,420003,420004,-131",
                                    @"wd",          @"%@",  // 搜索关键词
                                    @"cg",          @"%@",  // 分类
                                    @"pn",          @"%@",  // 页数
                                    @"ps",          @"30",  // 返回结果个数
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchmix",
                                    @"act",         @"index",
                                    @"anum",        @"8",   // 最多取8个专辑
                                    @"ver",         @"%@",  // 是否返回专题信息，custom - 是
                                    @"ph",          @"420002,420005,420006,-131",
                                    @"wd",          @"%@",  // 搜索关键词
                                    @"cg",          @"%@",  // 分类
                                    @"pn",          @"%@",  // 页数
                                    @"ps",          @"30",  // 返回结果个数
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Search_Star_Works:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchstar",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420003,420004,-131",
                                    @"sr",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchstar",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420005,420006,-131",
                                    @"sr",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Search_Star_Album:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchalbum",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420003,420004,-131",
                                    @"sa",          @"%@",
                                    @"cg",          @"%@",
                                    @"pn",          @"%@",
                                    @"ps",          @"30",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchalbum",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420005,420006,-131",
                                    @"sa",          @"%@",
                                    @"cg",          @"%@",
                                    @"pn",          @"%@",
                                    @"ps",          @"30",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Search_Star_Video:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchvideo",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420003,420004",
                                    @"wd",          @"%@",
                                    @"cg",          @"%@",
                                    @"pn",          @"%@",
                                    @"ps",          @"30",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchvideo",
                                    @"act",         @"index",
                                    @"ph",          @"420002,420005,420006",
                                    @"wd",          @"%@",
                                    @"cg",          @"%@",
                                    @"pn",          @"%@",
                                    @"ps",          @"30",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
#endif
        }
            break;
        case LTURLModule_Search_Video_Source:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchsrc",
                                    @"act",         @"srclist",
                                    @"dt",          @"1",
                                    @"src",         @"%@",
                                    @"id",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_OuterNet_VideoList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchsrc",
                                    @"act",         @"videolist",
                                    @"dt",          @"1",
                                    @"site",        @"%@",
                                    @"id",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Recommend:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"searchrecommend",
                                    @"act",         @"index",
                                    //@"num",         @"10", // 这里默认10
                                    @"devid",       @"%@",
                                    @"uid",         @"%@",
                                    @"history",     @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Search_Suggest: // wyw add
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeSearch;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"suggest",
                                    @"act",         @"list",
                                    @"p",           @"mobile",
                                    @"t",           @"all",
                                    @"q",           @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
            //#ifndef LT_MERGE_FROM_IPAD_CLIENT       //ipad 直播 也需要这些接口
            //iPhone6.7新版直播首页
        case LTURLModule_Live_Home_SortHotLives:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveHome",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
            // 直播大厅新接口
        case LTURLModule_Live_Hot_SortHotLives:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"sortHotLive",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Live_Hot_DefaultLive:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"hotLive",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

            // iphone  直播大厅体娱音 － 接口参数
        case LTURLModule_Live_New_LiveList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoom",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_Channel_New:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomNew",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_Carouse_Category:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"live/livecatalog?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
            // pad 直播大厅体娱音 －直播厅时间列表接口
        case LTURLModule_Live_New_LiveSportMusic_Een_List:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomDateList",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"step",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"direction",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
            // pad 直播大厅 体育娱乐音乐 二级 特定日期数据获取接口
        case LTURLModule_Live_New_LiveS_M_E_SubList:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveRoomByDate",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"date",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_LiveHollList_General:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"getChannelliveBystatus",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    [self liveClientId],
                                    @"beginDate",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"endDate",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"hasPay",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"order",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_LunBo_WeiShi_ChannelList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"channel",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"signal",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"subtype",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Carouse_ChannelList_By_Code:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"channel",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"signal",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"subtype",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channelClass",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Live_LunBo_WeiShi_PreCurNextBillList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"preCurNextPlayBill",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"channelIds",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channelType", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_LunBo_WeiShi_CurrentBillList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"currentPlayBill",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"channelIds",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_ChannelStream:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"stream",
                                    @"act",             @"index",
                                    @"clientId",        [self liveClientId],
                                    @"channelId",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"withAllStreams",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"isPay",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_MIGU_ChannelStream:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"getMiguUrl",
                                    @"act",             @"index",
                                    @"clientId",        [self liveClientId],
                                    @"channelId",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rateLevel",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_BillListIncremental:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"incrementalPlayBill",
                                    @"act",             @"index",
                                    @"clientId",        [self liveClientId],
                                    @"programId",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"direction",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_New_SearchByLiveID:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"liveInfoByID",
                                    @"act",             @"index",
                                    @"id",              LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",        [self liveClientId],
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_AppleWatch_LiveList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",          @"main",
                                    @"mod",             @"live",
                                    @"ctl",             @"liveRoomByAllForWatch",
                                    @"act",             @"index",
                                    @"clientId",        [self liveClientId],
                                    @"num",             @"20",
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_CMS_Reccommend:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"block",
                                    @"act",         @"index",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
            //#endif
        case LTURLModule_Live_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"livechannel",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_LunboList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"channel",
                                    @"ct",          @"letv",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_WeishiList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"channel",
                                    @"ct",          @"tv",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_LiveList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"operation",
                                    @"ct",          @"%@",
                                    @"d",           @"%@",
                                    @"t",           @"%@",
                                    @"home",        @"%@",
                                    @"dev_id",      @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_Bill:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"liveepg",
                                    @"act",         @"index",
                                    @"c",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"d",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY, // fixme
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_AllLiveList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"getAllLiveRoom",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"action",      @"live",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;

        case LTURLModule_Live_MyOrders:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"booklivelist",
                                    @"act",         @"index",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"clientId",    @"1002",//[self liveClientId],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_MyOrderDetail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"orderDetail",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"liveId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;

        case LTURLModule_Live_LivePlay:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveplay",
                                    @"act",         @"index",
                                    @"liveId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channelId",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"mac",         [NSString safeString:[NSString macaddress]],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_ChannelPlay:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"channelplay",
                                    @"act",         @"index",
                                    @"channelId",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"mac",         [NSString safeString:[NSString macaddress]],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_WonderLookBack:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"liveReplay",
                                    @"act",         @"index",
                                    @"ct",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_ChannelBill:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"channelInfo",
                                    @"ce",          @"%@",
                                    @"d",           @"%@",
                                    @"dev_id",      @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_Live_Batch_Validate:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"livebatchvalidate",
                                    @"act",           @"index",
                                    @"liveids",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];

        }
            break;
#endif
        case LTURLModule_Live_PlayingBill:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"currentliveepg",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_ChannelInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"livechannel",
                                    @"act",         @"channelInfo",
                                    @"c",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_Focus:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"livefocus",
                                    @"act",         @"index",
                                    @"id",          @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_SeverTime:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"getDate",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_LiveTm:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"timeexpirestamp",
                                    @"act",         @"timeExpireStamp",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_CanPlay:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"live",
                                    @"act",         @"canplay",
                                    @"streamId",    @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_GetLiveUrlByScode:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"liveurl",
                                    @"act",         @"geturl",
                                    @"scode",        @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Live_Authority:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"livevalidate",
                                    @"act",         @"index",
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"liveid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"streamId",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"splatId",     [self liveClientId],
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"flag",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_Lunbo_Authority:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"livevalidate",
                                    @"act",         @"validate",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"country",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",        @"2", // 轮播直播类型
                                    @"streamId",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"splatId",     [self liveClientId],
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"deviceId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"terminal",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Live_UseTicket:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"liveuseticket",
                                    @"act",         @"index",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tickettype",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;

        case LTURLModule_Live_TicketInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"livegetticket",
                                    @"act",         @"index",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;


        case LTURLModule_Live_LivingPrice:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"livepackage",
                                    @"act",         @"index",
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"isteam",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Live_GetLiveOrderID:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"paymentorderid",
                                    @"act",         @"index",
                                    @"productid",   @"1001",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_Live_GetLiveOrderIDAudit:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"paymentorderid",
                                    @"act",         @"index",
                                    @"productid",   @"1001",
                                    @"audit",       @"1",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"add",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"dev_token",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"play_time",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"p_name",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel_code",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel_name",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel_type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"live_id",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Del:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"del",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Close:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"close",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Open:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"open",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_BookLive_Clean:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"clean",
                                    @"dev_id",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"add",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Del:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"del",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Close:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"close",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Open:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"open",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Push_Clean:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"bookalbum",
                                    @"act",         @"clean",
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IOSDevice:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"stat",
                                    @"ctl",         @"iosdevice",
                                    @"act",         @"add",
                                    @"ip",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"name",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sysname",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sysver",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"model",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"lmodel",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"app_type",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"app_version", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"dev_token",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"longitude",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_About:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"version",
                                    @"ctl",         @"about",
                                    @"act",         @"ourinfo",
                                    @"language",    LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Alert_Info:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"message",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Audit:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"audit",
                                    @"ctl",         @"audit",
                                    @"act",         @"indexv1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_ErrorUpload:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"stat",
                                    @"ctl",         @"videostat",
                                    @"act",         @"add",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Feedback:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"feedback",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Ad_Config:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"advertisementnew",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Ad_Combine:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"advertisementpin",
                                    @"act",         @"index",
                                    @"ad_url",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"video_url",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip1",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip2",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_UC_SMSMobile:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;

            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    /*  接口参数修改*/

                                    //下发短信接口加密key：poi345
                                    @"mod",         @"sso",
                                    @"ctl",         @"clientSendMsg",
                                    @"act",         @"index",
                                    @"mobile",      LT_REQUEST_URL_DYNAMIC_VALUE,
#ifndef LT_IPAD_CLIENT
                                    @"captchaValue",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"captchaId",   LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,

                                    //新加的参数
                                    @"plat",        @"mobile_tv",
                                    @"action",      @"reg",
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
#ifndef LT_IPAD_CLIENT
        case LTURLModule_UC_VertiCode:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"getCaptcha",
                                    @"act",         @"index",
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_PhoneNumRegistered:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"mobilecheck",
                                    @"act",         @"index",
                                    @"mobile",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
#endif
        case LTURLModule_UC_ChangeEmail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"sendBindEmail",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"email",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ChangeMobile:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"modifyMobile",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ChangePassword:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"sso",
                                    @"ctl",         @"modifyPwd",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_CheckEmailExists:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"checkEmailExists",
                                    @"email",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_CheckMobileExists:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"checkMobileExists",
                                    @"mobile",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_GenerateOrderID:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"getOrderId",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_Login:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"newLogin",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ThirdPartyLogin:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"thirdUserLogin",
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_Register:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            /* iPhone>=5.6 之后 ， 新给的注册接口
             http://dynamic.user.app.m.letv.com/android/dynamic.php?mod=sso&ctl=addUser&act=index&pcode={$pcode}&version={$version}
             所以要把参数改成下面的*/
            //#ifdef LT_MERGE_FROM_IPAD_CLIENT
            //             urlRequest.urlParams = [NSMutableArray arrayWithObjects:
            //             @"mod",         @"passport",
            //             @"ctl",         @"index",
            //             @"act",         @"addUser",
            //             @"gender",      @"0",
            //             @"registService",@"mapp",
            //             @"partnerUID",  LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
            //             @"pcode",       CURRENT_PCODE,
            //             @"version",     CURRENT_VERSION,
            //             nil];
            //#else
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod" ,        @"sso",
                                    @"ctl" ,        @"addUser",
                                    @"act" ,        @"index",
                                    @"pcode" ,      CURRENT_PCODE,
                                    @"version" ,    CURRENT_VERSION,
                                    nil];
            //#endif
        }
            break;
        case LTURLModule_UC_MovieAvaiable:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"getService",
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"end",         @"4",
                                    @"storepath",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_Pay:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"offline",
                                    @"deptno",      @"130",
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"commodity",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"price",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"merOrder",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"payType",     @"ledian",
                                    @"service",     @"consume",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_PayResult:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"getPayResult",
                                    @"merOrder",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_QueryLePoint:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"queryrecord",
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"query",       @"02",
                                    @"day",         @"0",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_QueryVIP:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"vip",
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"end",         @"4", // 只有ipad调用，默认传4
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UserInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"getUserByTk",
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UserInfoPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"protobuf",    @"1",
                                    @"act",         @"getUserByTk",
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UpdataNickName:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"updateuser/index?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:

                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"nickname",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;

        case LTURLModule_UC_LogoutImageCade:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"captcha?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_Consume:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"saleNew",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_ConsumePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"saleNew",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    //                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;

        case LTURLModule_UC_ConsumeAudit:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"saleNew",
                                    @"audit",       @"1",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_ConsumeAuditPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"saleNew",
                                    @"audit",       @"1",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"status",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;

        case LTURLModule_UC_DeviceUidVipInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"vipinfo",
                                    @"act",         @"index",
                                    @"end",         @"4",
                                    @"audit",       @"1",
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;

        case LTURLModule_UC_BindAccount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"synchronOrder",
                                    @"act",         @"index",
                                    @"viptype",     @"1",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"virid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uuid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_UC_GetDeviveUserInfo:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"payExtraGet",
                                    @"act",         @"index",
                                    @"viptype",     @"1",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_UC_LiveAmount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"liveAmount",
                                    @"act",         @"index",
                                    @"viptype",     @"1",
                                    @"tickettype",  @"1",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;

        case LTURLModule_UC_ChatHistory:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"chatGethistory",
                                    @"act",         @"index",
                                    @"roomId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"server",      @"true",
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_ChatHistoryPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"chatGethistory",
                                    @"act",         @"index",
                                    @"roomId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"server",      @"true",
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_ChatSendMessage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"chatSendmessage",
                                    @"act",         @"index",
                                    @"roomId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"message",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"color",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"font",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"position",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"forhost",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vtkey",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"from",        kDanmakuSourceArg,
                                    nil];
        }
            break;
        case LTURLModule_UC_ChatSendMessagePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"luamod",      @"main",
                                    @"mod",         @"mob",
                                    @"ctl",         @"chatSendmessage",
                                    @"act",         @"index",
                                    @"roomId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"message",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"color",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"font",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"position",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"forhost",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vtkey",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"from",        kDanmakuSourceArg,
                                    nil];
        }
            break;

        case LTURLModule_UC_Recharge:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"queryrecord",
                                    @"username",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"starttime",   LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"endtime",     LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"query",       @"00",
                                    @"day",         LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"deptid",      LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"productid",   LT_REQUEST_URL_DYNAMIC_VALUE_EMPTY,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_VERTIFY_TOKEN:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"clientCheckTicket",
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_GetAll:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        [LT_REQUEST_URL_DYNAMIC_VALUE isEqualToString:@""]?@"1":LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    @"20",
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"upgc",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_GetAllNew:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"getNew",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        [LT_REQUEST_URL_DYNAMIC_VALUE isEqualToString:@""]?@"1":LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"upgc",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
            
        }
            break;
        case LTURLModule_Cloud_GetAllPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        [LT_REQUEST_URL_DYNAMIC_VALUE isEqualToString:@""]?@"1":LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    @"20",
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_GetByPage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_GetFirst:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        @"1",
                                    @"pagesize",    @"1",
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_PageSize:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"get",
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        @"1",
                                    @"pagesize",    @"@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_SubmitSingle:
        {
            //TODO: ZhangQigang 增加 videoType 的字段上传 -- 服务器知道 video 的类型, 不需要上传.
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"add",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"nvid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vtype",       @"1",
                                    @"from",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"htime",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"longitude",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"upgc",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_SubmitMore:
        {
            //TODO: ZhangQigang 增加 videoType 字段上传 -- 服务器知道 video 的类型, 不需要上传.
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"import",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_Delete:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"del",
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"flush",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"idstr",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"backdata",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"upgc",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_GetPoint:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"getPoint",
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_Search:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"cloud",
                                    @"act",         @"search",
                                    @"pids",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vids",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_GetAllFavrite://获得追剧列表
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"follow",
                                    @"act",         @"list",
                                    @"page",        @"1",
                                    @"pagesize",    @"1000",
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_DeleteFavrite://删除追剧
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"follow",
                                    @"act",         @"delete",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Cloud_SubmitFavrite://添加追剧
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"follow",
                                    @"act",         @"add",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"iostoken",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"fromtype",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Cloud_SubmitFavriteMore://批量上传追剧收藏
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"follow",
                                    @"act",         @"dump",
                                    //                                    @"data",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_QRCode_Submit:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"submitQRCode",
                                    @"guid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Shake_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"shake",
                                    @"act",         @"add",
                                    @"aid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uuid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playtime",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vtype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"longitude",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Shake_Get:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"shake",
                                    @"act",         @"get",
                                    @"uuid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"longitude",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"latitude",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_Product:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"index",
                                    @"act",         @"product",
                                    @"device",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_OrderID:
        case LTURLModule_IAP_OrderID_Test:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"index",
                                    @"act",         @"newPay",
                                    @"ptype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"end",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"subend",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     @"3",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_OrderID_Test_Notlogin:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"index",
                                    @"act",         @"newPay",
                                    @"ptype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"end",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"subend",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uname",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     @"3",
                                    @"audit",       @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_IAP_HK_OrderID:
        case LTURLModule_IAP_HK_OrderID_Test:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",                  @"iappay",
                                    @"ctl",                  @"index",
                                    @"act",                  @"orderId",
                                    @"productid",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",                  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",                  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"price",                LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"itemamt",              LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_id",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_name",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_desc",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"merchant_business_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"currency",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"my_order_type",        @"SDK",
                                    @"pcode",                CURRENT_PCODE,
                                    @"version",              CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_HK_OrderID_Test_Notlogin:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",                  @"iappay",
                                    @"ctl",                  @"index",
                                    @"act",                  @"orderId",
                                    @"productid",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",                  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",                  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"price",                LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"itemamt",              LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_id",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_name",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_desc",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"merchant_business_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"currency",             LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"my_order_type",        @"SDK",
                                    @"pcode",                CURRENT_PCODE,
                                    @"version",              CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_IAP_ProductId:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"productList",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;
        case LTURLModule_IAP_ProductId_Pre:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"pay",
                                    @"ctl",         @"payPackagePre",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_LEB_Extra_Count:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLebPay;
            urlRequest.urlType = LTRequestURL_LebPay;
            urlRequest.urlHeadPath = @"vrcurrency/balance?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"bizId",       @"102",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_LEB_Package_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLebPay;
            urlRequest.urlType = LTRequestURL_LebPay;
            urlRequest.urlHeadPath = @"vrcurrency/package?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"busiId",       @"102",
                                    @"terminal",     @"1301",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_LEB_OrderID:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLebPay;
            urlRequest.urlType = LTRequestURL_LebPay;
            urlRequest.urlHeadPath = @"vrcurrency/recharge?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"bizId",       @"102",
                                    @"terminal",    @"1301",
                                    @"userId",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"itemNo",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vrCurrency",  @"1001",
                                    @"deviceId",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pay_version", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"service",    @"lepay.directpay.api.show.cashier",
                                    @"merchant_business_id",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"currency",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"product_id",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key_index",   @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_LEB_OrderDetail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLebPay;
            urlRequest.urlType = LTRequestURL_LebPay;
            urlRequest.urlHeadPath = @"vrcurrency/queryrechargedetailbyid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"bizId",       @"102",
                                    @"rechargeId",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_Receipt:
        case LTURLModule_IAP_Receipt_Test:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"iappay",
                                    @"ctl",         @"index",
                                    @"act",         @"offline",
                                    nil];
        }
            break;


        case LTURLModule_Share_PlayUrl:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",             @"linkshare",
                                    @"act",           @"index",
                                    @"pcode",     CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Recommend_APP:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",             @"exchange",
                                    @"act",           @"index",
                                    @"exchid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",    @"30",
                                    @"pcode",     CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Report_ASIdentifier:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"iosidfa",
                                    @"act",         @"index",
                                    @"idfa",        @"%@",
                                    @"key",         @"%@",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Get_TimeStamp:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"timestamp",
                                    @"act",         @"timestamp",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Get_Promotion_Info:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"spread",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_SendBackPwdEmail:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"passport",
                                    @"ctl",         @"index",
                                    @"act",         @"sendBackPwdEmail",
                                    @"email",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_SearchVoucher:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",          @"passport",
                                    @"ctl",          @"index",
                                    @"act",          @"queryServlet",
                                    @"uname",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",        CURRENT_PCODE,
                                    @"version",      CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UseVoucher:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"yuanxian/updTicket?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"name",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_VoucherList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"yuanxian/myTickets?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_CommendForVip:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",           @"passport",
                                    @"ctl",           @"index",
                                    @"act",           @"praiseactivity",
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"username",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sign",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_AppCheckin:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"checkin",
                                    @"act",           @"index",
                                    @"did",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sig",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_UC_AppCheckin_V56:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",           @"mob",
                                    @"ctl",           @"floatball",
                                    @"act",           @"index",
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_UC_AppCheckin_V56PB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",           @"mob",
                                    @"ctl",           @"floatball",
                                    @"act",           @"index",
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;
#endif
        case LTURLModule_UC_SSOLoginSina:
        {
            NSString * deviceModel=UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone?@"iphone":@"ipad";
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"appssosina",
                                    @"act",           @"index",
                                    @"access_token",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"equipType",     deviceModel,
                                    @"equipID",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"plat",          @"mobile_tv",
                                    @"softID",        CURRENT_VERSION,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"imei",          @"",
                                    @"mac",           [NSString safeString:[NSString macaddress]],
                                    @"openid",        LT_REQUEST_URL_DYNAMIC_VALUE,
#endif
                                    nil];
        }
            break;
        case LTURLModule_UC_SSOLoginQQ:
        {
            NSString * deviceModel=UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone?@"iphone":@"ipad";
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"appssoqq",
                                    @"act",           @"index",
                                    @"appkey",        [[LeTVAppModule sharedModule]letv_LTShareFrameWorkGetTencentAPPKey],
                                    @"access_token",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"openid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"plat",          @"mobile_tv",
                                    @"equipType",     deviceModel,
                                    @"equipID",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"softID",        CURRENT_VERSION,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"imei",          @"",
                                    @"mac",           [NSString safeString:[NSString macaddress]],
#endif
                                    nil];
        }
            break;

        case LTURLModule_UC_SSOLoginWX:
        {
            NSString * deviceModel=UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone?@"iphone":@"ipad";
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",        @"main",
                                    @"mod",           @"mob",
                                    @"ctl",           @"appssoweixin",
                                    @"act",           @"index",
                                    @"access_token",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"openid",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"plat",          @"mobile_tv",
                                    @"equipType",     deviceModel,
                                    @"equipID",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"softID",        CURRENT_VERSION,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"imei",          @"",
                                    @"mac",           [NSString safeString:[NSString macaddress]],
#endif
                                    nil];
        }
            break;


        case LTURLModule_UC_UnloginSystemMessage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/unlogin?";
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:@"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,nil];
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_UnloginSystemMessagePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/unlogin?";
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:@"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,nil];
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case LTURLModule_UC_loginSystemMessage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/loginsysmes?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"is_read",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_UC_singleMessage_read:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/readMessage?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"msg_id",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_UC_loginCommentMessage:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/loginreplymes?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"is_read",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
        }
            break;
        case LTURLModule_UC_loginCommentMessage_delete:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/deletemessage?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"id",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
        }
            break;
        case LTURLModule_UC_loginReplyedCommentMessage_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/index?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"type",@"video",
                                    @"source",@"Iphone",
                                    @"ctype",@"",
                                    @"rows",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"commentid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];

        }
            break;
        case LTURLModule_UC_startUnreadMessage:
        {
            /*
             platform	平台：1、PC端+移动端 2、PC端 3、移动端  支持多平台筛选 例如 platform=1,2,3	 	数值型	是
             from	来源，支持传多个值，  例如 2,3,4	 	整形	是
             sso_tk	用户登录后产生的token值	 	字符串	是	 header里接收
             pcode	产品代码	 	字符串	是	GET提交
             version	版本号
             */
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/unreadcount?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"platform",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
        }
            break;
        case LTURLModule_UC_startUnreadMessagePB:
        {
            /*
             platform	平台：1、PC端+移动端 2、PC端 3、移动端  支持多平台筛选 例如 platform=1,2,3	 	数值型	是
             from	来源，支持传多个值，  例如 2,3,4	 	整形	是
             sso_tk	用户登录后产生的token值	 	字符串	是	 header里接收
             pcode	产品代码	 	字符串	是	GET提交
             version	版本号
             */
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/unreadcount?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"platform",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case LTURLModule_UC_allMessage_read:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"listmessage/readall?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"from",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
        }
            break;
        case LTURLModule_Get_VIP_Video_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"channelindexvip",
                                    @"act",         @"index",
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"markid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Get_VIP_Privilege_Info:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"minfo",
                                    @"ctl",         @"vipproduct",
                                    @"act",         @"index",
                                    @"up",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"svip",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Comment_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rows",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;
        case  LTURLModule_Comment_ListPB:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/list?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rows",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;

        case LTURLModule_Comment_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/add?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"voteFlag",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"htime",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Comment_AddPB:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/add?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"voteFlag",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"htime",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ctype",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;
        case LTURLModule_Comment_Reply:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/reply?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"replyid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;
        case LTURLModule_Comment_ReplyPB:{
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/reply?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"xid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"replyid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"content",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;
        case LTURLModule_Comment_Reply_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/replylist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",         LT_REQUEST_URL_DYNAMIC_VALUE,      // 页数
                                    @"rows",        @"20",     // 每页的条数
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,  // 评论ID
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;
        case LTURLModule_Comment_Reply_ListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/replylist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"page",         LT_REQUEST_URL_DYNAMIC_VALUE,      // 页数
                                    @"rows",        @"20",     // 每页的条数
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,  // 评论ID
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case LTURLModule_Comment_Like:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/like?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"attr",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;
        case LTURLModule_Comment_LikePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/like?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"commentid",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"attr",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case  LTURLModule_Comment_VoteList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/votelist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case  LTURLModule_Comment_VoteListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/votelist?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;
        case LTURLModule_Comment_Vote:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"id",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Comment_VotePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"id",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
        }
            break;

        case LTURLModule_Comment_Number:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/commnum?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,nil];

        }
            break;
        case LTURLModule_Comment_NumberPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"comment/commnum?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];

        }
            break;

        case LTURLModule_Integretion_Rules:
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"credit",
                                    @"act",@"getactioninfo",
                                    @"action", @"sharevideo,video,startmapp",
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];
            break;
        case LTURLModule_Integretion_Task:// 此接口暂时弃用
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"credit",
                                    @"act",@"check",
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];

            break;
        case LTURLModule_Integretion_Action:
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"credit",
                                    @"act",@"add",
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"desc",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"action",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,nil];

            break;
        case LTURLModule_Top_Game_Data:

            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType  = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"topmatches",
                                    @"act",@"index",
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
            break;

        case LTURLModule_Hot_PraiseOrDown:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"hotpoint/addupdown?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"did",     [DeviceManager getDeviceUUID],
                                    @"vid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"act",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    nil];
            break;

        case LTURLModule_Hot_Praise_Count:
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType  = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"vote",
                                    @"act",@"num",
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    @"id",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
            break;

        case LTScoreRecord:
            urlRequest.urlDomainType = LTRequestURLDomainTypeUser;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"credit",
                                    @"act",@"getActionProgress",
                                    @"action", @"sharevideo,video,startmapp",
                                    @"count",@"1",
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];

            break;


            //我的页面焦点图,版块ID: 1480
        case LTURLModule_My_FocusView:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType  = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"block",
                                    @"act",@"index",
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                    @"id",LT_REQUEST_URL_DYNAMIC_VALUE,
#else
                                    @"id",@"1480",
#endif
                                    nil];
            break;
        case LTURLModule_Album_VideoList_ByDate:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"videolistbydate",
                                    @"act",         @"detail",
                                    @"id",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"year",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"month",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"videoType",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Get_WaterMark:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"waterMark",
                                    @"act",@"index",
                                    @"cid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"liveid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
        }
            break;

        case LTURLModule_Fav_Add:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/add?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"play_id",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"video_id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_type", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from_type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];
        }
            break;

        case LTURLModule_Fav_Delete:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/delete?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"play_id",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"video_id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_type", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];

        }
            break;

        case LTURLModule_Fav_MultiDelete:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/multidelete?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"flush",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_id",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];

        }
            break;

        case LTURLModule_Fav_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/listfavorite?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"category",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_type",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"from_type",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"page",            LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pagesize",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",           [DeviceManager getDeviceUUID],
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    @"source",          kSourceArg,
                                    nil];

        }
            break;

        case LTURLModule_Fav_IsFav:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/isfavorite?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"play_id",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"video_id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"favorite_type",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",           [DeviceManager getDeviceUUID],
                                    @"pcode",           CURRENT_PCODE,
                                    @"version",         CURRENT_VERSION,
                                    @"source",          kSourceArg,
                                    nil];

        }
            break;

        case LTURLModule_Fav_Dump://Post
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"favorite/dump?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"devid",       [DeviceManager getDeviceUUID],
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"source",      kSourceArg,
                                    nil];

        }
            break;
        case LTURLModule_Shot_TextShare_Get:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"sharewords",
                                    @"act",          @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_STAR_Video_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:

                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"id" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_STAR_Video_ListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",        @"1",
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"id" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Star_HalfPlayList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/star?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:

                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Shot_Icons_CMS:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"shareimg?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:

                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"uid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Shot_Icons_CMSPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"shareimg?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",        @"1",
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"uid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_STAR_VOTE:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"device_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version",   CURRENT_VERSION,
                                    @"pcode",     CURRENT_PCODE,
                                    nil];
        }
            break;
        case LTURLModule_STAR_VOTEPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",        @"1",
                                    @"id",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"device_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"num",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version",   CURRENT_VERSION,
                                    @"pcode",     CURRENT_PCODE,
                                    nil];
        }
            break;

        case LTURLModule_Star_History_List:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star/starranking?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"nums" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"starttime" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Star_History_ListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star/starranking?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",        @"1",
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"nums" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"starttime" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Star_Ranklist:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star/starrank?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"id" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"n" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_Star_RanklistPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"star/starrank?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",        @"1",
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"id" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"n" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_RedPacket_StaringUp:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/package?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"userid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_RedPacket_PaySuccess:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/order?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userType",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"orderId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;

        case LTURLModule_RedPacket_PaySucCallBack:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/callback?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"orderId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;

        case LTURLModule_RedPacket_Position:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/position?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        case LTURLModule_LiveHall_SearchByDate:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"date",LT_REQUEST_URL_DYNAMIC_VALUE
                                    ,nil];
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channel",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        nil];
            break;
        case LTURLModule_LiveHall_GetCurrentInfo:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams =  nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channel",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        nil];
            break;
        case LTURLModule_LiveHall_GetIncremental:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams =  [NSMutableArray arrayWithObjects:
                                     @"id",LT_REQUEST_URL_DYNAMIC_VALUE
                                     ,nil];
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channel",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        nil];
            break;
        case LTURLModule_Live_GetLiveChannel:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams =  nil;

            break;
        case LTURLModule_Live_GetLiveChannelByThirdParty:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams =  [NSMutableArray arrayWithObjects:
                                     @"signal",LT_REQUEST_URL_DYNAMIC_VALUE,
                                     @"withTest",LT_REQUEST_URL_DYNAMIC_VALUE
                                     ,nil];
            break;
        case LTURLModule_Live_GetChannelStream:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE
                                        ,nil];
            break;
        case LTURLModule_Live_GetSnapShot:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE
                                        ,nil];
            break;
        case LTURLModule_Live_GetCurrentBillList1:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"channelIds",LT_REQUEST_URL_DYNAMIC_VALUE
                                    ,nil];
            break;
        case LTURLModule_Live_GetCurrentDayBillList:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE
                                        ,nil];
            break;
        case LTURLModule_Live_GetBillListIncremental:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"direction",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        @"programId",LT_REQUEST_URL_DYNAMIC_VALUE
                                        ,nil];

            break;
        case LTURLModule_Live_GetBillListPlayingInfo:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            urlRequest.urlHeadParams = [NSMutableArray arrayWithObjects:
                                        @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                        nil];
            break;
        case LTURLModule_Live_GetCurrentBillList2:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"channelIds",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
            urlRequest.urlHeadParams = nil;
            break;
        case LTURLModule_Live_Livehall_GetPlayerInfo:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            break;
        case LTURLModule_Live_Livehall_sortHotLives:
            urlRequest.urlDomainType = LTRequestURLDomainTypeLiveNew;
            urlRequest.urlType  = LTRequestURL_LiveNew;
            urlRequest.urlParams = nil;
            break;

#endif
        case LTURLModule_Danmaku_Get:
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"danmu_list",
                                    @"act",@"index",
                                    @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"amount", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
            break;
        case LTURLModule_Danmaku_GetPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"danmu_list",
                                    @"act",@"index",
                                    @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"amount", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    nil];
            break;
        case LTURLModule_Danmaku_Send:
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"danmu_add",
                                    @"act",@"index",
                                    @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"txt", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"color",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"x",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"y",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"font",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"position",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    @"from",kDanmakuSourceArg,
                                    nil];
            break;
        case LTURLModule_RedPacket_StaringUpPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/package?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"userid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_RedPacket_PaySuccessPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/order?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"userType",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"orderId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;
        case LTURLModule_RedPacket_PaySucCallBackPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"redpackage/callback?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"uid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channelId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"orderId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",   CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid" , LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];

        }
            break;
        case LTURLModule_Danmaku_SendPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"luamod",@"main",
                                    @"mod",@"mob",
                                    @"ctl",@"danmu_add",
                                    @"act",@"index",
                                    @"vid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"key",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"start",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"txt", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"color",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"x",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"y",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"font",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"position",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"sso_tk",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",CURRENT_PCODE,
                                    @"version",CURRENT_VERSION,
                                    @"from",kDanmakuSourceArg,
                                    nil];
            break;
        case LTURLModule_Danmaku_IsDanmaku:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/isDanmaku?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;
        case LTURLModule_Danmaku_IsDanmakuPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/isDanmaku?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;

        case LTURLModule_HotPatch:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"iphonehotpatch",
                                    @"act", @"index",
                                    @"patchNo", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;
        case LTURLModule_HotPatchPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",@"1",
                                    @"mod", @"mob",
                                    @"ctl", @"iphonehotpatch",
                                    @"act", @"index",
                                    @"patchNo", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;

        case LTURLModule_PageCard:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"pagecard",
                                    @"act", @"index",
                                    @"pcversion", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION, nil];
            break;
        case LTURLModule_LoadingPoster:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"tm", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tss", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"pid", LT_REQUEST_URL_DYNAMIC_VALUE, nil];
            break;
        case LTURLModule_LiveVoteList:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/livevotevid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,nil];

            break;
        case LTURLModule_Votelist:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/votebyid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type", LT_REQUEST_URL_DYNAMIC_VALUE,nil];
            break;
        case LTURLModule_VotelistPB:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/votebyid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type", LT_REQUEST_URL_DYNAMIC_VALUE,nil];
            break;
        case LTURLModule_Vote:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"version", CURRENT_VERSION,
                                    @"id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,nil];
            break;
        case LTURLModule_FullScreenVoteList:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/votebyid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"type", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
            break;
        case LTURLModule_GetLivingOnlineNum:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"live/livenum?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"group", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetLiveShoppingProduct:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"buybystreamid",
                                    @"streamId", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_liveAddProductToCart:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"addinbuycart",
                                    @"purType", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pids", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"user_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"streamId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rs", @"2102",
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetLiveShoppingCartCount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"getbuycartnum",
                                    @"user_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetProductAttentionCount:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"totalcount",
                                    @"streamId", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"startingtime", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"duration", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_Live_GetAllOrderData:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"luamod",      @"main",
                                    @"mod",         @"live",
                                    @"ctl",         @"getAllBookChannel",
                                    @"act",         @"index",
                                    @"clientId",    [self liveClientId],
                                    @"action",      @"book",
                                    @"ch",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    @"belongArea",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    nil];
        }
            break;
        case LTURLModule_VideoPraiseOrStep:
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play/updown?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"act", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid", [NSString safeString:[SettingManager alreadyLoginUserID]],
                                    @"did", [DeviceManager getDeviceUUID],nil];
            break;

        case LTURLModule_IsBadWord:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"badword/index?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"word",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,
                                    nil];
        }
            break;
        case LTURLModule_GetClientIP:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"ip",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
            break;
        }
        case LTURLModule_Comment_AllKeyboardList:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"emoji?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"devid", [DeviceManager getDeviceUUID],
                                    @"protobuf",    @"1",
                                    nil];
            break;
        }
        case LTURLModule_GetCoreSpotlightData:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"corespotlight",
                                    @"act",@"index",
                                    @"pcode",@"010110000",
                                    @"version", CURRENT_VERSION,
                                    nil];
            break;
        }
        case LTURLModule_GetCoreSpotlightDataPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",@"mob",
                                    @"ctl",@"corespotlight",
                                    @"act",@"index",
                                    @"pcode",@"010110000",
                                    @"version", CURRENT_VERSION,
                                    @"protobuf",    @"1",
                                    nil];
            break;
        }
        case LTURLModule_FindTopicPB:
        {
            //LT_REQUEST_URL_STATIC_HEAD_MEIZI
            urlRequest.urlDomainType = LTRequestURLDomainTypeMeizi;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"discover",
                                    @"act",         @"index",
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;


        case LTURLModule_Live_SeverTimePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeLive;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"mod",         @"mob",
                                    @"ctl",         @"booklive",
                                    @"act",         @"getDate",
                                    @"protobuf",    @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Video_VF_And_AdvertisePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"play?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"tss",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"playid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tm",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",       LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"uid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"cid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"zid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rate",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"jailbreak",   LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"AD_IPDX",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"adParameter",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"adPath",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"vastTag",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"internalName",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_GetLiveShoppingProductPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"buybystreamid",
                                    @"streamId", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetLiveShoppingCartCountPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"getbuycartnum",
                                    @"user_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_liveAddProductToCartPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeRecommend;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"addinbuycart",
                                    @"purType", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pids", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"user_id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"streamId",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"rs", @"2012",
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_GetProductAttentionCountPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"totalcount",
                                    @"streamId", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"startingtime", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"duration", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_BuyingOrderPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"appointment",
                                    @"RUSH_ID", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"MOBILE",LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"isStock",@"0",
                                    @"needRemindInfo",@"1",
                                    @"cpsid", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,
                                    nil];
        }
            break;
        case LTURLModule_BuyingCheckIsOrderedPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"mod", @"mob",
                                    @"ctl", @"live",
                                    @"act", @"getRushInfo",
                                    @"needRemindInfo", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"isStock",@"0",
                                    @"rushIds", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_LiveVoteListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/livevotevid?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"pcode", CURRENT_PCODE,
                                    @"version", CURRENT_VERSION,
                                    @"vid", LT_REQUEST_URL_DYNAMIC_VALUE,nil];
        }
            break;
        case LTURLModule_VotePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"vote/vote?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"version", CURRENT_VERSION,
                                    @"id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"ip", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;

        case LTURLModule_MyNewPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
            urlRequest.urlHeadPath = @"profilepad/index?",
#else
            urlRequest.urlHeadPath = @"profile/index?",
#endif
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_UC_VoucherListPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNoCare;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"yuanxian/myTickets?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",      @"1",
                                    @"uid",           LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"devid",         LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",         CURRENT_PCODE,
                                    @"version",       CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_IAP_ProductIdPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"iappay",
                                    @"ctl",         @"productList",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }

            break;

        case LTURLModule_Live_UseTicketPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"pay",
                                    @"ctl",         @"liveuseticket",
                                    @"act",         @"index",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"tickettype",  LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];

        }
            break;
        case LTURLModule_Live_TicketInfoPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"pay",
                                    @"ctl",         @"livegetticket",
                                    @"act",         @"index",
                                    @"userid",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"channel",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"category",    LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"season",      LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"turn",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"game",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"apisign",     LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_GetLivingOnlineNumPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_PlayCombine;
            urlRequest.urlHeadPath = @"live/livenum?";
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf", @"1",
                                    @"group", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"id", LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"version", CURRENT_VERSION,
                                    @"pcode", CURRENT_PCODE,nil];
        }
            break;
        case LTURLModule_IAP_ProductId_PrePB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypePay;
            urlRequest.urlType = LTRequestURL_Dynamic;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"pay",
                                    @"ctl",         @"payPackagePre",
                                    @"act",         @"index",
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        case LTURLModule_Get_VIP_Privilege_InfoPB:
        {
            urlRequest.urlDomainType = LTRequestURLDomainTypeNormal;
            urlRequest.urlType = LTRequestURL_Static;
            urlRequest.urlParams = [NSMutableArray arrayWithObjects:
                                    @"protobuf",    @"1",
                                    @"mod",         @"minfo",
                                    @"ctl",         @"vipproduct",
                                    @"act",         @"index",
                                    @"up",          LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"svip",        LT_REQUEST_URL_DYNAMIC_VALUE,
                                    @"pcode",       CURRENT_PCODE,
                                    @"version",     CURRENT_VERSION,
                                    nil];
        }
            break;
        default:
            break;
    }

    if (urlModule != LTURLMOdule_Video_UrlParse ) {
        if ([urlRequest.urlParams isKindOfClass:[NSMutableArray class]]) {

            if (urlModule == LTURLModule_Channel_Album ||urlModule == LTURLModule_Channel_Album_PB
                ||urlModule ==  LTURLModule_Channel_Video_PB || urlModule ==  LTURLModule_Channel_Video) {

                //为所有的接口添加地域标识
                NSDictionary *geocoders = [SettingManager getLocationGeocoder];
                if(![urlRequest.urlParams containsObject:@"country"]) {
                    NSArray *country = [NSArray arrayWithObjects:@"country",
                                        [NSString safeString:geocoders[@"country"] ], nil];
                    [urlRequest.urlParams addObjectsFromArray:country];
                }

                if(![urlRequest.urlParams containsObject:@"provinceid"]) {
                    NSArray *provinceid = [NSArray arrayWithObjects:@"provinceid", [NSString safeString:geocoders[@"provinceid"] ], nil];
                    [urlRequest.urlParams addObjectsFromArray:provinceid];
                }
                if(![urlRequest.urlParams containsObject:@"districtid"]) {
                    NSArray *districtid = [NSArray arrayWithObjects:@"districtid", [NSString safeString:geocoders[@"districtid"] ], nil];
                    [urlRequest.urlParams addObjectsFromArray:districtid];
                }
                if(![urlRequest.urlParams containsObject:@"citylevel"]) {
                    NSArray *citylevel = [NSArray arrayWithObjects:@"citylevel", [NSString safeString:geocoders[@"citylevel"] ], nil];
                    [urlRequest.urlParams addObjectsFromArray:citylevel];
                }
                if(![urlRequest.urlParams containsObject:@"location"]) {
                    NSArray *location = [NSArray arrayWithObjects:@"location",
                                         [NSString safeString:geocoders[@"location"] ], nil];
                    [urlRequest.urlParams addObjectsFromArray:location];
                }
            }

            NSArray *lang = [NSArray arrayWithObjects:@"lang", [NSString getPreferredLanguage], nil];
            [urlRequest.urlParams addObjectsFromArray:lang];

            NSString *region = [SettingManager getLocationCountryCode];
            if ([NSString isBlankString:region]) {
                region = @"CN";
            }
            NSArray *regions = [NSArray arrayWithObjects:@"region", region, nil];
            [urlRequest.urlParams addObjectsFromArray:regions];

        }
    }

    return urlRequest;
}

+ (NSString *)getUrlHeadByUrlModule:(LTURLModule)urlModule
{
    LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];

    LTRequestURLType urlType = urlInfo.urlType;
    LTRequestURLDomainType urlDomainType = urlInfo.urlDomainType;
    NSString *urlHead = @"";

    BOOL bSettingTest = [SettingManager isTestApi];

    BOOL bForced2Test = (LTURLModule_IAP_Receipt_Test == urlModule);
    BOOL bForced2Product = (LTURLModule_ApiStatus == urlModule);

#ifdef DEBUG
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kTestAPIKey]) {
        BOOL isTestApi = [[NSUserDefaults standardUserDefaults] boolForKey:kTestAPIKey];
        
        if (isTestApi) {
            bForced2Product = NO;
        }
    }
#endif

    BOOL bUseTestAPI = ((bSettingTest && !bForced2Product)|| bForced2Test

                        );

    if (bUseTestAPI) {

        urlHead = LT_REQUEST_URL_TEST_HEAD;

#if DEBUG
        // 如果是DEBUG模式，并且用户是香港，则使用香港的测试环境
        if ([SettingManager isHK]) {
            urlHead = LT_REQUEST_URL_HK_TEST_HEAD;
        }
#endif

        //#ifndef LT_MERGE_FROM_IPAD_CLIENT             //ipad 也需要直播新接口
        if (urlType ==LTRequestURL_LiveNew) {
            urlHead = LT_REQUEST_URL_LIVE_NEW_HEAD;
        }
        //#endif
        else if (urlType == LTRequestURL_PlayCombine) {
            urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD_TEST;

#if DEBUG
            if ([SettingManager isHK]) {
                urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD_HK_TEST;
            }
#endif
        }
        else if (urlType == LTRequestURL_LebPay) {
            urlHead = LT_REQUEST_URL_LB_TEST_HEAD;
        }
    }
    else{
        switch (urlType) {
            case LTRequestURL_Dynamic:
            {
                switch (urlDomainType) {
                    case LTRequestURLDomainTypeSearch:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_SEARCH;
                        break;
                    case LTRequestURLDomainTypeMeizi:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_MEIZI;
                        break;
                    case LTRequestURLDomainTypePay:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_PAY;
                        break;
                    case LTRequestURLDomainTypeUser:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_USER;
                        break;
                    case LTRequestURLDomainTypeRecommend:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_RECOMMEND;
                        break;
                    case LTRequestURLDomainTypeLive:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD_LIVE;
                        break;
                    case LTRequestURLDomainTypeNormal:
                    default:
                        urlHead = LT_REQUEST_URL_DYNAMIC_HEAD;
                        break;
                }
            }
                break;
            case LTRequestURL_Static:
            {
                switch (urlDomainType) {
                    case LTRequestURLDomainTypeSearch:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_SEARCH;
                        break;
                    case LTRequestURLDomainTypeMeizi:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_MEIZI;
                        break;
                    case LTRequestURLDomainTypePay:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_PAY;
                        break;
                    case LTRequestURLDomainTypeUser:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_USER;
                        break;
                    case LTRequestURLDomainTypeRecommend:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_RECOMMEND;
                        break;
                    case LTRequestURLDomainTypeLive:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD_LIVE;
                        break;
                    case LTRequestURLDomainTypeNormal:
                    default:
                        urlHead = LT_REQUEST_URL_STATIC_HEAD;
                        break;
                }
            }
                break;
                //#ifndef LT_MERGE_FROM_IPAD_CLIENT
            case LTRequestURL_LiveNew:
            {
                urlHead = LT_REQUEST_URL_LIVE_NEW_HEAD;
            }
                break;
                //#endif

            case LTRequestURL_LebPay:
            {
                urlHead = LT_REQUEST_URL_LB_HEAD;
            }
                break;
            case LTRequestURL_PlayCombine:
            {
                urlHead = LT_REQUEST_URL_PLAY_COMBINE_HEAD;
                break;
            }
            default:
                break;
        }
    }

    return urlHead;

}

+ (NSString *)formatRequestURL:(LTRequestURLInfo *)urlInfo
                  andUrlModule:(LTURLModule)urlModule
              andDynamicValues:(NSArray *)arrayDynamicValues
{
    return [LTRequestURLManager formatRequestURL:urlInfo
                                    andUrlModule:urlModule
                                andDynamicValues:arrayDynamicValues
                                andUrlHeadValues:nil];

}

+ (NSString *)formatRequestURL:(LTRequestURLInfo *)urlInfo
                  andUrlModule:(LTURLModule)urlModule
              andDynamicValues:(NSArray *)arrayDynamicValues
              andUrlHeadValues:(NSArray *)arrayUrlHeadValues
{

    LTRequestURLType urlType = urlInfo.urlType;
    NSString *urlHead = @"";

    NSMutableArray *dynamicValuesArray = [NSMutableArray arrayWithArray:arrayDynamicValues];

    switch (urlType) {
        case LTRequestURL_Dynamic:
        case LTRequestURL_Static:
        case LTRequestURL_LiveNew:
        case LTRequestURL_PlayCombine:
        case LTRequestURL_LebPay:
        {
            urlHead = [self getUrlHeadByUrlModule:urlModule];
        }
            break;
        case LTRequestURL_Parse:
        {
            urlHead = [NSString stringWithFormat:@"%@&", dynamicValuesArray[0]];
            [dynamicValuesArray removeObjectAtIndex:0];
        }
            break;
        default:
            break;
    }

    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
                                                   andDynamicValues:dynamicValuesArray
                                                   andUrlHeadValues:arrayUrlHeadValues];


    return [NSString stringWithFormat:
            @"%@%@",
            urlHead,
            urlPath];

}

+ (NSString *)formatRequestURLByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues
{
    LTRequestURLInfo *requestInfo = [LTRequestURLManager getURLInfoByType:urlModule];


    return [LTRequestURLManager formatRequestURL:requestInfo
                                    andUrlModule:urlModule
                                andDynamicValues:arrayDynamicValues];

}

+ (NSString *)formatRequestURLByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues
                      andUrlHeadValues:(NSArray *)arrayUrlHeadValues
{
    LTRequestURLInfo *requestInfo = [LTRequestURLManager getURLInfoByType:urlModule];


    return [LTRequestURLManager formatRequestURL:requestInfo
                                    andUrlModule:urlModule
                                andDynamicValues:arrayDynamicValues
                                andUrlHeadValues:arrayUrlHeadValues];
}

+ (LTURLModule)getUrlModuleByUrl:(NSString *)urlString
{
    for (LTURLModule urlModule = LTURLModule_Begin; urlModule < LTURLModule_End; urlModule++) {

        NSString * urlHead = [self getUrlHeadByUrlModule:urlModule];

        if (![urlString hasPrefix:urlHead]) {
            continue;
        }

        LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];
        NSMutableArray *arrayParam = urlInfo.urlParams;

        NSString *KeyValueJoinedString = @"";

        switch (urlInfo.urlType) {
            case LTRequestURL_Dynamic:
            case LTRequestURL_Parse:
            case LTRequestURL_LiveNew:
            case LTRequestURL_PlayCombine:
            case LTRequestURL_LebPay:
            {
                KeyValueJoinedString = @"=";
            }
                break;
            case LTRequestURL_Static:
            {
                KeyValueJoinedString = @"/";
            }
                break;
            default:
                break;
        }

        BOOL isMatched = YES;
        NSInteger countParam = [arrayParam count];
        if (countParam < 2) {
            isMatched = NO;
        }
        for (int i = 0; i+1 < countParam; i+=2) {
            NSString *key = arrayParam[i];
            NSString *value = arrayParam[i+1];
            if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
                continue;
            }
            if ([NSString isBlankString:value]) {
                continue;
            }
            if ([NSString isBlankString:key]) {
                KeyValueJoinedString =@"";
            }
            NSString *currKeyValuePair = [NSString stringWithFormat:
                                          @"%@%@%@",
                                          key,
                                          KeyValueJoinedString,
                                          value];

            if ([urlString rangeOfString:currKeyValuePair].length <= 0) {
                isMatched = NO;
                break;
            }
        }

        if (isMatched) {
            return urlModule;
        }
    }

    return LTURLModule_Unknown;
}

+ (LTURLModule)getUrlModuleByUrl:(NSString *)urlString
                       fromIndex:(NSInteger)fromIndex
                         toIndex:(NSInteger)toIndex
{
    for (LTURLModule urlModule = fromIndex; urlModule < toIndex; urlModule++) {

        NSString * urlHead = [self getUrlHeadByUrlModule:urlModule];

        if (![urlString hasPrefix:urlHead]) {
            continue;
        }

        LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];
        NSMutableArray *arrayParam = urlInfo.urlParams;

        NSString *KeyValueJoinedString = @"";

        switch (urlInfo.urlType) {
            case LTRequestURL_Dynamic:
            case LTRequestURL_Parse:
            case LTRequestURL_PlayCombine:
            {
                KeyValueJoinedString = @"=";
            }
                break;
            case LTRequestURL_Static:
            {
                KeyValueJoinedString = @"/";
            }
                break;
            default:
                break;
        }

        BOOL isMatched = YES;
        NSInteger countParam = [arrayParam count];
        if (countParam < 2) {
            isMatched = NO;
        }
        for (int i = 0; i+1 < countParam; i+=2) {
            NSString *key = arrayParam[i];
            NSString *value = arrayParam[i+1];
            if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
                continue;
            }
            if ([NSString isBlankString:value]) {
                continue;
            }
            if ([NSString isBlankString:key]) {
                KeyValueJoinedString =@"";
            }
            NSString *currKeyValuePair = [NSString stringWithFormat:
                                          @"%@%@%@",
                                          key,
                                          KeyValueJoinedString,
                                          value];

            if ([urlString rangeOfString:currKeyValuePair].length <= 0) {
                isMatched = NO;
                break;
            }
        }

        if (isMatched) {
            return urlModule;
        }
    }

    return LTURLModule_Unknown;
}

+ (LTRequestURLType)getRequestURLTypeByModule:(LTURLModule)urlModule
{
    LTRequestURLInfo *requestInfo = [LTRequestURLManager getURLInfoByType:urlModule];
    return requestInfo.urlType;
}

+ (LTRequestURLDomainType)getRequestURLDomainTypeByModule:(LTURLModule)urlModule
{
    LTRequestURLInfo *requestInfo = [LTRequestURLManager getURLInfoByType:urlModule];
    return requestInfo.urlDomainType;
}

+ (NSString *)getRequestPathByModule:(LTURLModule)urlModule
                    andDynamicValues:(NSArray *)arrayDynamicValues
{
    LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];

    LTRequestURLType urlType = urlInfo.urlType;
    NSMutableArray *arrayParam = urlInfo.urlParams;
    NSMutableArray *dynamicValuesArray = [NSMutableArray arrayWithArray:arrayDynamicValues];

    NSString *KeyValueJoinedString = @"";
    NSString *componentsJoinedString = @"";
    NSString *urlTail = @"";
    NSString *urlHead = @"";

    switch (urlType) {
        case LTRequestURL_Dynamic:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = @"dynamic.php?";
            urlTail = LT_REQUEST_URL_DYNAMIC_TAIL;
        }
            break;
        case LTRequestURL_Static:
        {
            KeyValueJoinedString = @"/";
            componentsJoinedString = @"/";
            urlTail = LT_REQUEST_URL_STATIC_TAIL;
        }
            break;
        case LTRequestURL_Parse:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
        }
            break;
        case LTRequestURL_LiveNew:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [LTRequestURLManager getLiveNewHeaderByModule:urlModule andDynamicValues:dynamicValuesArray];
            urlTail = LT_REQUEST_URL_DYNAMIC_TAIL;
        }
            break;
        case LTRequestURL_PlayCombine:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [NSString safeString:urlInfo.urlHeadPath];
            urlTail = LT_REQUEST_URL_PLAY_COMBINE_TAIL;
        }
            break;
        default:
            break;
    }

    NSInteger countParam = [arrayParam count];
    NSInteger countDynamicParam = [dynamicValuesArray count];
    NSMutableArray *arrayKeyValues = [NSMutableArray array];

    NSInteger valuePos = 0;
    for (int i = 0; i+1 < countParam; i+=2) {
        NSString *key = arrayParam[i];
        NSString *value = arrayParam[i+1];
        if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
            if (valuePos >= countDynamicParam) {
                NSLog(@"LTRequestURLManager, param num error");
                continue;
            }
            NSString *strValue = dynamicValuesArray[valuePos];
            valuePos ++;
            if ([NSString isBlankString:strValue]) {
                continue;
            }
            value = [NSString stringWithFormat:
                     LT_REQUEST_URL_DYNAMIC_VALUE,
                     strValue];
        }
        if ([NSString isBlankString:value]) {
            continue;
        }
        NSString *newKeyValueJoinedString =KeyValueJoinedString;
        if ([NSString isBlankString:key]) {
            newKeyValueJoinedString =@"";
        }

        [arrayKeyValues addObject:[NSString stringWithFormat:
                                   @"%@%@%@",
                                   key,
                                   newKeyValueJoinedString,
                                   value]];
    }

    NSString *formatUrlParams = [arrayKeyValues componentsJoinedByString:componentsJoinedString];

    return [NSString stringWithFormat:
            @"%@%@%@",
            urlHead,
            formatUrlParams,
            urlTail];
}

+ (NSString *)getRequestPathByModule:(LTURLModule)urlModule
                    andDynamicValues:(NSArray *)arrayDynamicValues
                    andUrlHeadValues:(NSArray *)arrayUrlHeadValues

{
    LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];

    LTRequestURLType urlType = urlInfo.urlType;
    NSMutableArray *arrayParam = urlInfo.urlParams;
    NSMutableArray *dynamicValuesArray = [NSMutableArray arrayWithArray:arrayDynamicValues];
    NSMutableArray *urlHeadValuesArray = [NSMutableArray arrayWithArray:arrayUrlHeadValues];

    NSString *KeyValueJoinedString = @"";
    NSString *componentsJoinedString = @"";
    NSString *urlTail = @"";
    NSString *urlHead = @"";

    switch (urlType) {
        case LTRequestURL_Dynamic:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = @"dynamic.php?";
            urlTail = LT_REQUEST_URL_DYNAMIC_TAIL;
        }
            break;
        case LTRequestURL_Static:
        {
            KeyValueJoinedString = @"/";
            componentsJoinedString = @"/";
            urlTail = LT_REQUEST_URL_STATIC_TAIL;
        }
            break;
        case LTRequestURL_Parse:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
        }
            break;
        case LTRequestURL_LiveNew:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [LTRequestURLManager getLiveNewHeaderByModule:urlModule andDynamicValues:urlHeadValuesArray];
            urlTail = LT_REQUEST_URL_DYNAMIC_TAIL;
        }
            break;

        case LTRequestURL_PlayCombine:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [NSString safeString:urlInfo.urlHeadPath];
            urlTail = LT_REQUEST_URL_PLAY_COMBINE_TAIL;
        }
            break;
        case LTRequestURL_LebPay:
        {
            KeyValueJoinedString = @"=";
            componentsJoinedString = @"&";
            urlHead = [NSString safeString:urlInfo.urlHeadPath];
            urlTail = LT_REQUEST_URL_PLAY_COMBINE_TAIL;
        }
            break;
        default:
            break;
    }

    NSInteger countParam = [arrayParam count];
    NSInteger countDynamicParam = [dynamicValuesArray count];
    NSMutableArray *arrayKeyValues = [NSMutableArray array];

    NSInteger valuePos = 0;
    for (int i = 0; i+1 < countParam; i+=2) {
        NSString *key = arrayParam[i];
        NSString *value = arrayParam[i+1];
        if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
            if (valuePos >= countDynamicParam) {
                NSLog(@"LTRequestURLManager, param num error");
                continue;
            }
            NSString *strValue = dynamicValuesArray[valuePos];
            valuePos ++;
            if ([NSString isBlankString:strValue]) {
                continue;
            }
            value = [NSString stringWithFormat:
                     LT_REQUEST_URL_DYNAMIC_VALUE,
                     strValue];
        }
        if ([NSString isBlankString:value]) {
            continue;
        }
        NSString *newKeyValueJoinedString =KeyValueJoinedString;
        if ([NSString isBlankString:key]) {
            newKeyValueJoinedString =@"";
        }

        [arrayKeyValues addObject:[NSString stringWithFormat:
                                   @"%@%@%@",
                                   key,
                                   newKeyValueJoinedString,
                                   value]];
    }

    NSString *formatUrlParams = [arrayKeyValues componentsJoinedByString:componentsJoinedString];

    return [NSString stringWithFormat:
            @"%@%@%@",
            urlHead,
            formatUrlParams,
            urlTail];

}

+ (NSString *)getLiveNewHeaderByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues
{
    LTRequestURLInfo *urlInfo = [LTRequestURLManager getURLInfoByType:urlModule];
    NSMutableArray *arrayUrlHeadParam = urlInfo.urlHeadParams;
    NSMutableArray *urlHeadValuesArray = [NSMutableArray arrayWithArray:arrayDynamicValues];

    NSInteger countParam = [arrayUrlHeadParam count];
    NSInteger countDynamicParam = [urlHeadValuesArray count];


    NSInteger valuePos = 0;
    for (int i = 0; i+1 < countParam; i+=2) {
        //        NSString *key = arrayUrlHeadParam[i];
        NSString *value = arrayUrlHeadParam[i+1];
        if ([value isEqualToString:LT_REQUEST_URL_DYNAMIC_VALUE]) {
            if (valuePos >= countDynamicParam) {
                NSLog(@"LTRequestURLManager, param num error");
                continue;
            }
            NSString *strValue = urlHeadValuesArray[valuePos];
            valuePos ++;
            if ([NSString isBlankString:strValue]) {
                continue;
            }
            value = [NSString stringWithFormat:
                     LT_REQUEST_URL_DYNAMIC_VALUE,
                     strValue];
        }
        if ([NSString isBlankString:value]) {
            continue;
        }

        arrayUrlHeadParam[i+1] =value;
    }

    switch (urlModule) {
        case LTURLModule_LiveHall_SearchByDate:
        {
            NSString *channel =@"sports";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channel"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channel = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/liveRoom/%@/specialDate/%@?",channel,[self liveClientId]];
        }

            break;
        case LTURLModule_LiveHall_GetCurrentInfo:
        {
            NSString *channel =@"sports";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channel"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channel = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/liveRoom/%@/current/%@",channel,[self liveClientId]];
        }
            break;
        case LTURLModule_LiveHall_GetIncremental:
        {
            NSString *channel =@"sports";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channel"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channel = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/liveRoom/%@/incremental/%@",channel,[self liveClientId]];
        }
            break;
        case LTURLModule_Live_GetLiveChannel:
            return [NSString stringWithFormat:@"v1/channel/letv/100/%@?signal=5,7",[self liveClientId]];
            break;
        case LTURLModule_Live_GetLiveChannelByThirdParty:
            return [NSString stringWithFormat:@"v1/channel/third/100/%@?",[self liveClientId]];
            break;
        case LTURLModule_Live_GetChannelStream:
        {
            NSString *channelId =@"";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channelId"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channelId = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/stream/%@/%@?withAllStreams=1",[self liveClientId],channelId];
        }
            break;
        case LTURLModule_Live_GetSnapShot:
        {
            NSString *channelId =@"";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channelId"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channelId = arrayUrlHeadParam[i+1];
                }
            }
            return [NSString stringWithFormat:@"v1/channel/snapshot/%@.jpg",channelId];
        }
            break;
        case LTURLModule_Live_GetCurrentBillList1:
            return [NSString stringWithFormat:@"v1/playbill/current/%@?",[self liveClientId]];
            break;
        case LTURLModule_Live_GetCurrentDayBillList:
        {
            NSString *channelId =@"";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"channelId"]&&(i!=arrayUrlHeadParam.count -1)) {
                    channelId = arrayUrlHeadParam[i+1];
                }
            }

            return [NSString stringWithFormat:@"v1/playbill/wholeday/%@/%@",[self liveClientId],channelId];
        }
            break;
        case LTURLModule_Live_GetBillListIncremental:
        {
            NSString *programId =@"";
            NSString *direction =@"1";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"programId"]&&(i!=arrayUrlHeadParam.count -1)) {
                    programId = arrayUrlHeadParam[i+1];
                }
                if ([str isEqualToString:@"direction"]&&(i!=arrayUrlHeadParam.count -1)) {
                    direction = arrayUrlHeadParam[i+1];
                }

            }

            return [NSString stringWithFormat:@"v1/playbill/incremental/%@/%@/%@",[self liveClientId],direction,programId];
        }
            break;
        case LTURLModule_Live_GetBillListPlayingInfo:
        {
            NSString *vid =@"";
            for(int i=0;i<arrayUrlHeadParam.count;i++)
            {
                NSString *str = arrayUrlHeadParam[i];
                if ([str isEqualToString:@"vid"]&&(i!=arrayUrlHeadParam.count -1)) {
                    vid = arrayUrlHeadParam[i+1];
                }
            }

            return [NSString stringWithFormat:@"v1/playbill/vrs/100/%@/%@",[self liveClientId],vid];
        }
            break;
        case LTURLModule_Live_GetCurrentBillList2:
        {
            return [NSString stringWithFormat:@"v1/playbill/current2/%@?",[self liveClientId]];
        }
            break;
        case LTURLModule_Live_Livehall_GetPlayerInfo:
        {
            if ([SettingManager isTestApi]) {
                return [NSString stringWithFormat:@"v1/liveRoom/terminal/hotLive/%@?test=1",[self liveClientId]];
            } else {
                return [NSString stringWithFormat:@"v1/liveRoom/terminal/hotLive/%@",[self liveClientId]];
            }
        }
            break;
        case LTURLModule_Live_Livehall_sortHotLives:
        {
            if ([SettingManager isTestApi]) {
                return [NSString stringWithFormat:@"v1/liveRoom/terminal/sortHotLives/%@?test=1",[self liveClientId]];
            } else {
                return [NSString stringWithFormat:@"v1/liveRoom/terminal/sortHotLives/%@",[self liveClientId]];
            }
        }
            break;
        default:
            break;
    }

    return @"";
}

+ (NSString *)liveClientId {
    NSString *liveClientId = LT_LIVE_CLIENTID;
    if ([SettingManager isHK]) {
#ifdef LT_IPAD_CLIENT
        liveClientId = @"1060419007";
#else
        liveClientId = @"1060419005";
#endif
    }
    return liveClientId;
}


@end

#endif
