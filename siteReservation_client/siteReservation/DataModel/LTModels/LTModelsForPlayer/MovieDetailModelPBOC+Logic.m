//
//  PicCollectionModelPBOC+Logic.m
//  LeTVMobileDataModel
//
//  Created by jeason on 16/3/9.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "MovieDetailModelPBOC+Logic.h"
#import "NSString+MovieInfo.h"
#import "HistoryCommand.h"

@implementation MovieDetailModelPBOC(Logic)
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (instancetype)initWithVideoModel:(VideoModel*)model
{
    if (self = [super init]) {
        self.nameCn = [model.nameCn copy];
        self.subTitle = [model.subTitle copy];
        self.picCollections = model.picAll;
        //self.score = [[NSString alloc] initWithString:model.score];
        self.cid = [model.cid copy];
        self.type = model.type;
        self.at = 0;
        //self.atList =
        self.releaseDate = [model.releaseDate copy];
        self.episode = [model.episode/*JEASONepisode no del!!!!*/ copy];
        //self.__nowEpisodes =
        //self.__platformVideoNum = [[NSString alloc] initWithString:model]
        //self.platformVideoInfo =
        //self.__isEnd
        self.play = model.play;
        //self.albumTypeKey = [[NSString alloc] initWithString:model.al]
        self.duration = [model.duration/*JEASONduration(non del!!)*/ copy];
        //self.directory =
        //slef.starring =
        self.desc = [model.desc copy];
        //self.pidsubtitle =
        self.area = [model.area copy];
        self.subCategory = [model.subCategory copy];
        self.style = [model.style copy];
        //self.playTv = model.pl
        //self.school = mode
        self.language = [model.language copy];
        //self.instructor = [[NSString alloc] initWithString:model.in]
        self.tag = [model.tag copy];
        self.jump = model.jump;
        self.pay = model.pay;
        self.download = [NSString stringWithFormat:@"%d",model.download];
        self.pid = [model.pid copy];
        //self.__stamp = mode
        self.musicStyle = [model.musicStyle copy];
        self.singer = [model.singer copy];
        //self.filmstyle = [[NSString alloc] initWithString:model.];
        //self.travelType = [[NSString alloc] initWithString:model.];
        //self.__varietyShow = [[NSString alloc] initWithString:model.];
        //self.relationAlbumId = [[NSString alloc] initWithString:model.];
        //self.relationId = [[NSString alloc] initWithString:model.];
        self.playCount = [model.playCount copy];
        self.isSelected = [model.isSelected copy];
        //self.compere = [[NSString alloc] initWithString:model.com];
        self.controlAreas = [model.controlAreas copy];
        self.disableType = [model.disableType copy];
        //self.alias = [[NSString alloc] initWithString:model.al];
        //self.playStatus = [[NSString alloc] initWithString:model.];
        //self.cast = [[NSString alloc] initWithString:model.c];
        self.fitAge = [model.fitAge copy];
        //        self.originator = [[NSString alloc] initWithString:model.ori];
        //        self.supervise = [[NSString alloc] initWithString:model.su];
        //        self.dub = [[NSString alloc] initWithString:model.du];
        self.isHomemade = [model.isHomemade copy];
    }
    return self;
}


-(void)setPidWithNSString:(NSString*)pid
{
    self.pid = pid;
    
    if (![NSString empty:pid] && ![pid isEqualToString:@"0"] && [NSString empty:self.id]) {
        self.pid = pid;
    }
}

-(void)setIdWithNSString:(NSString*)id
{
    if(![NSString empty:id])
    {
        self.id = id;
    }
    if(![NSString isBlankString:id] && [NSString isBlankString:self.pid])
    {
        self.pid = id;
    }
}



#pragma mark - properties
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

- (void)setJumpWithNSString:(NSString*)jump
{
    self.jump = ([jump integerValue] == 1) ? TRUE : FALSE;
}

- (void)setPlayWithNSString:(NSString*)play
{
    self.play = ([play integerValue] == 1) ? TRUE : FALSE;
}

- (void)setPayWithNSString:(NSString*)pay
{
    self.pay = ([pay integerValue] == 1) ? TRUE : FALSE;
}

- (void)setAtWithNSString:(NSString*)at
{
    self.at = [NSString formateVideoAtValue:at];
}





#pragma mark - others

- (NSString *)getAlbumId
{
    if (![NSString isBlankString:self.pid]) {
        return self.pid;
    }
    
    return @"";
}

- (BOOL)isShortVideoSeries
{
    if (LT_VIDEO_AT_PLAY != self.at) {
        return NO;
    }
    
    if (VIDEO_FROM_VRS != self.type) {
        return NO;
    }
    
    NSString *aid = self.pid;
    if (    [NSString isBlankString:aid]
        ||  [aid isEqualToString:@"0"]) {
        return NO;
    }
    
    return YES;
}

// 是否支持缓存
- (BOOL)isDownloadSupported
{
    return (!self.jump && [self.download integerValue] == 1);
}

// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload
{
    return  ([self.isVipDownload integerValue] == 1) ? YES : NO;
}

- (NSString *)getUpdateInfo
{
    if (ALBUM_FROM_VRS != self.type) {
        return @"";
    }
    
    if (![NSString isBlankString:self.style]) {
        // 如果style不为空，通过style判断
        if (MovieShowWithMatrix != [self getMovieShowStyle]) {
            return @"";
        }
    }
    
    // 否则，根据cid判断
    if ([NSString isBlankString:self.cid]) {
        return @"";
    }
    if (    NewCID_Anime != [self.cid integerValue]
        &&  NewCID_TV != [self.cid integerValue]
        && NewCID_TVProgram != [self.cid integerValue]) {
        return @"";
    }
    
    if (NewCID_TVProgram == [self.cid integerValue]) {
        NSInteger episode = [self.episode integerValue];
        if ([self.download integerValue] == 1 && episode > 0) {
            return [NSString stringWithFormat:NSLocalizedString(@"%d期全", @"%d期全"), episode, NSLocalizedString(@"期全", nil)];
        }
        else if ([self.nowEpisodes length] >= 8) {
            NSString *month = [self.nowEpisodes substringWithRange:NSMakeRange(4, 2)];
            NSString *day = [self.nowEpisodes substringWithRange:NSMakeRange(6, 2)];
            return [NSString stringWithFormat:NSLocalizedString(@"%@-%@期", @"%@-%@期"), month, day];
        }
        else {
            return @"";
        }
    }
    
    if ( [self.download integerValue] == 1
        &&  [self.nowEpisodes integerValue] < [self.episode integerValue]) {
        if ([self.nowEpisodes integerValue] <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%@%@%@", NSLocalizedString(@"更新至", nil), self.nowEpisodes , NSLocalizedString(@"集", nil)];
        }
    }
    else{
        if ([self.episode integerValue] <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%@%@", self.episode, NSLocalizedString(@"集全", nil)];
        }
    }
    
    return @"";
    
}

- (NSString *)getAtUrl
{
    NSString *url = @"";
    switch (self.at) {
        case LT_VIDEO_AT_WEB:
            url = self.atList.atWeb.url;
            break;
        case LT_VIDEO_AT_WEB_INNER:
            url = self.atList.atWebInner.url;
            break;
        case LT_VIDEO_AT_LIVING:
            url = self.atList.atLiving.url_high;
            if ([NSString isBlankString:url]) {
                url = self.atList.atLiving.url_low;
            }
            break;
        default:
            break;
    }
    
    return url;
}


- (BOOL)isShareToStarcastSupported{
    
    if (self.pay) {
        // 会员频道不支持分享到大咔
        return NO;
    }
    return YES;
}



- (MovieShowStyle)getMovieShowStyle
{
    if (ALBUM_FROM_VRS == self.type) {
        if (1 == [self.style integerValue]) {
            return MovieShowWithMatrix;
        }
        else if (2 == [self.style integerValue]){
            if ([self getTotalCountOfVideoInfo] >= 2) {
                return MovieShowWithTable;
            }
        }
    }
    
    return MovieShowWithButton;
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

- (LTOrderInfo *)getOrderInfo{
    
    LTOrderInfo *orderInfo = [[LTOrderInfo alloc] init];
    
    orderInfo.productName = self.nameCn;
    orderInfo.singlePrice = 0.f;
    orderInfo.periodOfValidity = 0;;
    orderInfo.isExpired = NO;
    orderInfo.ptype = @"1";
    orderInfo.pid = self.pid;
    orderInfo.movieType = [NSString stringWithFormat:@"%d", self.type];
    orderInfo.movieTitle = self.nameCn;
    orderInfo.movieId = self.pid;
    orderInfo.isPaySuccess = NO;
    
    return orderInfo;
    
}
- (NSString *)getFavIcon
{
    NSString *imageUrl = @"";
    
    if (![NSString empty:self.picCollections.pic320_200]) {
        imageUrl = self.picCollections.pic320_200;
    }
    else if (![NSString empty:self.picCollections.pic200_150]) {
        imageUrl = self.picCollections.pic200_150;
    }
    else if (![NSString empty:self.picCollections.pic120_90]) {
        imageUrl = self.picCollections.pic120_90;
    }
    else if (![NSString empty:self.picCollections.pic150_200]) {
        imageUrl = self.picCollections.pic150_200;
    }
    else if (![NSString empty:self.picCollections.pic400_300]) {
        imageUrl = self.picCollections.pic400_300;
    }
    else if (![NSString empty:self.picCollections.pic300_300]) {
        imageUrl = self.picCollections.pic300_300;
    }
    
    return imageUrl;
}
- (NSString *)icon
{
    if (ALBUM_FROM_VRS == self.type) {
        if (self.picCollections.pic200_150.length > 0) {
            return self.picCollections.pic200_150;
        }
        return self.picCollections.pic150_200;
    }
    else{
        return self.picCollections.pic120_90;
    }
}

- (NSString *)getDownloadIcon
{
    if (![NSString isBlankString:self.picCollections.pic200_150]) {
        return self.picCollections.pic200_150;
    }
    if (![NSString isBlankString:self.picCollections.pic120_90]) {
        return self.picCollections.pic120_90;
    }
    return self.picCollections.pic150_200;
}

- (BOOL) isTVUpdating{
    
    if (    [self.cid integerValue] != NewCID_TV
        &&  [self.cid integerValue] != NewCID_Anime
        &&  [self.cid integerValue] != NewCID_TVProgram) {
        return NO;
    }
    return ([self.isEnd integerValue] == 1) ? TRUE : FALSE;;
}

- (BOOL)isNeedMergeVideoList
{
    return (1 != [self.style integerValue]);
    /*
     return (    ([self.cid integerValue] != NewCID_TV)
     &&  ([self.cid integerValue] != NewCID_Anime)
     &&  ([self.cid integerValue] != NewCID_TVProgram));
     */
}

- (BOOL)isNeedOrderVideoListDesc
{
    return (    [self.cid integerValue] == NewCID_TVProgram
            ||  [self.cid integerValue] == NewCID_Entertainment
            ||  [self.cid integerValue] == NewCID_Sport);
}

- (NSInteger)getTotalCountOfVideoInfo
{
    if ([self isNeedMergeVideoList]) {
        return [self.platformVideoNum integerValue];
    }
    else{
        /*
         return self.nowEpisodes;
         */
        return [self.platformVideoInfo integerValue];
    }
}

- (BOOL)isAlreadyFavorited
{
#ifdef LT_IPAD_CLIENT
    Boolean bUpdating = [self isTVUpdating];
    
    NSString *strFavOrFollow = [HistoryCommand getFavAndFollowStatusByMovieId:self.id
                                                              andUpdateStatus:bUpdating];
    BOOL bAlreadyFav = ![NSString isBlankString:strFavOrFollow];
    
    return bAlreadyFav;
#else
    return (nil != [HistoryCommand searchByMovieId:self.pid
                                       andDataType:DATA_TYPE_FAVORITE]);
#endif
}
//v5.3版本
- (BOOL)isAlreadyFav
{
    return (nil != [HistoryCommand searchByMovieIdOrPid:self.pid
                                            andDataType:DATA_TYPE_FAVORITE]);
}


-(BOOL)isMiniFilm{
    if([self.filmstyle integerValue]==43){
        return YES;
    }
    return NO;
    
}

- (BOOL)isShowWithGroup
{
    return ([self.varietyShow integerValue] == 1 || NewCID_TVProgram == [self.cid integerValue]);
}

@end


