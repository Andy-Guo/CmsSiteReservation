//
//  LeMPSessionParameter.h
//  LeTVMobilePlayer
//
//  Created by xingbo on 16/10/17.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTDataCenterCommDef.h"
#import "LTDataCenterEnumDef.h"

/**
    添加session统计参数
 */
@interface LeMPSessionParameter : NSObject

@property (nonatomic, assign) BOOL isPanorama;
@property (nonatomic, copy)   NSDictionary *pushDictionary; // 推送传过来的字符串
@property (nonatomic, copy)   NSString *pushType;           // 推送类型
@property (nonatomic, assign) BOOL isPush; //是否是push

@property (nonatomic, copy) NSString *ref;
@property (nonatomic, assign) LTDCCodePlayFrom playFrom;
@property (nonatomic, copy) NSString *isRec;
@property (nonatomic, copy) NSString *reid;
@property (nonatomic, assign) BOOL isQcode; //是否是扫描二维码
@property (nonatomic, assign) LTDCPageID pageid;

@property (nonatomic, copy) NSString * QRPreUrl;

// 进入播放视频来源  后联播是1 点击播放是0 内联播是-1
@property (nonatomic, assign) NSInteger videoEnterType;
@property (nonatomic, assign) NSInteger playNextType; // 联播类型
@property (nonatomic, assign) BOOL isDownloaded;

// 下一个session的统计参数
@property (nonatomic, strong) LeMPSessionParameter *nextSessionParameter;
@end
