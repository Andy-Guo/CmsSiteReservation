//
//  LTEnterLivePlayerAuxiliaryParameter.h
//  LeTVMobileDataModel
//
//  Created by letv_lzb on 16/9/6.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>

#import <LetvMobileDataModel/LeMPSessionParameter.h>

@class LTLiveChannelListDetailModel;
@class LTLiveRoomDetailModel;

@interface LTEnterLivePlayerAuxiliaryParameter : LeMPSessionParameter

@property (nonatomic, assign) BOOL isNeedZoomOut;   // 是否以全屏方式进入
@property (nonatomic, assign) BOOL isPanorama;
@property (nonatomic, copy)   NSDictionary *pushDictionary; // 推送传过来的字符串
@property (nonatomic, copy)   NSString *pushType;           // 推送类型
@property (nonatomic, assign) BOOL isHalfLunBoPlayer;     //是否为半屏轮播台播放器（直播大厅的小屏播放器）
@property (nonatomic, assign) CGRect halfLunBoPlayerRect; //半屏轮播台播放器frame

@property (nonatomic, copy) NSString *ref;
@property (nonatomic, assign) LTDCCodePlayFrom playFrom;
@property (nonatomic, copy) NSString *reid;
@property (nonatomic, assign) BOOL isQcode; //是否是扫描二维码
@property (nonatomic, copy) NSString * QRPreUrl;
@property (nonatomic, copy) NSString *titleInitial; // 视频初始标题（接口数据之前的占位）

@property (nonatomic, assign) LTLiveListType liveListType;//直播播放器的类型，热点、轮播、卫视等

@property (nonatomic, strong) LTLiveChannelListDetailModel *channelInfo; // 频道信息
@property (nonatomic, strong) LTLiveRoomDetailModel *liveInfo;  // 直播信息

@property (nonatomic, assign) BOOL isFromLivehall;  // 是否从直播大厅进入

@property (nonatomic, copy) NSString *channelType; // sports,music ..

@property (nonatomic, assign) BOOL isPanoramaFromWeb; // 是否网页调起的全景

@property (nonatomic, assign) BOOL forcedToSkipAdvertise;  // 是否跳过广告

@property (nonatomic, copy) NSString *branchesSelectId;  // 多视角切换的selectId

@property (nonatomic, assign)NSInteger lunboCategoryIndex; //轮播台分类index标识

@property (nonatomic, copy) NSString *liveUrl;//外部传入直播流地址
@property (nonatomic, copy) NSString *streamId;//直播流id

@end
