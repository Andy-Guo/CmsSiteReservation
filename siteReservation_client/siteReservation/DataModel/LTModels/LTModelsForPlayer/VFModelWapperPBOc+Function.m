//
//  VFModelWapperPBOc+Function.m
//  LTPBData
//
//  Created by 李宇航 on 16/2/29.
//  Copyright © 2016年 mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VFModelWapperPBOc+Function.h"

@implementation VideoFileItemPBOC(ModelFunction)

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

@implementation VideoFileModelPBOC(ModelFunction)


- (VideoFileItemPBOC*) getVideoFileItemByCodeRate: (VideoCodeType) vct
{
    BOOL isNeedDRM = [self.drmFlag integerValue] && ![DeviceManager isJailBreak];
    switch (vct) {
        case VIDEO_CODE_ULD:
            return isNeedDRM?self.drm_180_marlin:self.mp4_180;
            break;
        case VIDEO_CODE_LD:
            return isNeedDRM?self.drm_350_marlin:self.mp4_350;
            break;
        case VIDEO_CODE_SD:
            return isNeedDRM?self.drm_1000_marlin:self.mp4_1000;
            break;
        case VIDEO_CODE_HD:
            return isNeedDRM?self.drm_1300_marlin:self.mp4_1300;
            break;
        case VIDEO_CODE_720P:
            return isNeedDRM?self.drm_720p_marlin:self.mp4_720p;
            break;
        case VIDEO_CODE_1080P:
            return isNeedDRM?self.drm_1080p3m_marlin:self.mp4_1080p3m;
            break;
        default:
            break;
    }
    
    return nil;
}

- (VideoFileItemPBOC*) getVideoFileItemByCodeRate: (VideoCodeType) vct isDolbyVideo:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama
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
    NSString *uldString = @"mp4_180";
    NSString *ldString = @"mp4_350";
    NSString *sdString = @"mp4_1000";
    NSString *hdString = @"mp4_1300";
    NSString *hLdString = @"mp4_720p";
    NSString *hhLdString = @"mp4_1080p3m";
    
    if(isNeedDRM){
        uldString = @"drm_180_marlin";
        ldString = @"drm_350_marlin";
        sdString = @"drm_1000_marlin";
        hdString = @"drm_1300_marlin";
        hLdString = @"drm_720p_marlin";
        hhLdString = @"drm_1080p3m_marlin";
    }
    
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

- (LTVideoCodeType) getVideoCodeTypeFromVideoFileKey: (NSString*) vct
{
    if ([vct isEqualToString: @"mp4_180"] ||
        [vct isEqualToString: @"drm_180_marlin"]) {
        return LTVideoCodeTypeULD;
    }
    if ([vct isEqualToString: @"mp4_350"] ||
        [vct isEqualToString: @"mp4_350_360"] ||
        [vct isEqualToString: @"drm_350_marlin"]) {
        return LTVideoCodeTypeLD;
    }
    if ([vct isEqualToString: @"mp4_1000"] ||
        [vct isEqualToString: @"mp4_800_db"] ||
        [vct isEqualToString: @"mp4_1000_360"] ||
        [vct isEqualToString: @"mp4_800_360"] ||
        [vct isEqualToString: @"drm_1000_marlin"]) {
        return LTVideoCodeTypeSD;
    }
    if ([vct isEqualToString: @"mp4_1300"] ||
        [vct isEqualToString: @"mp4_1300_db"] ||
        [vct isEqualToString: @"mp4_1300_360"] ||
        [vct isEqualToString: @"drm_1300_marlin"]) {
        return LTVideoCodeTypeHD;
    }
    if ([vct isEqualToString: @"mp4_720p"] ||
        [vct isEqualToString: @"mp4_720p_db"] ||
        [vct isEqualToString: @"mp4_720p_360"] ||
        [vct isEqualToString: @"drm_720p_marlin"]) {
        return LTVideoCodeType720P;
    }
    if ([vct isEqualToString: @"mp4_1080p3m"] ||
        [vct isEqualToString: @"mp4_1080p6m_db"] ||
        [vct isEqualToString: @"mp4_1080p_360"] ||
        [vct isEqualToString: @"drm_1080p3m_marlin"]) {
        return LTVideoCodeType1080P;
    }
    return LTVideoCodeTypeUnkown;
}

- (NSArray*) getNotEmptyBitrate
{
    NSMutableArray* resultArrayBitrate = [NSMutableArray array];
    
    for (VideoCodeType vct = VIDEO_CODE_BEGIN; vct <= VIDEO_CODE_END; vct++) {
        VideoFileItemPBOC* videoFileItem = [self getVideoFileItemByCodeRate: vct];
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
        
        VideoFileItemPBOC* videoFileItem = [self getVideoFileItemByCodeRate: videoCodeType];
        
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

- (NSArray*) getSupportedBitrateOfDolbyType:(BOOL)isDolbyVideo isPanorama:(BOOL)isPanorama{
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
    
    VideoFileItemPBOC* currItem = [self getVideoFileItemByCodeRate: codeRateType];
    if (nil == currItem
        || ![currItem isValidInfo]) {
        return;
    }
    
    NSString* invaliadValue = [NSString stringWithFormat: @"%d", VideoFileUrlValidityType_invalid];
    
    if (![currItem.flag_mainUrl isEqualToString: invaliadValue]) {
        currItem.flag_mainUrl = invaliadValue;
        return;
    }
    
    if (![currItem.flag_backUrl0 isEqualToString: invaliadValue]) {
        currItem.flag_backUrl0 = invaliadValue;
        return;
    }
    
    if (![currItem.flag_backUrl1 isEqualToString: invaliadValue]) {
        currItem.flag_backUrl1 = invaliadValue;
        return;
    }
    
    if (![currItem.flag_backUrl2 isEqualToString: invaliadValue]) {
        currItem.flag_backUrl2 = invaliadValue;
        return;
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
    
    VideoFileItemPBOC* currItem = [self getVideoFileItemByCodeRate: codeRateType];
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
    
    VideoFileItemPBOC* currItem = [self getVideoFileItemByCodeRate: codeRateType];
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
    VideoFileItemPBOC* videoFileItem = [self getVideoFileItemByCodeRate: codeRateType];
    
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
    VideoFileItemPBOC* videoFileItem = nil;
    
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
    VideoFileItemPBOC* videoFileItem = [self getVideoFileItemByCodeRate: codeRateType];
    
    if (nil == videoFileItem
        || ![videoFileItem isValidInfo]) {
        return nil;
    }
    
    return videoFileItem.storePath;
}

@end

@implementation VideoModelPBOC(ModelFunction)

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

#pragma mark - self defined
+ (VideoModel *)videoModelWithSubjectVideoModel:(LTSubjectVideo *)subjectVideo
{
    if (!subjectVideo) {
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[subjectVideo toDictionary]];
    dict[@"mid"] = @"";
    dict[@"cid"] = @"";
    dict[@"pay"] = @"0";
    dict[@"pay"] = @"0";
    dict[@"jump"] = @"0";
    VideoModel *videoModel = [[VideoModel alloc] initWithDictionary:dict error:nil];
    if (videoModel) {
        videoModel.brList/*JEASONbrList no del!!!!*/ = @[@"mp4_180", @"mp4_350", @"mp4_1000", @"mp4_1300", @"mp4_720p", @"mp4_1080p3m"];
    }
    
    return videoModel;
    
}

+ (BOOL)isAlreadyDownloadCompleteWith:(NSString*)vid{
    
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:vid];
    if (nil != downloadInfo) {
        enum DownloadStatus status = (enum DownloadStatus)[downloadInfo.download_status intValue];
        return (DownloadStatusComplete == status);
    }
    
    return NO;
}

+ (LTDownloadCommand *)getDBDownloadedInfoWith:(NSString*)vid{
    
    if ([NSString isBlankString:vid]) {
        return nil;
    }
    
    LTDownloadCommand *resultDownloadInfo = [LTDownloadCommand searchByVID:vid];
    
    return resultDownloadInfo;
}

#pragma mark - properties
-(void)setJumpWithNSString:(NSString*)jump
{
    self.jump = ([jump integerValue] == 1) ? TRUE : FALSE;
}


-(void)setPlayWithNSString:(NSString*)play
{
    self.play = ([play integerValue] == 1) ? TRUE : FALSE;
}

-(void)setPayWithNSString:(NSString*)pay
{
    self.pay = ([pay integerValue] == 1) ? TRUE : FALSE;
}

-(void)setDownloadWithNSString:(NSString*)download
{
    self.download = ([download integerValue] == 1) ? TRUE : FALSE;
}

- (void)setTypeWithNSString:(NSString*)type
{
    switch ([type integerValue]) {
        case 1:
            self.type = ALBUM_FROM_VRS;
            break;
        case 2:
            self.type = VIDEO_FROM_PTV;
            break;
        case 3:
            self.type = VIDEO_FROM_VRS;
            break;
        default:
            break;
    }
}

/*
#pragma mark -
- (NSInteger)episode
{
    return [self.episode integerValue];
}

- (NSString *)episodeInfo
{
    return self.episode;
}

- (NSInteger)porder
{
    return [self.porder integerValue];
}

- (NSInteger)btime
{
    return [self.btime integerValue];
}

- (NSInteger)etime
{
    return [self.etime integerValue];
}

- (NSInteger)duration
{
    return [self.duration integerValue];
}

- (NSArray *)brList
{
    if (self.brList.count <= 0) {
        return nil;
    }
    
    NSMutableArray *resultArrayBitrate = [NSMutableArray array];
    for (VideoCodeType codeType = VIDEO_CODE_BEGIN; codeType <= VIDEO_CODE_END; codeType++) {
        NSString *strCodeValue = [NSString stringWithFormat:@"mp4_%@", [NSString formatBitrateValue:codeType]];
        if ([self.brList  containsObject:strCodeValue]) {
            [resultArrayBitrate addObject:@(codeType)];
        }
    }
    
    return resultArrayBitrate;
    
}*/

- (NSArray *)getInnerBrList
{
    if (self.brList/*JEASONbrList no del!!!!*/.count <= 0) {
        return nil;
    }
    
    NSMutableArray *resultArrayBitrate = [NSMutableArray array];
    for (VideoCodeType codeType = VIDEO_CODE_BEGIN; codeType <= VIDEO_CODE_END; codeType++) {
        NSString *strCodeValue = [NSString stringWithFormat:@"mp4_%@", [NSString formatBitrateValue:codeType]];
        NSNumber *numCodeValue = [[NSNumber alloc] initWithInt:codeType];
        if ([self.brList/*JEASONbrList no del!!!!*/  containsObject:strCodeValue]) {
            [resultArrayBitrate addObject:@(codeType)];
        }
        else if ([self.brList/*JEASONbrList no del!!!!*/  containsObject:numCodeValue]) {
            [resultArrayBitrate addObject:@(codeType)];
        }
    }
    
    return resultArrayBitrate;
}

#pragma mark - others
- (NSString *)icon
{
    if (![NSString isBlankString:self.picAll.pic300_300]) {
        return self.picAll.pic300_300;
    }
    
    if (![NSString isBlankString:self.picAll.pic200_150]) {
        return self.picAll.pic200_150;
    }
    
    return self.picAll.pic120_90;
}

- (NSString *)smallIcon {
    NSString *icon = @"";
    
    if (![NSString isBlankString:self.picAll.pic120_90]) {
        icon = self.picAll.pic120_90;
    }
    else if (![NSString isBlankString:self.picAll.pic200_150]) {
        icon = self.picAll.pic200_150;
    }
    else if (![NSString isBlankString:self.picAll.pic300_300]) {
        icon = self.picAll.pic300_300;
    }
    else if (![NSString isBlankString:self.picAll.pic400_300]) {
        icon = self.picAll.pic400_300;
    }
    
    return icon;
}

- (BOOL)isMainVideo
{
    return [self.videoType isEqualToString:@"0001"];
}

// 是否支持播放
- (BOOL)isPlaySupported
{
    return self.play;
}

// 是否支持下载
- (BOOL)isDownloadSupported
{
    /*
     BOOL notPay = (     self.pay
     &&   ![SettingManager isVipUser]);
     */
    return (    self.download
            &&  [self getInnerBrList].count > 0
            &&  !self.pay/*!notPay*/);
}

// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload
{
    return  ([self.isVipDownload integerValue] == 1) ? TRUE : FALSE;
}

- (BOOL)isDownloadDisabledByVIP
{
    if ([self isDownloadSupported]) {
        return NO;
    }
    
    if (    !self.download
        ||  [self getInnerBrList].count <= 0) {
        return NO;
    }
    
    if (self.pay) {
        return YES;
    }
    
    return NO;
}

- (NSString *)getJumpOutPlayUrl
{
    //iphoneV5.9 跳转地址有server端提供
    //#ifndef LT_IPAD_CLIENT
    if (![NSString isBlankString:self.jumplink]) {
        return [NSString safeString:self.jumplink];
    }
    //#endif
#ifdef LT_IPAD_CLIENT
    NSString *url = [NSString stringWithFormat:
                     LT_JUMPOUTPLAY_URL,
                     self.vid
                     ];
#else
    BOOL bAlbum = (     ![NSString isBlankString:self.pid]
                   &&   ![self.pid isEqualToString:@"0"]
                   &&   ![self.pid isEqualToString:self.vid]);
    NSString *url = [NSString stringWithFormat:
                     LT_JUMPOUTPLAY_URL,
                     [NSString stringWithFormat:@"%d", bAlbum],
                     bAlbum ? self.pid : self.vid,
                     bAlbum ? self.vid : @"0",
                     [NSString stringWithFormat:@"%d", [SettingManager getDefaultBitrateOfPlay]
                      ]
                     ];
#endif
    return url;
}

-(void)setVidWithNSString:(NSString*)vid
{
    self.vid = vid;
    
    if (![NSString empty:vid]) {
        self.id = vid;
    }
}

-(void)setIdWithNSString:(NSString*)id
{
    if([NSString empty:self.id])
    {
        self.id = id;
    }
    
    if (![NSString empty:id] && [NSString empty:self.vid]) {
        self.vid = id;
    }
}


- (BOOL) isAlreadyDownloaded
{
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    
    if (nil != downloadInfo) {
        return YES;
    }
    
    return NO;
}

- (BOOL) isAlreadyDownloading
{
    if ([NSString isBlankString:self.mid]) {
        return NO;
    }
    
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    
    if (nil != downloadInfo) {
        enum DownloadStatus status = (enum DownloadStatus)[downloadInfo.download_status intValue];
        return (DownloadStatusDownloading == status || DownloadStatusWait == status ||DownloadStatusPause == status);
    }
    
    return NO;
}

- (BOOL) isDownloadPause
{
    if ([NSString isBlankString:self.mid]) {
        return NO;
    }
    
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    
    if (nil != downloadInfo) {
        enum DownloadStatus status = (enum DownloadStatus)[downloadInfo.download_status intValue];
        return (DownloadStatusError == status || DownloadStatusPause == status);
    }
    
    return NO;
}

- (BOOL)isAlreadyDownloadComplete{
    
    if ([NSString isBlankString:self.mid] && [NetworkReachability connectedToNetwork]) {
        return NO;
    }
    
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    if (nil != downloadInfo) {
        enum DownloadStatus status = (enum DownloadStatus)[downloadInfo.download_status intValue];
        return (DownloadStatusComplete == status);
    }
    
    return NO;
}

- (LTDownloadCommand *) getDBDownloadedInfo{
    
    if ([NSString isBlankString:self.vid]) {
        return nil;
    }
    
    LTDownloadCommand *resultDownloadInfo = [LTDownloadCommand searchByVID:self.vid];
    
    return resultDownloadInfo;
}

- (VideoCodeType)getValidDownloadBitrate{
    
    if ([self getInnerBrList].count <= 0) {
        return VIDEO_CODE_UNKNOWN;
    }
    
    // get default bitrate from setting manager
    VideoCodeType codeType = [SettingManager getDefaultBitrateOfDownload];
    if (![[self getInnerBrList] containsObject:[NSNumber numberWithInt:codeType]]) {
        // if not existed, get one from supported array
        codeType = (VideoCodeType)[[[self getInnerBrList] lastObject] integerValue];
    }
    
    return codeType;
}

- (NSString *)getDisplayTitle
{
    NSString *titleDisplay = self.nameCn;
    //如果是音乐，title显示 歌曲名称和歌手
    if(![NSString isBlankString:self.singer])
    {
        titleDisplay = [NSString stringWithFormat:@"%@ %@",self.nameCn,self.singer];
    }
    if (NewCID_TVProgram == [self.cid integerValue]) {
        if (![NSString isBlankString:self.subTitle]) {
            if ([NSString isBlankString:self.episode/*JEASONepisode no del!!!!*/]) {
                titleDisplay = self.subTitle;
            }
            else{
                titleDisplay = [NSString stringWithFormat:@"%@:%@", self.episode/*JEASONepisode no del!!!!*/, self.subTitle];
            }
        }
    }
    return titleDisplay;
}
- (NSString *)getVipTag
{
    if (self.pay) {
        return @"VIP";
    }
    else{
        return @"";
    }
}

//是否是付费电视剧
- (BOOL) isTVSerialAndPay{
    if ([NSString isBlankString:self.cid] || !self.pay) {
        return NO;
    }
    
    //cid为2（电视剧）,且pay是1
    if ([self.cid isEqualToString:@"2"] && self.pay) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isPanorama
{
    if (self.vtypeFlag && [self.vtypeFlag length] > 0) {
        NSArray *vtypeFlagArray = [self.vtypeFlag componentsSeparatedByString:@","];
        if ([vtypeFlagArray count] > 0) {
            for (int i=0; i<[vtypeFlagArray count]; i++) {
                NSString *temp = [vtypeFlagArray objectAtIndex:i];
                if ([temp length] > 0) {
                    temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if ([temp isEqualToString:@"2"]) {
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}


- (BOOL)isDolbyVideo {
    if ([self.dolbyFlag isKindOfClass:[NSString class]]
        && [self.dolbyFlag isEqualToString:@"1"]) {
        return YES;
    }
    
    return NO;
}

- (void)convertToRecommendItem:(RecommendItem*)item
{
    if (item != nil) {
        self.vid = item.vid;
        self.pid = item.pid;
        self.cid = item.cid;
        self.nameCn = item.title;
        self.subTitle = item.subname;
        PicCollectionModelPBOC * pic = [[PicCollectionModelPBOC alloc]init];
        pic.pic320_200 = item.pic320_200;
        self.picAll = pic;
        self.type = VIDEO_FROM_VRS;
        self.jump = item.jump;
        self.duration/*JEASONduration(non del!!)*/ = item.duration;
        self.subCategory = item.subCategory;
        self.area = item.dataArea;
        self.releaseDate = item.releaseDate;
        self.style = item.style;
        self.videoTypeName = item.videoTypeName;
        self.singer = item.singer;
        self.playCount = item.playCount;
        self.cornerMark = item.cornerMark;
        self.brList = item.brList;
        self.download = item.download;
        self.mid = item.mid;
    }
    
}

@end

@implementation  MovieCanPlayDetailPBOC(ModelFunction)

- (MoviePayTicketType)moviePayTicketType{
    if ([self.ticketType isEqualToString:@"0"]) {
        return LT_TicketType_Vip;
    }
    
    if ([self.ticketType isEqualToString:@"1"]) {
        return LT_TicketType_General;
    }
    
    if ([NSString isBlankString:self.ticketType]) {
        return LT_TicketType_NotVip;
    }
    
    return LT_TicketType_NotVip;
    
}

@end

@implementation VFModelPBOC (Logic)

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

@implementation VFVideoFilePBOC (Logic)
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

