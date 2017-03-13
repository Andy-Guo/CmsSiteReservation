//
//  LTLiveModel.m
//  LetvIphoneClient
//
//  Created by Dabao on 14-10-28.
//
//

#import "LTLiveModel.h"
#import <LeTVMobileDataModel/LiveOrderCommand.h>
#import <LeTVMobileDataModel/SettingManager+VideoCode.h>

@implementation LTLiveModel
@end

@implementation LTLiveHomeResultModel

@end

@implementation LTLiveHomeLeTopicModel
@end

@implementation LTLiveHomeHotLiveBlockModel
@end

@implementation LTLiveHomeTrailerBlockModel

@end

@implementation LTLiveHomeTrailerModel

@end

@implementation LTLiveHomeHotCarouselBlockModel
@end

@implementation LTLiveHomeHotCarouselModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"pic3_400_225" :@"pic"}];
}
@end

@implementation LTLiveHomeHotTVBlockModel
@end

@implementation LTLiveHomeHotTVModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"pic3_400_225" :@"pic"}];
}
@end

@implementation LTLiveRecommendModel
@end

@implementation LTLiveRoomBlockModel
@end

@implementation LTLiveRoomModel
@end
@implementation LTLiveNewRoomModel
@end
@implementation LTLiveBranchesModel
@end
@implementation LTLiveMultiProgramModel
@end

@implementation LTLiveFocusModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"pic1_746_419" :@"pic1",
                                                       @"pic2_960_540" :@"pic2",
                                                       @"pic3_400_225" :@"pic3",
                                                       @"pic4_160_90" :@"pic4"
                                                       }];
}

-(NSString*)getSharePic
{
    if (![NSString isBlankString:self.pic4]) {
        return self.pic4;
    }else if(![NSString isBlankString:self.pic3]){
        return self.pic3;
    }else if (![NSString isBlankString:self.pic1]){
        return self.pic1;
    }else if (![NSString isBlankString:self.pic2]){
        return self.pic2;
    }
    return nil;
}
@end

@implementation LTLiveRoomHalfListResultModel
@end

//全部预约
@implementation LTLiveOrderModel
- (void)removeInvalidData
{
    NSMutableArray *removes = [[NSMutableArray alloc] init];
    
    [self.result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LTLiveOrderBlockModel *block = (LTLiveOrderBlockModel *)obj;
        if (block.result.count == 0) {
            [removes addObject:block];
        }
    }];
    [self.result removeObjectsInArray:removes];
}
@end
@implementation LTLiveOrderBlockModel
@end

@implementation LTLiveRoomDetailModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description" :@"__description"}];
}

- (NSString *)formatLiveType:(NSString *)liveType
{
    if ([liveType isEqualToString:@"entertainment"]) {
        return @"ent";
    }
    return liveType;
}

- (NSString *)getIconUrl
{
    NSString *imgUrl = self.typeICO;
    if ([self.liveType isEqualToString:@"sports"]) {
        imgUrl = self.level2ImgUrl;
    }
    return imgUrl;
}

- (NSString *)getHomeFocusPic
{
    NSString *imageUrl = self.focusPic.pic3;
    if ([NSString isBlankString:imageUrl]) {
        imageUrl = self.focusPic.pic1;
    }
    
    if ([NSString isBlankString:imageUrl]) {
        imageUrl = self.focusPic.pic2;
    }
    
    if ([NSString isBlankString:imageUrl]) {
        imageUrl = self.focusPic.pic4;
    }
    
    return imageUrl;
}

#ifdef LT_IPAD_CLIENT
- (BillStatus)getBillStatus
{
    BillStatus billStatus = ORDER_STATUS;
    NSInteger status = [[NSString safeString:self.status] integerValue];
    if (status == 1) {
        if ([self.isPay integerValue] == 1) {
            billStatus = BILL_BUY_STATUS;
        }
        else {
            NSString *orderDate = [NSString formatTimeDateStr3:self.beginTime];    // 2014-10-18
            NSString *playTime = [NSString formatTimeDateStr1:self.beginTime];    // 08:20
            
            LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:orderDate
                                                                      billTime:playTime
                                                                   channelCode:[self formatLiveType:self.liveType]
                                                                     orderName:self.title];
            if (nil != liveCommand){
                billStatus = CANCELORDER_STATUS;
            }
            else{
                billStatus = ORDER_STATUS;
            }
        }
    }
    else if (status == 2) {
        billStatus = BILL_PLAY_STATUS;
    }
    else {
        if (![NSString isBlankString:self.recordingId]){
            billStatus = BILL_REPLAY_STATUS;   // 回看
        }
        else{
            billStatus = BILL_UPLOADING;       // 上传中
        }
    }
    return billStatus;
}
#else


- (BillStatus)getBillStatus
{
    BillStatus billStatus = ORDER_STATUS;
    NSInteger status = [[NSString safeString:self.status] integerValue];
    if (status == 1) {
        if ([self.isPay integerValue] == 1) {
            billStatus = BILL_BUY_STATUS;
        }
        else {
            NSString *orderDate = [NSString formatTimeDateStr3:self.beginTime];    // 2014-10-18
            NSString *playTime = [NSString formatTimeDateStr1:self.beginTime];    // 08:20
            
            LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:orderDate
                                                                      billTime:playTime
                                                                   channelCode:[self formatLiveType:self.liveType]
                                                                     orderName:self.title];
            if (nil != liveCommand){
                billStatus = CANCELORDER_STATUS;
            }
            else{
                billStatus = ORDER_STATUS;
            }
        }
    }
    else if (status == 2) {
        billStatus = BILL_PLAY_STATUS;
    }
    else {
        if (![NSString isBlankString:self.recordingId]){
            billStatus = BILL_REPLAY_STATUS;   // 回看
        }
        else{
            billStatus = BILL_UPLOADING;       // 上传中
        }
    }
    return billStatus;
}

#endif

- (BillStatus)getHomeBillStatus
{
    BillStatus billStatus = ORDER_STATUS;
    NSInteger status = [[NSString safeString:self.status] integerValue];
    if (status == 1) {
        NSString *orderDate = [NSString formatTimeDateStr3:self.beginTime];    // 2014-10-18
        NSString *playTime = [NSString formatTimeDateStr1:self.beginTime];    // 08:20
        
        LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:orderDate
                                                                  billTime:playTime
                                                               channelCode:[self formatLiveType:self.liveType]
                                                                 orderName:self.title];
        if (nil != liveCommand){
            billStatus = CANCELORDER_STATUS;
        }
        else{
            billStatus = ORDER_STATUS;
        }
    }
    else if (status == 2) {
        billStatus = BILL_PLAY_STATUS;
    }
    else {
        if (![NSString isBlankString:self.recordingId]){
            billStatus = BILL_REPLAY_STATUS;   // 回看
        }
        else{
            billStatus = BILL_UPLOADING;       // 上传中
        }
    }
    return billStatus;
}

- (NSString *)getChannelIconName{
    NSString *channelIcon = nil;
    if ([self.ch isEqualToString:@"letv_live_sports"]) {
        channelIcon = NSLocalizedString(@"entireLive_sport", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_variety"]) {
        channelIcon = NSLocalizedString(@"centireLive_variety", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_finance"]){
        channelIcon = NSLocalizedString(@"entireLive_finance", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_information"]){
        channelIcon = NSLocalizedString(@"entireLive_information", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_game"]){
        channelIcon = NSLocalizedString(@"entireLive_game", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_brand"]){
        channelIcon = NSLocalizedString(@"entireLive_brand", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_other"]){
        channelIcon = NSLocalizedString(@"entireLive_other", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_ent"]) {
        channelIcon = NSLocalizedString(@"entireLive_entertainment", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_music"]) {
        channelIcon = NSLocalizedString(@"entireLive_music", nil);
    }
    return channelIcon;
}

- (NSString *)getChannelTypeValue{
    NSString *channelStr = nil;
    if ([self.ch isEqual:@"letv_live_sports"]) {
        channelStr = [NSString stringWithFormat:@"%@",self.level1];
        
    } else if ([self.ch isEqualToString:@"letv_live_variety"]) {
        channelStr = NSLocalizedString(@"综艺频道", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_finance"]){
        channelStr = NSLocalizedString(@"财经频道", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_information"]){
        channelStr = NSLocalizedString(@"资讯频道", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_game"]){
        channelStr = NSLocalizedString(@"游戏频道", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_brand"]){
        channelStr = NSLocalizedString(@"品牌频道", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_other"]){
        channelStr = NSLocalizedString(@"其他", nil);
        
    } else if ([self.ch isEqualToString:@"letv_live_ent"]) {
        channelStr = [NSString stringWithFormat:@"%@" ,self.typeValue];
        
    } else if ([self.ch isEqualToString:@"letv_live_music"]) {
        channelStr = [NSString stringWithFormat:@"%@" ,self.typeValue];
    }
    return channelStr;
}

/**
 当前直播是否已预约
 */
- (BOOL)isLiveAppoint{
    NSString *orderDate = [NSString formatTimeDateStr3:self.beginTime];    // 2014-10-18
    NSString *playTime = [NSString formatTimeDateStr1:self.beginTime];    // 08:20
    
    LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:orderDate
                                                              billTime:playTime
                                                           channelCode:[self formatLiveType:self.liveType]
                                                             orderName:self.title];
    if (nil != liveCommand){
        return YES;
    }
    else{
        return NO;
    }
}


/**
 当前直播的类型
 */
- (LTLivingPayType)currentLiveType{
    if ([self.liveType isEqualToString:@"sports"]) {
        return LTLivingPayTypeSport;
    }
    if ([self.liveType isEqualToString:@"music"]) {
        return LTLivingPayTypeMusic;
    }
    if ([self.liveType isEqualToString:@"entertainment"]) {
        return LTLivingPayTypeEntertainment;
    }
    if ([self.liveType isEqualToString:@"other"]) {
        return LTLivingPayTypeOther;
    }
    
    return LTLivingPayTypeUnknown;
    
}

- (BOOL)isPanorama
{
    if (self.isPanoramicView && [self.isPanoramicView length] > 0) {
        return [self.isPanoramicView integerValue] == 1;
    }
    return NO;
}

- (BOOL)isSupportedMultiProgram {
    if (![NSString isBlankString:self.isBranch]&&[self.isBranch isEqualToString:@"1"]) {
        if (![NSString isBlankString:self.branchType]&&([self.branchType isEqualToString:@"1"]||[self.branchType isEqualToString:@"2"])) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (BOOL)isLivePush
{
    if (![NSString isBlankString:self.isPush] && [self.isPush isEqualToString:kIsLivePush]) {
        return YES;
    }
    return NO;
}

@end

@implementation LTLiveRoomDefaultModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"default" :@"rows"}];
}
@end

@implementation LTLiveRoomResultDefaultModel
@end

@implementation LTLiveRoomHotBlockModel
@end

@implementation LTLiveRoomSpecialModel

@end

@implementation LTLiveRoomHotResultModel
@end

@implementation LTLiveRoomHotHalfResultModel
@end

@implementation LTLiveRoomHotModel
- (void)removeInvalidData
{
    NSMutableArray *removes = [[NSMutableArray alloc] init];
    
    [self.result.sortHotItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LTLiveRoomHotBlockModel *block = (LTLiveRoomHotBlockModel *)obj;
        if (block.data.count == 0) {
            [removes addObject:block];
        }
    }];
    [self.result.sortHotItems removeObjectsInArray:removes];
}
@end
@implementation LTLiveRoomHotHalfModel
@end


@implementation LTLiveChannelModel
@end
@implementation LTLiveCurrentChannelModel
@end
@implementation LTLiveCurrentChannelMenuModel
@end
@implementation LTLiveTheaterIcoModel
@end
@implementation LTLiveMarkDetailModel
@end
@implementation LTLiveWaterMarkModel
@end
@implementation LTLiveChannelDetailModel

- (NSString *)formatPlayTime// 格式化播放开始时间
{
    return _playTime;
}
- (int)programPlayType{ // 当前节目播放类型： 1：回看 2： 直播 3：预告
    NSDate *playDate = [NSDate stringToDate:_playTime];
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interval1 = [zone1 secondsFromGMTForDate: playDate];
    NSDate *localeDate1 = [playDate  dateByAddingTimeInterval: interval1];
    playDate = localeDate1;
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDate *curDate = localeDate;
    
    NSDate *endDate = [NSDate stringToDate:_endTime];
    NSTimeZone *zone2 = [NSTimeZone systemTimeZone];
    NSInteger interval2 = [zone2 secondsFromGMTForDate: endDate];
    NSDate *localeDate2 = [endDate  dateByAddingTimeInterval: interval2];
    endDate = localeDate2;
    int result = 0;
    if (NSOrderedDescending == [curDate compare:playDate]) {//当前时间晚于播放时间
        if (NSOrderedAscending == [curDate compare:endDate]) {
            result =  2;
        }else if(NSOrderedDescending == [curDate compare:endDate]){
            result = 1;
        }else{
            result = 1;
        }
    }else if(NSOrderedAscending == [curDate compare:playDate]){//当前时间早于播放时间
        result = 3;
    }else{//相等
        result = 2;
    }
//    NSLog(@"play  %@ , playDate is %@ , curDate is %@ , endDate is %@",_playTime,playDate,curDate,endDate);
//    NSLog(@"result is %d",result);
    
    return result;
}
- (BillStatus)getChannelBillStatusWithChannelCode:(NSString *)channelCode
{
    BillStatus billStatus = ORDER_STATUS;
   
    NSString *orderDate = [NSString formatTimeDateStr3:self.playTime];    // 2014-10-18
    NSString *playTime = [NSString formatTimeDateStr1:self.playTime];    // 08:20
    
    LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:orderDate
                                                              billTime:playTime
                                                           channelCode:channelCode
                                                             orderName:self.title];
    if (nil != liveCommand){
        billStatus = CANCELORDER_STATUS;
    }
    else{
        billStatus = ORDER_STATUS;
    }
    return billStatus;
}
@end


@implementation LTLiveChannelRowsModel
@end
@implementation LTLiveChannelMenuModel
@end


@implementation LTLiveVideoModel
@end
@implementation LTLiveVideoDetailModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description" :@"__description"}];
}
@end
@implementation LTLiveChannelBillViewPicModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"400_300" :@"pic_400_300"}];
}
@end
@implementation LTLiveChannelBillResultModel
@end

@implementation LTLiveChannelBillModel
- (id)getProgramWithChannelId:(NSString *)channelId
{
    if ([NSString isBlankString:channelId]) {
        return nil;
    }
    LTLiveChannelBillBlockModel *curBillBlockModel = nil;
    if (self.result.rows && self.result.rows.count > 0) {
        for (LTLiveChannelBillBlockModel *model in self.result.rows) {
            if ([model.channelId isEqualToString:channelId]) {
                curBillBlockModel = model;
                break;
            }
        }
    }
    return curBillBlockModel;
}

@end
@implementation LTLiveChannelBillDetailModel

@end
@implementation LTLiveChannelBillBlockModel
@end

@implementation LTLiveChannelResultModel
@end

@implementation LTLiveChannelListModel
- (id)getChannelListDetailModel:(NSString *)channelId
{
    for (LTLiveChannelListDetailModel *listDetailModel in self.result.rows) {
        if ([listDetailModel.channelId isEqualToString:channelId]) {
            return listDetailModel;
        }
    }
    return nil;
}

- (id)getChannelBillBlockModel:(NSString *)channelId
{
    for (LTLiveChannelListDetailModel *listDetailModel in self.result.rows) {
        if ([listDetailModel.channelId isEqualToString:channelId]) {
            return listDetailModel.billBlockModel;
        }
    }
    return nil;
}

- (BOOL)isHasChannel:(NSString *)channelId
{
    __block BOOL isHasChannel = NO;
    [self.result.rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LTLiveChannelListDetailModel *detailModel = obj;
        if ([detailModel.channelId isEqualToString:channelId]) {
            *stop = YES;
            isHasChannel = YES;
        }
    }];
    return isHasChannel;
}

- (void)sortWithNumericKeys
{
    if (self.result.rows.count == 0) {
        return;
    }
    
    [self.result.rows sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        LTLiveChannelListDetailModel *order1 = obj1;
        LTLiveChannelListDetailModel *order2 = obj2;
        NSInteger value1 = [[NSString safeString:order1.numericKeys] integerValue];
        if ([NSString isBlankString:order1.numericKeys]) {
            value1 = self.result.rows.count + 100;
        }
        NSInteger value2 = [[NSString safeString:order2.numericKeys] integerValue];
        if ([NSString isBlankString:order2.numericKeys]) {
            value2 = self.result.rows.count + 100;
        }
        if (value1 > value2) {
            return NSOrderedDescending;
        }else if (value1 < value2) {
            return NSOrderedAscending;
        }else{
            return NSOrderedSame;
        }
    }];
}
@end
@implementation LTLiveChannelStreamsModel
- (LiveCodeType)getLiveTypeFromCode:(LTLiveChannelStreamsModel *)liveStream{
    LiveCodeType type = LIVE_CODE_UNKNOW;
    if (liveStream){
        if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_350]){
            type = LIVE_CODE_LD;
        }
        else if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_1000]){
            type = LIVE_CODE_SD;
        }
        else if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_1300]){
            type = LIVE_CODE_HD;
        }
        else if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_720p]){
            type = LIVE_CODE_720P;
        }else if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_1080p]){
            type = LIVE_CODE_1080P;
        }
    }
    return type;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.streamId forKey:@"streamId"];
    [aCoder encodeObject:self.streamName forKey:@"streamName"];
    [aCoder encodeObject:self.rateType forKey:@"rateType"];
    [aCoder encodeObject:self.streamUrl forKey:@"streamUrl"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.streamId = [aDecoder decodeObjectForKey:@"streamId"];
        self.streamName = [aDecoder decodeObjectForKey:@"streamName"];
        self.rateType = [aDecoder decodeObjectForKey:@"rateType"];
        self.streamUrl = [aDecoder decodeObjectForKey:@"streamUrl"];
    }
    return self;
}

@end

@implementation LTLiveChannelLogoModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"pic1_746_419" :@"pic1",
                                                       @"pic2_960_540" :@"pic2",
                                                       }];
}
@end

@implementation LTLiveChannelListDetailModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"pic3_400_225" :@"pic3"}];
}

- (LiveCodeType)getDefaultLiveType
{
    return LIVE_CODE_SD;
}
- (LiveCodeType)getLiveTypeFromCode:(LTLiveChannelStreamsModel *)liveStream{
    LiveCodeType type = LIVE_CODE_UNKNOW;
    if (liveStream){
        if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_350]){
            type = LIVE_CODE_LD;
        }
        else if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_1000]){
            type = LIVE_CODE_SD;
        }
        else if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_1300]){
            type = LIVE_CODE_HD;
        }
        else if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_720p]){
            type = LIVE_CODE_720P;
        }else if ([liveStream.rateType isEqualToString:LT_LIVING_STREAN_flv_1080p]){
            type = LIVE_CODE_1080P;
        }
    }
    return type;
}


- (LTLiveChannelStreamsModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType{
    LTLiveChannelStreamsModel *LiveUrlModel = [self getLiveChannelStream:LT_LIVING_STREAN_flv_1000];
    switch (liveCodeType) {
        case LIVE_CODE_LD:
            LiveUrlModel= [self getLiveChannelStream:LT_LIVING_STREAN_flv_350];
            break;
        case LIVE_CODE_SD:
            LiveUrlModel = [self getLiveChannelStream:LT_LIVING_STREAN_flv_1000];
            break;
        case LIVE_CODE_HD:
            LiveUrlModel= [self getLiveChannelStream:LT_LIVING_STREAN_flv_1300];
            break;
        case LIVE_CODE_720P:
            LiveUrlModel= [self getLiveChannelStream:LT_LIVING_STREAN_flv_720p];
            break;
        case LIVE_CODE_1080P:
            LiveUrlModel= [self getLiveChannelStream:LT_LIVING_STREAN_flv_1080p];
            break;
        default:
            break;
    }
    if ([NSString isBlankString:LiveUrlModel.streamUrl]) {
        LiveUrlModel = [self getLiveChannelStream:LT_LIVING_STREAN_flv_1000];
    }
    if ([NSString isBlankString:LiveUrlModel.streamUrl]) {
        LiveUrlModel = [self getLiveChannelStream:LT_LIVING_STREAN_flv_350];
    }
    if ([NSString isBlankString:LiveUrlModel.streamUrl]) {
        LiveUrlModel = [self getLiveChannelStream:LT_LIVING_STREAN_flv_1300];
    }
    if ([NSString isBlankString:LiveUrlModel.streamUrl]) {
        LiveUrlModel = [self getLiveChannelStream:LT_LIVING_STREAN_flv_720p];
    }
    if ([NSString isBlankString:LiveUrlModel.streamUrl]) {
        LiveUrlModel = [self getLiveChannelStream:LT_LIVING_STREAN_flv_1080p];
    }
    return LiveUrlModel;
}

- (BOOL)isValidCodeType:(LiveCodeType)liveCodeType{
    switch (liveCodeType) {
        case LIVE_CODE_LD:
            return ![NSString isBlankString:[self getLiveChannelStream:LT_LIVING_STREAN_flv_350].rateType];
            break;
        case LIVE_CODE_SD:
            return ![NSString isBlankString:[self getLiveChannelStream:LT_LIVING_STREAN_flv_1000].rateType];
            break;
        case LIVE_CODE_HD:
            return ![NSString isBlankString:[self getLiveChannelStream:LT_LIVING_STREAN_flv_1300].rateType];
            break;
        case LIVE_CODE_720P:
            return ![NSString isBlankString:[self getLiveChannelStream:LT_LIVING_STREAN_flv_720p].rateType];
            break;
        case LIVE_CODE_1080P:
            return ![NSString isBlankString:[self getLiveChannelStream:LT_LIVING_STREAN_flv_1080p].rateType];
            break;
        default:
            break;
    }
    return NO;
}


- (LTLiveChannelStreamsModel *)getLiveChannelStream:(NSString *)streamCode
{
    for (LTLiveChannelStreamsModel *stream in self.streams) {
        if ([stream.rateType isEqualToString:streamCode]) {
            return stream;
        }
    }
    return nil;
}



- (NSArray *)getAllValidCodeTypes
{
    NSMutableArray *allCodeTypes = [[NSMutableArray alloc] init];
    if ([self isValidCodeType:LIVE_CODE_1080P]) {
        [allCodeTypes addObject:[NSNumber numberWithInteger:LIVE_CODE_1080P]];
    }
    if ([self isValidCodeType:LIVE_CODE_720P]) {
        [allCodeTypes addObject:[NSNumber numberWithInteger:LIVE_CODE_720P]];
    }
    if ([self isValidCodeType:LIVE_CODE_HD]) {
        [allCodeTypes addObject:[NSNumber numberWithInteger:LIVE_CODE_HD]];
    }
    if ([self isValidCodeType:LIVE_CODE_SD]) {
        [allCodeTypes addObject:[NSNumber numberWithInteger:LIVE_CODE_SD]];
    }
    if ([self isValidCodeType:LIVE_CODE_LD]) {
        [allCodeTypes addObject:[NSNumber numberWithInteger:LIVE_CODE_LD]];
    }
    return allCodeTypes;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.channelId forKey:@"channelId"];
    [aCoder encodeObject:self.channelEname forKey:@"channelEname"];
    [aCoder encodeObject:self.channelName forKey:@"channelName"];
    [aCoder encodeObject:self.numericKeys forKey:@"numericKeys"];
    [aCoder encodeObject:self.streams forKey:@"streams"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.channelId = [aDecoder decodeObjectForKey:@"channelId"];
        self.channelEname = [aDecoder decodeObjectForKey:@"channelEname"];
        self.channelName = [aDecoder decodeObjectForKey:@"channelName"];
        self.numericKeys = [aDecoder decodeObjectForKey:@"numericKeys"];
        self.streams = [aDecoder decodeObjectForKey:@"streams"];
    }
    return self;
}

@end


@implementation LTLiveChannelFlowModel
-(LTLiveChannelStreamsModel *)getDefaultLiveStreamModel
{
    LiveCodeType type = [SettingManager getDefaultLiveBitrateOfPlay];

    NSArray *stramModelArray = self.rows;
    LTLiveChannelStreamsModel *defalutStreamModel = nil;
    LTLiveChannelStreamsModel *streamModelLD =nil;
    LTLiveChannelStreamsModel *streamModelSD =nil;
    LTLiveChannelStreamsModel *streamModelHD =nil;
    LTLiveChannelStreamsModel *streamModel720P =nil;
    LTLiveChannelStreamsModel *streamModel1080P =nil;
    for( LTLiveChannelStreamsModel *streamModel in stramModelArray)
    {
        if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1000]) {
            streamModelSD =streamModel;
            
        }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_350]) {
            streamModelLD =streamModel;
            
        }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1300]) {
            streamModelHD =streamModel;
            
        }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_720p]) {
            streamModel720P =streamModel;
            
        }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1080p]){
            streamModel1080P =streamModel;
            
        }
        
    }
    if (![NSString isBlankString:streamModelLD.streamUrl] && type == LIVE_CODE_SD) {
        defalutStreamModel = streamModelLD;
    }
    if (![NSString isBlankString:streamModelLD.streamUrl] && type == LIVE_CODE_LD) {
        defalutStreamModel = streamModelLD;
    }
    if (![NSString isBlankString:streamModelHD.streamUrl] && type == LIVE_CODE_HD) {
        defalutStreamModel = streamModelHD;
    }
    if (![NSString isBlankString:streamModel720P.streamUrl] && type == LIVE_CODE_720P) {
        defalutStreamModel = streamModel720P;
    }
    if (![NSString isBlankString:streamModel1080P.streamUrl] && type == LIVE_CODE_1080P) {
        defalutStreamModel = streamModel1080P;
    }
    if (defalutStreamModel == nil) {
        if (![NSString isBlankString:streamModelSD.streamUrl]) {
            return streamModelSD;
        }
        if (![NSString isBlankString:streamModelLD.streamUrl]) {
            return streamModelLD;
        }
        if (![NSString isBlankString:streamModelHD.streamUrl]) {
            return streamModelHD;
        }
        if (![NSString isBlankString:streamModel720P.streamUrl]) {
            return streamModel720P;
        }
        if (![NSString isBlankString:streamModel1080P.streamUrl]) {
            return streamModel1080P;
        }
    }
    return defalutStreamModel;
}

- (LTLiveChannelStreamsModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType{
    NSArray *LiveUrlModelArray =self.rows;
    LTLiveChannelStreamsModel *StreamUrlModel = nil;
    LTLiveChannelStreamsModel *StreamModelLD_Url =nil;
    LTLiveChannelStreamsModel *StreamModelSD_Url =nil;
    LTLiveChannelStreamsModel *StreamModelHD_Url =nil;
    LTLiveChannelStreamsModel *StreamModel720P_Url =nil;
    LTLiveChannelStreamsModel *streamModel1080P_Url = nil;
    for( LTLiveChannelStreamsModel *stream_UrlModel in LiveUrlModelArray)
    {
        if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1000]) {
            StreamModelSD_Url =stream_UrlModel;
            
        }else if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_350]) {
            StreamModelLD_Url =stream_UrlModel;
            
        }else if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1300]) {
            StreamModelHD_Url =stream_UrlModel;
            
        }else if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_720p]) {
            StreamModel720P_Url =stream_UrlModel;
            
        }else if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1080p]){
            streamModel1080P_Url =stream_UrlModel;
            
        }
        
    }
    switch (liveCodeType) {
        case LIVE_CODE_LD:
            StreamUrlModel= StreamModelLD_Url;
            break;
        case LIVE_CODE_SD:
            StreamUrlModel = StreamModelSD_Url;
            break;
        case LIVE_CODE_HD:
            StreamUrlModel= StreamModelHD_Url;
            break;
        case LIVE_CODE_720P:
            StreamUrlModel= StreamModel720P_Url;
            break;
        case LIVE_CODE_1080P:
            StreamUrlModel = streamModel1080P_Url;
            break;
        default:
            break;
    }
    return StreamUrlModel;
    
}

@end

@implementation LTLiveChannelMIGUFlowModel
- (NSString *)streamUrlAtArray
{
    NSString *streamUrl = nil;
    if (self.streamUrl.count > 0) {
        for (NSInteger i = 0; i < self.streamUrl.count; i ++) {
            streamUrl = self.streamUrl[i];
            if (streamUrl != nil) {
                break;
            }
        }
    }
    return streamUrl;
}
@end

@implementation LTLiveChannelBrandModel
@end
@implementation LTLiveChannelBrandDetailModel
@end

@implementation LTLiveOnlineNumModel

@end

@implementation LTLiveAddProductModel

@end

@implementation LTLiveShoppingCartModel
- (NSInteger)getShoppingCartCount {
    NSInteger count = [[self.result safeValueForKey:@"cartItemCount"] integerValue];
    return count;
}
@end

@implementation LTLiveShoppingCartListModel

@end

@implementation LTLiveListOrderModel
@end

@implementation LTLiveListOrderChannelModel
@end

@implementation LTLiveOrderChannelDetailModel
@end

@implementation LTLivePlayModel

- (NSArray *)validLiveCodeTypeArray
{
    NSArray *codeArray = nil;
    if (self.streamInfo) {
        NSMutableArray *validLiveVideoArray = [[NSMutableArray alloc] init];
        for (LTLiveChannelStreamsModel *streamModel in self.streamInfo) {
            if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1080p]) {
                [validLiveVideoArray addObject:[NSNumber numberWithInteger:VIDEO_CODE_1080P]];
            }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_720p]) {
                [validLiveVideoArray addObject:[NSNumber numberWithInteger:VIDEO_CODE_720P]];
            }
            else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1300]){
                [validLiveVideoArray addObject:[NSNumber numberWithInteger:VIDEO_CODE_HD]];
            }
            else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1000]){
                [validLiveVideoArray addObject:[NSNumber numberWithInteger:VIDEO_CODE_SD]];
            }
            else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_350]){
                [validLiveVideoArray addObject:[NSNumber numberWithInteger:VIDEO_CODE_LD]];
            }
        }
        codeArray = validLiveVideoArray;
    }
    return codeArray;
}

-(LTLiveChannelStreamsModel *)getDefaultLiveStreamModel
{
    LiveCodeType type = [SettingManager getDefaultLiveBitrateOfPlay];
    
    NSArray *stramModelArray = self.streamInfo;
    LTLiveChannelStreamsModel *defalutStreamModel = nil;
    LTLiveChannelStreamsModel *streamModelLD =nil;
    LTLiveChannelStreamsModel *streamModelSD =nil;
    LTLiveChannelStreamsModel *streamModelHD =nil;
    LTLiveChannelStreamsModel *streamModel720P =nil;
    LTLiveChannelStreamsModel *streamModel1080P =nil;
    for( LTLiveChannelStreamsModel *streamModel in stramModelArray)
    {
        if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1000]) {
            streamModelSD =streamModel;
            
        }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_350]) {
            streamModelLD =streamModel;
            
        }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1300]) {
            streamModelHD =streamModel;
            
        }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_720p]) {
            streamModel720P =streamModel;
            
        }else if ([streamModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1080p]){
            streamModel1080P =streamModel;
            
        }
        
    }
    if (![NSString isBlankString:streamModelLD.streamUrl] && type == VIDEO_CODE_SD) {
        defalutStreamModel = streamModelLD;
    }
    if (![NSString isBlankString:streamModelLD.streamUrl] && type == VIDEO_CODE_LD) {
        defalutStreamModel = streamModelLD;
    }
    if (![NSString isBlankString:streamModelHD.streamUrl] && type == VIDEO_CODE_HD) {
        defalutStreamModel = streamModelHD;
    }
    if (![NSString isBlankString:streamModel720P.streamUrl] && type == VIDEO_CODE_720P) {
        defalutStreamModel = streamModel720P;
    }
    if (![NSString isBlankString:streamModel1080P.streamUrl] && type == VIDEO_CODE_1080P) {
        defalutStreamModel = streamModel1080P;
    }
    if (defalutStreamModel == nil) {
        if (![NSString isBlankString:streamModelSD.streamUrl]) {
            return streamModelSD;
        }
        if (![NSString isBlankString:streamModelLD.streamUrl]) {
            return streamModelLD;
        }
        if (![NSString isBlankString:streamModelHD.streamUrl]) {
            return streamModelHD;
        }
        if (![NSString isBlankString:streamModel720P.streamUrl]) {
            return streamModel720P;
        }
        if (![NSString isBlankString:streamModel1080P.streamUrl]) {
            return streamModel1080P;
        }
    }
    return defalutStreamModel;
}

- (LTLiveChannelStreamsModel *)getUrlFromLiveType:(VideoCodeType)liveCodeType{
    NSArray *LiveUrlModelArray =self.streamInfo;
    LTLiveChannelStreamsModel *StreamUrlModel = nil;
    LTLiveChannelStreamsModel *StreamModelLD_Url =nil;
    LTLiveChannelStreamsModel *StreamModelSD_Url =nil;
    LTLiveChannelStreamsModel *StreamModelHD_Url =nil;
    LTLiveChannelStreamsModel *StreamModel720P_Url =nil;
    LTLiveChannelStreamsModel *streamModel1080P_Url = nil;
    for( LTLiveChannelStreamsModel *stream_UrlModel in LiveUrlModelArray)
    {
        if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1000]) {
            StreamModelSD_Url =stream_UrlModel;
            
        }else if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_350]) {
            StreamModelLD_Url =stream_UrlModel;
            
        }else if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1300]) {
            StreamModelHD_Url =stream_UrlModel;
            
        }else if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_720p]) {
            StreamModel720P_Url =stream_UrlModel;
            
        }else if ([stream_UrlModel.rateType isEqualToString:LT_LIVING_STREAN_flv_1080p]){
            streamModel1080P_Url =stream_UrlModel;
            
        }
        
    }
    switch (liveCodeType) {
        case VIDEO_CODE_LD:
            StreamUrlModel= StreamModelLD_Url;
            break;
        case VIDEO_CODE_SD:
            StreamUrlModel = StreamModelSD_Url;
            break;
        case VIDEO_CODE_HD:
            StreamUrlModel= StreamModelHD_Url;
            break;
        case VIDEO_CODE_720P:
            StreamUrlModel= StreamModel720P_Url;
            break;
        case VIDEO_CODE_1080P:
            StreamUrlModel = streamModel1080P_Url;
            break;
        default:
            break;
    }
    return StreamUrlModel;
    
}

@end

@implementation LTLiveCarouseModel
@end
@implementation LTLiveCarouseCategoryModel
@end

