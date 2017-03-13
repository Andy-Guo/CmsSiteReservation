//
//  LTChannelModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-3.
//
//

#import "LTChannelModel.h"
#import "LTDataModelEngine.h"
//#import "NSObject+ObjectEmpty.h"
//#import "NSString+HTTPExtensions.h"
#import "NSString+MovieInfo.h"

@implementation LTChartPic

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"400*300" : @"icon_400_300",
                                                       @"200*150" : @"icon_200_150",
                                                       @"400*225" : @"icon_400_225",
                                                       }];
}

@end

@implementation ChannelMainListModel

@end


@implementation SpecialListModel

@end


@implementation LTDoblyAlbumModel

@end
@implementation LTDoblyAlbumListModel

@end

@implementation LTDoblyVideoModel

@end

@implementation LTDoblyVideoListModel

@end

@implementation CharTopListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"dataType" : @"type",
                                                       @"name" : @"title",
                                                       @"subname" : @"subtitle",
                                                       @"playcount" : @"count",
                                                       @"name" : @"cname",
                                                       @"pid" : @"aid",
                                                       @"jump":@"needJump"
                                                       }];
}

- (NSString *)getIcon {
    NSString *url = @"";
    
    if (![NSString empty:self.picall.icon_400_300]) {
        url = self.picall.icon_400_300;
    }
    else if (![NSString empty:self.picall.icon_200_150]) {
        url = self.picall.icon_200_150;
    }
    
    return url;
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
        NSInteger episode = [self.episode integerValue];
        if ([self.isEnd integerValue] && episode > 0) {
            return [NSString stringWithFormat:NSLocalizedString(@"%ld期全", @"%ld期全"), (long)episode, NSLocalizedString(@"期全", nil)];
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
    
    if (    ![self.isEnd integerValue]
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
            return [NSString stringWithFormat:@"%@%@", self.episode, NSLocalizedString(@"集全", nil)];
        }
    }
    
    return @"";
    
}

@end

@implementation SubCharListModel
@end

@implementation  CharListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name" : @"cname",
                                                       @"list" : @"toplist",
                                                       }];
}

@end

@implementation LTChannelModel


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                @"channel" : @"channelList",
                @"speciallist" : @"specialList",
                @"block": @"chartList",
                @"data": @"chartNavList",
                }];
}

- (void)resetData
{
    if (self.channelList.count > 0)
    {
        self.channelList =nil;
    }
    
    if (self.specialList.count >0) {
        self.specialList= nil;
    }
    
}

- (NSInteger)getArrayCount:(CHANNEL_MAINLIST_TYPE)requestMode
{
    switch (requestMode) {
        case CHANNEL_MAINLIST_SORT:
            return self.channelList.count;
            
            break;
        case CHANNEL_MAINLIST_SPECIAL:
            return self.specialList.count;
        case CHANNEL_MAINLIST_CHART:
            return self.chartList.video.count;
        default:
            return self.channelList.count;
            break;
    }
}

- (NSString *)getIconByIndex:(NSInteger)index RequestMode:(CHANNEL_MAINLIST_TYPE)requestMode
{
    if (index >= self.channelList.count) {
        return @"";
    }
    
    switch (requestMode) {
        case CHANNEL_MAINLIST_SORT:
        {
            ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[index];
            return channelMainListModel.icon;
        }
            break;
        case CHANNEL_MAINLIST_SPECIAL:
        {
            SpecialListModel  *specialListModel=(SpecialListModel *)self.specialList[index];
            return specialListModel.icon;
        }
            break;
        case CHANNEL_MAINLIST_CHART:
        {
            OldMovieDetailModel *videoModel= (OldMovieDetailModel *)self.chartList.video[index];
            return videoModel.icon;
        }
            break;
        default:
        {
            ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[index];
            return channelMainListModel.icon;
        }
            break;
    }
}

- (NSString *)getIdByIndex:(NSInteger)index RequestMode:(CHANNEL_MAINLIST_TYPE)requestMode

{
    if (index >= self.channelList.count) {
        return @"";
    }
    
    switch (requestMode) {
        case CHANNEL_MAINLIST_SORT:
        {
            ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[index];
            return channelMainListModel.id;
        }
            break;
        case CHANNEL_MAINLIST_SPECIAL:
        {
            SpecialListModel  *specialListModel=(SpecialListModel *)self.specialList[index];
            return specialListModel.sid;
        }
            break;
        case CHANNEL_MAINLIST_CHART:
        {
              OldMovieDetailModel *videoModel= (OldMovieDetailModel *)self.chartList.video[index];
              return videoModel.id;
        }
            break;
        default:
        {
            ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[index];
            return channelMainListModel.id;
        }
            break;
    }

}

- (NSString *)getNameByIndex:(NSInteger)index RequestMode:(CHANNEL_MAINLIST_TYPE)requestMode

{
    switch (requestMode) {
        case CHANNEL_MAINLIST_SORT:
        {
            ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[index];
            return channelMainListModel.name;
        }
            break;
        case CHANNEL_MAINLIST_SPECIAL:
        {
            SpecialListModel  *specialListModel=(SpecialListModel *)self.specialList[index];
            return specialListModel.sname;
        }
            break;
        case CHANNEL_MAINLIST_CHART:
        {
            OldMovieDetailModel *videoModel= (OldMovieDetailModel *)self.chartList.video[index];
            return videoModel.title;
        }
            break;
        default:
        {
            ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[index];
            return channelMainListModel.name;
        }
            break;
    }
}

- (NSString *)getSubtitleByIndex:(NSInteger)index  RequestMode:(CHANNEL_MAINLIST_TYPE)requestMode
{
    switch(requestMode) {
        case CHANNEL_MAINLIST_SORT:
        {
            ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[index];
            return channelMainListModel.subtitle;
        }
            break;
        case CHANNEL_MAINLIST_SPECIAL:
        {
            SpecialListModel  *specialListModel=(SpecialListModel *)self.specialList[index];
            return specialListModel.subtitle;
        }
            break;
        default:
        {
            ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[index];
            return channelMainListModel.subtitle;
        }
            break;
    }

}

- (BOOL)isDataNull:(CHANNEL_MAINLIST_TYPE)requestMode
{
    return 0 == [self getArrayCount:requestMode];
}

#ifdef LT_IPAD_CLIENT
- (ChannelID)getChannelIDByIndex:(NSInteger)index{
    
    NSString *cid = [self getIdByIndex:index RequestMode:CHANNEL_MAINLIST_SORT];
    if ([cid isEqualToString:kCidAnime]) {
        return ChannelAnime;
    }
    if ([cid isEqualToString:kCidDocumentary]) {
        return ChannelDocumentary;
    }
    if ([cid isEqualToString:kCidEntertainment]) {
        return ChannelEntertainment;
    }
    if ([cid isEqualToString:kCidFasion]) {
        return ChannelFashion;
    }
    if ([cid isEqualToString:kCidLetvMake]) {
        return ChannelLetvMake;
    }
    if ([cid isEqualToString:kCidLetvProduce]) {
        return ChannelLetvProduce;
    }
    if ([cid isEqualToString:kCidMovie]) {
        return ChannelMovie;
    }
    if ([cid isEqualToString:kCidOpenClass]) {
        return ChannelOpenClass;
    }
    if ([cid isEqualToString:kCidSport]) {
        return ChannelSport;
    }
    if ([cid isEqualToString:kCidTV]) {
        return ChannelTV;
    }
    if ([cid isEqualToString:kCidTVProgram]) {
        return ChannelTVProgram;
    }
    if ([cid isEqualToString:kCidTour]) {
        return ChannelTravel;
    }
    if ([cid isEqualToString:kCidCar]) {
        return ChannelCar;
    }
    if ([cid isEqualToString:kCidFinacial]) {
        return ChannelFinance;
    }
    if ([cid isEqualToString:@"1000"]) {
        return ChannelVip;
    }
    if ([cid isEqualToString:kCidKids]) {
        return ChannelKids;
    }
    if ([cid isEqualToString:kCidMusic]) {
        return ChannelMusic;
    }
    if ([cid isEqualToString:kCidNBA]) {
        return ChannelNBA;
    }
    
    return ChannelUnDefine;
    
}

- (NSInteger) getIndexByChannelID:(ChannelID)channelId{
    
    NSString *cid = @"";
    switch (channelId) {
        case ChannelAnime:
            cid = kCidAnime;
            break;
        case ChannelDocumentary:
            cid = kCidDocumentary;
            break;
        case ChannelEntertainment:
            cid = kCidEntertainment;
            break;
        case ChannelFashion:
            cid = kCidFasion;
            break;
        case ChannelLetvMake:
            cid = kCidLetvMake;
            break;
        case ChannelLetvProduce:
            cid = kCidLetvProduce;
            break;
        case ChannelMovie:
            cid = kCidMovie;
            break;
        case ChannelOpenClass:
            cid = kCidOpenClass;
            break;
        case ChannelSport:
            cid = kCidSport;
            break;
        case ChannelTV:
            cid = kCidTV;
            break;
        case ChannelTVProgram:
            cid = kCidTVProgram;
            break;
        case ChannelFinance:
            cid = kCidFinacial;
            break;
        case ChannelCar:
            cid = kCidCar;
            break;
        case ChannelTravel:
            cid = kCidTour;
            break;
        case ChannelVip:
            cid = @"1000";
            break;
        case ChannelKids:
            cid = kCidKids;
            break;
        case ChannelMusic:
            cid = kCidMusic;
            break;
        case ChannelNBA:
            cid = kCidNBA;
            break;
        case ChannelUnDefine:
        default:
            break;
    }
    
    if ([NSString isBlankString:cid]) {
        return -1;
    }
    
    NSInteger countOfMainListData = [self getArrayCount:CHANNEL_MAINLIST_SORT];
    for (int i = 0; i < countOfMainListData; i++) {
        NSString *cidCurrent = [self getIdByIndex:i RequestMode:CHANNEL_MAINLIST_SORT];
        if ([cid isEqualToString:cidCurrent]) {
            return i;
        }
    }
    
    return -1;
}

- (NSInteger) getDefaultIndexByChannelID:(ChannelID)channelId{
    
    return channelId;
    
}

- (NSString *)getDefaultIconByChannelID:(ChannelID)channelId
                       forSelectedState:(BOOL)isSelected{
    
    switch (channelId) {
        case ChannelAnime:
            return isSelected ? @"dongman_selected.png" : @"dongman_normal.png";
        case ChannelDocumentary:
            return isSelected ? @"jilupian_selected.png" : @"jilupian_normal.png";
        case ChannelEntertainment:
            return isSelected ? @"yule_selected.png" : @"yule_normal.png";
        case ChannelFashion:
            return isSelected ? @"fengshang_selected.png" : @"fengshang_normal.png";
        case ChannelLetvMake:
            return isSelected ? @"leshizhizao_selected.png" : @"leshizhizao_normal.png";
        case ChannelLetvProduce:
            return isSelected ? @"leshichupin_selected.png" : @"leshichupin_normal.png";
        case ChannelMovie:
            return isSelected ? @"dianying_selected.png" : @"dianying_normal.png";
        case ChannelOpenClass:
            return isSelected ? @"gongkaike_selected.png" : @"gongkaike_normal.png";
        case ChannelSport:
            return isSelected ? @"tiyu_selected.png" : @"tiyu_normal.png";
        case ChannelTV:
            return isSelected ? @"dianshiju_selected.png" : @"dianshiju_normal.png";
        case ChannelTVProgram:
            return isSelected ? @"zongyi_selected.png" : @"zongyi_normal.png";
        case ChannelVip:
            return isSelected ? @"huiyuan_selected.png" : @"huiyuan_normal.png";
        case ChannelCar:
            return isSelected ? @"qiche_selected.png" : @"qiche_normal.png";
        case ChannelTravel:
            return isSelected ? @"lvyou_selected.png" : @"lvyou_normal.png";
        case ChannelFinance:
            return isSelected ? @"caijing_selected.png" : @"caijing_normal.png";
        case ChannelKids:
            return isSelected ? @"qinzi_selected.png" : @"qinzi_normal.png";
        case ChannelMusic:
            return isSelected ? @"yinyue_selected.png" : @"yinyue_normal.png";
        case ChannelNBA:
            return isSelected ? @"nba_selected.png" : @"nba_normal.png";
        case ChannelUnDefine:
        default:
            break;
    }
    
    return @"";
    
}


- (NSString *)getIconByChannelID:(ChannelID)channelId
                forSelectedState:(BOOL)isSelected{
    
    NSString *keyIcon = @"";
    
    NSInteger idx = [self getIndexByChannelID:channelId];
    
    if (idx < 0) {
        return @"";
    }
    
    ChannelMainListModel *channelMainListModel=(ChannelMainListModel *)self.channelList[idx];
    
    
    UIDevicePlatform devicePlatform = [DeviceManager getDevicePlatform];
    if (    UIDevice1GiPad == devicePlatform
        ||  UIDevice2GiPad == devicePlatform) {
        keyIcon = isSelected ? channelMainListModel.icon_selected_small : channelMainListModel.icon_normal_small;
    }
    else{
        keyIcon = isSelected ? channelMainListModel.icon_selected_big : channelMainListModel.icon_normal_big;
    }
    
    if ([NSString isBlankString:keyIcon]) {
        return @"";
    }

    
    return keyIcon;
}


#endif

//for 排行榜
- (NSInteger) getCurrentNavIndex
{
    NSString *currentId = self.chartList.cid;
    
    for (NSInteger index = 0; index < [self.chartNavList count]; index++) {
        CharListModel *chartListModel=self.chartNavList[index];
        if ([currentId isEqualToString:chartListModel.cid]) {
            return index;
        }
    }
    return 0;
}

- (BOOL) getItemNeedJumpByIndex:(NSInteger)_index
{
     OldMovieDetailModel *videoModel= self.chartList.video[_index];
    return [videoModel.jump isEqualToString:@"2"];
}

- (LT_VIDEO_AT) getItemAtByIndex:(NSInteger)_index
{
    OldMovieDetailModel *videoModel= self.chartList.video[_index];

    return [NSString formateVideoAtValue:videoModel.at];
}

- (NSString *)getItemTypeByIndex:(NSInteger)_index{
    OldMovieDetailModel *videoModel= self.chartList.video[_index];
    return videoModel.type;
}

- (NSString*) getItemUrlByIndex:(NSInteger)_index{
    OldMovieDetailModel *videoModel= self.chartList.video[_index];
    return videoModel.url;
}

- (NSString*) getItemScoreByIndex:(NSInteger)_index{
     OldMovieDetailModel *videoModel= self.chartList.video[_index];
    return videoModel.score;
}

- (NSMutableArray *)getSpecArrayByIndex:(NSInteger)_index
{
    NSMutableArray *arraySpec = [NSMutableArray array];
    
    OldMovieDetailModel *videoModel= (OldMovieDetailModel *)self.chartList.video[_index];
    NSString *cid = videoModel.cid;
    if (    [kCidMovie isEqualToString:cid]
        ||  [kCidTV isEqualToString:cid]) {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"导演", nil)
                                                      andValue:videoModel.directory]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"主演", nil)
                                                      andValue:videoModel.starring]];
        
    }
    else if ([kCidAnime isEqualToString:cid]) {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"地区", nil)
                                                      andValue:videoModel.area]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"类型", nil)
                                                      andValue:videoModel.subCategory]];
    }
    else {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"标签", nil)
                                                      andValue:videoModel.tags]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"播放数", nil)
                                                      andValue:videoModel.playcount]];
        
    }
    
    return arraySpec;
}

- (NSString*) getNavNameByIndex:(NSInteger)_index
{
    CharListModel *model=(CharListModel *)self.chartNavList[_index];
    return model.cname;
  
}

- (NSString*) getNavIdByIndex:(NSInteger)_index
{
    CharListModel *model=(CharListModel *)self.chartNavList[_index];
    return model.cid;
}

@end

#ifdef LT_IPAD_CLIENT
/* the data model for chart.... for iPad */
@implementation ChartModel

- (NSInteger) getCurrentNavIndex
{
    NSString *currentId = self.block.cid;
    
    for (NSInteger index = 0; index < self.nav.count; index++) {
        CharListModel *item = self.nav[index];
        if ([currentId isEqualToString:item.cid]) {
            return index;
        }
    }
    return 0;
}

@end

/* the data model for subject.... for iPad */
@implementation SubjectModel

- (NSInteger) getCurrentNavIndex
{
    NSString *currentId = self.block.sid;
    
    for (NSInteger index = 0; index < self.nav.count; index++) {
        SpecialListModel *item = self.nav[index];
        if ([currentId isEqualToString:item.sid]) {
            return index;
        }
    }
    return 0;
}

@end
#endif
