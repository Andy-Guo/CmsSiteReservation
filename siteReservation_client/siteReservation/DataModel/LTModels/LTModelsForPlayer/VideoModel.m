//
//  VideoModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import "VideoModel.h"
#import "MovieDetailModel.h"
#import "LTDownloadCommand.h"
#import "NSString+MovieInfo.h"
//#import "NSString+HTTPExtensions.h"
#import "LTSubjectDetailModel.h"
#import "SettingManager+VideoCode.h"
#import "LTRequestURLDefine.h"
#import "RecommendModel.h"

@implementation VideoWatchingFocusModel

@end

@implementation LTVideoPosterModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"960*540" : @"pic1",
                                                       @"1080*608" : @"pic2"}];
}
@end

@implementation VideoModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

/*+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description"  : @"desc",
                                                       @"picAll"       : @"picAll",
                                                       @"episode"      : @"__episode",
                                                       @"porder"       : @"__porder",
                                                       @"brList"       : @"__brList",
                                                       @"btime"        : @"__btime",
                                                       @"etime"        : @"__etime",
                                                       @"duration"     : @"__duration",
                                                       @"album_pay"    : @"albumPay",
                                                       }];
}*/


+(JSONKeyMapper*)keyMapper
 {
     return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                         @"description"  : @"desc",
                                                         }];
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
    _jump = ([jump integerValue] == 1) ? TRUE : FALSE;
}


-(void)setPlayWithNSString:(NSString*)play
{
    _play = ([play integerValue] == 1) ? TRUE : FALSE;
}

-(void)setPayWithNSString:(NSString*)pay
{
    _pay = ([pay integerValue] == 1) ? TRUE : FALSE;
}

-(void)setDownloadWithNSString:(NSString*)download
{
    _download = ([download integerValue] == 1) ? TRUE : FALSE;
}

- (void)setTypeWithNSString:(NSString*)type
{
    switch ([type integerValue]) {
        case 1:
            _type = ALBUM_FROM_VRS;
            break;
        case 2:
            _type = VIDEO_FROM_PTV;
            break;
        case 3:
            _type = VIDEO_FROM_VRS;
            break;
        default:
            break;
    }
}


#pragma mark -
//- (NSInteger)episode
//{
//    return [_episode integerValue];
//}

//- (NSString *)episodeInfo
//{
//    return _episode;
//}

//- (NSInteger)porder
//{
//    return [_porder integerValue];
//}

//- (NSInteger)btime
//{
//    return [_btime integerValue];
//}

//- (NSInteger)etime
//{
//    return [_etime integerValue];
//}

//- (NSInteger)duration
//{
//    return [_duration integerValue];
//}

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
            &&  [self getInnerBrList]/*JEASONbrList no del!!!!*/.count > 0
            &&  !self.pay/*!notPay*/);
}

// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload
{
    return  ([_isVipDownload integerValue] == 1) ? TRUE : FALSE;
}

- (BOOL)isDownloadDisabledByVIP
{
    if ([self isDownloadSupported]) {
        return NO;
    }
    
    if (    !self.download
        ||  [self getInnerBrList]/*JEASONbrList no del!!!!*/.count <= 0) {
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
    _vid = vid;
    
    if (![NSString empty:vid]) {
        _id = vid;
    }
}

-(void)setIdWithNSString:(NSString*)id
{
    if([NSString empty:_id])
    {
        _id = id;
    }
    
    if (![NSString empty:id] && [NSString empty:self.vid]) {
        _vid = id;
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
    
    if ([self getInnerBrList]/*JEASONbrList no del!!!!*/.count <= 0) {
        return VIDEO_CODE_UNKNOWN;
    }
    
    // get default bitrate from setting manager
    VideoCodeType codeType = [SettingManager getDefaultBitrateOfDownload];
    if (![[self getInnerBrList]/*JEASONbrList no del!!!!*/ containsObject:[NSNumber numberWithInt:codeType]]) {
        // if not existed, get one from supported array
        codeType = (VideoCodeType)[[[self getInnerBrList]/*JEASONbrList no del!!!!*/ lastObject] integerValue];
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
    
    //cid不为1（电影）,且pay是1
    if (![self.cid isEqualToString:@"1"] && self.pay) {
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
        if ([NSString isBlankString:self.nameCn]) {
            self.nameCn = item.pidname;
        }
        self.subTitle = item.subname;
        if ([NSString isBlankString:item.subname]) {
            self.subTitle = item.pidsubtitle;
        }
        PicCollectionModel * pic = [[PicCollectionModel alloc]init];
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
        self.brList/*JEASONbrList no del!!!!*/ = item.brList;
        self.download = item.download;
        self.mid = item.mid;
        self.pidname = item.pidname;
    }

}
@end
