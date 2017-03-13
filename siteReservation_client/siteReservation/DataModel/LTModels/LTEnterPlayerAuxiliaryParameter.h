//
//  LTEnterPlayerAuxiliaryParameter.h
//  LeTVMobileFoundation
//
//  Created by bob on 15/11/20.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>
#import <LetvMobileDataModel/LeMPSessionParameter.h>

@interface LTEnterPlayerAuxiliaryParameter : LeMPSessionParameter

@property (nonatomic, assign) BOOL isAnimate;       // 是否以动画的方式进入播放器
@property (nonatomic, assign) BOOL isCancelAnimate;
@property (nonatomic, assign) BOOL isNeedZoomOut;   // 是否以全屏方式进入
@property (nonatomic, assign) BOOL isRotateFirstAnimation;
@property (nonatomic, assign) BOOL isScrollToComment;
@property (nonatomic, assign) BOOL isPanorama;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) BOOL isPush; //是否是push
@property (nonatomic, copy)   NSDictionary *pushDictionary; // 推送传过来的字符串
@property (nonatomic, copy)   NSString *pushType;           // 推送类型
@property (nonatomic, copy)   NSString *cid;                // cid
@property (nonatomic, copy)   NSString *channelId;                // 频道页channelId

@property (nonatomic, copy) NSString *ref;
@property (nonatomic, assign) LTDCCodePlayFrom playFrom;
@property (nonatomic, copy) NSString *isRec;
@property (nonatomic, copy) NSString *reid;
@property (nonatomic, assign) BOOL isQcode; //是否是扫描二维码
@property (nonatomic, copy) NSString * QRPreUrl;
@property (nonatomic, copy) NSString *titleInitial; // 视频初始标题（接口数据之前的占位）
@property (nonatomic, assign) BOOL isLexBox; //是否是乐盒

// 进入播放视频来源  后联播是1 点击播放是0 内联播是-1
@property (nonatomic, assign) NSInteger videoEnterType;
@property (nonatomic, assign) NSInteger playNextType; // 联播类型
@property (nonatomic, assign) BOOL isDownloaded;
@property (nonatomic, assign) NSTimeInterval halfScreenTofullTime;
@end
