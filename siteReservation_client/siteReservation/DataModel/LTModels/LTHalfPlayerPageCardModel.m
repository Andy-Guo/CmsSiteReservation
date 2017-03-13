//
//  LTHalfPlayerPageCardModel.m
//  LeTVMobileDataModel
//
//  Created by bob on 15/8/26.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#ifdef LT_IPAD_CLIENT
#import "LTHalfPlayerPageCardModel.h"
#import "LTRequestURLDefine.h"
@implementation LTHalfPlayerPageCardModel

-(BOOL)isPostiveVideo
{
    BOOL isPositive = NO;
    
    NSInteger cidInt = [self.videoInfo.cid integerValue];

    // 电视剧、电影、动漫、综艺
    if (cidInt == NewCID_TV || cidInt == NewCID_MOVIE || cidInt == NewCID_Anime || cidInt == NewCID_TVProgram || cidInt == NewCid_Vip || cidInt == NewCID_Documentary ||  cidInt == Newcid_Education || cidInt == NewCID_Kids) {
        if ([self.videoInfo.videoTypeKey isEqualToString:kVideoTypePositive]) {
            isPositive = YES;
        }
    }
    else {
        if (self.albumInfo.varietyShow) {
            isPositive = YES;
            if (cidInt == NewCID_Sport || cidInt == NewCID_Finacial || cidInt == NewCID_OpenClass) {
                if (![self.videoInfo.videoTypeKey isEqualToString:kVideoTypePositive]) {
                    isPositive = NO;
                }
            }
        }
    }
    
    //综艺期数片段，走正片逻辑
    if (cidInt == NewCID_TVProgram && [self.videoInfo.videoTypeKey isEqualToString:kVideoTypeFragmentVideo] && ![NSObject empty:self.videoList.fragmentsVideoList.videoInfo] && [self.videoList.fragmentsVideoList videoWithVid:self.videoInfo.vid]) {
        isPositive = YES;
    }
    
    return isPositive;
    
}


-(LTPlayListDataType)getPlayListDataType
{
    if (self.ztList) {
        return LTPlayListDataSubjectListType;
    }else if([self isPostiveVideo]){
        return LTPlayListDataVideoListType;
    }else{
        return LTPlayListDataRecommendListType;
    }
}


-(NSString*)getEpsoideCardSubTitleDisplay:(BOOL)isHalf
{
    NSInteger cid=[self.albumInfo.cid integerValue];
    
    NSString * titleText = @"";
    
    MovieShowStyle style = self.videoList.style;
    
    //按月显示
    if ((style == MovieShowWithDate) &&
        (cid == NewCID_Documentary || cid == NewCID_TVProgram || cid == NewCID_Sport)) {
        if (self.albumInfo.isEnd) {
            if (![NSString isBlankString:self.albumInfo.platformVideoInfo]) {
                titleText = [titleText stringByAppendingFormat:@"%@%@%@",[NSString safeString:self.albumInfo.platformVideoInfo],NSLocalizedString(@"期",nil),NSLocalizedString(@"全",nil)];
            }
        }else if (![NSString isBlankString:self.albumInfo.nowEpisodes]) {
            NSString *dayString = [NSString getDayNSString:self.albumInfo.nowEpisodes];
            if ([NSString isBlankString:dayString] && ![NSString isBlankString:self.albumInfo.nowEpisodes]) {
                dayString = self.albumInfo.nowEpisodes;
            }
            if (![NSString isBlankString:dayString]) {
                titleText = [titleText stringByAppendingFormat:@"%@%@%@",NSLocalizedString(@"更新至",nil),dayString,NSLocalizedString(@"期", nil)];
            }
        }
    }else if((style == MovieShowWithMatrix) &&
             (cid == NewCID_Anime || cid == NewCID_TV)){
        if (self.albumInfo.isEnd) {
            titleText = [NSString stringWithFormat:@"%ld%@",(long)self.albumInfo.episode, NSLocalizedString(@"集全", nil)];
        }else{
            titleText = [NSString stringWithFormat:@"%@%ld%@/%@%ld%@",
                         NSLocalizedString(@"更新至", nil),
                         (long)self.albumInfo.nowEpisodes,
                         NSLocalizedString(@"集", nil),
                         NSLocalizedString(@"共", nil),
                         (long)self.albumInfo.episode,
                         NSLocalizedString(@"集", nil)];
            
            //部分动漫没有总集数
            if (cid == NewCID_Anime && self.albumInfo.episode <= 0) {
                titleText = [NSString stringWithFormat:@"%@%ld%@",NSLocalizedString(@"更新至", nil),(long)self.albumInfo.nowEpisodes,NSLocalizedString(@"集", nil)];
            }
        }
        
    }else {
        if (isHalf && (style == MovieShowWithTable)) {
            NSDictionary *videoList = self.videoList.videoList;
            if (videoList && [videoList isKindOfClass:[NSDictionary class]]) {
                NSInteger totalNum = [[videoList objectForKey:@"totalNum"] integerValue];
                if (totalNum > 0) {
                    titleText = [NSString stringWithFormat:@"%ld", (long)totalNum];
                }
            }
        }
    }
    return [NSString safeString:titleText];
}

- (NSString *)getFullScreenTitleName{
    NSString * title = NSLocalizedString(@"剧集", nil);
    
    if ([self getPlayListDataType] == LTPlayListDataSubjectListType) {
        if (self.ztList.desc.type == LTSubjectTypeAlbum) {
            if ([self getEpisodeCardStyle] == MovieShowWithDate) {
                title = NSLocalizedString(@"期数", nil);
            }else{
                title = NSLocalizedString(@"剧集", nil);
            }
            
        }else{
            title = NSLocalizedString(@"列表", nil);
        }
    }else{
        if ([self getPlayListDataType] == LTPlayListDataVideoListType) {
            if ([self getEpisodeCardStyle] == MovieShowWithDate) {
                title = NSLocalizedString(@"期数", nil);
            }else{
                if ([self getEpisodeCardStyle] == MovieShowWithMatrix) {
                    title = NSLocalizedString(@"剧集", nil);
                }else{
                    title = NSLocalizedString(@"列表", nil);
                }
            }
        }else if ([self getPlayListDataType] == LTPlayListDataRecommendListType) {
            title = NSLocalizedString(@"相关", nil);
        }
    }
    
    return title;
}



-(MovieShowStyle)getEpisodeCardStyle;
{
    MovieShowStyle style = MovieShowWithUnknown;
    if (self.ztList) {
        style = self.ztList.style;
    }else{
        style = self.videoList.style;
    }
    return style;
}


-(VideoListModel*)getEpisodeVideoList
{
    VideoListModel * videoListModel = nil;
    if (self.ztList) {
        if (self.ztList.style == MovieShowWithDate) {
            videoListModel = self.ztList.varityShowModel.videoListModel;
        }else{
            videoListModel = self.ztList.commonVideoList;
        }
    }else{
        if (self.videoList.style == MovieShowWithDate) {
            videoListModel = self.videoList.varityShowModel.videoListModel;
        }else{
            videoListModel = self.videoList.commonVideoList;
        }
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    if (![NSObject empty:videoListModel.previewList]) {
        NSMutableArray * videos = [[NSMutableArray alloc]init];
        if (![NSObject empty:videoListModel.videoInfo]) {
            [videos addObjectsFromArray:videoListModel.videoInfo];
        }
        [videoListModel.previewList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            VideoModel * v = (VideoModel*)obj;
            if (![videos containsObject:v]) {
                [videos addObject:v];
            }
        }];
        videoListModel.videoInfo = videos;
    }
#pragma clang diagnostic pop

    return videoListModel;
}

-(VarityShowVideoListModel*)getVarityShowVideoListModel
{
    VarityShowVideoListModel * videoListModel = nil;
    if (self.ztList) {
        videoListModel = self.ztList.varityShowModel;
    }else{
        videoListModel = self.videoList.varityShowModel;
    }
    return videoListModel;
}


-(NSArray*)getEpisodeRegionItemArrayWithVideoList:(VideoListModel *)videoList withVarityShowVideoList:(VarityShowVideoListModel *)varityShowInfo withStyle:(MovieShowStyle)movieShowStyle
{
    __block NSMutableArray * regionItems = [[NSMutableArray alloc]init];
    
    NSInteger totalRegionCount = NUMBER_OF_ROW([videoList.totalNum integerValue], LT_VIDEOLIST_REQUEST_NUM);
    
    if (movieShowStyle == MovieShowWithDate) {
        totalRegionCount = varityShowInfo.arrayOrderedYears.count;
    }
    
    @synchronized(self) {
        dispatch_queue_t queue = dispatch_queue_create([@"setter" UTF8String], NULL);
        @try {
            dispatch_apply(totalRegionCount, queue, ^(size_t index) {
                LTEpisodeRegionItem *item = [[LTEpisodeRegionItem alloc] init];
                item.movieDetail = self.albumInfo;
                if (movieShowStyle == MovieShowWithDate) {
                    item.totalYears = varityShowInfo.arrayOrderedYears;
                    item.pageIndex = index;
                    item.currPageIndex = varityShowInfo.indexForYearList;
                    item.year = OBJECT_OF_ATINDEX(varityShowInfo.arrayOrderedYears, index);
                    item.currentYear = varityShowInfo.currentYear;
                    item.regionName = [NSString safeString:[NSString stringWithFormat:@"%@%@",item.year,NSLocalizedString(@"年", nil)]];
                    item.style = movieShowStyle;
                    if (item.currPageIndex == item.pageIndex) {
                        item.videoList = varityShowInfo.videoListModel;
                    }
                }else{
                    item.regionName = [NSString safeString:[NSString stringWithFormat:@"%lu-%lu",LT_VIDEOLIST_REQUEST_NUM*index +1,LT_VIDEOLIST_REQUEST_NUM*(index+1)]];
                    item.totalNum = [videoList.totalNum integerValue];
                    item.pageIndex = index;
                    item.style = movieShowStyle;
                    item.currPageIndex = [videoList.__pagenum integerValue] - 1;
                    if (item.currPageIndex < 0) {
                        item.currPageIndex = 0;
                    }
                    if (item.currPageIndex == item.pageIndex) {
                        item.videoList = videoList;
                    }
                    
                }
                if (totalRegionCount - 1 == index) {
                    item.isLastItem = YES;
                    if (movieShowStyle != MovieShowWithDate) {
                        item.regionName = [NSString safeString:[NSString stringWithFormat:@"%lu-%@",LT_VIDEOLIST_REQUEST_NUM*index +1,videoList.totalNum]];
                    }
                }
                
                [regionItems addObject:item];
                
                
            });
            
            //兼容电影频道正片模板，把周边视频数据插入普通剧集列表
            if (movieShowStyle != MovieShowWithDate) {
                LTEpisodeRegionItem * firstItem = OBJECT_OF_ATINDEX(regionItems, 0);
                VideoListModel * originVideoList = firstItem.videoList;
                if (originVideoList) {
                   originVideoList = [self combineOuterVideoLisToVideoList:originVideoList];
                    firstItem.videoList = originVideoList;
                    [regionItems replaceObjectAtIndex:0 withObject:firstItem];
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            ;
        }
        queue = nil;
    }
    return regionItems;
}


-(VideoListModel*)combineOuterVideoLisToVideoList:(VideoListModel*)videoListModel
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"

    if ([self.videoInfo.cid integerValue] != NewCID_MOVIE) {
        return videoListModel;
    }
    if (![self isPostiveVideo]) {
        return videoListModel;
    }
    if ([NSObject empty:videoListModel.videoInfo]) {
        return videoListModel;
    }
    if (![NSObject empty:self.outerVideoList.otherVideos.videoInfo]) {
        NSMutableArray * originVideoes = [[NSMutableArray alloc]initWithArray:videoListModel.videoInfo];
        VideoModel *firstModel = OBJECT_OF_ATINDEX(self.outerVideoList.otherVideos.videoInfo, 0);
        // 去重处理，如果已经拼接过，就不再拼接
        if (firstModel && [originVideoes containsObject:firstModel]) {
            return videoListModel;
        }
        [originVideoes addObjectsFromArray:self.outerVideoList.otherVideos.videoInfo];
        videoListModel.videoInfo = originVideoes;
    }
    return videoListModel;
#pragma clang diagnostic pop

}


@end

@implementation LTPageCardPlayerInfoModel

@end

@implementation LTPageCardZanCaiCountModel

@end

@implementation LTPageCardZanCaiModel

@end

@implementation LTEpisodeRegionItem

// 反序列化自身包括子类
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int propertyCount = 0;
        objc_property_t *propertyList = class_copyPropertyList(self.class, &propertyCount);
        for (unsigned i = 0; i < propertyCount; i++) {
            objc_property_t property = propertyList[i];
            NSString * propertyName= [NSString stringWithUTF8String:property_getName(property)];
            @try {
                id value = [aDecoder decodeObjectForKey:propertyName];
                [self setValue:value forKey:propertyName];
            }@catch (NSException *exception) {
            }
        }
        free(propertyList);
    }
    return self;
}

// 序列化自身包括子类
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(self.class, &propertyCount);
    for (unsigned i = 0; i < propertyCount; i++) {
        objc_property_t property = propertyList[i];
        NSString * propertyName= [NSString stringWithUTF8String:property_getName(property)];
        @try {
            id value = [self valueForKey:propertyName];
            [aCoder encodeObject:value forKey:propertyName];
        }@catch (NSException *exception) {
        }
    }
    free(propertyList);
}


-(BOOL)isContainPlayingVid:(NSString *)playingVid
{
    
    __block BOOL flag = NO;
    if ([NSString isBlankString:playingVid]) {
        return flag;
    }
    if (![NSObject empty:self.videoList.videoInfo]) {
        [self.videoList.videoInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            VideoModel * video=(VideoModel*)obj;
            
            if ([video.vid isEqualToString:playingVid]) {
                flag = YES;
                *stop = flag;
            }
        }];
    };
    
    return flag;
}

@end

@implementation LTPageCardVideoListModel

-(void)setStyleWithNSString:(NSString*)style
{
    _style = (MovieShowStyle)[style integerValue];
}

-(void)setVideoList:(NSDictionary *)videoList
{
    _videoList = videoList;
    
    if ([NSObject empty:videoList]) {
        return;
    }
    if (_style == MovieShowWithDate) {
        _varityShowModel = [VarityShowVideoListModel varityShowVideoListModelWithDict:videoList];
    }else{
        _commonVideoList = [[VideoListModel alloc]initWithDictionary:videoList error:nil];
    }

}

-(void)setFragments:(NSArray *)fragments
{
    _fragments = fragments;
    
    if (![NSObject empty:fragments]) {
        _fragmentsVideoList = [VideoListModel videoListModelWithVideoJsonArray:fragments];
    }
}

-(id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        _style = (MovieShowStyle)[[dict valueForKey:@"style"] integerValue];
    }
    return self;
}

@end

@implementation LTPageCardOuterVideoListModel

@end

@implementation LTPageCardStar
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"tDescription"}];
}
@end

@implementation LTPageCardStarVideoModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"aid"  : @"pid",
                                                       }];
}

- (NSString *)getVideoDisplayName{
    NSString *videoName = @"";
    if(![NSString isBlankString:self.categoryName]){
        videoName = [videoName stringByAppendingString:[NSString stringWithFormat:@"%@ 丨 ",self.categoryName]];
    }
    if (![NSString isBlankString:self.name]) {
        videoName = [videoName stringByAppendingString:self.name];
    }
    return videoName;

}
@end

@implementation LTPageCardStarItem
- (void)setVideoList:(NSArray<Optional,LTPageCardStarVideoModel> *)videoList{
    
    if ([NSObject empty:videoList]) {
        _videoList = nil;
        return;
    }
    
    NSMutableArray *tempVideoList = [NSMutableArray arrayWithArray:videoList];
    NSMutableArray *resultVideoList =[[NSMutableArray alloc] initWithCapacity:2];
    if (tempVideoList.count > 2) {

        while (resultVideoList.count != 2 && tempVideoList.count != 0) {
            int index = arc4random()%tempVideoList.count;
            if (![NSObject empty:OBJECT_OF_ATINDEX(tempVideoList, index)]) {
                [resultVideoList addObject:OBJECT_OF_ATINDEX(tempVideoList, index)];
                [tempVideoList removeObjectAtIndex:index];
            }
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
        _videoList = resultVideoList;
#pragma clang diagnostic pop
    }else{
        _videoList = videoList;
    }
}

- (BOOL)isFocused{
    if ([self.focusStatus isEqualToString:@"YES"]) {
        return YES;
    }
    return NO;
}

- (void)setFocus:(BOOL)focus{
    if (focus) {
        self.focusStatus = @"YES";
    }else{
        self.focusStatus = @"NO";
    }
}
@end


@implementation LTPageCardStarRecommendModel

- (NSString *)getAllStarId{
    NSString *starId = @"";
    
    for (int i = 0; i < self.starRecommend.count; i++) {
        LTPageCardStarItem *starItem = [self.starRecommend objectAtIndex:i];
        if (i == self.starRecommend.count - 1) {
            starId = [starId stringByAppendingString:[NSString stringWithFormat:@"%@",starItem.star.leId]];
        }else{
            starId = [starId stringByAppendingString:[NSString stringWithFormat:@"%@,",starItem.star.leId]];
        }
    }
    
    return starId;
}

- (void)synchroFocusState:(NSDictionary *)focusDic{
    for (LTPageCardStarItem *starItem in self.starRecommend) {
         NSNumber *focusState = focusDic[starItem.star.leId];
        if ([focusState integerValue] == 1) {
            [starItem setFocus:YES];
        }else{
            [starItem setFocus:NO];
        }
    }
    
    self.synchroFocusStateFlag = @"YES";
}

- (BOOL)isSynchronized{
    if ([self.synchroFocusStateFlag isEqualToString:@"YES"]) {
        return YES;
    }
    return NO;
}

- (void)setNoNeedSynchro{
    self.synchroFocusStateFlag = @"YES";
}

- (void)setNeedSynchro{
    self.synchroFocusStateFlag = @"NO";
}
@end

@implementation LTPageCardRelateModel
- (NSInteger)indexOfItemWithVid:(NSString *)vid
{
    NSInteger countOfItems = self.recData.count;
    for (NSInteger i = 0; i < countOfItems; i++) {
        RecommendItem *item = self.recData[i];
        if (    [item isValidSingleVideoRecommendItem]
            &&  [vid isEqualToString:item.vid]) {
            return i;
        }
    }
    
    return -1;
}

- (RecommendItem *)itemWithVid:(NSString *)vid
{
    NSInteger countOfItems = self.recData.count;
    for (NSInteger i = 0; i < countOfItems; i++) {
        RecommendItem *item = self.recData[i];
        if (    [item isValidSingleVideoRecommendItem]
            &&  [vid isEqualToString:item.vid]) {
            return item;
        }
    }
    
    return nil;
}

- (RecommendItem *)nextValidSingleVideoRecommendItemAfterItemWithVid:(NSString *)vid
{
    NSInteger indexOfCurrItem = [self indexOfItemWithVid:vid];
    NSInteger nextBeginIndex = 0;
    if (indexOfCurrItem >= 0) {
        nextBeginIndex = indexOfCurrItem + 1;
    }
    
    NSInteger countOfItems = self.recData.count;
    for (NSInteger i = nextBeginIndex; i < countOfItems; i++) {
        RecommendItem *item = self.recData[i];
        if ([item isValidSingleVideoRecommendItem]) {
            return item;
        }
    }
    return nil;
}

@end

@implementation LTPageCardRecommendModel

@end

@implementation LTPageCardYourLikeModel

@end

@implementation LTPageCardMusicOriginalElemModel

@end

@implementation LTPageCardRelatePostiveModel

@end

@implementation LTPageCardCMSItem

@end

@implementation LTPageCardMusicOriginalModel

@end

@implementation LTPageCardCMSSpredModel

@end

@implementation LTPageCardCMSGameSpredModel

@end


@implementation LTPageCardCMSOperateModel

-(void)setCmsOperateList:(NSArray<Optional> *)cmsOperateList
{
    _cmsOperateList = cmsOperateList;
    
    if (![NSObject empty:_cmsOperateList]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
        _cmsItems = [[NSMutableArray alloc]init];
#pragma clang diagnostic pop

        [_cmsOperateList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary * dict = (NSDictionary*)obj;
            if (![NSObject empty:dict]) {
                LTPageCardCMSItem * item = [[LTPageCardCMSItem alloc]initWithDictionary:dict error:nil];
                if (item) {
                    [_cmsItems addObject:item];
                }
            }
        }];
    }
}
@end

@implementation LTPageCardIntroModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"nameCn"  : @"name",
                                                       }];
}

- (void)setTypeWithNSString:(NSString*)type
{
    switch ([type integerValue]) {
        case 1:
            _type = LTSubjectTypeAlbum;
            break;
        case 3:
            _type = LTSubjectTypeVideo;
            break;
        default:
            _type = LTSubjectTypeUnknown;
            break;
    }
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation LTPageCardRedPackageInfoModel

@end

@implementation LTPageCardRedPackageModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"package"  : @"packageInfo",
                                                       }];
}

@end

@implementation LTPageCardSubjectModel


-(void)setVideoList:(NSDictionary *)videoList
{
    _videoList = videoList;
    _style = (MovieShowStyle)[[videoList valueForKeyPath:@"style"] integerValue];

    if ([NSObject empty:videoList]) {
        return;
    }
    if (_style == MovieShowWithDate) {
        _varityShowModel = [VarityShowVideoListModel varityShowVideoListModelWithDict:videoList];
    }else{
        _commonVideoList = [[VideoListModel alloc]initWithDictionary:videoList error:nil];
    }
    
}


-(id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        _style = (MovieShowStyle)[[dict valueForKeyPath:@"videoList.style"] integerValue];
    }
    return self;
}

- (NSInteger)indexOfSubjectAlbumWithPid:(NSString*)pid
{
    if ([NSString isBlankString:pid]) {
        return -1;
    }
    
    for (int i = 0; i < self.albumList.count; i++) {
        MovieDetailModel *subjectAlbum = self.albumList[i];
        if ([subjectAlbum.pid isEqualToString:pid]) {
            return i;
        }
    }
    
    return -1;
}

- (MovieDetailModel *)subjectAlbumWithPid:(NSString *)pid
{
    NSInteger idx = [self indexOfSubjectAlbumWithPid:pid];
    if (idx < 0) {
        return nil;
    }
    
    return self.albumList[idx];
}

- (MovieDetailModel *)firstValidSubjectAlbumWithPid:(NSString *)pid
{
    MovieDetailModel *currSubjectAlbum = [self subjectAlbumWithPid:pid];
    if (    nil == currSubjectAlbum
        &&  self.albumList.count > 0) {
        currSubjectAlbum = self.albumList.firstObject;
    }
    if (!currSubjectAlbum) {
        return nil;
    }
    
    if ([currSubjectAlbum play]) {
        return currSubjectAlbum;
    }
    
    return [self nextValidSubjectAlbumWithPid:currSubjectAlbum.pid];
}

- (MovieDetailModel *)nextValidSubjectAlbumWithPid:(NSString *)pid
{
    NSInteger idx = [self indexOfSubjectAlbumWithPid:pid];
    if (idx < 0) {
        return [self firstValidSubjectAlbumWithPid:nil];
    }
    
    NSInteger countAlbums = self.albumList.count;
    for (NSInteger i = idx+1; i < countAlbums; i++) {
        MovieDetailModel *subjectAlbum = self.albumList[i];
        if (    subjectAlbum
            &&  [subjectAlbum play]) {
            return subjectAlbum;
        }
    }
    
    return nil;
}

- (NSInteger)indexOfSubjectVideoWithVid:(NSString*)vid
{
    if ([NSString isBlankString:vid]) {
        return -1;
    }
    NSArray * videoes = nil;
    if (self.style == MovieShowWithDate) {
        videoes = self.varityShowModel.videoListModel.videoInfo;
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        videoes = self.commonVideoList.videoInfo;
    }
    if (![NSObject empty:videoes]) {
        for (int i = 0; i < videoes.count; i++) {
            VideoModel *video = videoes[i];
            if ([video.vid isEqualToString:vid]) {
                return i;
            }
        }
    }
    
    return -1;
}

- (VideoModel *)subjectVideoWithVid:(NSString *)vid
{
    NSInteger idx = [self indexOfSubjectVideoWithVid:vid];
    if (idx < 0) {
        return nil;
    }
    VideoModel * video = nil;
    if (self.style == MovieShowWithDate) {
        video = self.varityShowModel.videoListModel.videoInfo[idx];
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        video = self.commonVideoList.videoInfo[idx];
    }
    
    return video;
}

- (VideoModel *)nextValidSubjectVideoWithVid:(NSString *)vid
{
    //如果是专辑专题包，proces中连播、后推荐反查时不查这个list
    if (self.desc.type == LTSubjectTypeAlbum) {
        return nil;
    }
    NSInteger idx = [self indexOfSubjectVideoWithVid:vid];
    if (idx < 0) {
        return [self firstValidSubjectVideoWithVid:nil];
    }
    
    NSArray * videoes = nil;
    if (self.style == MovieShowWithDate) {
        videoes = self.varityShowModel.videoListModel.videoInfo;
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        videoes = self.commonVideoList.videoInfo;
    }
    
    NSInteger countVideos = videoes.count;
    for (NSInteger i = idx+1; i < countVideos; i++) {
        VideoModel *subjectVideo = videoes[i];
        if (    subjectVideo
            &&  [subjectVideo isPlaySupported]) {
            return subjectVideo;
        }
    }
    
    return nil;
}

- (VideoModel *)firstValidSubjectVideoWithVid:(NSString *)vid
{
    VideoModel *currSubjectVideo = [self subjectVideoWithVid:vid];
    
    if (self.style == MovieShowWithDate) {
        if (    nil == currSubjectVideo
            &&  self.varityShowModel.videoListModel.videoInfo.count > 0) {
            currSubjectVideo = self.varityShowModel.videoListModel.videoInfo.firstObject;
        }
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        if (    nil == currSubjectVideo
            &&  self.commonVideoList.videoInfo.count > 0) {
            currSubjectVideo = self.commonVideoList.videoInfo.firstObject;
        }
    }
    
    if (!currSubjectVideo) {
        return nil;
    }
    
    if ([currSubjectVideo isPlaySupported]) {
        return currSubjectVideo;
    }
    
    return [self nextValidSubjectVideoWithVid:currSubjectVideo.vid];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
#else


#import "LTHalfPlayerPageCardModel.h"
#import "LTRequestURLDefine.h"
@implementation LTHalfPlayerPageCardModel

-(BOOL)isPostiveVideo
{
    BOOL isPositive = NO;
    
    NSInteger cidInt = [self.videoInfo.cid integerValue];

    // 电视剧、电影、动漫、综艺
    if (cidInt == NewCID_TV || cidInt == NewCID_MOVIE || cidInt == NewCID_Anime || cidInt == NewCID_TVProgram || cidInt == NewCid_Vip || cidInt == NewCID_Documentary ||  cidInt == Newcid_Education || cidInt == NewCID_Kids) {
        if ([self.videoInfo.videoTypeKey isEqualToString:kVideoTypePositive]) {
            isPositive = YES;
        }
    }
    else {
        if ([self.albumInfo.varietyShow integerValue] == 1 ) {
            isPositive = YES;
            if (cidInt == NewCID_Sport || cidInt == NewCID_Finacial || cidInt == NewCID_OpenClass) {
                if (![self.videoInfo.videoTypeKey isEqualToString:kVideoTypePositive]) {
                    isPositive = NO;
                }
            }
        }
    }
    
    //综艺期数片段，走正片逻辑
    if (cidInt == NewCID_TVProgram  && ![NSObject empty:self.videoList]) {
        isPositive = YES;
    }
    
    return isPositive;
    
}

- (LTPageCardVideoListModel *)videoList
{
    if (_videoList) {
        return _videoList;
    }
    if (self.ztList) {  // 视频专题的配置数据转换为剧集的配置
        _videoList = [[LTPageCardVideoListModel alloc] init];
        NSDictionary *ztVideoList = self.ztList.videoList;
        _videoList.nStyle = ztVideoList[@"nStyle"];
        _videoList.rows = ztVideoList[@"rows"];
        _videoList.style = self.ztList.style;
        if (_videoList.style == MovieShowWithDate) {
            if ([_videoList.nStyle integerValue] == 131) {
                _videoList.nStyle = @"127";
            }else {
                _videoList.nStyle = @"126";
                _videoList.rows = @(1);
            }
        }else if (_videoList.style == MovieShowWithTable) {
            if ([_videoList.nStyle integerValue] == 131) {
                _videoList.nStyle = @"129";
            }else {
                _videoList.nStyle = @"128";
                _videoList.rows = @(1);
            }
        }else if (_videoList.style == MovieShowWithMatrix) {
            _videoList.nStyle = @"124";
            _videoList.rows = @(1);
        }
        return _videoList;
    }
    return nil;
}

- (NSArray *)cardList
{
    if (![NSObject empty:_cardList]) {
        return _cardList;
    }
    if (![NSString isBlankString:self.videoSort]) {
        self.cardList = [self.videoSort componentsSeparatedByRegex:@"-"];
    }else if (![NSString isBlankString:self.ztListSort]) {
        self.cardList = [self.ztListSort componentsSeparatedByRegex:@"-"];
    }
    return _cardList;
}


-(LTPlayListDataType)getPlayListDataType
{
    if (self.ztList) {
        return LTPlayListDataSubjectListType;
    }else if([self isPostiveVideo]){
        return LTPlayListDataVideoListType;
    }else{
        return LTPlayListDataRecommendListType;
    }
}


-(NSString*)getEpsoideCardSubTitleDisplay:(BOOL)isHalf
{
    NSInteger cid=[self.albumInfo.cid integerValue];
    
    NSString * titleText = @"";
    
    MovieShowStyle style = self.videoList.style;
    
    //按月显示
    if ((style == MovieShowWithDate) &&
        (cid == NewCID_Documentary || cid == NewCID_TVProgram || cid == NewCID_Sport)) {
        if ([self.albumInfo.isEnd integerValue] == 1 ) {
            if (![NSString isBlankString:self.albumInfo.platformVideoInfo]) {
                titleText = [titleText stringByAppendingFormat:@"%@%@%@",[NSString safeString:self.albumInfo.platformVideoInfo],NSLocalizedString(@"期",nil),NSLocalizedString(@"全",nil)];
            }
        }else if (![NSString isBlankString:self.albumInfo.nowEpisodes]) {
            NSString *dayString = [NSString getDayNSString:self.albumInfo.nowEpisodes];
            if ([NSString isBlankString:dayString] && ![NSString isBlankString:self.albumInfo.nowEpisodes]) {
                dayString = self.albumInfo.nowEpisodes;
            }
            if (![NSString isBlankString:dayString]) {
                titleText = [titleText stringByAppendingFormat:@"%@%@%@",NSLocalizedString(@"更新至",nil),dayString,NSLocalizedString(@"期", nil)];
            }
        }
    }else if((style == MovieShowWithMatrix) &&
             (cid == NewCID_Anime || cid == NewCID_TV)){
        if ([self.albumInfo.isEnd integerValue] == 1 ) {
            titleText = [NSString stringWithFormat:@"%@%@",self.albumInfo.episode, NSLocalizedString(@"集全", nil)];
        }else{
            titleText = [NSString stringWithFormat:@"%@%@%@/%@%@%@",
                         NSLocalizedString(@"更新至", nil),
                         self.albumInfo.nowEpisodes,
                         NSLocalizedString(@"集", nil),
                         NSLocalizedString(@"共", nil),
                         self.albumInfo.episode,
                         NSLocalizedString(@"集", nil)];

            //部分动漫没有总集数
            if (cid == NewCID_Anime && [self.albumInfo.episode integerValue] <= 0) {
                titleText = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"更新至", nil),self.albumInfo.nowEpisodes,NSLocalizedString(@"集", nil)];
            }
        }
        
    }else {
        if (isHalf && (style == MovieShowWithTable)) {
            NSDictionary *videoList = self.videoList.videoList;
            if (videoList && [videoList isKindOfClass:[NSDictionary class]]) {
                NSInteger totalNum = [[videoList objectForKey:@"totalNum"] integerValue];
                if (totalNum > 0) {
                    titleText = [NSString stringWithFormat:@"%ld", (long)totalNum];
                }
            }
        }
    }
    return [NSString safeString:titleText];
}

- (NSString *)getRelatePostiveSubTitleDisplay
{
    NSString *titleText = @"";
    if ([self.albumInfo.isEnd integerValue] == 1 ) {
        if (![NSString isBlankString:self.albumInfo.platformVideoInfo]) {
            titleText = [titleText stringByAppendingFormat:@"%@%@%@",[NSString safeString:self.albumInfo.platformVideoInfo],NSLocalizedString(@"期",nil),NSLocalizedString(@"全",nil)];
        }
    }else if (![NSString isBlankString:self.albumInfo.nowEpisodes]) {
        NSString *dayString = [NSString getDayNSString:self.albumInfo.nowEpisodes];
        if ([NSString isBlankString:dayString] && ![NSString isBlankString:self.albumInfo.nowEpisodes]) {
            dayString = self.albumInfo.nowEpisodes;
        }
        if (![NSString isBlankString:dayString]) {
            titleText = [titleText stringByAppendingFormat:@"%@%@%@",NSLocalizedString(@"更新至",nil),dayString,NSLocalizedString(@"期", nil)];
        }
    }
    return titleText;
}

- (NSString *)getFullScreenTitleName{
    NSString * title = NSLocalizedString(@"剧集", nil);
    
    if ([self getPlayListDataType] == LTPlayListDataSubjectListType) {
        if (self.ztList.desc.type == LTSubjectTypeAlbum) {
            if ([self getEpisodeCardStyle] == MovieShowWithDate) {
                title = NSLocalizedString(@"期数", nil);
            }else{
                title = NSLocalizedString(@"剧集", nil);
            }
            
        }else{
            title = NSLocalizedString(@"列表", nil);
        }
    }else{
        if ([self getPlayListDataType] == LTPlayListDataVideoListType) {
            if ([self getEpisodeCardStyle] == MovieShowWithDate) {
                title = NSLocalizedString(@"期数", nil);
            }else{
                if ([self getEpisodeCardStyle] == MovieShowWithMatrix) {
                    title = NSLocalizedString(@"剧集", nil);
                }else{
                    title = NSLocalizedString(@"列表", nil);
                }
            }
        }else if ([self getPlayListDataType] == LTPlayListDataRecommendListType) {
            title = NSLocalizedString(@"相关", nil);
        }
    }
    
    return title;
}



-(MovieShowStyle)getEpisodeCardStyle;
{
    MovieShowStyle style = MovieShowWithUnknown;
    if (self.ztList) {
        style = self.ztList.style;
    }else{
        style = self.videoList.style;
    }
    return style;
}


-(VideoListModel*)getEpisodeVideoList
{
    VideoListModel * videoListModel = nil;
    if (self.ztList) {
        if (self.ztList.style == MovieShowWithDate) {
            videoListModel = self.ztList.varityShowModel.videoListModel;
        }else{
            videoListModel = self.ztList.commonVideoList;
        }
    }else{
        if (self.videoList.style == MovieShowWithDate) {
            videoListModel = self.videoList.varityShowModel.videoListModel;
        }else{
            videoListModel = self.videoList.commonVideoList;
        }
    }
    /*
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    if (![NSObject empty:videoListModel.previewList]) {
        NSMutableArray * videos = [[NSMutableArray alloc]init];
        if (![NSObject empty:videoListModel.videoInfo]) {
            [videos addObjectsFromArray:videoListModel.videoInfo];
        }
        [videoListModel.previewList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            VideoModel * v = (VideoModel*)obj;
            if (![videos containsObject:v]) {
                [videos addObject:v];
            }
        }];
        videoListModel.videoInfo = videos;
    }
#pragma clang diagnostic pop
     */
    // 是否已经拼接了预告片
    if (![NSObject empty:videoListModel.previewList]) {
        __block BOOL hasAppendPreList = NO;
        [videoListModel.previewList enumerateObjectsUsingBlock:^(VideoModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([videoListModel.videoInfo containsObject:obj]) {
                hasAppendPreList = YES;
                *stop = YES;
            }
        }];
        if (!hasAppendPreList) {
            [self updatePerviewListForCurrentUserAndVideoListModel:videoListModel];
        }
    }
    return videoListModel;
}

- (void)updatePerviewListForCurrentUserAndVideoListModel:(VideoListModel *)videoListModel
{
    [self updatePerviewListForCurrentUserAndVideoListModel:videoListModel isPaySuccess:NO];
}

- (void)updatePerviewListForCurrentUserAndVideoListModel:(VideoListModel *)videoListModel isPaySuccess:(BOOL)isPaySuccess
{
    if (![NSObject empty:videoListModel.previewList]) {
        BOOL isVip = isPaySuccess;
        if (!isVip) {   // 如果传入的是购买成功，就使用传入参数，否则取settingmanager参数
            isVip = [SettingManager isVipUser];
        }
        // 当前更新集数
        NSInteger nowEpisodes = [self.albumInfo.nowEpisodes integerValue];
        // 非会员预告片
        NSMutableArray *noVipPreList = [NSMutableArray arrayWithCapacity:10];
        // 全展示预告片
        NSMutableArray *commonPreList = [NSMutableArray arrayWithCapacity:10];
        
        NSArray* (^arrayAppendBlock)(NSArray *frontArray, NSArray *backArray);
        arrayAppendBlock = ^NSArray* (NSArray *frontArray, NSArray *backArray){
            NSMutableArray *totalArray = [[NSMutableArray alloc] init];
            [totalArray addObjectsFromArray:frontArray];
            [totalArray addObjectsFromArray:backArray];
            if (![NSObject empty:totalArray]) {
                return totalArray;
            }
            return nil;
        };
        
        
        [videoListModel.previewList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            VideoModel * v = (VideoModel*)obj;
            // 大于更新集数的是全展示预告片
            if ([v.episode integerValue] > nowEpisodes) {
                if (![commonPreList containsObject:v]
                    && ![videoListModel.videoInfo containsObject:v]) {
                    [commonPreList addObject:v];
                }
            }else {  // 否则是非会员预告片
                if (![noVipPreList containsObject:v]) {
                    if (isVip || ![videoListModel.videoInfo containsObject:v]) {
                        [noVipPreList addObject:v];
                    }
                }
            }
        }];
        
        VideoModel *firstVideo = [videoListModel.videoInfo firstObject];
        VideoModel *lastVideo = [videoListModel.videoInfo lastObject];
        // 把非会员预告片插入列表
        if (!isVip && ![NSObject empty:noVipPreList]) {
            VideoModel *firstPre = [noVipPreList firstObject];
            if (([firstPre.episode integerValue] > [firstVideo.episode integerValue])
                && ([firstPre.episode integerValue] <= [lastVideo.episode integerValue])) {
                __block NSInteger preFirstIndex = -1;
                [videoListModel.videoInfo enumerateObjectsUsingBlock:^(VideoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.episode integerValue] == [firstPre.episode integerValue]) {
                        preFirstIndex = idx;
                        *stop = YES;
                    }
                }];
                NSArray *originVideoList = [videoListModel.videoInfo copy];
                NSArray *frontList = [originVideoList subarrayWithRange:NSMakeRange(0, preFirstIndex)];
                NSArray *backList = [originVideoList subarrayWithRange:NSMakeRange(preFirstIndex, originVideoList.count - preFirstIndex)];
                videoListModel.videoInfo = arrayAppendBlock(arrayAppendBlock(frontList, noVipPreList), backList);
                
            }else if ([firstPre.episode integerValue] == ([lastVideo.episode integerValue] + 1)) {
                videoListModel.videoInfo = arrayAppendBlock(videoListModel.videoInfo, noVipPreList);
            }
        }else if (isVip && ![NSObject empty:noVipPreList]) {  // 把非会员预告片踢出列表
            NSMutableArray *mutArray = [[NSMutableArray alloc] initWithArray:videoListModel.videoInfo];
            [noVipPreList enumerateObjectsUsingBlock:^(VideoModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([mutArray containsObject:obj]) {
                    [mutArray removeObject:obj];
                }
            }];
            videoListModel.videoInfo = mutArray;
        }
        // 把全展示预告片拼到剧集列表最后
        if (([lastVideo.episode integerValue] == nowEpisodes)
            && ![NSObject empty:commonPreList]) {
            videoListModel.videoInfo = arrayAppendBlock(videoListModel.videoInfo, commonPreList);
        }
    }
}

-(VarityShowVideoListModel*)getVarityShowVideoListModel
{
    VarityShowVideoListModel * videoListModel = nil;
    if (self.ztList) {
        videoListModel = self.ztList.varityShowModel;
    }else{
        videoListModel = self.videoList.varityShowModel;
    }
    return videoListModel;
}


-(NSArray*)getEpisodeRegionItemArrayWithVideoList:(VideoListModel *)videoList withVarityShowVideoList:(VarityShowVideoListModel *)varityShowInfo withStyle:(MovieShowStyle)movieShowStyle
{
    __block NSMutableArray * regionItems = [[NSMutableArray alloc]init];
    
    NSInteger totalRegionCount = NUMBER_OF_ROW([videoList.totalNum integerValue], LT_VIDEOLIST_REQUEST_NUM);
    
    if (movieShowStyle == MovieShowWithDate) {
        totalRegionCount = varityShowInfo.arrayOrderedYears.count;
    }
    
    @synchronized(self) {
        dispatch_queue_t queue = dispatch_queue_create([@"setter" UTF8String], NULL);
        @try {
            dispatch_apply(totalRegionCount, queue, ^(size_t index) {
                LTEpisodeRegionItem *item = [[LTEpisodeRegionItem alloc] init];
                item.movieDetail = self.albumInfo;
                if (movieShowStyle == MovieShowWithDate) {
                    item.totalYears = varityShowInfo.arrayOrderedYears;
                    item.pageIndex = index;
                    item.currPageIndex = varityShowInfo.indexForYearList;
                    item.year = OBJECT_OF_ATINDEX(varityShowInfo.arrayOrderedYears, index);
                    item.currentYear = varityShowInfo.currentYear;
                    item.regionName = [NSString safeString:[NSString stringWithFormat:@"%@%@",item.year,NSLocalizedString(@"年", nil)]];
                    item.style = movieShowStyle;
                    if (item.currPageIndex == item.pageIndex) {
                        item.videoList = varityShowInfo.videoListModel;
                    }
                }else{
                    NSArray *pagenavi = videoList.pagenavi;
                    NSString *regionName = OBJECT_OF_ATINDEX(pagenavi, index);
                    if ([NSString isBlankString:regionName]) {
                        regionName = [NSString safeString:[NSString stringWithFormat:@"%lu-%lu",LT_VIDEOLIST_REQUEST_NUM*index +1,LT_VIDEOLIST_REQUEST_NUM*(index+1)]];
                    }
                    item.regionName = regionName;
                    item.totalNum = [videoList.totalNum integerValue];
                    item.pageIndex = index;
                    item.style = movieShowStyle;
                    item.currPageIndex = [videoList.__pagenum integerValue] - 1;
                    if (item.currPageIndex < 0) {
                        item.currPageIndex = 0;
                    }
                    if (item.currPageIndex == item.pageIndex) {
                        item.videoList = videoList;
                    }
                    
                }
                if (totalRegionCount - 1 == index) {
                    item.isLastItem = YES;
                    if ((movieShowStyle != MovieShowWithDate)
                        && [NSString isBlankString:item.regionName]) {
                        item.regionName = [NSString safeString:[NSString stringWithFormat:@"%lu-%@",LT_VIDEOLIST_REQUEST_NUM*index +1,videoList.totalNum]];
                    }
                }
                
                [regionItems addObject:item];
                
                
            });
            
            //兼容电影频道正片模板，把周边视频数据插入普通剧集列表
            if (movieShowStyle != MovieShowWithDate) {
                LTEpisodeRegionItem * firstItem = OBJECT_OF_ATINDEX(regionItems, 0);
                VideoListModel * originVideoList = firstItem.videoList;
                if (originVideoList) {
                   originVideoList = [self combineOuterVideoLisToVideoList:originVideoList];
                    firstItem.videoList = originVideoList;
                    [regionItems replaceObjectAtIndex:0 withObject:firstItem];
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            ;
        }
        queue = nil;
    }
    return regionItems;
}


-(VideoListModel*)combineOuterVideoLisToVideoList:(VideoListModel*)videoListModel
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"

    if ([self.videoInfo.cid integerValue] != NewCID_MOVIE) {
        return videoListModel;
    }
    if (![self isPostiveVideo]) {
        return videoListModel;
    }
    if ([NSObject empty:videoListModel.videoInfo]) {
        return videoListModel;
    }
    if (![NSObject empty:self.outerVideoList.otherVideos.videoInfo]) {
        NSMutableArray * originVideoes = [[NSMutableArray alloc]initWithArray:videoListModel.videoInfo];
        VideoModel *firstModel = OBJECT_OF_ATINDEX(self.outerVideoList.otherVideos.videoInfo, 0);
        // 去重处理，如果已经拼接过，就不再拼接
        if (firstModel && [originVideoes containsObject:firstModel]) {
            return videoListModel;
        }
        [originVideoes addObjectsFromArray:self.outerVideoList.otherVideos.videoInfo];
        videoListModel.videoInfo = originVideoes;
        self.outerVideoList = nil;
    }
    return videoListModel;
#pragma clang diagnostic pop

}


@end

@implementation LTPageCardPlayerInfoModel

@end

@implementation LTPageCardZanCaiCountModel

@end

@implementation LTPageCardZanCaiModel

@end

@implementation LTEpisodeRegionItem

// 反序列化自身包括子类
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int propertyCount = 0;
        objc_property_t *propertyList = class_copyPropertyList(self.class, &propertyCount);
        for (unsigned i = 0; i < propertyCount; i++) {
            objc_property_t property = propertyList[i];
            NSString * propertyName= [NSString stringWithUTF8String:property_getName(property)];
            @try {
                id value = [aDecoder decodeObjectForKey:propertyName];
                [self setValue:value forKey:propertyName];
            }@catch (NSException *exception) {
            }
        }
        free(propertyList);
    }
    return self;
}

// 序列化自身包括子类
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(self.class, &propertyCount);
    for (unsigned i = 0; i < propertyCount; i++) {
        objc_property_t property = propertyList[i];
        NSString * propertyName= [NSString stringWithUTF8String:property_getName(property)];
        @try {
            id value = [self valueForKey:propertyName];
            [aCoder encodeObject:value forKey:propertyName];
        }@catch (NSException *exception) {
        }
    }
    free(propertyList);
}


-(BOOL)isContainPlayingVid:(NSString *)playingVid
{
    
    __block BOOL flag = NO;
    if ([NSString isBlankString:playingVid]) {
        return flag;
    }
    if (![NSObject empty:self.videoList.videoInfo]) {
        [self.videoList.videoInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            VideoModel * video=(VideoModel*)obj;
            
            if ([video.vid isEqualToString:playingVid]) {
                flag = YES;
                *stop = flag;
            }
        }];
    };
    
    return flag;
}

@end

@implementation LTPageCardVideoListModel

-(void)setStyleWithNSString:(NSString*)style
{
    _style = (MovieShowStyle)[style integerValue];
}

-(void)setVideoList:(NSDictionary *)videoList
{
    _videoList = videoList;
}

-(void)setFragments:(NSArray *)fragments
{
    _fragments = fragments;
    
    if (![NSObject empty:fragments]) {
        _fragmentsVideoList = [VideoListModel videoListModelWithFragmentsData:fragments];
    }
}

- (void)loadStyleModel
{
    if ([NSObject empty:_videoList]) {
        return;
    }
    if (_style == MovieShowWithDate) {
        _varityShowModel = [VarityShowVideoListModel varityShowVideoListModelWithDict:_videoList];
    }else{
        _commonVideoList = [[VideoListModel alloc]initWithDictionary:_videoList error:nil];
    }
}

-(id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        _style = (MovieShowStyle)[[dict valueForKey:@"style"] integerValue];
        [self loadStyleModel];
    }
    return self;
}

@end

@implementation LTPageCardOuterVideoListModel

@end

@implementation LTPageCardStar
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"tDescription"}];
}
@end

@implementation LTPageCardStarVideoModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"aid"  : @"pid",
                                                       }];
}

- (NSString *)getVideoDisplayName{
    NSString *videoName = @"";
    if(![NSString isBlankString:self.categoryName]){
        videoName = [videoName stringByAppendingString:[NSString stringWithFormat:@"%@ 丨 ",self.categoryName]];
    }
    if (![NSString isBlankString:self.name]) {
        videoName = [videoName stringByAppendingString:self.name];
    }
    return videoName;

}
@end

@implementation LTPageCardStarItem
- (void)setVideoList:(NSArray<Optional,LTPageCardStarVideoModel> *)videoList{
    
    if ([NSObject empty:videoList]) {
        _videoList = nil;
        return;
    }
    
    NSMutableArray *tempVideoList = [NSMutableArray arrayWithArray:videoList];
    NSMutableArray *resultVideoList =[[NSMutableArray alloc] initWithCapacity:2];
    if (tempVideoList.count > 2) {

        while (resultVideoList.count != 2 && tempVideoList.count != 0) {
            int index = arc4random()%tempVideoList.count;
            if (![NSObject empty:OBJECT_OF_ATINDEX(tempVideoList, index)]) {
                [resultVideoList addObject:OBJECT_OF_ATINDEX(tempVideoList, index)];
                [tempVideoList removeObjectAtIndex:index];
            }
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
        _videoList = resultVideoList;
#pragma clang diagnostic pop
    }else{
        _videoList = videoList;
    }
}

- (BOOL)isFocused{
    if ([self.focusStatus isEqualToString:@"YES"]) {
        return YES;
    }
    return NO;
}

- (void)setFocus:(BOOL)focus{
    if (focus) {
        self.focusStatus = @"YES";
    }else{
        self.focusStatus = @"NO";
    }
}
@end


@implementation LTPageCardStarRecommendModel

- (NSString *)getAllStarId{
    NSString *starId = @"";
    
    for (int i = 0; i < self.starRecommend.count; i++) {
        LTPageCardStarItem *starItem = [self.starRecommend objectAtIndex:i];
        if (i == self.starRecommend.count - 1) {
            starId = [starId stringByAppendingString:[NSString stringWithFormat:@"%@",starItem.star.leId]];
        }else{
            starId = [starId stringByAppendingString:[NSString stringWithFormat:@"%@,",starItem.star.leId]];
        }
    }
    
    return starId;
}

- (void)synchroFocusState:(NSDictionary *)focusDic{
    for (LTPageCardStarItem *starItem in self.starRecommend) {
         NSNumber *focusState = focusDic[starItem.star.leId];
        if ([focusState integerValue] == 1) {
            [starItem setFocus:YES];
        }else{
            [starItem setFocus:NO];
        }
    }
    
    self.synchroFocusStateFlag = @"YES";
}

- (BOOL)isSynchronized{
    if ([self.synchroFocusStateFlag isEqualToString:@"YES"]) {
        return YES;
    }
    return NO;
}

- (void)setNoNeedSynchro{
    self.synchroFocusStateFlag = @"YES";
}

- (void)setNeedSynchro{
    self.synchroFocusStateFlag = @"NO";
}
@end

@implementation LTPageCardRelateModel
- (NSInteger)indexOfItemWithVid:(NSString *)vid
{
    NSInteger countOfItems = self.recData.count;
    for (NSInteger i = 0; i < countOfItems; i++) {
        RecommendItem *item = self.recData[i];
        if (    [item isValidSingleVideoRecommendItem]
            &&  [vid isEqualToString:item.vid]) {
            return i;
        }
    }
    
    return -1;
}

- (RecommendItem *)itemWithVid:(NSString *)vid
{
    NSInteger countOfItems = self.recData.count;
    for (NSInteger i = 0; i < countOfItems; i++) {
        RecommendItem *item = self.recData[i];
        if (    [item isValidSingleVideoRecommendItem]
            &&  [vid isEqualToString:item.vid]) {
            return item;
        }
    }
    
    return nil;
}

- (RecommendItem *)nextValidSingleVideoRecommendItemAfterItemWithVid:(NSString *)vid
{
    NSInteger indexOfCurrItem = [self indexOfItemWithVid:vid];
    NSInteger nextBeginIndex = 0;
    if (indexOfCurrItem >= 0) {
        nextBeginIndex = indexOfCurrItem + 1;
    }
    
    NSInteger countOfItems = self.recData.count;
    for (NSInteger i = nextBeginIndex; i < countOfItems; i++) {
        RecommendItem *item = self.recData[i];
        if ([item isValidSingleVideoRecommendItem]) {
            return item;
        }
    }
    return nil;
}

@end

@implementation LTPageCardRecommendModel

@end

@implementation LTPageCardYourLikeModel

@end

@implementation LTPageCardMusicOriginalElemModel

@end

@implementation LTPageCardRelatePostiveModel

@end

@implementation LTPageCardCMSItem

@end

@implementation LTPageCardMusicOriginalModel

@end

@implementation LTPageCardCMSSpredModel

@end

@implementation LTPageCardCMSGameSpredModel

@end


@implementation LTPageCardCMSOperateModel

-(void)setCmsOperateList:(NSArray<Optional> *)cmsOperateList
{
    _cmsOperateList = cmsOperateList;
    
    if (![NSObject empty:_cmsOperateList]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
        _cmsItems = [[NSMutableArray alloc]init];
#pragma clang diagnostic pop

        [_cmsOperateList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary * dict = (NSDictionary*)obj;
            if (![NSObject empty:dict]) {
                LTPageCardCMSItem * item = [[LTPageCardCMSItem alloc]initWithDictionary:dict error:nil];
                if (item) {
                    [_cmsItems addObject:item];
                }
            }
        }];
    }
}
@end

@implementation LTPageCardIntroModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"nameCn"  : @"name",
                                                       }];
}

- (void)setTypeWithNSString:(NSString*)type
{
    switch ([type integerValue]) {
        case 1:
            _type = LTSubjectTypeAlbum;
            break;
        case 3:
            _type = LTSubjectTypeVideo;
            break;
        default:
            _type = LTSubjectTypeUnknown;
            break;
    }
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation LTPageCardRedPackageInfoModel

@end

@implementation LTPageCardRedPackageModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"package"  : @"packageInfo",
                                                       }];
}

@end

@implementation LTPageCardAlbumListModel


@end

@implementation LTPageCardSubjectModel


-(void)setVideoList:(NSDictionary *)videoList
{
    _videoList = videoList;
    _style = (MovieShowStyle)[[videoList valueForKeyPath:@"style"] integerValue];

    if ([NSObject empty:videoList]) {
        return;
    }
    if (_style == MovieShowWithDate) {
        _varityShowModel = [VarityShowVideoListModel varityShowVideoListModelWithDict:videoList];
    }else{
        _commonVideoList = [[VideoListModel alloc]initWithDictionary:videoList error:nil];
    }
}


-(id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        _style = (MovieShowStyle)[[dict valueForKeyPath:@"videoList.style"] integerValue];
    }
    return self;
}

- (NSInteger)indexOfSubjectAlbumWithPid:(NSString*)pid
{
    if ([NSString isBlankString:pid]) {
        return -1;
    }
    
    for (int i = 0; i < self.albumList.data.count; i++) {
        NSArray *albumList = self.albumList.data;
        MovieDetailModel *subjectAlbum = albumList[i];
        if ([subjectAlbum.pid isEqualToString:pid]) {
            return i;
        }
    }
    
    return -1;
}

- (MovieDetailModel *)subjectAlbumWithPid:(NSString *)pid
{
    NSInteger idx = [self indexOfSubjectAlbumWithPid:pid];
    if (idx < 0) {
        return nil;
    }
    
    return self.albumList.data[idx];
}

- (MovieDetailModel *)firstValidSubjectAlbumWithPid:(NSString *)pid
{
    MovieDetailModel *currSubjectAlbum = [self subjectAlbumWithPid:pid];
    if (    nil == currSubjectAlbum
        &&  self.albumList.data.count > 0) {
        currSubjectAlbum = self.albumList.data.firstObject;
    }
    if (!currSubjectAlbum) {
        return nil;
    }
    
    if ([currSubjectAlbum play]) {
        return currSubjectAlbum;
    }
    
    return [self nextValidSubjectAlbumWithPid:currSubjectAlbum.pid];
}

- (MovieDetailModel *)nextValidSubjectAlbumWithPid:(NSString *)pid
{
    NSInteger idx = [self indexOfSubjectAlbumWithPid:pid];
    if (idx < 0) {
        return [self firstValidSubjectAlbumWithPid:nil];
    }
    
    NSInteger countAlbums = self.albumList.data.count;
    for (NSInteger i = idx+1; i < countAlbums; i++) {
        MovieDetailModel *subjectAlbum = self.albumList.data[i];
        if (    subjectAlbum
            &&  [subjectAlbum play]) {
            return subjectAlbum;
        }
    }
    
    return nil;
}

- (NSInteger)indexOfSubjectVideoWithVid:(NSString*)vid
{
    if ([NSString isBlankString:vid]) {
        return -1;
    }
    NSArray * videoes = nil;
    if (self.style == MovieShowWithDate) {
        videoes = self.varityShowModel.videoListModel.videoInfo;
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        videoes = self.commonVideoList.videoInfo;
    }
    if (![NSObject empty:videoes]) {
        for (int i = 0; i < videoes.count; i++) {
            VideoModel *video = videoes[i];
            if ([video.vid isEqualToString:vid]) {
                return i;
            }
        }
    }
    
    return -1;
}

- (VideoModel *)subjectVideoWithVid:(NSString *)vid
{
    NSInteger idx = [self indexOfSubjectVideoWithVid:vid];
    if (idx < 0) {
        return nil;
    }
    VideoModel * video = nil;
    if (self.style == MovieShowWithDate) {
        video = self.varityShowModel.videoListModel.videoInfo[idx];
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        video = self.commonVideoList.videoInfo[idx];
    }
    
    return video;
}

- (VideoModel *)nextValidSubjectVideoWithVid:(NSString *)vid
{
    //如果是专辑专题包，proces中连播、后推荐反查时不查这个list
    if (self.desc.type == LTSubjectTypeAlbum) {
        return nil;
    }
    NSInteger idx = [self indexOfSubjectVideoWithVid:vid];
    if (idx < 0) {
        return [self firstValidSubjectVideoWithVid:nil];
    }
    
    NSArray * videoes = nil;
    if (self.style == MovieShowWithDate) {
        videoes = self.varityShowModel.videoListModel.videoInfo;
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        videoes = self.commonVideoList.videoInfo;
    }
    
    NSInteger countVideos = videoes.count;
    for (NSInteger i = idx+1; i < countVideos; i++) {
        VideoModel *subjectVideo = videoes[i];
        if (    subjectVideo
            &&  [subjectVideo isPlaySupported]) {
            return subjectVideo;
        }
    }
    
    return nil;
}

- (VideoModel *)firstValidSubjectVideoWithVid:(NSString *)vid
{
    VideoModel *currSubjectVideo = [self subjectVideoWithVid:vid];
    
    if (self.style == MovieShowWithDate) {
        if (    nil == currSubjectVideo
            &&  self.varityShowModel.videoListModel.videoInfo.count > 0) {
            currSubjectVideo = self.varityShowModel.videoListModel.videoInfo.firstObject;
        }
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        if (    nil == currSubjectVideo
            &&  self.commonVideoList.videoInfo.count > 0) {
            currSubjectVideo = self.commonVideoList.videoInfo.firstObject;
        }
    }
    
    if (!currSubjectVideo) {
        return nil;
    }
    
    if ([currSubjectVideo isPlaySupported]) {
        return currSubjectVideo;
    }
    
    return [self nextValidSubjectVideoWithVid:currSubjectVideo.vid];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end

#endif
