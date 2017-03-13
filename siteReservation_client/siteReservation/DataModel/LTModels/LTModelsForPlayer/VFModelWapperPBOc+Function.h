//
//  VFModelWapperPBOc+Function.h
//  LTPBData
//
//  Created by 李宇航 on 16/2/29.
//  Copyright © 2016年 mobile. All rights reserved.
//

#ifndef VFModelWapperPBOc_Function_h
#define VFModelWapperPBOc_Function_h
//#import <LetvMobileProtobuf/LetvMobileProtobuf.h>
#import <LeTVMobileDataModel/LeTVMobileDataModel.h>

@interface  VideoFileItemPBOC(ModelFunction)
// 是否包含valid url
- (BOOL)isValidInfo;

// 获取下一个状态为VideoFileUrlValidityType_valid的url
- (NSString *)getVerifiedUrl;
@end

@interface  VideoFileModelPBOC(ModelFunction)
// 根据码率获取对应videoFileItem
- (VideoFileItemPBOC *)getVideoFileItemByCodeRate:(VideoCodeType)vct;
- (VideoFileItemPBOC *)getVideoFileItemByCodeRate:(VideoCodeType)vct isDolbyVideo:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama;
// 根据videoFileItem Key 值获取对应码率
- (VideoCodeType)getVideoCodeTypeByVideoFileKey:(NSString *)vct;
- (LTVideoCodeType) getVideoCodeTypeFromVideoFileKey: (NSString*) vct;

// 获取能够支持的码率列表
- (NSArray *)getNotEmptyBitrate;
- (NSArray*) getRealSupportedBitrate;
- (NSArray*) getSupportedBitrateOfDolbyType:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama;

// 将url设置为invalidate状态
- (void)invalidateUrl:(NSString *)url
           byCodeRate:(VideoCodeType)codeRateType DEPRECATED_ATTRIBUTE;

// 将当前url设置为invalidate状态
- (void)invalidateCurrentUrlByCodeRate:(VideoCodeType)codeRateType;

// 将指定码率所有url设置为invalidate状态
- (void)invalidateAllUrlsByCodeRate:(VideoCodeType)codeRateType;

// 校验码率，如果传入codeType不存在对应url，返回存在url的最高码率
- (VideoCodeType)verifyCodeType:(VideoCodeType)codeType;

// 获取valid url
- (NSString *)getVerifiedUrlByCodeRate:(VideoCodeType)codeRateType;

- (NSString*) getVerifiedUrlByCodeRate: (VideoCodeType)codeRateType isDolbyVideo:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama;

// 获取视频文件名称
- (NSString *)getStorePathByCodeRate:(VideoCodeType)codeRateType;
@end

@interface  VideoModelPBOC(ModelFunction)
+ (VideoModel *)videoModelWithSubjectVideoModel:(LTSubjectVideo *)subjectVideo;

+ (BOOL)isAlreadyDownloadCompleteWith:(NSString*)vid;

+ (LTDownloadCommand *)getDBDownloadedInfoWith:(NSString*)vid;

// 对应属性（__propertyName）的类型转换
//- (NSInteger)episode;
//- (NSInteger)porder;
//- (NSArray *)brList;
//- (NSInteger)btime;
//- (NSInteger)etime;
//- (NSInteger)duration;

//- (NSString *)episodeInfo;
- (NSArray *)getInnerBrList;
// 获取icon
- (NSString *)icon;
// 获取小的icon
- (NSString *)smallIcon;
// 是否是正片
- (BOOL)isMainVideo;
// 是否支持播放
- (BOOL)isPlaySupported;
// 是否支持缓存
- (BOOL)isDownloadSupported;
// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload;
// 是否vip禁止缓存
- (BOOL)isDownloadDisabledByVIP;
// 外跳播放地址
- (NSString *)getJumpOutPlayUrl;
// 是否已经添加到缓存列表
- (BOOL)isAlreadyDownloaded;
- (BOOL) isAlreadyDownloading;
- (BOOL) isDownloadPause;
// 是否已经缓存完成
- (BOOL)isAlreadyDownloadComplete;
// 获取缓存信息
- (LTDownloadCommand*) getDBDownloadedInfo;
// 获取valid缓存码率
- (VideoCodeType)getValidDownloadBitrate;
// UI展示title
- (NSString *)getDisplayTitle;
- (NSString *)getVipTag;

//是否是付费电视剧
- (BOOL) isTVSerialAndPay;

- (BOOL)isPayVideoNotAllowedTrial;

/**
 *  是否是全景视频
 *
 *  @return
 */
- (BOOL)isPanorama;
- (BOOL)isDolbyVideo;

/**
 *  转换一个推荐模型为视频信息模型
 *
 *  @param item 推荐模型
 */
- (void)convertToRecommendItem:(RecommendItem*)item;


@end

@interface MovieCanPlayDetailPBOC(ModelFunction)
/**
 *  影片观影券类型
 *
 *  @return
 */
- (MoviePayTicketType)moviePayTicketType;

@end


@interface VFModelPBOC (Logic)
- (void)switchToPanorama;
- (BOOL)isPayVideoNotAllowedTrial;
@end

@interface VFVideoFilePBOC (Logic)
- (BOOL)isCurrentRateDolby;
@end

#endif /* VFModelWapperPBOc_Function_h */
