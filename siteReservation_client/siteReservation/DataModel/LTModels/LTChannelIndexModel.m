//
//  LTChannelIndexModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-11-5.
//
//

#import "LTChannelIndexModel.h"
//#import "NSString+HTTPExtensions.h"
//#import "NSString+MD5.h"
//#import "NSObject+ObjectEmpty.h"
#import "NSString+MovieInfo.h"
#import "LTVideoAuxiliaryInfoManager.h"
#import "LTDataCenter.h"
#import "ImageCacheManager.h"

@implementation FocusPicModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"jump":@"__jump",
                                                       @"play":@"__play",
                                                       @"pay":@"__pay",
                                                       @"isEnd"        : @"__isEnd",
                                                       @"episode"      : @"__episode",
                                                       @"nowEpisodes"  : @"__nowEpisodes",
                                                       @"mobilePic":@"pic",
                                                       @"id":@"__id",
                                                       }];
}

- (BOOL)isEnd
{
    if ([NSString isBlankString:self.__isEnd]) {
        return TRUE;
    }
    return ([self.__isEnd integerValue] == 1) ? TRUE : FALSE;
}

- (NSInteger)episode
{
    return [self.__episode integerValue];
}

- (NSInteger)nowEpisodes
{
    return [self.__nowEpisodes integerValue];
}

- (BOOL)jump
{
    return ([self.__jump integerValue] == 1) ? TRUE : FALSE;
}

- (BOOL)play
{
    return ([self.__play integerValue] == 1) ? TRUE : FALSE;
}

- (BOOL)pay
{
    return ([self.__pay integerValue] == 1) ? TRUE : FALSE;
}
#pragma mark - properties
//- (void)setTypeWithNSString:(NSString*)type
//{
//    switch ([type integerValue]) {
//        case 1:
//            _type = ALBUM_FROM_VRS;
//            break;
//        case 2:
//            _type = VIDEO_FROM_PTV;
//            break;
//        case 3:
//            _type = VIDEO_FROM_VRS;
//            break;
//        default:
//
//            break;
//    }
//}


//- (void)setAtWithNSString:(NSString*)at
//{
//    _at = [NSString formate5VideoAtValue:at];
//}

-(NSString *)getIcon{
    NSString *iconUrl = @"";
#ifdef LT_IPAD_CLIENT
    if ([NSString isBlankString:iconUrl]) {
        iconUrl =  self.padPic;
    }
#endif
    if ([NSString isBlankString:iconUrl]) {
        iconUrl =  self.pic;
    }
    
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.pic_200_150;
    }
    
    return iconUrl;
}

- (NSString *)getUpdateInfo
{
    if (ALBUM_FROM_VRS != [self.type integerValue]) {
        return @"";
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
        NSInteger episode = [self episode];
        if (self.isEnd && episode > 0) {
            return [NSString stringWithFormat:@"%ld%@", (long)episode, NSLocalizedString(@"期全", nil)];
        }
        else if ([self.__nowEpisodes length] >= 8) {
            NSString *month = [self.__nowEpisodes substringWithRange:NSMakeRange(4, 2)];
            NSString *day = [self.__nowEpisodes substringWithRange:NSMakeRange(6, 2)];
            return [NSString stringWithFormat:NSLocalizedString(@"%@-%@期", @"%@-%@期"), month, day];
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
            return [NSString stringWithFormat:@"%@%ld%@", NSLocalizedString(@"更新至", nil), (long)self.nowEpisodes, NSLocalizedString(@"集", nil)];
        }
    }
    else{
        if (self.episode <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%ld%@", (long)self.episode, NSLocalizedString(@"集全", nil)];
        }
    }
    
    return @"";
    
}

- (BOOL)isValid {
    BOOL isValid = YES;
    /* 视频类型过滤去掉，迎合全网数据
     if (![NSString empty:self.type]) {
     NSInteger type = [self.type integerValue];
     // iPhone支持专辑，iPad不支持
     if (type != VIDEO_FROM_VRS && type != ALBUM_FROM_VRS && type != VIDEO_FROM_VID) {
     isValid = NO;
     }
     }
     */
    if (![[LTVideoAuxiliaryInfoManager defaultManager] isExistVideoAt:self.at]) {
        isValid = NO;
    }
    
    return isValid;
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

@end

@implementation FilterModel


@end

@implementation RedirectModel


@end

@implementation FilmListModel

/**
 *  获取播放数
 *
 *  @return 如果返回@“” 说明数据有问题，如果返回 @"0"怎说明 playCount 为空或者 0.返回其他正常
 */
- (NSString *)playCountTextFromPlayCount{
    @try {
        if (![self isPureInt:self.playCount])
        {
            return @"0";
        }
        if ([NSString isBlankString:self.playCount]) {
            return @"0";
        }
        NSString *text               = @"";
        
        unsigned long long playCount = self.playCount.longLongValue;
        if (playCount > 100000000)
        {
            text                         = [text stringByAppendingString:[NSString stringWithFormat:@"%.1f%@", (float)playCount / 100000000,NSLocalizedString(@"亿", @"亿")]];
        }
        else if (playCount > 10000)
        {
            text                         = [text stringByAppendingString:[NSString stringWithFormat:@"%.1f%@",(float)playCount / 10000,NSLocalizedString(@"万", @"万")]];
        }
        else
        {
            text                         = [text stringByAppendingString:[NSString stringWithFormat:@"%llu",playCount]];
        }
        return text;
    }
    @catch (NSException *exception) {
        NSLog(@"获取播放数出错 == %@",exception);
        return @"";
    }
    
    return @"0";
}
- (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan                             = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)getNewIcon
{
    if (   ![NSObject empty:self.picList]
        && [self.picList isKindOfClass:[NSDictionary class]]) {
        return [self.picList objectForKey:@"pic169"];   // 16:9的图
    }
#ifndef LT_IPAD_CLIENT
    return self.mobilePic;
#else
    return self.padPic;
#endif
}

-(NSString *)getIcon{
    NSString *iconUrl = @"";
#ifdef LT_IPAD_CLIENT
    if ([NSString isBlankString:iconUrl]) {
        iconUrl =  self.padPic;
    }
#endif
    if ([NSString isBlankString:iconUrl]) {
        iconUrl =  self.mobilePic;
    }
    return iconUrl;
}

- (NSString *)getUpdateInfo {
    if (ALBUM_FROM_VRS != [self.type integerValue]) {
        return @"";
    }
    
    // 否则，根据cid判断
    if ([NSString isBlankString:self.cid]) {
        return @"";
    }
    if (    NewCID_Anime != [self.cid integerValue]
        &&  NewCID_TV != [self.cid integerValue]
        && NewCID_TVProgram != [self.cid integerValue]
        && NewCID_Kids != [self.cid integerValue]) {
        return @"";
    }
    
    if (NewCID_TVProgram == [self.cid integerValue]) {
        NSInteger episode = [self.episode integerValue];
        if ([self.isEnd isEqualToString:@"1"] && episode > 0) {
            return [NSString stringWithFormat:@"%ld%@", (long)episode, NSLocalizedString(@"期全", nil)];
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
    
    if (    ![self.isEnd isEqualToString:@"1"]
        &&  [self.nowEpisodes integerValue] < [self.episode integerValue]) {
        if ([self.nowEpisodes integerValue] <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"更新至", nil), self.nowEpisodes, NSLocalizedString(@"集", nil)];
        }
    }
    else{
        //        if ([self.episode integerValue] <= 0) {
        //            return @"";
        //        }
        //        else{
        //            return [NSString stringWithFormat:NSLocalizedString(@"%@集全", @"%@集全"), self.episode];
        //        }
        return @"";
    }
    
    return @"";
    
}

- (BOOL)isValid {
    BOOL isValid = YES;
    /* 视频类型过滤去掉，迎合全网数据
     if (![NSString empty:self.type]) {
     NSInteger type = [self.type integerValue];
     // iPhone支持专辑，iPad不支持
     if (type != VIDEO_FROM_VRS && type != ALBUM_FROM_VRS && type != VIDEO_FROM_VID) {
     isValid = NO;
     }
     }
     */
    if (![[LTVideoAuxiliaryInfoManager defaultManager] isExistVideoAt:self.at]) {
        isValid = NO;
    }
    
    return isValid;
}


- (NSString *)pic_300x300
{
    if ([NSString isBlankString:_pic_300x300]) {
        if (![NSObject empty:self.picList] && [self.picList isKindOfClass:[NSDictionary class]]) {
            return [self.picList objectForKey:@"300x300"];
        }
    }
    return _pic_300x300;
}


- (NSString *)pic_400x300
{
    if ([NSString isBlankString:_pic_400x300]) {
        if (![NSObject empty:self.picList] && [self.picList isKindOfClass:[NSDictionary class]]) {
            return [self.picList objectForKey:@"400x300"];
        }
    }
    return _pic_400x300;
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

@end

@implementation FilmListModelWrapper
@end

@implementation LinkPropertyModel


@end

@implementation LTPageCardSectionModel


@end

@implementation ChannelListBlockModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"blockname"  : @"name",
                                                       @"list"  : @"blockContent",
                                                       @"outPutStyle"      :@"sectionModel",
                                                       @"sub_block" : @"subBlock",
                                                       }];
}
-(BOOL)isPersonalRecommend
{
    BOOL isRec = NO;
    if (!([self.cms_num integerValue] == self.blockContent.count)) {
        isRec = YES;
    }
    return isRec;
}


- (void)addStatisticAction:(LTDCPageID)pageID row:(NSInteger)index section:(NSInteger)section flag:(NSString *)flag {
    if (self.blockContent.count > index) {
        FilmListModel *model = self.blockContent[index];
        LTDCActionCode code = LTDCActionCodeClick;
        if ([model.is_rec boolValue]) {
            //个性化推荐模块，发点击统计
            code = LTDCActionCodeRecommendClick;
        }
        
        LTStatisticInfo *info = [[LTStatisticInfo alloc] init];
        info.acode = code;
        info.cid = model.cid;
        info.zid = model.zid;
        info.pid = model.pid;
        info.vid = model.vid;
        info.wz = (index + 1);
        info.pageID = pageID;
        info.apc = LTDCActionPropertyCategoryChannelBlock;
        if (pageID == LTDCPageIDIndex) {
            info.apc = LTDCActionPropertyCategoryIndexBlock;
        }
        
   
        info.lid = model.streamCode;
        
        info.fragId = self.fragId;
        info.name = self.name;
        if ([self.contentStyle integerValue] == PageStyle_Service_Area) {
            info.name = model.nameCn;
        }
        
        if ([flag integerValue]!= -1) {
            info.flag = flag;
            info.apc = LTDCActionPropertyCategoryIndexBlock;
            info.name = model.nameCn;
        }
        
        info.scidID = self.pageid;
        info.bucket = self.bucket;
        info.area = self.area;
        info.reid = self.reid;
        info.rank = [NSString stringWithFormat:@"%ld",(long)section+1];
        
        if ([model.at intValue] == LT_VIDEO_AT_5_Web) {
            info.cur_url = model.webUrl;
        } else if ([model.at intValue] == LT_VIDEO_AT_5_WebView) {
            info.cur_url = model.webViewUrl;
        } else if ([model.at intValue] == LT_VIDEO_AT_5_FullscreenPlayer_Living) {
            info.cur_url = model.streamUrl;
        }
        [LTDataCenter addStatistic:info];
    }
}

- (void)addStatisticAction:(LTDCPageID)pageID row:(NSInteger)index section:(NSInteger)section
{
    
    [self addStatisticAction:pageID row:index section:section flag:@"-1"];
}

- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index
{
    
    [self addStatisticShow:pageID index:index flag:@"-1"];
}
- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index flag:(NSString *)flag
{
    
    PageStyle style = [self.contentStyle integerValue];
    
    switch (style) {
        case PageStyle_VIP_Promotion:
        case PageStyle_Search:
        case PageStyle_Hot_Words:
        case PageStyle_Navigation_New:
        case PageStyle_Chart:
        case PageStyle_Movie_List:
        case PageStyle_Unkown:
            return;
            break;
        default:
            break;
    }
    
    LTStatisticInfo * statisticInfo = [[LTStatisticInfo alloc]init];
    LTDCActionCode code = LTDCActionCodeShow;
    if ([self isPersonalRecommend]) {
        //个性化推荐模块，发曝光统计
        code = LTDCActionCodeShowForRecommend;
    }
    statisticInfo.acode = code;
    statisticInfo.pageID = pageID;
    statisticInfo.fragId = self.fragId;
    statisticInfo.name = self.name;
    statisticInfo.scidID = self.pageid;
    statisticInfo.wz = index + 1;
    statisticInfo.apc = LTDCActionPropertyCategoryChannelBlock;
    if (pageID == LTDCPageIDIndex) {
        statisticInfo.apc = ([self.contentStyle integerValue] == PageStyle_Recommend) ? LTDCActionPropertyCategoryIndexBlock1 : LTDCActionPropertyCategoryIndexBlock;
    }
    statisticInfo.bucket = self.bucket;
    statisticInfo.reid = self.reid;
    statisticInfo.area = self.area;
    statisticInfo.rank = [NSString stringWithFormat:@"%ld",(long)index+1];
    if ([flag integerValue]!= -1) {
        statisticInfo.flag = flag;
        statisticInfo.apc = LTDCActionPropertyCategoryIndexBlock;
        
    }
    // 模块曝光时增加模块内所有视频的vid信息上报，在扩展字段ap中上报vid列表和pid列表，
    // 有vid只报vid，vids=vid1;vid2...，若没有vid时情况下再上报pid，pids=pid1;pid2...，pid
    __block NSString *vidString = @"";
    __block NSString *pidString = @"";
    [self.blockContent enumerateObjectsUsingBlock:^(FilmListModel *obj, NSUInteger idx, BOOL *stop) {
        
        if ([NSString isBlankString:obj.vid]) {
            if (![NSString isBlankString:obj.pid]) {
                if ([NSString isBlankString:pidString]) {
                    pidString = obj.pid;
                } else {
                    pidString = [NSString stringWithFormat:@"%@;%@", pidString, obj.pid];
                }
            }
        } else {
            if ([NSString isBlankString:vidString]) {
                vidString = obj.vid;
            } else {
                vidString = [NSString stringWithFormat:@"%@;%@", vidString, obj.vid];
            }
        }
        
        
    }];
    statisticInfo.vids = vidString;
    statisticInfo.pids = pidString;
    [LTDataCenter addStatistic:statisticInfo];
}
@end
@implementation ChannelNavigationModel


@end

@implementation LTChannelIndexModel

- (BOOL)isContainPageID:(NSString *)pageID
{
    __block BOOL isContain = NO;
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *obj, NSUInteger idx, BOOL *blockStop) {
        if ([obj.contentStyle integerValue] == PageStyle_Navigation_New) {
            [obj.blockContent enumerateObjectsUsingBlock:^(FilmListModel *obj, NSUInteger idx, BOOL *stop) {
                if ([obj.pageid isEqualToString:pageID]) {
                    isContain = YES;
                    *stop = YES;
                }
            }];
            *blockStop = YES;
        }
    }];
    return isContain;
}

- (BOOL)isContainFilter
{
    __block BOOL isContain = NO;
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *obj, NSUInteger idx, BOOL *blockStop) {
        if ([obj.contentStyle integerValue] == PageStyle_Navigation_New) {
            [obj.blockContent enumerateObjectsUsingBlock:^(FilmListModel *obj, NSUInteger idx, BOOL *stop) {
                if ([obj.subTitle isEqualToString:kNameFilterTag]) {
                    isContain = YES;
                    *stop = YES;
                }
            }];
            *blockStop = YES;
        }
    }];
    return isContain;
}

// 是否有二级导航
- (BOOL)isContainNav
{
    __block BOOL isContain = NO;
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *obj, NSUInteger idx, BOOL *blockStop) {
        if ([obj.contentStyle integerValue] == PageStyle_Navigation_New) {
            isContain = YES;
            *blockStop = YES;
        }
    }];
    return isContain;
}


- (NSUInteger)indexOfFilter
{
    __block NSUInteger index = 0;
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *obj, NSUInteger idx, BOOL *blockStop) {
        if ([obj.contentStyle integerValue] == PageStyle_Navigation_New) {
            index = idx;
            *blockStop = YES;
        }
    }];
    return index;
}

- (void)dealPlayerDataToLock {
    
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PageStyle style = [obj.contentStyle intValue];
        
        if (style == PageStyle_Recommend_ChannelPlayer
            ||style == PageStyle_Card_Player_NoMore) {
            obj.isLock = @"1";
        }
        
    }];
}

- (void)removeVideoInvalidData:(NSMutableArray *)dataArray {
    
    if (dataArray == nil || [dataArray count] == 0) {
        return;
    }
    
    NSMutableArray *toBeRemove = [[NSMutableArray alloc] init];
    
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FilmListModel *videoModel = (FilmListModel *)obj;
        
        if ([videoModel isValid] == NO) {
            [toBeRemove addObject:videoModel];
        }
    }];
    
    if ([toBeRemove count] > 0) {
        [dataArray removeObjectsInArray:toBeRemove];
    }
}

// 删除不符合类型的数据
- (void)removeInvalidData {
    // 去除焦点图非法数据
    if (self.focuspic != nil) {
        [self removeVideoInvalidData:self.focuspic];
    }
    
    NSMutableArray *toBeRemove = [[NSMutableArray alloc] init];
    NSMutableArray *rmLives = [[NSMutableArray alloc] init];
#ifndef LT_MERGE_FROM_IPAD_CLIENT
    NSMutableArray *searchwords = [[NSMutableArray alloc] init];
#endif
    NSMutableArray *toRemoveUnknownContentStyleArray = [[NSMutableArray alloc] init];
    
    [self.block enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ChannelListBlockModel *blockModel = (ChannelListBlockModel *)obj;
        PageStyle style = [blockModel.contentStyle integerValue];
        
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        //首页和频道页一样，都在这里处理
        if (![[LTVideoAuxiliaryInfoManager defaultManager] isExistPageStyle:blockModel.contentStyle] && ![self.isFromFilter boolValue]) {
            if (blockModel != nil) {
                [toRemoveUnknownContentStyleArray addObject:blockModel];
            }
        }
        
        if (style == PageStyle_Live) {
            [rmLives addObject:blockModel];
        }
        
        if (style == PageStyle_Hot_Words) {
            [searchwords addObject:blockModel];
        }
        if (style == PageStyle_FloatLayer_Activity) {
            [toBeRemove addObject:blockModel];
        }
        
        if (   blockModel != nil
            && blockModel.blockContent.count > 0
            && style != PageStyle_Hot_Words
            && style != PageStyle_Navigation_New) {
            //这部分需要判断，不然把热词就会删掉
            [self removeVideoInvalidData:blockModel.blockContent];
        }
        
        if (   blockModel.blockContent.count == 0
            && style != PageStyle_VIP_Promotion
            && style != PageStyle_Search
            && style != PageStyle_Live
            && style != PageStyle_Chart
            && style != PageStyle_Navigation_New
            && style != PageStyle_New_Promotion
            && style != PageStyle_Advertisement
            && [blockModel.contentType integerValue] != 5) {
            //清理掉list个数为零的模块，除了搜索
            [toBeRemove addObject:blockModel];
        }
#else
        if (   blockModel != nil
            && blockModel.blockContent.count > 0) {
            [self removeVideoInvalidData:blockModel.blockContent];
        }

        if (   blockModel.blockContent.count == 0
            && style != PageStyle_VIP_Promotion
            && style != PageStyle_Chart
            && style != PageStyle_Live
            && [blockModel.contentType integerValue] != 5) {
            //清理掉list个数为零的模块，除了搜索
            [toBeRemove addObject:blockModel];
        }
        
        if ([blockModel.contentStyle isEqualToString:@"288"]) {
            [toBeRemove addObject:blockModel];
        }
#endif
    }];
    
#ifndef LT_MERGE_FROM_IPAD_CLIENT
    if (rmLives.count > 1) {
        [rmLives removeObjectAtIndex:0];    //留下第一个直播数据
        if (rmLives.count > 0) {
            [self.block removeObjectsInArray:rmLives];
        }
    }
    
    if (searchwords.count > 1) {
        [searchwords removeObjectAtIndex:0];       //留下第一个搜索数据
        if (searchwords.count > 0) {
            [self.block removeObjectsInArray:searchwords];
        }
    }
#else
    // pad频道没有直播
    if (rmLives.count > 0) {
        [self.block removeObjectsInArray:rmLives];
    }
#endif
    
    if ([toRemoveUnknownContentStyleArray count] > 0) {
        [self.block removeObjectsInArray:toRemoveUnknownContentStyleArray];
    }
    
    if (toBeRemove.count > 0) {
        [self.block removeObjectsInArray:toBeRemove];  //删除不符合数据的类型的Block
    }
}

- (BOOL)isShouldCache
{
    BOOL isNeedCache = NO;
    
    [self removeInvalidData];
    
    if (self.block.count > 0) {
        __block NSMutableArray *removes = [[NSMutableArray alloc] initWithCapacity:10];
        [self.block enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ChannelListBlockModel *block = (ChannelListBlockModel *)obj;
            
            if (   [block.contentStyle integerValue] == PageStyle_Live
                || [block.contentStyle integerValue] == PageStyle_Search
                || [block.contentStyle integerValue] == PageStyle_Hot_Words
                || [block.contentStyle integerValue] == PageStyle_VIP_Promotion
                || [block.contentStyle integerValue] == PageStyle_Navigation_New
                ) {
                [removes addObject:block];
            }
        }];
        
        if (removes.count > 0) {
            [self.block removeObjectsInArray:removes];
        }
        
        if (self.block.count > 0) {
            isNeedCache = YES;
        }
    }
    
    if (!isNeedCache) {
        NSString *errorCodeInfo = [NSString stringWithFormat:@"频道页: LTChannelIndexModel check data exception, blockCount:%ld", (unsigned long)[self.block count]];
        [LTDataCenter writeToErrorLogFile:errorCodeInfo];
    }
    
    return isNeedCache;
}


- (BOOL)isShouldCache:(BOOL)isHome
{
    
    BOOL isNeedCache = NO;
    
    [self removeInvalidData];

    if (isHome) {
        
        NSInteger maxNumber = [SettingManager getBlockMaxNumber];
        if (maxNumber <= 0) {
            maxNumber = 1;
        }
        __block BOOL isFocus = NO; // 焦点图是否符合
        
#ifdef LT_MERGE_FROM_IPAD_CLIENT
        isFocus = (self.focuspic.count >= maxNumber);
#endif
        if (self.block.count > 0) {
            __block NSMutableArray *removes = [[NSMutableArray alloc] initWithCapacity:10];
            [self.block enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ChannelListBlockModel *block = (ChannelListBlockModel *)obj;
//#ifndef LT_MERGE_FROM_IPAD_CLIENT
//                if ([block.contentStyle integerValue] == PageStyle_Focus_New && block.video.count >= maxNumber) {
//                    isFocus = YES;
//                }
//#endif
                if (   [block.contentStyle integerValue] == PageStyle_Search
                    || [block.contentStyle integerValue] == PageStyle_Promotion
                    || [block.contentStyle integerValue] == PageStyle_Hot_Words
                    || [block.contentStyle integerValue] == PageStyle_Heavy_Recommend
                    || [block.contentStyle integerValue] == PageStyle_Focus_New
                    || [block.contentStyle integerValue] == PageStyle_New_Promotion
                    ) {
                    [removes addObject:block];
                }
            }];
            
            if (removes.count > 0) {
                [self.block removeObjectsInArray:removes];
            }
            
            if (self.block.count >= maxNumber && isFocus) {
                isNeedCache = YES;
            }
        }
        
        if (!isNeedCache) {
            NSString *errorCodeInfo = [NSString stringWithFormat:@"首页:LTRecommendModel check data exception, blockCount:%ld, isFocus:%u", (unsigned long)[self.block count], isFocus];
            [LTDataCenter writeToErrorLogFile:errorCodeInfo];
        }
    } else {
        
        if (self.block.count > 0) {
            __block NSMutableArray *removes = [[NSMutableArray alloc] initWithCapacity:10];
            [self.block enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ChannelListBlockModel *block = (ChannelListBlockModel *)obj;
                
                if (   [block.contentStyle integerValue] == PageStyle_Live
                    || [block.contentStyle integerValue] == PageStyle_Search
                    || [block.contentStyle integerValue] == PageStyle_Hot_Words
                    || [block.contentStyle integerValue] == PageStyle_VIP_Promotion
                    || [block.contentStyle integerValue] == PageStyle_Navigation_New
                    ) {
                    [removes addObject:block];
                }
            }];
            
            if (removes.count > 0) {
                [self.block removeObjectsInArray:removes];
            }
            
            if (self.block.count > 0) {
                isNeedCache = YES;
            }
        }
        
        
        if (!isNeedCache) {
            NSString *errorCodeInfo = [NSString stringWithFormat:@"频道页: LTChannelIndexModel check data exception, blockCount:%ld", (unsigned long)[self.block count]];
            [LTDataCenter writeToErrorLogFile:errorCodeInfo];
        }
    }
    return isNeedCache;
}

- (void)removeDonotConformData:(void (^)(NSDictionary *locks, NSDictionary *removes))finishBlock;
{
    /* 根据 样式 id 识别焦点图、 服务区 、广告区块、 乐看搜索 、 搜索热词 板块， 在该页面不显示；
     并且记住位置*/
    NSMutableDictionary *removes = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (
            [obj.contentStyle integerValue] == PageStyle_Focus_New
            || [obj.contentStyle integerValue] == PageStyle_Service_Area
            || [obj.contentStyle integerValue] == PageStyle_Advertisement
            || [obj.contentStyle integerValue] == PageStyle_Search
            || [obj.contentStyle integerValue] == PageStyle_Hot_Words
            ) {
            [removes setObject:obj forKey:@(idx)];
        }
    }];
    
    [self.block removeObjectsInArray:removes.allValues];
    
    /*锁住的取出来，并且记住位置*/
    NSMutableDictionary *locks = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.isLock boolValue]) {
            [locks setObject:obj forKey:@(idx)];
        }
    }];
    
    if (finishBlock) {
        finishBlock(locks, removes);
    }
}

- (void)checkBody:(NSDictionary *)body
{
    if ([SettingManager isHK]) {
        return;
    }
    
    [self dealPlayerDataToLock];
    
#ifdef LT_IPAD_CLIENT
    NSString *sandboxPath = [FileManager appNavigationDataPath];
#else
    NSString *sandboxPath = [FileManager appNavigationDataDocumentPath];
#endif

    NSString *endPath = [sandboxPath stringByAppendingPathComponent:kAPPHomeSortDataSource];
    NSDictionary *jsonObject = [NSDictionary dictionaryWithContentsOfFile:endPath];
    
    LTLog(@"kAPPHomeSortDataSource %@", endPath);
    
    if ([NSObject empty:jsonObject]) {
        [self writToBox:[self toDictionary] filePath:endPath];
    } else {
        
        LTChannelIndexModel *tempIndexModel = [[LTChannelIndexModel alloc] initWithDictionary:jsonObject error:nil];
        if (![tempIndexModel.isEdit boolValue]) {
            [self writToBox:[self toDictionary] filePath:endPath];
            return;
        }
        
        if ([body isEqualToDictionary:jsonObject]) {
            return;
        }
        
        __weak typeof(self) wSelf = self;
        
        [self removeDonotConformData:^(NSDictionary *locks, NSDictionary *removes) {
            /*老数据处理*/
            LTChannelIndexModel *channelIndexModel = [[LTChannelIndexModel alloc] initWithDictionary:jsonObject error:nil];
            [channelIndexModel removeDonotConformData:nil];
            
            NSMutableArray *newlockArray = [[NSMutableArray alloc] initWithCapacity:10];
            [wSelf.block removeObjectsInArray:[wSelf modelsArray:newlockArray addModelFromDictionary:locks]];
            
            /*把新数据按照老数据排序*/
            NSMutableArray *sorts = [[NSMutableArray alloc] initWithCapacity:10];
            
            [channelIndexModel.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *channelObj, NSUInteger idx, BOOL *channelStop) {
                
                [wSelf.block enumerateObjectsUsingBlock:^(ChannelListBlockModel *obj, NSUInteger idx, BOOL *stop) {
                    if ([channelObj.fragId isEqualToString:obj.fragId]) {
                        [sorts addObject:obj];
                        *stop = YES;
                    }
                }];
            }];
            
            [wSelf.block removeObjectsInArray:sorts];
            if (wSelf.block.count > 0) {
                /*把剩下的加到原来数组里*/
                [sorts addObjectsFromArray:wSelf.block];
            }
            
            /*把新数据重新插入到block*/
            sorts = [wSelf modelsArray:sorts addModelFromDictionary:locks];
            sorts = [wSelf modelsArray:sorts addModelFromDictionary:removes];
            
            wSelf.block = (NSMutableArray <ChannelListBlockModel, Optional> *)sorts;
            wSelf.isEdit = @"YES";
            [wSelf writToBox:[wSelf toDictionary] filePath:endPath];
        }];
    }
    
}

- (void)writToBox:(NSDictionary *)jsonObject filePath:(NSString *)endPath
{
    
    BOOL isSuccess = [jsonObject writeToFile:endPath atomically:YES];
    
    if (!isSuccess) {
        NSString *errorCodeInfo = [NSString stringWithFormat:@"频道页: LTChannelIndexModel check data exception, blockCount:%ld", (unsigned long)[self.block count]];
        [LTDataCenter writeToErrorLogFile:errorCodeInfo];
    }
}

- (NSMutableArray<ChannelListBlockModel, Optional> *)modelsArray:(NSMutableArray<ChannelListBlockModel, Optional> *)array addModelFromDictionary:(NSDictionary *)dictionary {
    
    NSMutableArray *arraySort = [[NSMutableArray alloc]initWithArray:dictionary.allKeys];
    if (arraySort.count > 0) {
        [arraySort sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSNumber *a = (NSNumber *)obj1;
            NSNumber *b = (NSNumber *)obj2;
            if ([a integerValue] > [b integerValue]) {
                return NSOrderedDescending;
            }
            else if ([a integerValue] < [b integerValue]){
                return NSOrderedAscending;
            }
            else {
                return NSOrderedSame;
            }
        }];
        
        for (NSInteger i = 0; i < arraySort.count; i ++) {
            
            NSNumber *index = (NSNumber *)arraySort[i];
            ChannelListBlockModel *obj = (ChannelListBlockModel *)dictionary[index];
            if (array.count > [index integerValue]) {
                [array insertObject:obj atIndex:[index integerValue]];
            } else {
                [array addObject:obj];
            }
        }
    }
    
    return array;
}
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"focus"  : @"focuspic",
                                                   }];
}

- (BOOL)hasAdvertisementContentStyle {
    __weak typeof(self) wSelf = self;

    __block BOOL hasAdv = NO;
    [self.block enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChannelListBlockModel *block = (ChannelListBlockModel *)obj;
        
        if ([block.contentStyle integerValue] == PageStyle_Advertisement) {
            hasAdv = YES;
            *stop = YES;
        }
    }];
    
    return hasAdv;
}

@end

@implementation LTChannelConditionModel @end

@implementation LTEmotionMetaDataModel

+ (BOOL)isSpecialConfig:(NSString *)configName {
    
    if ([@"bottom_navigation_pic" isEqualToString:configName] || [@"service_bgcolor" isEqualToString:configName] || [@"top_pic" isEqualToString:configName] ) {
        return YES;
    }
    return NO;
}

- (EmotionType)getType {
    if ([@"1" isEqualToString:self.type]) {
        return EmotionType_image;
    }else if ([@"2" isEqualToString:self.type]) {
        return EmotionType_color;
    }
    return EmotionType_none;
}

- (UIColor *)getCheckColor {
    if (![NSObject empty:self.color_checked]) {
        return [UIColor colorWithAlphaString:self.color_checked];
    }
    return nil;
}
- (UIColor *)getUncheckColor {
    if (![NSObject empty:self.color_unchecked]) {
        return [UIColor colorWithAlphaString:self.color_unchecked];
    }
    return nil;
}

#ifndef LT_IPAD_CLIENT
- (NSString *)getUncheckedImageUrl {
    if (iPhone6plus || [UIScreen mainScreen].scale >= 3) {
        return self.icon_3x_unchecked;
    }else {
        return self.icon_2x_unchecked;
    }
}

- (NSString *)getChecedkImageUrl {
    if (iPhone6plus) {
        return self.icon_3x_checked;
    }else {
        return self.icon_2x_checked;
    }
}

- (NSString *)getSpecialConfigImage {
    if (iPhone4||iPhone5) {
        return self.icon_2x_unchecked;
    }
    else if(iPhone6) {
        return self.icon_2x_checked;
    }
    else if(iPhone6plus) {
        return self.icon_3x_unchecked;
    }
    return @"";
}
#endif

- (NSMutableArray *)getDownLoadImagesUrl {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if ([self getType] == EmotionType_image) {
        
        NSString *checkUrl = [self getChecedkImageUrl];
        if (![NSString empty:checkUrl]) {
            [array addObject:checkUrl];
        }
        
        NSString *uncheckUrl = [self getUncheckedImageUrl];
        if (![NSString empty:uncheckUrl]) {
            [array addObject:uncheckUrl];
        }
    }
    return array;
}

#pragma mark 编码 对对象属性进行编码的处理
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count,i;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *char_f = property_getName(property);
        NSString  *propertyName = [ NSString  stringWithUTF8String :char_f];
        if ([@"type" isEqualToString:propertyName]) {
            //type是系统关键字，不要用其默认的值。
            continue;
        }
        id  propertyValue = [ self valueForKey :( NSString *)propertyName];
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
#ifdef LT_IPAD_CLIENT
    [aCoder encodeObject:_type forKey:@"type"];
    free(properties);
#else


    free(properties);
    [aCoder encodeObject:_type forKey:@"type"];
#endif
}

#pragma mark 解码 解码归档数据来初始化对象
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count,i;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            NSString  *propertyName = [ NSString  stringWithUTF8String :char_f];
            id  propertyValue = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:propertyValue forKey:propertyName];
        }
        free(properties);
    }
    return self;
}

@end

@implementation LTEmotionMaterialModel

#pragma mark 编码 对对象属性进行编码的处理
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count,i;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *char_f = property_getName(property);
        NSString  *propertyName = [ NSString  stringWithUTF8String :char_f];
        id  propertyValue = [ self valueForKey :( NSString *)propertyName];
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
    free(properties);
}

#pragma mark 解码 解码归档数据来初始化对象
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count,i;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            NSString  *propertyName = [ NSString  stringWithUTF8String :char_f];
            id  propertyValue = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:propertyValue forKey:propertyName];
        }
        free(properties);
    }
    return self;
}

@end

@interface LTEmotionDesignModel(){
    LTEmotionDesignModel *validModel;
}
@end

@implementation LTEmotionDesignModel

+ (LTEmotionDesignModel *)shareInstance {
    static LTEmotionDesignModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+ (UIImage *)convertImageToDeviceScale:(UIImage *)image{
    NSData *data = UIImagePNGRepresentation(image);
    if (data) {
        CGFloat scale = [UIScreen mainScreen].scale;
        if (scale < 2) {
            scale = 2;
        }
        return [[UIImage alloc]initWithData:data scale:scale];
    }else {
        return image;
    }
}

- (NSMutableArray *)getDownloadUrls {
    
    NSMutableArray *urlsArray = [[NSMutableArray alloc]init];
    
    if (self.material) {
        //遍历所有的属性，获取相应的URL
        unsigned int count,i;
        objc_property_t *properties = class_copyPropertyList([LTEmotionMaterialModel class], &count);
        for (i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            NSString  *propertyName = [ NSString  stringWithUTF8String :char_f];
            id  propertyValue = [ self.material  valueForKey :( NSString *)propertyName];
            if ([propertyValue isKindOfClass:[LTEmotionMetaDataModel class]]) {
                LTEmotionMetaDataModel *model = propertyValue;
                if ([LTEmotionMetaDataModel isSpecialConfig:propertyName]) {
                    NSString *url = [model getSpecialConfigImage];
                    if (![NSString empty:url]) {
                        [urlsArray addObject:url];
                    }
                }else {
                    [urlsArray addObjectsFromArray:[model getDownLoadImagesUrl]];
                }
            }
        }
        free(properties);
    }
    return urlsArray;
}

- (BOOL)isInEmotion {
    if (self.validEmotionModel) {
        return YES;
    }
    return NO;
}

#pragma mark 编码 对对象属性进行编码的处理
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_startTime forKey:@"startTime"];
    [aCoder encodeObject:_endTime forKey:@"endTime"];
    [aCoder encodeObject:_material forKey:@"material"];
#ifdef LT_IPAD_CLIENT

#else


    [aCoder encodeObject:_startTimestamp forKey:@"startTimestamp"];
    [aCoder encodeObject:_endTimestamp forKey:@"endTimestamp"];
#endif
}

#pragma mark 解码 解码归档数据来初始化对象
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _startTime = [aDecoder decodeObjectForKey:@"startTime"];
        _endTime = [aDecoder decodeObjectForKey:@"endTime"];
        _material = [aDecoder decodeObjectForKey:@"material"];
#ifdef LT_IPAD_CLIENT

#else


        _startTimestamp = [aDecoder decodeObjectForKey:@"startTimestamp"];
        _endTimestamp = [aDecoder decodeObjectForKey:@"endTimestamp"];
#endif
    }
    return self;
}

@end

