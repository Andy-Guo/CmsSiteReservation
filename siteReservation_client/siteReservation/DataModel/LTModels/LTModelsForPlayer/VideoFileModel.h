//
//  VideoFileModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-5.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
//#import <LetvMobileProtobuf/LetvMobileProtobuf.h>

#import <LetvMobileProtobuf/LetvMobileProtobuf.h>

@class VideoModel;
@class MoviePayDetail;
@class MovieCanPlayDetail;
@class MovieDetailModel;

@class ValidateData;

typedef enum {

    VideoFileUrlValidityType_unknown,
    VideoFileUrlValidityType_valid,     // 有效
    VideoFileUrlValidityType_invalid,   // 无效

}VideoFileUrlValidityType;

@protocol VideoFileItem @end
@interface VideoFileItem : JSONModel

@property (strong, nonatomic) NSString<Optional>* mainUrl;      // string	视频调度地址；
@property (strong, nonatomic) NSString<Optional>* backUrl0;     // string	视频备用调度地址1（域名备份调度）；
@property (strong, nonatomic) NSString<Optional>* backUrl1;     // string	视频备用调度地址2（双线出口的IP调度）；
@property (strong, nonatomic) NSString<Optional>* backUrl2;     // string	视频备用调度地址3（域名备份调度）；
@property (strong, nonatomic) NSString<Optional>* filesize;     // string	视频文件大小byte；
@property (strong, nonatomic) NSString<Optional>* storePath;    // string	视频文件名称
@property (strong, nonatomic) NSString<Optional>* token;        // string   视频码率对应的 token
@property (strong, nonatomic) NSString<Optional>* vtype;

@property(nonatomic, strong)  NSString <Optional>*drm_token;
// 对应各url是否有效，取值为VideoFileUrlValidityType
@property (strong, nonatomic) NSString<Optional>* flag_mainUrl;      //
@property (strong, nonatomic) NSString<Optional>* flag_backUrl0;     //
@property (strong, nonatomic) NSString<Optional>* flag_backUrl1;     //
@property (strong, nonatomic) NSString<Optional>* flag_backUrl2;     //

@property (strong, nonatomic) NSDictionary<Optional>* audioTracks;//支持的音轨

// 是否包含valid url
- (BOOL)isValidInfo;

// 获取下一个状态为VideoFileUrlValidityType_valid的url
- (NSString *)getVerifiedUrl;

@end

@protocol VideoStreamLevelItem @end

@interface VideoStreamLevelItem : JSONModel

@property (strong, nonatomic) NSString<Optional>* status;      // string	是否降码流status: 0-否，1-是
@property (strong, nonatomic) NSString<Optional>* level;     // string	要将到的码流,即指定为infos中的码流key,如：mp4_350,mp4_1000

@end

@protocol VideoFileModel @end
@interface VideoFileModel : JSONModel

@property (strong, nonatomic) VideoFileItem<Optional>* mp4_180;     // videoFileInfo	视频地址：MP4格式180码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_350;     // videoFileInfo	视频地址：MP4格式350码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_800;     // videoFileInfo	视频地址：MP4格式800码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_1000;    // videoFileInfo	视频地址：MP4格式1000码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_1300;    // videoFileInfo	视频地址：MP4格式1300码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_720p;    // videoFileInfo	视频地址：MP4格式720p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_1080p3m; // videoFileInfo	视频地址：MP4格式1080p码率；

@property (strong, nonatomic) VideoFileItem<Optional>* drm_180_marlin;    // videoFileInfo	视频地址：MP4格式720p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* drm_180_access; // videoFileInfo	视频地址：MP4格式1080p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* drm_350_marlin;    // videoFileInfo	视频地址：MP4格式720p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* drm_350_access; // videoFileInfo	视频地址：MP4格式1080p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* drm_800_marlin;    // videoFileInfo	视频地址：MP4格式720p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* drm_1300_access; // videoFileInfo	视频地址：MP4格式1080p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* drm_1300_marlin;    // videoFileInfo	视频地址：MP4格式720p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* drm_800_access; // videoFileInfo	视频地址：MP4格式1080p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* drm_1000_marlin;
@property (strong, nonatomic) VideoFileItem<Optional>* drm_720p_marlin;
@property (strong, nonatomic) VideoFileItem<Optional>* drm_1080p3m_marlin;

// 全景视频
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_180_360;     // videoFileInfo	视频地址：MP4格式180码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_350_360;     // videoFileInfo	视频地址：MP4格式350码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_800_360;     // videoFileInfo	视频地址：MP4格式800码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_1000_360;    // videoFileInfo	视频地址：MP4格式1000码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_1300_360;    // videoFileInfo	视频地址：MP4格式1300码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_720p_360;    // videoFileInfo	视频地址：MP4格式720p码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_1080p_360;    // videoFileInfo	视频地址：MP4格式1080p码率；

// 杜比视频
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_800_db;     // videoFileInfo	视频地址：MP4格式180码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_1300_db;     // videoFileInfo	视频地址：MP4格式180码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_720p_db;     // videoFileInfo	视频地址：MP4格式180码率；
@property (strong, nonatomic) VideoFileItem<Optional>* mp4_1080p6m_db;     // videoFileInfo	视频地址：MP4格式180码率；

@property (strong, nonatomic) VideoStreamLevelItem<Optional> *streamLevel;    // 码流配置：

//客户端添加，从videoInfo中取DRM数据判断是否走DRM码流
@property (strong, nonatomic) NSString *drmFlag;


// 根据码率获取对应videoFileItem
- (VideoFileItem *)getVideoFileItemByCodeRate:(VideoCodeType)vct;
- (VideoFileItem *)getVideoFileItemByCodeRate: (VideoCodeType) vct isDolbyVideo:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama;

// 根据videoFileItem Key 值获取对应码率
- (VideoCodeType)getVideoCodeTypeByVideoFileKey:(NSString *)vct;
- (VideoCodeType)getVideoCodeTypeFromVideoFileKey:(NSString *)vct;

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

//!!!!: boss v1-v2 鉴权格式修改
@interface VFValidate : JSONModel

@property (nonatomic, strong) NSString<Optional> *code;
@property (nonatomic, strong) ValidateData<Optional> *data;

@end


// 以下是改造新接口，新增model   zzj 20150329

@interface VFPayInfo : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *isOpenTVOD;               // 分地区控制，是否开启单片付费功能（TVOD）：1-是，0-否；（>=6.8版本开始启用,单片购买类型提供）
@property (nonatomic, strong) MovieCanPlayDetail<Optional> *values;
@property (nonatomic, strong) MoviePayDetail<Optional> *chargeInfo;
@end

@interface VFVideoFile : JSONModel
@property (nonatomic, strong) VideoFileModel<Optional> *infos;
@property (nonatomic, strong) NSString<Optional> *mmsid;
@property (nonatomic, strong) NSString<Optional> *currentRate;
@property (nonatomic, strong) NSString<Optional> *streamErrCode;
@property (strong, nonatomic) NSDictionary<Optional>* subtitle;//所有字幕
@property (strong, nonatomic) NSDictionary<Optional>* defSubTrack;//默认字幕
@property (strong, nonatomic) NSDictionary<Optional>* defAudioTrack;//默认音轨

- (BOOL)isCurrentRateDolby;

@end

@interface VFStreameLevel : JSONModel
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *level;
@end

@protocol VFModelPBOCModule <LTProtocolBaseModule>
@property (nonatomic, strong) VFVideoFile<Optional> *videofile;
@property (nonatomic, strong) VideoStreamLevelItem<Optional> *streamLevel;
@property (nonatomic, strong) VideoModel<Optional> *videoInfo;
@property (nonatomic, strong) VFPayInfo<Optional> *payInfo;
@property (nonatomic, strong) VFValidate<Optional> *validate;
@property (nonatomic, strong) NSDictionary<Optional>* adInfo;
- (void)switchToPanorama;

- (BOOL)isPayVideoNotAllowedTrial;
@end

@interface VFModelPBOCModule : LTProtocolBaseModule<VFModelPBOCModule>

@end

@interface VFModel : JSONModel
@property (nonatomic, strong) VFVideoFile<Optional> *videofile;
@property (nonatomic, strong) VideoStreamLevelItem<Optional> *streamLevel;
@property (nonatomic, strong) VideoModel<Optional> *videoInfo;
@property (nonatomic, strong) VFPayInfo<Optional> *payInfo;
@property (nonatomic, strong) VFValidate<Optional> *validate;
@property (nonatomic, strong) NSDictionary<Optional>* adInfo;
@property (nonatomic, strong) MovieDetailModel<Optional> *albumInfo;

- (void)switchToPanorama;

- (void)verifyPanorama;

- (void)swichToDolby;

- (BOOL)isPayVideoNotAllowedTrial;


@end

@interface VFModelWapper : JSONModel
@property (nonatomic, strong) VFModel<Optional> *data;
@end
