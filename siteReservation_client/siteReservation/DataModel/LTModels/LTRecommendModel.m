//
//  LTRecommendModel.m
//  LetvIphoneClient
//
//  Created by bob on 13-8-15.
//
//

#import "LTRecommendModel.h"
//#import "NSString+HTTPExtensions.h"
//#import "NSString+MD5.h"
//#import "NSObject+ObjectEmpty.h"
#import "NSString+MovieInfo.h"
#import "LTVideoAuxiliaryInfoManager.h"
#import "LTDataCenter.h"

@implementation LTRecommendSearchWord
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.nameCn forKey:@"nameCn"];

}
- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        self.nameCn = [decoder decodeObjectForKey:@"nameCn"];
 
    }
    return  self;
}

@end

@implementation LTRecommendVideoModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"mobilePic"  : @"pic",
                                                       @"stamp" : @"tag",
                                                       }];
}

-(NSString *)getIcon
{
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
    
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.picList[@"pic169"];
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
            return [NSString stringWithFormat:NSLocalizedString(@"%ld期全", @"%ld期全"), (long)episode, NSLocalizedString(@"期全", nil)];
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
    
    if (    ![self.isEnd isEqualToString:@"1"]
        &&  [self.nowEpisodes integerValue] < [self.episode integerValue]) {
        if ([self.nowEpisodes integerValue] <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%@%@%@", NSLocalizedString(@"更新至", nil),self.nowEpisodes, NSLocalizedString(@"集", nil)];
        }
    }
    else{
        if ([self.episode integerValue] <= 0) {
            return @"";
        }
        else{
            
            return @"";//[NSString stringWithFormat:NSLocalizedString(@"%@集全", @"%@集全"), self.episode];
        }
    }
    
    return @"";
    
}

- (NSString *)getDuration {
    NSString *durationStr = @"";
    
    if (![NSString empty:self.duration]) {
        NSInteger durationInt = [self.duration integerValue];
        
        NSInteger durationSecondPart = durationInt % 60;
        NSInteger durationMinutePart = durationInt / 60;
        
        durationStr = [NSString stringWithFormat:@"%02ld:%02ld", (long)durationMinutePart, (long)durationSecondPart];
    }
    
    return durationStr;
}

- (BOOL)isValid {
    BOOL isValid = YES;
    /* 视频类型过滤去掉，迎合全网数据
    if (![NSString empty:self.type]) {
        NSInteger type = [self.type integerValue];

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

- (NSString *)pic_300x300{
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
@implementation LTSpecialTopicModel

@end
@implementation LTSpecialTopicVideoModel

@end
@implementation LTRecommendShowTagListModel


@end

@implementation LTRecommendBootimgModel

- (NSString *)getPushPicName
{
//#ifdef LT_IPAD_CLIENT
//    return self.pic1024_768;
//#else
//    if (iPhone5) {
//        return self.pic640_1136;
//    }else{
//        return self.pic640_960;
//    }
//#endif
    
#ifndef LT_IPAD_CLIENT
    if (iPhone5) {
        return _pic_2;
    }
#endif
    
    return _pic_1;
}

- (LTBootImagePriority)getPushPicPriority{
    
//    if (self.settop) {
//        return 1;
//    }
    
    return 0;
}


@end

@implementation LTLiveCmsReccomendModel

@end


@implementation LTRecommendFocusPic

- (BOOL)isShortVideoSeries
{
    if (LT_VIDEO_AT_PLAY != [self.at integerValue]) {
        return NO;
    }
    
    if (VIDEO_FROM_VRS != [self.type integerValue]) {
        return NO;
    }
    
    NSString *aid = self.pid;
    if (    [NSString isBlankString:aid]
        ||  [aid isEqualToString:@"0"]) {
        return NO;
    }
    
//    NSString *vid = self.id;
//    if ([NSString isBlankString:vid]) {
//        return NO;
//    }
    
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"mobilePic"  : @"pic",
                                                       }];
}

- (BOOL)isValid {
    BOOL isValid = YES;
    /* 视频类型过滤去掉，迎合全网数据
    if (![NSString empty:self.type]) {
        NSInteger type = [self.type integerValue];

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

@end

@implementation LTRecommendBlockModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"template"  : @"templateType",
                                                       @"list"  : @"video",
                                                       @"outPutStyle"   :@"sectionModel",
                                                       @"sub_block" : @"subBlock",
                                                       }];
}

- (BOOL)isPersonalRecommend
{
    BOOL isRec=NO;
    if (!([self.cms_num integerValue] == self.video.count)) {
            isRec =YES;
    }
    return isRec;
}

- (void)addStatisticAction:(LTDCPageID)pageID index:(NSInteger)index section:(NSInteger)sctioin
{
    if (self.video.count > index) {
        LTRecommendVideoModel *model = self.video[index];
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
        info.pageID = LTDCPageIDIndex;
        info.apc = LTDCActionPropertyCategoryIndexBlock;
        info.lid = model.id;
        if ([model.at intValue] == LT_VIDEO_AT_5_Web) {
            info.cur_url = model.webUrl;
        } else if ([model.at intValue] == LT_VIDEO_AT_5_WebView) {
            info.cur_url = model.webViewUrl;
        } else if ([model.at intValue] == LT_VIDEO_AT_5_FullscreenPlayer_Living) {
            info.cur_url = model.streamUrl;
        }
        
        info.fragId = self.fragId;
        info.name = self.blockname;
        info.bucket = self.bucket;
        info.area = self.area;
        info.reid = self.reid;
        info.rank = [NSString stringWithFormat:@"%ld",(long)sctioin+1];
        [LTDataCenter addStatistic:info];
    }
}

- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index
{
    LTStatisticInfo * statisticInfo = [[LTStatisticInfo alloc]init];
    LTDCActionCode code = LTDCActionCodeShow;
    if ([self isPersonalRecommend]) {
        //个性化推荐模块，发曝光统计
        code = LTDCActionCodeShowForRecommend;
    }
    statisticInfo.acode = code;
    statisticInfo.pageID = pageID;
    statisticInfo.fragId = self.fragId;
    statisticInfo.name = self.blockname;
    statisticInfo.wz = index + 1;
    statisticInfo.bucket = self.bucket;
    statisticInfo.area = self.area;
    statisticInfo.reid = self.reid;
    statisticInfo.rank = [NSString stringWithFormat:@"%ld",(long)index+1];
    statisticInfo.apc = ([self.contentStyle integerValue] == PageStyle_Recommend)?LTDCActionPropertyCategoryIndexBlock1:LTDCActionPropertyCategoryIndexBlock;
    // 模块曝光时增加模块内所有视频的vid信息上报，在扩展字段ap中上报vid列表和pid列表，
    // 有vid只报vid，vids=vid1;vid2...，若没有vid时情况下再上报pid，pids=pid1;pid2...，pid
    __block NSString *vidString = @"";
    __block NSString *pidString = @"";
    [self.video enumerateObjectsUsingBlock:^(LTRecommendVideoModel *obj, NSUInteger idx, BOOL *stop) {
        
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

@implementation LTRecommendRedFieldModel
@end

@implementation LTRecommendModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"focus"  : @"focuspic",
                                                       }];
}


- (BOOL)isPushPicExisted:(NSString *)picname
{
    
    if ([NSString isBlankString:picname]) {
        return NO;
    }
    
    NSInteger countBootImage = self.bootimg.count;
    
    for (int i = 0; i < countBootImage; i++) {
        NSString *strpicname = [((LTRecommendBootimgModel *)self.bootimg[i]) getPushPicName];
        if ([picname isEqualToString:strpicname]) {
            return YES;
        }
    }
    
    return NO;
    
}

- (void)removeFocusInvalidData:(NSMutableArray *)dataArray {
    
    if (dataArray == nil || [dataArray count] == 0) {
        return;
    }
    
    NSMutableArray *toBeRemove = [[NSMutableArray alloc] init];
    
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LTRecommendVideoModel *picModel = (LTRecommendVideoModel *)obj;
        if ([picModel isValid] == NO) {
            [toBeRemove addObject:picModel];
        }
    }];
    
    if ([toBeRemove count] > 0) {
        [dataArray removeObjectsInArray:toBeRemove];
    }
}

- (void)removeVideoInvalidData:(NSMutableArray *)dataArray {
    
    if (dataArray == nil || [dataArray count] == 0) {
        return;
    }
    
    NSMutableArray *toBeRemove = [[NSMutableArray alloc] init];
    
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LTRecommendVideoModel *videoModel = (LTRecommendVideoModel *)obj;
        
        if ([videoModel isValid] == NO) {
            [toBeRemove addObject:videoModel];
        }
    }];
    
    if ([toBeRemove count] > 0) {
        [dataArray removeObjectsInArray:toBeRemove];
    }
}

- (void)removeInvalidData {
    if (self.focuspic != nil) {
        [self removeFocusInvalidData:self.focuspic];
    }
    
    if (self.block != nil) {
        
        NSMutableArray *toBeRemove = [[NSMutableArray alloc] init];
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        NSMutableArray *searchwords = [[NSMutableArray alloc] init];
#else
        NSMutableArray *rmLives = [[NSMutableArray alloc] init];
#endif
        [self.block enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            LTRecommendBlockModel *blockModel = (LTRecommendBlockModel *)obj;
            PageStyle style = [blockModel.contentStyle integerValue];
            
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            if (style == PageStyle_Hot_Words) {
                [searchwords addObject:blockModel];
            }
            
            if (   blockModel != nil
                && blockModel.video.count > 0
                && style != PageStyle_Hot_Words
                && style != PageStyle_Star) {
                //这部分需要判断，不然把热词就会删掉
                [self removeVideoInvalidData:blockModel.video];
            }
            if (   blockModel.video.count == 0
                && style != PageStyle_New_Promotion
                && style != PageStyle_Search) {
                //清理掉list个数为零的模块，除了搜索
                [toBeRemove addObject:blockModel];
            }
#else
            if ([[LTVideoAuxiliaryInfoManager defaultManager] isExistPageStyle:blockModel.contentStyle]) {
                if (style == PageStyle_Live) {
                    [rmLives addObject:blockModel];
                }
                
                if (   blockModel != nil
                    && blockModel.video.count > 0) {
                    [self removeVideoInvalidData:blockModel.video];
                }
                
                if (   blockModel.video.count == 0
                    && style != PageStyle_Live) {
                    //清理掉list个数为零的模块，除了搜索
                    [toBeRemove addObject:blockModel];
                }
            } else {
                [toBeRemove addObject:blockModel];
            }
#endif
        }];

#ifndef LT_MERGE_FROM_IPAD_CLIENT
        if (searchwords.count > 1) {
            [searchwords removeObjectAtIndex:0];       //留下第一个搜索数据
            if (searchwords.count > 0) {
                [self.block removeObjectsInArray:searchwords];
            }
        }
#else
        if (rmLives.count > 1) {
            [rmLives removeObjectAtIndex:0];    //留下第一个直播数据
            if (rmLives.count > 0) {
                [self.block removeObjectsInArray:rmLives];
            }
        }
#endif
        if (toBeRemove.count > 0) {
            [self.block removeObjectsInArray:toBeRemove];  //删除不符合数据的类型的Block
        }
        
        
    }
}

- (BOOL)isShouldCache
{
    BOOL isNeedCache = NO;
    __block BOOL isFocus = NO; // 焦点图是否符合
    
    [self removeInvalidData];
    if (self.block.count > 0) {
        
        NSInteger maxNumber = [SettingManager getBlockMaxNumber];
        if (maxNumber <= 0) {
            maxNumber = 1;
        }
        
#ifdef LT_IPAD_CLIENT
        __block BOOL isFocus = NO; // 焦点图是否符合
#else

#endif
        __block NSMutableArray *removes = [[NSMutableArray alloc] initWithCapacity:10];
#ifdef LT_MERGE_FROM_IPAD_CLIENT
        isFocus = (self.focuspic.count >= maxNumber);
#endif
        [self.block enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LTRecommendBlockModel *block = (LTRecommendBlockModel *)obj;
#ifndef LT_MERGE_FROM_IPAD_CLIENT
            if ([block.contentStyle integerValue] == PageStyle_Focus_New && block.video.count >= maxNumber) {
                isFocus = YES;
            }
#endif
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
    
    return isNeedCache;
}

@end


@implementation LTPersonalizedRecommendModel

- (void)removeVideoInvalidData:(NSMutableArray *)dataArray {
    
    if (dataArray == nil || [dataArray count] == 0) {
        return;
    }
    
    NSMutableArray *toBeRemove = [[NSMutableArray alloc] init];
    
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LTRecommendVideoModel *videoModel = (LTRecommendVideoModel *)obj;
        
        if ([videoModel isValid] == NO) {
            [toBeRemove addObject:videoModel];
        }
    }];
    
    if ([toBeRemove count] > 0) {
        [dataArray removeObjectsInArray:toBeRemove];
    }
}

- (void)removeInvalidData {
    if (self.block != nil) {
        [self.block enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            LTRecommendBlockModel *blockModel = (LTRecommendBlockModel *)obj;
            
            [self removeVideoInvalidData:blockModel.video];
        }];
    }
}

@end

@implementation LTRecommendBlockContentModel
@end

@implementation LTRecommendLaunchLogoPicModel
@end

@implementation LTRecommendLauchLogoModel
@end

@implementation LTRecommendLaunchLogoBlockModel
- (NSString *)getIconForSize
{
    NSString *iconUrl = @"";
#ifndef LT_IPAD_CLIENT
    if (iPhone4) {
        iconUrl = self.blockContent.picList.pic1;
    } else if (iPhone5) {
        iconUrl = self.blockContent.picList.pic2;
    } else if (iPhone6) {
        iconUrl = self.blockContent.picList.mobilePic;
    } else if (iPhone6plus) {
        iconUrl = self.blockContent.picList.padPic;
    }
#else
    
#endif
    return iconUrl;
}
@end

@implementation LTRecommendPromotionModel
- (id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        if (self.result.rows) {
            NSMutableArray *rows = [NSMutableArray arrayWithCapacity:2];
            for (NSDictionary *blockModel in [self.result.rows copy]) {
                NSInteger at = [blockModel[@"at"] integerValue];
                LTRecommendPromotionBlockModel *model = [LTRecommendPromotionBlockModel new];
                if (at == 106 || at == 116) {
                    model.type = @"tv";
                    LTLiveChannelListDetailModel *channelModel = [[LTLiveChannelListDetailModel alloc] initWithDictionary:blockModel error:nil];
                    model.detailModel = channelModel;
                } else if (at == 5) {
                    model.type = @"cms";
                    LTRecommendVideoModel *cmsModel = [[LTRecommendVideoModel alloc]
                                                       initWithDictionary:blockModel error:nil];
                    model.detailModel = cmsModel;
                } else {
                    model.type = @"live";
                    LTLiveRoomDetailModel *liveModel = [[LTLiveRoomDetailModel alloc] initWithDictionary:blockModel error:nil];
                    model.detailModel = liveModel;
                }
                model.content = blockModel;
                [rows addObject:model];
            }
            self.result.rows = rows;
        }
    }
    return self;
}
@end
@implementation LTRecommendPromotionReusltModel @end
@implementation LTRecommendPromotionLiveDataModel @end
@implementation LTRecommendPromotionCMSModel @end
@implementation LTRecommendPromotionTVDataModel @end

@implementation LTRecommendPromotionBlockModel @end

