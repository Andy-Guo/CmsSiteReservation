//
//  MovieDetailModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-2.
//
//

#import "MovieDetailModel.h"
//#import "NSString+HTTPExtensions.h"
#import "NSString+MovieInfo.h"
#import "HistoryCommand.h"

#ifndef LT_IPAD_CLIENT

@implementation MovieDetailModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"description"  : @"desc",
            }];
}

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
/*


@property (strong, nonatomic) NSString<Optional> *alias;            //别名(电影)
@property (strong, nonatomic) NSString<Optional> *playStatus;       //更新频率(电视剧、动漫、综艺)
@property (strong, nonatomic) NSString<Optional> *cast;              //声优(动漫)
@property (strong, nonatomic) NSString<Optional> *fitAge;            //适应年龄(动漫)                                          OK
@property (strong, nonatomic) NSString<Optional> *originator;        //原作(动漫)
@property (strong, nonatomic) NSString<Optional> *supervise;         //监督(动漫)
@property (strong, nonatomic) NSString<Optional> *dub;               //配音(动漫)
//@property (strong, nonatomic) NSString<Optional> *rCompany;         //节目来源(纪录片)
@property (strong, nonatomic) NSString<Optional> *isHomemade;        //是否为自制(0为否,1为是)*/


-(void)setPidWithNSString:(NSString*)pid
{
    _pid = pid;
    
    if (![NSString empty:pid] && ![pid isEqualToString:@"0"] && [NSString empty:_id]) {
        _id = pid;
    }
}

-(void)setIdWithNSString:(NSString*)id
{
    if(![NSString empty:id])
    {
        _id = id;
    }
    if(![NSString isBlankString:id] && [NSString isBlankString:_pid])
    {
        _pid = id;
    }
}


#pragma mark - convert
//- (BOOL)download
//{
//    return ([self.__download integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (BOOL)varietyShow
//{
//    return ([self.__varietyShow integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (BOOL)isEnd
//{
//    if ([NSString isBlankString:self.__isEnd]) {
//        return TRUE;
//    }
//    return ([self.__isEnd integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (NSInteger)episode
//{
//    return [self.__episode integerValue];
//}
//
//- (NSInteger)nowEpisodes
//{
//    return [self.__nowEpisodes integerValue];
//}
//
//- (NSInteger)platformVideoNum
//{
//    return [self.__platformVideoNum integerValue];
//}
//
//- (NSInteger)platformVideoInfo
//{
//    return [self.__platformVideoInfo integerValue];
//}

//- (LT_STAMP_TYPE)stamp
//{
//    return [NSString formatVideoStampType:self.stamp];
//}

#pragma mark - properties
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

- (void)setJumpWithNSString:(NSString*)jump
{
    _jump = ([jump integerValue] == 1) ? TRUE : FALSE;
}

- (void)setPlayWithNSString:(NSString*)play
{
    _play = ([play integerValue] == 1) ? TRUE : FALSE;
}

- (void)setPayWithNSString:(NSString*)pay
{
    _pay = ([pay integerValue] == 1) ? TRUE : FALSE;
}

- (void)setAtWithNSString:(NSString*)at
{
    _at = [NSString formateVideoAtValue:at];
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
    return  ([_isVipDownload integerValue] == 1) ? YES : NO;
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
    return [self.picCollections getImage320_200];
    
    /*
    if (![NSString isBlankString:self.picCollections.pic200_150] && self.picCollections.pic200_150.length > 0) {
        return self.picCollections.pic320_200;
    }else if (![NSString isBlankString:self.picCollections.pic200_150] && self.picCollections.pic320_200.length > 0) {
        return self.picCollections.pic320_200;
    }else if (![NSString isBlankString:self.picCollections.pic400_300] && self.picCollections.pic400_300.length > 0){
        return self.picCollections.pic400_300;
    }else if(![NSString isBlankString:self.picCollections.pic120_90] && self.picCollections.pic120_90.length > 0){
        return self.picCollections.pic120_90;
    }else if(![NSString isBlankString:self.picCollections.pic214_161] && self.picCollections.pic214_161.length > 0){
        return self.picCollections.pic214_161;
    }else if(![NSString isBlankString:self.picCollections.pic800_407] && self.picCollections.pic800_407.length > 0){
        return self.picCollections.pic800_407;
    }else if(![NSString isBlankString:self.picCollections.pic300_300] && self.picCollections.pic300_300.length > 0){
        return self.picCollections.pic300_300;
    }else if(![NSString isBlankString:self.picCollections.pic1024_387] && self.picCollections.pic1024_387.length > 0){
        return self.picCollections.pic1024_387;
    }
    else{
        return self.picCollections.pic150_200;
    }
     */
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
    if (![NSString isBlankString:self.picCollections.pic400_300]) {
        return self.picCollections.pic400_300;
    }
    if (![NSString isBlankString:self.picCollections.pic320_200]) {
        return self.picCollections.pic320_200;
    }
    if (![NSString isBlankString:self.picCollections.pic214_161]) {
        return self.picCollections.pic214_161;
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

#else

@implementation MovieDetailModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description"  : @"desc",
                                                       }];
}

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
    _pid = pid;
    
    if (![NSString empty:pid] && ![pid isEqualToString:@"0"] && [NSString empty:_id]) {
        _id = pid;
    }
}

-(void)setIdWithNSString:(NSString*)id
{
    if(![NSString empty:id])
    {
        _id = id;
    }
    if(![NSString isBlankString:id] && [NSString isBlankString:_pid]){
        _pid = id;
    }

}


#pragma mark - convert
//- (BOOL)varietyShow
//{
//    return ([self.__varietyShow integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (BOOL)download
//{
//    return ([self.__download integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (BOOL)isEnd
//{
//    if ([NSString isBlankString:self.__isEnd]) {
//        return TRUE;
//    }
//    return ([self.__isEnd integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (NSInteger)episode
//{
//    return [self.__episode integerValue];
//}
//
//- (NSInteger)nowEpisodes
//{
//    return [self.__nowEpisodes integerValue];
//}
//
//- (NSInteger)platformVideoNum
//{
//    return [self.__platformVideoNum integerValue];
//}
//
//- (NSInteger)platformVideoInfo
//{
//    return [self.__platformVideoInfo integerValue];
//}
//
//- (LT_STAMP_TYPE)stamp
//{
//    return [NSString formatVideoStampType:self.__stamp];
//}

#pragma mark - properties
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

- (void)setJumpWithNSString:(NSString*)jump
{
    _jump = ([jump integerValue] == 1) ? TRUE : FALSE;
}

- (void)setPlayWithNSString:(NSString*)play
{
    _play = ([play integerValue] == 1) ? TRUE : FALSE;
}

- (void)setPayWithNSString:(NSString*)pay
{
    _pay = ([pay integerValue] == 1) ? TRUE : FALSE;
}

- (void)setAtWithNSString:(NSString*)at
{
    _at = [NSString formateVideoAtValue:at];
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
    return (    !self.jump
            &&  self.download);
}


// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload
{
    return  ([_isVipDownload integerValue] == 1) ? YES : NO;
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
        &&  NewCID_TVProgram != [self.cid integerValue]) {
        return @"";
    }
    
    if (NewCID_TVProgram == [self.cid integerValue]) {
        NSInteger episode = [self episode];
        if (self.isEnd && episode > 0) {
            if ([NSString isBlankString:self.pid]) {
                return @"";
            }
            return [NSString stringWithFormat:NSLocalizedString(@"%d期全", @"%d期全"), episode, NSLocalizedString(@"期全", nil)];
        }
        else if ([self.nowEpisodes length] >= 8) {
            NSString *month = [self.nowEpisodes substringWithRange:NSMakeRange(4, 2)];
            NSString *day = [self.nowEpisodes substringWithRange:NSMakeRange(6, 2)];
            return [NSString stringWithFormat:NSLocalizedString(@"%@%@-%@期", @"%@%@-%@期"),NSLocalizedString(@"更新至", nil), month, day];
        }
        else {
            return @"";
        }
    }
    
    if (    !self.isEnd
        &&  self.nowEpisodes < self.episode) {
        if (self.nowEpisodes <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%@%d%@", NSLocalizedString(@"更新至", nil), self.nowEpisodes, NSLocalizedString(@"集", nil)];
        }
    }
    else{
        if (self.episode <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%d%@", self.episode, NSLocalizedString(@"集全", nil)];
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
    return [self.picCollections getImage320_200];
    
    /*
     if (![NSString isBlankString:self.picCollections.pic200_150] && self.picCollections.pic200_150.length > 0) {
     return self.picCollections.pic320_200;
     }else if (![NSString isBlankString:self.picCollections.pic200_150] && self.picCollections.pic320_200.length > 0) {
     return self.picCollections.pic320_200;
     }else if (![NSString isBlankString:self.picCollections.pic400_300] && self.picCollections.pic400_300.length > 0){
     return self.picCollections.pic400_300;
     }else if(![NSString isBlankString:self.picCollections.pic120_90] && self.picCollections.pic120_90.length > 0){
     return self.picCollections.pic120_90;
     }else if(![NSString isBlankString:self.picCollections.pic214_161] && self.picCollections.pic214_161.length > 0){
     return self.picCollections.pic214_161;
     }else if(![NSString isBlankString:self.picCollections.pic800_407] && self.picCollections.pic800_407.length > 0){
     return self.picCollections.pic800_407;
     }else if(![NSString isBlankString:self.picCollections.pic300_300] && self.picCollections.pic300_300.length > 0){
     return self.picCollections.pic300_300;
     }else if(![NSString isBlankString:self.picCollections.pic1024_387] && self.picCollections.pic1024_387.length > 0){
     return self.picCollections.pic1024_387;
     }
     else{
     return self.picCollections.pic150_200;
     }
     */
}


- (NSString *)icon
{
    
    if (![NSString empty:self.picCollections.pic400_300]) {
        return self.picCollections.pic400_300;
    }
    else if (![NSString empty:self.picCollections.pic200_150]) {
        return self.picCollections.pic200_150;
    }
    else if (![NSString empty:self.picCollections.pic150_200]) {
        return self.picCollections.pic150_200;
    }
    else if (![NSString empty:self.picCollections.pic120_90]) {
        return self.picCollections.pic120_90;
    }
    
    return @"";
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
    
    return !self.isEnd;
}

- (BOOL)isNeedMergeVideoList
{
#ifdef LT_IPAD_CLIENT
    return NO;
#else
    return (1 != [self.style integerValue]);
#endif
    /*
     return (    ([self.cid integerValue] != NewCID_TV)
     &&  ([self.cid integerValue] != NewCID_Anime)
     &&  ([self.cid integerValue] != NewCID_TVProgram));
     */
}

- (BOOL)isNeedOrderVideoListDesc
{
    return (    [self.cid integerValue] == NewCID_TVProgram
#ifdef LT_IPAD_CLIENT
            ||  [self.cid integerValue] == NewCID_Entertainment
            ||  [self.cid integerValue] == NewCID_Sport
#endif
            );
}


- (NSInteger)getTotalCountOfVideoInfo
{
    if ([self isNeedMergeVideoList]) {
        return self.platformVideoNum;
    }
    else{
        /*
        return self.nowEpisodes;
         */
        return self.platformVideoInfo;
    }
}

- (BOOL)isAlreadyFavorited
{
#ifdef LT_IPAD_CLIENT
    Boolean bUpdating = [self isTVUpdating];
    
    NSString *strFavOrFollow = [HistoryCommand getFavAndFollowStatusByMovieId:self.pid
                                                              andUpdateStatus:bUpdating];
    BOOL bAlreadyFav = ![NSString isBlankString:strFavOrFollow];
    
    return bAlreadyFav;
#else
    return (nil != [HistoryCommand searchByMovieId:self.pid
                                       andDataType:DATA_TYPE_FAVORITE]);
#endif
}


-(BOOL)isMiniFilm{
    if([self.filmstyle integerValue]==43){
        return YES;
    }
    return NO;
    
}


/** 
    是否是正片，都转化为正片、非正片两个术语。
    iPad 正片显示三栏，非正片显示两栏
 */
- (BOOL)isPositive {

    BOOL isPositive = NO;
    
    NSInteger cidInt = [self.cid integerValue];
    
    // 电视剧、电影、动漫、综艺
    if (cidInt == NewCID_TV || cidInt == NewCID_MOVIE || cidInt == NewCID_Anime || cidInt == NewCID_TVProgram) {
        if ([self platformVideoInfo] > 0) {
            isPositive = YES;
        }
    }
    else if (cidInt == NewCID_Entertainment || cidInt == NewCID_Car || cidInt == NewCID_News
             || cidInt == NewCID_Kids || cidInt == NewCID_Music || cidInt == NewCID_Finacial
             || cidInt == NewCID_Fasion || cidInt == NewCID_Tour) {
        if (self.varietyShow) {
            isPositive = YES;
        }
    }
    else if (cidInt == NewCID_Sport || cidInt == NewCID_NBA) {
        if (self.varietyShow) {
//            NSArray *videoTypes = [NSArray arrayWithObjects:@"182056", @"182206", @"182207", @"182208",
//                                   @"182209", @"182210", @"180211", @"180003", @"180004", @"182202",
//                                   @"182234", @"182235", @"182236", @"182238", @"182239", @"182240", nil];
//            
//            if (![NSString empty:self.videoType] && ![videoTypes containsObject:self.videoType]) {
//                isPositive = YES;
//            }
            
            isPositive = YES;
        }
    }
    else if (cidInt == NewCID_Documentary) {
        if (self.varietyShow) {
            isPositive = YES;
        }
    }
    
    return isPositive;
}


//typedef enum {
//    NewCID_UnDefine = -1,
//    
//    NewCID_AdaptivieChanel = -2, // 由于服务器不提供cid,现有的判断是基于cid来判断
//    NewCID_MOVIE  =1,
//    NewCID_TV     =2,
//    NewCID_Entertainment =3,
//    NewCID_Sport  =4,
//    NewCID_Anime  =5,
//    NewCID_Info  =6,
//    NewCid_Original =7,
//    NewCid_Other =8,
//    NewCID_Music =9,
//    NewCID_Happy =10,
//    NewCID_TVProgram =11,  //综艺
//    NewCID_Education =12,
//    NewCID_Life =13,
//    NewCID_Car =14,
//    NewCID_Variety =15,   //电视节目
//    NewCID_Documentary =16,
//    NewCID_OpenClass =17,
//    NewCID_LetvProduce =19,
//    NewCID_Fasion =20,
//    NewCID_Finacial =22,
//    NewCID_Tour =23,
//    NewCID_Home = 99,   // 首页
//    NewCID_NBA = 1004,
//    NewCID_Kids = 34,   //亲子 原来是1005,iPhone5.5版本改成了34
//    NewCID_News = 1009, //资讯
//    
//    NewCid_Vip =1000,
//    
//    Newcid_Dolby = 1001,  // 杜比频道
//    Newcid_Funny = 1010,    // 趣味(搞笑)专区 5.5新增
//    Newcid_H265 = 2001    // 4G专区
//    
//}NewMovieCid;

- (BOOL)isShowWithGroup
{
    return (    self.varietyShow
            ||  NewCID_TVProgram == [self.cid integerValue]);
}

@end



#endif
