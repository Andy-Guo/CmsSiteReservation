//
//  LTChannelIndexModelPBOC+Function.m
//  LeTVMobileDataModel
//
//  Created by dabao on 16/4/1.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "LTChannelIndexModelPBOC+Function.h"

@implementation LTChannelIndexModelPBOC (Function)
- (BOOL)isContainPageID:(NSString *)pageID
{
    __block BOOL isContain = NO;
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModelPBOC *obj, NSUInteger idx, BOOL *blockStop) {
        if ([obj.contentStyle integerValue] == PageStyle_Navigation_New) {
            [obj.blockContent enumerateObjectsUsingBlock:^(FilmListModelPBOC *obj, NSUInteger idx, BOOL *stop) {
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
    [self.block enumerateObjectsUsingBlock:^(ChannelListBlockModelPBOC *obj, NSUInteger idx, BOOL *blockStop) {
        if ([obj.contentStyle integerValue] == PageStyle_Navigation_New) {
            [obj.blockContent enumerateObjectsUsingBlock:^(FilmListModelPBOC *obj, NSUInteger idx, BOOL *stop) {
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


- (void)removeVideoInvalidData:(NSMutableArray *)dataArray {
    
    if (dataArray == nil || [dataArray count] == 0) {
        return;
    }
    
    NSMutableArray *toBeRemove = [[NSMutableArray alloc] init];
    
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FilmListModelPBOC *videoModel = (FilmListModelPBOC *)obj;
        
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
    
    [self.block enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ChannelListBlockModelPBOC *blockModel = (ChannelListBlockModelPBOC *)obj;
        PageStyle style = [blockModel.contentStyle integerValue];
        
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        if (style == PageStyle_Live) {
            [rmLives addObject:blockModel];
        }
        
        if (style == PageStyle_Hot_Words) {
            [searchwords addObject:blockModel];
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
            && [blockModel.contentType integerValue] != 5) {
            //清理掉list个数为零的模块，除了搜索
            [toBeRemove addObject:blockModel];
        }
#else
        if ([[LTVideoAuxiliaryInfoManager defaultManager] isExistChannelPageStyle:blockModel.contentStyle]) {
            
            if (style == PageStyle_Live) {
                [rmLives addObject:blockModel];
            }
            
            if (   blockModel != nil
                && blockModel.blockContent.count > 0) {
                [self removeVideoInvalidData:blockModel.blockContent];
            }
            
            if (   blockModel.blockContent.count == 0
                && style != PageStyle_VIP_Promotion
                && style != PageStyle_Chart) {
                //清理掉list个数为零的模块，除了搜索
                [toBeRemove addObject:blockModel];
            }
        } else {
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
            ChannelListBlockModelPBOC *block = (ChannelListBlockModelPBOC *)obj;
            
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
@end

@implementation FilmListModelPBOC (Function)

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
    if ( ![NSObject empty:self.picList] /*&& [self.picList isKindOfClass:[NSDictionary class]]*/) {
        //return [self.picList objectForKey:@"pic169"];   // 16:9的图
        return self.picList.pic169;
    }
    
    return self.mobilePic;
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
    if (![NSObject empty:self.picList] /*&& [self.picList isKindOfClass:[NSDictionary class]]*/) {
        //        return [self.picList objectForKey:@"300x300"];
        return self.picList.pic_300_300;
    }
    return @"";
}

- (NSString *)pic_400x300
{
    if (![NSObject empty:self.picList] /*&& [self.picList isKindOfClass:[NSDictionary class]]*/) {
        //        return [self.picList objectForKey:@"400x300"];
        return self.picList.pic_400_300;
    }
    return @"";
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

@implementation ChannelListBlockModelPBOC (Function)

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
        FilmListModelPBOC *model = self.blockContent[index];
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
#ifdef LT_IPAD_CLIENT

#else


        if ([flag integerValue]!= -1) {
            info.flag = flag;
            info.apc = LTDCActionPropertyCategoryIndexBlock;
        }
#endif
        info.lid = model.streamCode;
        
        info.fragId = self.fragId;
        info.name = self.name;
        if ([self.contentStyle integerValue] == PageStyle_Service_Area) {
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

- (void)addStatisticAction:(LTDCPageID)pageID row:(NSInteger)index section:(NSInteger)section {
    
    
    [self addStatisticAction:pageID row:index section:section flag:@"-1"];
}

- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index
{
    
    [self addStatisticShow:pageID index:index flag:@"-1"];
}

- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index flag:(NSString *)flag {
    
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
    // 模块曝光时增加模块内所有视频的vid信息上报，在扩展字段ap中上报vid列表和pid列表，
    // 有vid只报vid，vids=vid1;vid2...，若没有vid时情况下再上报pid，pids=pid1;pid2...，pid
    __block NSString *vidString = @"";
    __block NSString *pidString = @"";
    [self.blockContent enumerateObjectsUsingBlock:^(FilmListModelPBOC *obj, NSUInteger idx, BOOL *stop) {
        
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
