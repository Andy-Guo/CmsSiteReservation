//
//  VideoFileModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-5.
//
//

#import "VideoFileModel.h"
#import "VideoModel.h"
#import "MoviePayDetail.h"
#import "ValidateData.h"
//#import "NSString+HTTPExtensions.h"
#import "VideoModel.h"
#import <LeTVMobileDataModel/LTDataCenter.h>

@implementation VideoFileItem

- (BOOL) isValidInfo
{
    return (![NSString isBlankString: self.mainUrl]
            || ![NSString isBlankString: self.backUrl0]
            || ![NSString isBlankString: self.backUrl1]
            || ![NSString isBlankString: self.backUrl2]);
}

- (NSString*) getVerifiedUrl
{
    NSString* rtUrl = @"";

    if (VideoFileUrlValidityType_invalid != [self.flag_mainUrl integerValue]) {
        rtUrl = self.mainUrl;
        if ([NSString isBlankString: rtUrl]) {
            self.flag_mainUrl = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_invalid];
        } else {
            self.flag_mainUrl = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_valid];
        }
    }

    if ([NSString isBlankString: rtUrl]
        && VideoFileUrlValidityType_invalid != [self.flag_backUrl0 integerValue]) {
        rtUrl = self.backUrl0;
        if ([NSString isBlankString: rtUrl]) {
            self.flag_backUrl0 = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_invalid];
        } else {
            self.flag_backUrl0 = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_valid];
        }
    }

    if ([NSString isBlankString: rtUrl]
        && VideoFileUrlValidityType_invalid != [self.flag_backUrl1 integerValue]) {
        rtUrl = self.backUrl1;
        if ([NSString isBlankString: rtUrl]) {
            self.flag_backUrl1 = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_invalid];
        } else {
            self.flag_backUrl1 = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_valid];
        }
    }

    if ([NSString isBlankString: rtUrl]
        && VideoFileUrlValidityType_invalid != [self.flag_backUrl2 integerValue]) {
        rtUrl = self.backUrl2;
        if ([NSString isBlankString: rtUrl]) {
            self.flag_backUrl2 = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_invalid];
        } else {
            self.flag_backUrl2 = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_valid];
        }
    }

    if ([NSString isBlankString: rtUrl]) {
        return nil;
    }

    return rtUrl;
}

@end

@implementation VideoStreamLevelItem

@end

@implementation VideoFileModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

- (VideoFileItem*) getVideoFileItemByCodeRate: (VideoCodeType) vct
{
    BOOL isNeedDRM = [self.drmFlag integerValue] && ![DeviceManager isJailBreak];

    switch (vct) {
        case VIDEO_CODE_ULD:
            if (isNeedDRM) {
                return self.drm_180_marlin;
            } else {
                return self.mp4_180;
            }
            break;
        case VIDEO_CODE_LD:
            if (isNeedDRM) {
                return self.drm_350_marlin;
            } else {
                return self.mp4_350;
            }
            break;
        case VIDEO_CODE_SD:
            if (isNeedDRM) {
                return self.drm_1000_marlin;
            } else {
                return self.mp4_1000;
            }
            break;
        case VIDEO_CODE_HD:
            if (isNeedDRM) {
                return self.drm_1300_marlin;
            } else {
                return self.mp4_1300;
            }
            break;
        case VIDEO_CODE_720P:
            if (isNeedDRM) {
                return self.drm_720p_marlin;
            } else {
                return self.mp4_720p;
            }
            break;
        case VIDEO_CODE_1080P:
            if (isNeedDRM) {
                return self.drm_1080p3m_marlin;
            } else {
                return self.mp4_1080p3m;
            }
            break;
        default:
            break;
    }

    return nil;
}

- (VideoFileItem*) getVideoFileItemByCodeRate: (VideoCodeType) vct isDolbyVideo:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama
{
    BOOL isNeedDRM = [self.drmFlag integerValue] && ![DeviceManager isJailBreak];
    switch (vct) {
        case VIDEO_CODE_ULD:
            if (isNeedDRM) {
                return self.drm_180_marlin;
            } else if(isDolbyVideo){
                return nil;
            } else if(isPanorama) {
                return self.mp4_180_360;
            } else {
                return self.mp4_180;
            }
            break;
        case VIDEO_CODE_LD:
            if (isNeedDRM) {
                return self.drm_350_marlin;
            } else if(isDolbyVideo){
                return nil;
            } else if(isPanorama) {
                return self.mp4_350_360;
            } else {
                return self.mp4_350;
            }
            break;
        case VIDEO_CODE_SD:
            if (isNeedDRM) {
                return self.drm_1000_marlin;
            } else if(isDolbyVideo){
                return self.mp4_800_db;
            } else if(isPanorama) {
                if (self.mp4_1000_360) {
                    return self.mp4_1000_360;
                } else {
                    return self.mp4_800_360;
                }
            } else {
                return self.mp4_1000;
            }
            break;
        case VIDEO_CODE_HD:
            if (isNeedDRM) {
                return self.drm_1300_marlin;
            } else if(isDolbyVideo) {
                return self.mp4_1300_db;
            } else if(isPanorama) {
                return self.mp4_1300_360;
            } else {
                return self.mp4_1300;
            }
            break;
        case VIDEO_CODE_720P:
            if (isNeedDRM) {
                return self.drm_720p_marlin;
            } else if (isDolbyVideo) {
                return self.mp4_720p_db;
            } else if (isPanorama) {
                return self.mp4_720p_360;
            } else {
                return self.mp4_720p;
            }
            break;
        case VIDEO_CODE_1080P:
            if (isNeedDRM) {
                return self.drm_1080p3m_marlin;
            } else if (isDolbyVideo) {
                return self.mp4_1080p6m_db;
            } else if (isPanorama) {
                return self.mp4_1080p_360;
            } else {
                return self.mp4_1080p3m;
            }
            break;
        default:
            break;
    }
    
    return nil;
}

- (VideoCodeType) getVideoCodeTypeByVideoFileKey: (NSString*) vct
{
    BOOL isNeedDRM = [self.drmFlag integerValue] && ![DeviceManager isJailBreak];
    NSString *uldString = (isNeedDRM)?@"drm_180_marlin":@"mp4_180";
    NSString *ldString = (isNeedDRM)?@"drm_350_marlin":@"mp4_350";
    NSString *sdString = (isNeedDRM)?@"drm_1000_marlin":@"mp4_1000";
    NSString *hdString = (isNeedDRM)?@"drm_1300_marlin":@"mp4_1300";
    NSString *hLdString = (isNeedDRM)?@"drm_720p_marlin":@"mp4_720p";
    NSString *hhLdString = (isNeedDRM)?@"drm_1080p3m_marlin":@"mp4_1080p3m";

    if ([vct isEqualToString: uldString]) {
        return VIDEO_CODE_ULD;
    }
    if ([vct isEqualToString:ldString]) {
        return VIDEO_CODE_LD;
    }
    if ([vct isEqualToString: sdString]) {
        return VIDEO_CODE_SD;
    }
    if ([vct isEqualToString: hdString]) {
        return VIDEO_CODE_HD;
    }
    if ([vct isEqualToString: hLdString]) {
        return VIDEO_CODE_720P;
    }
    if ([vct isEqualToString:hhLdString]) {
        return VIDEO_CODE_1080P;
    }
    return VIDEO_CODE_UNKNOWN;
}

- (VideoCodeType) getVideoCodeTypeFromVideoFileKey: (NSString*) vct
{
    if ([vct isEqualToString: @"mp4_180"] ||
        [vct isEqualToString: @"drm_180_marlin"] ||
        [vct isEqualToString: @"drm_180_360"]) {
        return VIDEO_CODE_ULD;
    }
    if ([vct isEqualToString: @"mp4_350"] ||
        [vct isEqualToString: @"mp4_350_360"] ||
        [vct isEqualToString: @"drm_350_marlin"]) {
        return VIDEO_CODE_LD;
    }
    if ([vct isEqualToString: @"mp4_1000"] ||
        [vct isEqualToString: @"mp4_800_db"] ||
        [vct isEqualToString: @"mp4_1000_360"] ||
        [vct isEqualToString: @"mp4_800_360"] ||
        [vct isEqualToString: @"drm_1000_marlin"]) {
        return VIDEO_CODE_SD;
    }
    if ([vct isEqualToString: @"mp4_1300"] ||
        [vct isEqualToString: @"mp4_1300_db"] ||
        [vct isEqualToString: @"mp4_1300_360"] ||
        [vct isEqualToString: @"drm_1300_marlin"]) {
        return VIDEO_CODE_HD;
    }
    if ([vct isEqualToString: @"mp4_720p"] ||
        [vct isEqualToString: @"mp4_720p_db"] ||
        [vct isEqualToString: @"mp4_720p_360"] ||
        [vct isEqualToString: @"drm_720p_marlin"]) {
        return VIDEO_CODE_720P;
    }
    if ([vct isEqualToString: @"mp4_1080p3m"] ||
        [vct isEqualToString: @"mp4_1080p6m_db"] ||
        [vct isEqualToString: @"mp4_1080p_360"] ||
        [vct isEqualToString: @"drm_1080p3m_marlin"]) {
        return VIDEO_CODE_1080P;
    }
    return VIDEO_CODE_UNKNOWN;
}

- (NSArray*) getNotEmptyBitrate
{
    NSMutableArray* resultArrayBitrate = [NSMutableArray array];

    for (VideoCodeType vct = VIDEO_CODE_BEGIN; vct <= VIDEO_CODE_END; vct++) {
        VideoFileItem* videoFileItem = [self getVideoFileItemByCodeRate: vct];
    
        if (nil == videoFileItem
            || ![videoFileItem isValidInfo]) {
            continue;
        }
        [resultArrayBitrate addObject: @(vct)];
    }

    return resultArrayBitrate;
}

- (NSArray*) getAllSupportedBitrate
{
    NSMutableArray* resultArrayBitrate = [NSMutableArray array];
    for (VideoCodeType vct = VIDEO_CODE_BEGIN; vct <= VIDEO_CODE_END; vct++) {
        VideoFileItem* videoFileItem = [self getVideoFileItemByCodeRate: vct];
        if (nil == videoFileItem) {
            continue;
        }
        [resultArrayBitrate addObject: @(vct)];
    }
    return resultArrayBitrate;
}

- (NSArray*) getRealSupportedBitrate
{
    NSMutableArray* resultArrayBitrate = [NSMutableArray array];
    NSArray* supportedBitrateArray = [self getNotEmptyBitrate];

    for (NSNumber* videoCodeNumber in supportedBitrateArray) {
        VideoCodeType videoCodeType = [videoCodeNumber intValue];

        VideoFileItem* videoFileItem = [self getVideoFileItemByCodeRate: videoCodeType];

        if (VideoFileUrlValidityType_invalid != [videoFileItem.flag_mainUrl integerValue]
            || VideoFileUrlValidityType_invalid != [videoFileItem.flag_backUrl0 integerValue]
            || VideoFileUrlValidityType_invalid != [videoFileItem.flag_backUrl1 integerValue]
            || VideoFileUrlValidityType_invalid != [videoFileItem.flag_backUrl2 integerValue]
            ) {
            [resultArrayBitrate addObject: @(videoCodeType)];
            continue;
        }
    }

    return resultArrayBitrate;
}

- (NSArray*) getSupportedBitrateOfDolbyType:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama
{
    NSMutableArray* resultArrayBitrate = [NSMutableArray array];
    NSMutableArray* supportedBitrateArray = [NSMutableArray array];
    for (VideoCodeType vct = VIDEO_CODE_BEGIN; vct <= VIDEO_CODE_END; vct++) {
        VideoFileItem* videoFileItem = [self getVideoFileItemByCodeRate: vct isDolbyVideo:isDolbyVideo isPanorama:isPanorama];
        if (nil == videoFileItem) {
            continue;
        }
        [supportedBitrateArray addObject: @(vct)];
    }
    
    for (NSNumber* videoCodeNumber in supportedBitrateArray) {
        VideoCodeType videoCodeType = [videoCodeNumber intValue];
        VideoFileItem* videoFileItem = [self getVideoFileItemByCodeRate: videoCodeType isDolbyVideo:isDolbyVideo isPanorama:isPanorama];
        if (videoFileItem) {
            [resultArrayBitrate addObject: @(videoCodeType)];
            continue;
        }
    }
    return resultArrayBitrate;
}

- (void) invalidateCurrentUrlByCodeRate: (VideoCodeType) codeRateType
{
    if (VIDEO_CODE_UNKNOWN == codeRateType) {
        return;
    }

    VideoFileItem* currItem = [self getVideoFileItemByCodeRate: codeRateType];

    if (nil == currItem
        || ![currItem isValidInfo]) {
        return;
    }

    NSString* invaliadValue = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_invalid];

    if (![currItem.flag_mainUrl isEqualToString: invaliadValue]) {
        currItem.flag_mainUrl = invaliadValue;
    }

    if (![currItem.flag_backUrl0 isEqualToString: invaliadValue]) {
        currItem.flag_backUrl0 = invaliadValue;
    }

    if (![currItem.flag_backUrl1 isEqualToString: invaliadValue]) {
        currItem.flag_backUrl1 = invaliadValue;
    }

    if (![currItem.flag_backUrl2 isEqualToString: invaliadValue]) {
        currItem.flag_backUrl2 = invaliadValue;
    }

    return;
}

- (void) invalidateUrl: (NSString*) url
            byCodeRate: (VideoCodeType) codeRateType
{
    if ([NSString isBlankString: url]
        || VIDEO_CODE_UNKNOWN == codeRateType) {
        return;
    }

    VideoFileItem* currItem = [self getVideoFileItemByCodeRate: codeRateType];

    if (nil == currItem
        || ![currItem isValidInfo]) {
        return;
    }

    NSString* invliadValue = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_invalid];

    if (![NSString isBlankString: currItem.mainUrl]
        && [url hasPrefix: currItem.mainUrl]) {
        currItem.flag_mainUrl = invliadValue;
        return;
    }

    if (![NSString isBlankString: currItem.backUrl0]
        && [url hasPrefix: currItem.backUrl0]) {
        currItem.flag_backUrl0 = invliadValue;
        return;
    }

    if (![NSString isBlankString: currItem.backUrl1]
        && [url hasPrefix: currItem.backUrl1]) {
        currItem.flag_backUrl1 = invliadValue;
        return;
    }

    if (![NSString isBlankString: currItem.backUrl2]
        && [url hasPrefix: currItem.backUrl2]) {
        currItem.flag_backUrl2 = invliadValue;
        return;
    }

    return;
}

- (void) invalidateAllUrlsByCodeRate: (VideoCodeType) codeRateType
{
    if (VIDEO_CODE_UNKNOWN == codeRateType) {
        return;
    }

    VideoFileItem* currItem = [self getVideoFileItemByCodeRate: codeRateType];

    if (nil == currItem
        || ![currItem isValidInfo]) {
        return;
    }

    NSString* invliadValue = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_invalid];

    currItem.flag_mainUrl = invliadValue;
    currItem.flag_backUrl0 = invliadValue;
    currItem.flag_backUrl1 = invliadValue;
    currItem.flag_backUrl2 = invliadValue;

    return;
}

- (VideoCodeType) verifyCodeType: (VideoCodeType) codeType
{
    NSArray* unInvalidBitrateArray = [self getRealSupportedBitrate];

    if (nil == unInvalidBitrateArray
        || [unInvalidBitrateArray count] <= 0) {
        NSLog (@"unInvalidBitrateArray... empty");
        return VIDEO_CODE_UNKNOWN;
    }

    VideoCodeType resultCodeType = codeType;

    /*
       if (![unInvalidBitrateArray containsObject:@(resultCodeType)]) {
        resultCodeType = (VideoCodeType)[unInvalidBitrateArray[0] integerValue];
       }
     */

    if (![unInvalidBitrateArray containsObject: @(resultCodeType)]) {
        switch (resultCodeType) {
        case VIDEO_CODE_ULD:
        {
            if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_LD)]) {
                resultCodeType = VIDEO_CODE_LD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_SD)]) {
                resultCodeType = VIDEO_CODE_SD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_HD)]) {
                resultCodeType = VIDEO_CODE_HD;
            } else {
                resultCodeType = VIDEO_CODE_UNKNOWN;
            }
        }
        break;
        case VIDEO_CODE_LD:
        {
            if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_ULD)]) {
                resultCodeType = VIDEO_CODE_ULD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_SD)]) {
                resultCodeType = VIDEO_CODE_SD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_HD)]) {
                resultCodeType = VIDEO_CODE_HD;
            } else {
                resultCodeType = VIDEO_CODE_UNKNOWN;
            }
        }
        break;
        case VIDEO_CODE_SD:
        {
            if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_LD)]) {
                resultCodeType = VIDEO_CODE_LD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_ULD)]) {
                resultCodeType = VIDEO_CODE_ULD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_HD)]) {
                resultCodeType = VIDEO_CODE_HD;
            } else {
                resultCodeType = VIDEO_CODE_UNKNOWN;
            }
        }
        break;
        case VIDEO_CODE_HD:
        {
            if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_SD)]) {
                resultCodeType = VIDEO_CODE_SD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_LD)]) {
                resultCodeType = VIDEO_CODE_LD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_ULD)]) {
                resultCodeType = VIDEO_CODE_ULD;
            } else {
                resultCodeType = VIDEO_CODE_UNKNOWN;
            }
        }
        break;
        case VIDEO_CODE_720P:
        {
            if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_HD)]) {
                resultCodeType = VIDEO_CODE_HD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_SD)]) {
                resultCodeType = VIDEO_CODE_SD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_LD)]) {
                resultCodeType = VIDEO_CODE_LD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_ULD)]) {
                resultCodeType = VIDEO_CODE_ULD;
            } else {
                resultCodeType = VIDEO_CODE_UNKNOWN;
            }
        }
        break;
        case VIDEO_CODE_1080P:
        {
            if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_720P)]) {
                resultCodeType = VIDEO_CODE_720P;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_HD)]) {
                resultCodeType = VIDEO_CODE_HD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_SD)]) {
                resultCodeType = VIDEO_CODE_SD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_LD)]) {
                resultCodeType = VIDEO_CODE_LD;
            } else if ([unInvalidBitrateArray containsObject: @(VIDEO_CODE_ULD)]) {
                resultCodeType = VIDEO_CODE_ULD;
            } else {
                resultCodeType = VIDEO_CODE_UNKNOWN;
            }
        }
        break;
        case VIDEO_CODE_UNKNOWN:
            // do nothing
            break;
        default:
            resultCodeType = VIDEO_CODE_ULD;
            break;
        }
    }

    return resultCodeType;
}

- (NSString*) getVerifiedUrlByCodeRate: (VideoCodeType) codeRateType
{
    VideoFileItem* videoFileItem = [self getVideoFileItemByCodeRate: codeRateType];

    
    if (nil == videoFileItem
        || ![videoFileItem isValidInfo]) {
        return nil;
    }
    NSString *rtUrl = [videoFileItem getVerifiedUrl];
    if (![self.drmFlag integerValue]) {
        rtUrl = [NSString stringWithFormat:
                 @"%@&pcode=%@&version=%@",
                 rtUrl,
                 CURRENT_PCODE,
                 CURRENT_VERSION];
    }
    
    return rtUrl;
}

- (NSString*) getVerifiedUrlByCodeRate: (VideoCodeType)codeRateType isDolbyVideo:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama
{
    VideoFileItem* videoFileItem = nil;
    
    if (!isDolbyVideo && !isPanorama) {
        videoFileItem = [self getVideoFileItemByCodeRate: codeRateType];
    } else {
        videoFileItem = [self getVideoFileItemByCodeRate: codeRateType isDolbyVideo:isDolbyVideo isPanorama:isPanorama];
    }
    
    if (nil == videoFileItem
        || ![videoFileItem isValidInfo]) {
        NSString *logStr = [NSString stringWithFormat:@"播放流程---获取videoFileItem失败, codeType:%d", codeRateType];
        [LTDataCenter errorLog:logStr];
        return nil;
    }
    NSString *rtUrl = [videoFileItem getVerifiedUrl];
    if (![self.drmFlag integerValue]) {
        rtUrl = [NSString stringWithFormat:
                 @"%@&pcode=%@&version=%@",
                 rtUrl,
                 CURRENT_PCODE,
                 CURRENT_VERSION];
    }
    
    return rtUrl;
}

- (NSString*) getStorePathByCodeRate: (VideoCodeType) codeRateType
{
    VideoFileItem* videoFileItem = [self getVideoFileItemByCodeRate: codeRateType];
    
    if (nil == videoFileItem
        || ![videoFileItem isValidInfo]) {
        return nil;
    }

    return videoFileItem.storePath;
}

@end

@implementation VFValidate

@end
@implementation VFPayInfo
@end

@implementation VFVideoFile

- (BOOL)isCurrentRateDolby {
    if (self.currentRate.length > 0 &&
        ([self.currentRate isEqualToString:@"mp4_800_db"] ||
         [self.currentRate isEqualToString:@"mp4_1300_db"] ||
         [self.currentRate isEqualToString:@"mp4_720p_db"] ||
         [self.currentRate isEqualToString:@"mp4_1080p6m_db"])) {
        return YES;
    }
    return NO;
}

@end

@implementation VFStreameLevel
@end

@implementation VFModel

- (void)verifyPanorama {
    
    if ([self.videoInfo isPanorama]) {
        if ([self.videofile.infos.mp4_180_360 isValidInfo]) {
            self.videofile.infos.mp4_180 = self.videofile.infos.mp4_180_360;
        }
        if ([self.videofile.infos.mp4_350_360 isValidInfo]) {
            self.videofile.infos.mp4_350 = self.videofile.infos.mp4_350_360;
        }
        if ([self.videofile.infos.mp4_800_360 isValidInfo]) {
            self.videofile.infos.mp4_800 = self.videofile.infos.mp4_800_360;
        }
        if ([self.videofile.infos.mp4_1000_360 isValidInfo]) {
            self.videofile.infos.mp4_1000 = self.videofile.infos.mp4_1000_360;
        }
        if ([self.videofile.infos.mp4_1300_360 isValidInfo]) {
            self.videofile.infos.mp4_1300 = self.videofile.infos.mp4_1300_360;
        }
        if ([self.videofile.infos.mp4_720p_360 isValidInfo]) {
            self.videofile.infos.mp4_720p = self.videofile.infos.mp4_720p_360;
        }
        if ([self.videofile.infos.mp4_1080p_360 isValidInfo]) {
            self.videofile.infos.mp4_1080p3m = self.videofile.infos.mp4_1080p_360;
        }
    }
}

- (void)switchToPanorama
{
    if ([self.videofile.infos.mp4_180_360 isValidInfo]) {
        self.videofile.infos.mp4_180 = self.videofile.infos.mp4_180_360;
    }
    if ([self.videofile.infos.mp4_350_360 isValidInfo]) {
        self.videofile.infos.mp4_350 = self.videofile.infos.mp4_350_360;
    }
    if ([self.videofile.infos.mp4_800_360 isValidInfo]) {
        self.videofile.infos.mp4_800 = self.videofile.infos.mp4_800_360;
    }
    if ([self.videofile.infos.mp4_1000_360 isValidInfo]) {
        self.videofile.infos.mp4_1000 = self.videofile.infos.mp4_1000_360;
    }
    if ([self.videofile.infos.mp4_1300_360 isValidInfo]) {
        self.videofile.infos.mp4_1300 = self.videofile.infos.mp4_1300_360;
    }
    if ([self.videofile.infos.mp4_720p_360 isValidInfo]) {
        self.videofile.infos.mp4_720p = self.videofile.infos.mp4_720p_360;
    }
    if ([self.videofile.infos.mp4_1080p_360 isValidInfo]) {
        self.videofile.infos.mp4_1080p3m = self.videofile.infos.mp4_1080p_360;
    }
}

- (BOOL)is64bit {
#if defined(__LP64__) && __LP64__
      return YES;
#else
      return NO;
#endif
}

- (void)swichToDolby {
    
    if (!LTAPI_IS_ALLOWED(10.0) || ![self is64bit]) {
        return;
    }
    
    /**
     *    如果有杜比码流，则使用杜比码流替换普通码流，否则使用杜比码流播放
     */
    if ([self.videofile.infos.mp4_800_db isValidInfo]
        || [self.videofile.infos.mp4_1300_db isValidInfo]
        || [self.videofile.infos.mp4_720p_db isValidInfo]
        || [self.videofile.infos.mp4_1080p6m_db isValidInfo]) {
        
        self.videofile.infos.mp4_180 = nil;
        self.videofile.infos.mp4_350 = nil;
        self.videofile.infos.mp4_1000 = nil;
        
        if ([self.videofile.infos.mp4_800_db isValidInfo]) {
            self.videofile.infos.mp4_800 = self.videofile.infos.mp4_800_db;
        }
        else {
            self.videofile.infos.mp4_800 = nil;
        }
        
        if ([self.videofile.infos.mp4_1300_db isValidInfo]) {
            self.videofile.infos.mp4_1300 = self.videofile.infos.mp4_1300_db;
        }
        else {
            self.videofile.infos.mp4_1300 = nil;
        }
        
        if ([self.videofile.infos.mp4_720p_db isValidInfo]) {
            self.videofile.infos.mp4_720p = self.videofile.infos.mp4_720p_db;
        }
        else {
            self.videofile.infos.mp4_720p = nil;
        }
        
        if ([self.videofile.infos.mp4_1080p6m_db isValidInfo]) {
            self.videofile.infos.mp4_1080p3m = self.videofile.infos.mp4_1080p6m_db;
        }
        else {
            self.videofile.infos.mp4_1080p3m = nil;
        }
    }
}


/*
     付费片并且不支持试看
 */
- (BOOL)isPayVideoNotAllowedTrial {

    if (self.videoInfo.pay
        && self.validate != nil
        && self.validate.data != nil
        && [self.validate.data.tryTime integerValue] == 0) {
        
        return YES;
    }
    
    return NO;
}

@end

@implementation VFModelPBOCModule

@end

@implementation VFModelWapper
@end



