//
//  LiveModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-5.
//
//

#import "LiveModel.h"
//#import "ExtensionNSDate.h"
#import "LiveOrderCommand.h"
#ifndef LT_IPAD_CLIENT

//#import "NSString+HTTPExtensions.h"
//#import "NSString+MD5.h"
//#import "NSObject+ObjectEmpty.h"

#endif


//#ifndef LT_IPAD_CLIENT

@implementation LiveServerTime

- (void)setDateWithNSString:(NSString*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (![NSString isBlankString:date]) {
        _date = [dateFormatter dateFromString:date];
    }
    else{
        _date = nil;
    }
}

@end

@implementation LiveFocusItem

@end

@implementation LiveFocusModel

@end

@implementation LiveBookInfo

@end

@implementation LiveChannelModel

- (LiveCodeType)getLiveTypeFromCode:(PhoneStreamLiveUrlModel *)liveStream{
    LiveCodeType type = LIVE_CODE_UNKNOW;
    if (liveStream){
        if ([liveStream.code isEqualToString:self.live_url_350.code]){
            type = LIVE_CODE_LD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_1000.code]){
            type = LIVE_CODE_SD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_1300.code]){
            type = LIVE_CODE_HD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_720p.code]){
            type = LIVE_CODE_720P;
        }
    }
    return type;
}
- (LiveCodeType)getDefaultLiveType:(PhoneStreamLiveUrlModel *)liveUrlModel{
    return LIVE_CODE_SD;
}

- (PhoneStreamLiveUrlModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType{
    PhoneStreamLiveUrlModel *LiveUrlModel =self.live_url_1000;
    switch (liveCodeType) {
        case LIVE_CODE_LD:
            LiveUrlModel= self.live_url_350;
            break;
        case LIVE_CODE_SD:
            LiveUrlModel = self.live_url_1000;
            break;
        case LIVE_CODE_HD:
            LiveUrlModel= self.live_url_1300;
            break;
        case LIVE_CODE_720P:
            LiveUrlModel= self.live_url_720p;
            break;
        default:
            break;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_1000;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_350;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_1300;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_720p;
    }
    return LiveUrlModel;

}

- (BOOL)isValidCodeType:(LiveCodeType)liveCodeType{
    switch (liveCodeType) {
        case LIVE_CODE_LD:
            return ![NSString isBlankString:self.live_url_350.code];
            break;
        case LIVE_CODE_SD:
            return ![NSString isBlankString:self.live_url_1000.code];
            break;
        case LIVE_CODE_HD:
            return ![NSString isBlankString:self.live_url_1300.code];
            break;
        case LIVE_CODE_720P:
            return ![NSString isBlankString:self.live_url_720p.code];
            break;
        default:
            break;
    }
    return NO;
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

//add by qinxl 对码流进行容错
- (void)correctLiveStream{
    if ([NSString isBlankString:self.phoneStreamLiveUrls.streamId]) {
        PhoneStreamLiveUrlModel *LiveUrlModel =self.live_url_1000;
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel  = self.live_url_350;
        }
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel = self.live_url_1300;
        }
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel = self.live_url_720p;
        }
        
        self.phoneStreamLiveUrls = LiveUrlModel;
    }

}

@end
@implementation PhoneStreamLiveUrlModel

@end

@implementation PlayBillModel

@end

@implementation LiveChannelListModel


@end
@implementation GetLiveUrlModel


@end

@implementation DateList

@end
@implementation LivehallProgramInfoModel
- (void)setCurrent_dateWithNSString:(NSString*)current_date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
    if (![NSString isBlankString:current_date]) {
//        NSDate *dt =[dateFormatter1 dateFromString:current_date];
        _current_date = [dateFormatter dateFromString:current_date];
    }
    else{
        _current_date = nil;
    }
}


@end

@implementation LivehallLiveListModel

-(BOOL)isPlay{
    return  [self.isplay integerValue]==1;
}
-(BOOL)isBooked{
    return  [self.isbooked integerValue]==1;
}
- (LiveCodeType)getDefaultLiveType{
    LiveCodeType type = [self getLiveTypeFromCode:self.phoneStreamLiveUrls];
    
    if (type == LIVE_CODE_UNKNOW){
        if (self.live_url_1000.code) {
            type = LIVE_CODE_SD;
        }
        else if (self.live_url_350.code){
            type = LIVE_CODE_LD;
        }
        else if (self.live_url_1300.code){
            type = LIVE_CODE_HD;
        }
        else if (self.live_url_720p.code){
            type = LIVE_CODE_720P;
        }
        else{
            type = LIVE_CODE_SD;
        }
    }
    return type;
}
- (LiveCodeType)getLiveTypeFromCode:(PhoneStreamLiveUrlModel *)liveStream{
    LiveCodeType type = LIVE_CODE_UNKNOW;
    if (liveStream){
        if ([liveStream.code isEqualToString:self.live_url_350.code]){
            type = LIVE_CODE_LD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_1000.code]){
            type = LIVE_CODE_SD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_1300.code]){
            type = LIVE_CODE_HD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_720p.code]){
            type = LIVE_CODE_720P;
        }
    }
    return type;
}
- (PhoneStreamLiveUrlModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType{
    PhoneStreamLiveUrlModel *LiveUrlModel =self.live_url_1000;
    switch (liveCodeType) {
        case LIVE_CODE_LD:
           LiveUrlModel= self.live_url_350;
            break;
        case LIVE_CODE_SD:
            LiveUrlModel = self.live_url_1000;
            break;
        case LIVE_CODE_HD:
            LiveUrlModel= self.live_url_1300;
            break;
        case LIVE_CODE_720P:
            LiveUrlModel= self.live_url_720p;
            break;
        default:
            break;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_1000;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
         LiveUrlModel =self.live_url_350;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_1300;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_720p;
    }
    return LiveUrlModel;
}

- (BOOL)isValidCodeType:(LiveCodeType)liveCodeType{
    switch (liveCodeType) {
        case LIVE_CODE_LD:
           return ![NSString isBlankString:self.live_url_350.code];
            break;
        case LIVE_CODE_SD:
            return ![NSString isBlankString:self.live_url_1000.code];
            break;
        case LIVE_CODE_HD:
             return ![NSString isBlankString:self.live_url_1300.code];
            break;
        case LIVE_CODE_720P:
            return ![NSString isBlankString:self.live_url_720p.code];
            break;
        default:
            break;
    }
    return NO;
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

//add by qinxl 对码流进行容错
- (void)correctLiveStream{
    if ([NSString isBlankString:self.phoneStreamLiveUrls.streamId]) {
        PhoneStreamLiveUrlModel *LiveUrlModel =self.live_url_1000;
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel  = self.live_url_350;
        }
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel = self.live_url_1300;
        }
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel = self.live_url_720p;
        }
        
        self.phoneStreamLiveUrls = LiveUrlModel;
    }
    
}
@end

@implementation LiveHallModel
- (NSInteger)getCurrentPlayingIndex:(NSString *)name
{
    for (NSInteger i = 0; i < self.data.count; i++) {
        LivehallLiveListModel *item = self.data[i];
        if ([item.name isEqualToString:name]) {
            return i;
        }
    }
    return -1;
}

- (NSInteger)getCurrentPlayingIndexByID:(NSString *)idStr{
    if ([NSString isBlankString:idStr]) {
        return -1;
    }
    
    for (NSInteger i = 0; i < self.data.count; i++) {
        LivehallLiveListModel *item = self.data[i];
        if ([item.id isEqualToString:idStr]) {
            return i;
        }
    }
    return -1;
}

- (NSString *)getPlayingDateString:(NSInteger)index{
    
    NSString *dateString = [self getDateString:index];
    if ([NSString isBlankString:dateString]){
        return nil;
    }
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSDate *playDate = [dateFormatter2 dateFromString:dateString];
    if ([playDate isYesterday]){
        return NSLocalizedString(@"昨天", nil);
    }
    else if ([playDate isToday]){
        return NSLocalizedString(@"今天", nil);
    }
    else if ([playDate isTomorrow]){
        return NSLocalizedString(@"明天", nil);
    }
    return nil;
}
- (NSString *)getDateString:(NSInteger)index{
    if (self.data.count<=index){
        return nil;
    }
    LivehallLiveListModel *liveItem = self.data[index];
    if ([liveItem.ct isEqualToString:@"sports"]) {
        return nil;
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (self.programInfo.date.length > 8) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    else{
        [dateFormatter setDateFormat:@"yyyy-MM"];
    }
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MM-dd"];
    
    NSString *year = [dateFormatter stringFromDate:[dateFormatter dateFromString:self.programInfo.date]];
    year = [year substringWithRange:NSMakeRange(0, 4)];
    NSString *time = [NSString stringWithFormat:@"%@-%@",year,liveItem.play_date];
    return time;
}
- (BillStatus)getBillStatusOfLiveItemAtIndex:(NSInteger)idxOfItem
                              forChannelCode:(NSString *)channelCode
{
    if (self.data.count<=idxOfItem) {
        return ORDER_STATUS;
    }
    LivehallLiveListModel *liveItem = self.data[idxOfItem];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *nowTimeStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *nowDate = [dateFormatter dateFromString:nowTimeStr];
    
    
    if ([channelCode isEqualToString:@"sports"]){
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        NSString *billTimeStr = [NSString stringWithFormat:@"%@ %@", self.programInfo.date, liveItem.play_time];
        NSDate *billTime = [dateFormatter dateFromString:billTimeStr];
        
        
        if (liveItem.isPlay){
            return BILL_PLAY_STATUS;
        }
        else if ([[billTime earlierDate:nowDate] isEqualToDate:billTime]){
            if (![NSString isBlankString:liveItem.recordingId ]){
                return BILL_REPLAY_STATUS;   //回看
            }
            else{
                return BILL_UPLOADING;      //上传中
            }
        }
        else{
            LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:self.programInfo.date
                                                                      billTime:liveItem.play_time
                                                                   channelCode:channelCode
                                                                     orderName:liveItem.name];
            if (nil != liveCommand){
                return CANCELORDER_STATUS;
            }
            else{
                return  ORDER_STATUS;
            }
        }

    }
    else{
        
        NSArray *dataArray = [self.programInfo.date componentsSeparatedByString:@"-"];
        
        NSString *billTimeStr = @"";
        NSString *monthDay = @"";
        
        if ([dataArray count] < 3) {
            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
            [dateFormatter1 setDateFormat:@"yyyy-MM"];
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"MM-dd"];
            
            NSDate *d = [dateFormatter2 dateFromString:liveItem.play_date];
            monthDay = [dateFormatter2 stringFromDate:d];
            monthDay = [monthDay substringWithRange:NSMakeRange(3, 2)]; // 只取日的部分
            
            billTimeStr = [NSString stringWithFormat:@"%@-%@ %@",self.programInfo.date,monthDay,liveItem.play_time];
        }
        else {
            billTimeStr = [NSString stringWithFormat:@"%@ %@",self.programInfo.date,liveItem.play_time];
        }
        
        NSDate *billTime = [dateFormatter dateFromString:billTimeStr];
        if (liveItem.isPlay){
            return BILL_PLAY_STATUS;
        }
        else if ([[billTime earlierDate:nowDate] isEqualToDate:billTime]){
            if (![NSString isBlankString:liveItem.recordingId]){
                return BILL_REPLAY_STATUS;
            }
            else{
                return BILL_UPLOADING;
            }
        }
        else{
            NSString *storeTime = @"";
            
            if ([dataArray count] < 3) {
                storeTime = [NSString stringWithFormat:@"%@-%@",self.programInfo.date,monthDay];
            }
            else {
                storeTime = [NSString stringWithFormat:@"%@",self.programInfo.date];
            }
            
            LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:storeTime billTime:liveItem.play_time channelCode:channelCode orderName:liveItem.name];
            if (nil != liveCommand){
                return CANCELORDER_STATUS;
            }
            else{
                return ORDER_STATUS;
            }
        }
    }
    
    return ORDER_STATUS;
}

- (BillStatus)getBillStatusOfLiveForHomeItemAtIndex:(NSInteger)idxOfItem
                              forChannelCode:(NSString *)channelCode {
    if (self.data.count <= idxOfItem) {
        return ORDER_STATUS;
    }
    
    BillStatus billStatus = ORDER_STATUS;
    
    LivehallLiveListModel *liveItem = self.data[idxOfItem];
    
    NSInteger status = [[NSString safeString:liveItem.status] integerValue];
    
    if (status == 0) {
        
// xcf: 和大宝确认，ipad的预约逻辑可能不需要保留，需要和刘博最终确认再改
// xcf: 150210，已和大宝确认，这部分代码已经不用了，新的状态已经确认了 和iPhone一样的，已经统一了
        
#ifndef LT_MERGE_FROM_IPAD_CLIENT
        if ([liveItem.pay integerValue] == 1) {
            billStatus = BILL_BUY_STATUS;
        } else {
            NSString *orderDate = nil;
            
            if (![liveItem.ct isEqualToString:@"sports"] ){
                orderDate = [self getDateString:idxOfItem];
            }
            else{
                orderDate = self.programInfo.date;
            }
            
            if (![NSString empty:self.from] && [self.from isEqualToString:kLiveHallModelFromHome]) {
                orderDate = liveItem.play_date;
            }
            
            NSString *playDate = [NSString safeString:orderDate];
            NSString *playTime = [NSString safeString:liveItem.play_time];
            
            LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:playDate
                                                                      billTime:playTime
                                                                   channelCode:channelCode
                                                                     orderName:liveItem.name];
            if (nil != liveCommand){
                billStatus = CANCELORDER_STATUS;
            }
            else{
                billStatus = ORDER_STATUS;
            }
        }
#else
        if ([liveItem isBooked]) {
            billStatus = CANCELORDER_STATUS;
        }
        else {
            billStatus = ORDER_STATUS;
        }
#endif
    }
    else if (status == 1) {
        billStatus = BILL_PLAY_STATUS;
    }
    else if (status == 2) {
        if (![NSString isBlankString:liveItem.recordingId]){
            billStatus = BILL_REPLAY_STATUS;   // 回看
        }
        else{
            billStatus = BILL_UPLOADING;       // 上传中
        }
    }
    
    return billStatus;
}


@end

@implementation LiveProgramListModel
-(BOOL)isPlay{
    return  [self.isplay integerValue]==1;
}
-(BOOL)isBooked{
    return  [self.isbooked integerValue]==1;
}

@end
@implementation BookInfoModel

@end
@implementation LiveChannel
- (NSInteger)getCurrentPlayingIndex
{
    for (NSInteger i = 0; i < self.programList.count; i++) {
        LiveProgramListModel *item = self.programList[i];
        if (item.isPlay) {
            return i;
        }
    }
    return -1;
}

- (BillStatus)getBillStatusOfLiveItemAtIndex:(NSInteger)idxOfItem
                              forChannelCode:(NSString *)channelCode
{
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    LiveProgramListModel *liveModel = self.programList[idxOfItem];
    
    if (liveModel.isPlay){
        return BILL_PLAY_STATUS;        //直播中
    }
    else{
        LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:self.programInfo.date
                                                                  billTime:liveModel.playtime
                                                               channelCode:channelCode
                                                                 orderName:liveModel.title];
        if (nil != liveCommand){
            return CANCELORDER_STATUS;
        }
        else {
            return ORDER_STATUS;
        }
    }
    
//    if (liveModel.isBooked){
//        return CANCELORDER_STATUS;   //已预约
//    }
//    if (!liveModel.isBooked){
//        return ORDER_STATUS;        // 可预约
//    }
//    
    return ORDER_STATUS;

}

- (LiveCodeType)getDefaultLiveType{
    
    return LIVE_CODE_SD;
}
- (LiveCodeType)getLiveTypeFromCode:(PhoneStreamLiveUrlModel *)liveStream{
    LiveCodeType type = LIVE_CODE_UNKNOW;
    if (liveStream){
        if ([liveStream.code isEqualToString:self.live_url_350.code]){
            type = LIVE_CODE_LD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_1000.code]){
            type = LIVE_CODE_SD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_1300.code]){
            type = LIVE_CODE_HD;
        }
        else if ([liveStream.code isEqualToString:self.live_url_720p.code]){
            type = LIVE_CODE_720P;
        }
        
    }
    return type;
}
- (PhoneStreamLiveUrlModel *)getUrlFromLiveType:(LiveCodeType)liveCodeType{
    PhoneStreamLiveUrlModel *LiveUrlModel =self.live_url_1000;
    switch (liveCodeType) {
        case LIVE_CODE_LD:
            LiveUrlModel= self.live_url_350;
            break;
        case LIVE_CODE_SD:
            LiveUrlModel = self.live_url_1000;
            break;
        case LIVE_CODE_HD:
            LiveUrlModel= self.live_url_1300;
            break;
        case LIVE_CODE_720P:
            LiveUrlModel= self.live_url_720p;
            break;
        default:
            break;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_1000;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_350;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_1300;
    }
    if ([NSString isBlankString:LiveUrlModel.liveUrl]) {
        LiveUrlModel =self.live_url_720p;
    }
    return LiveUrlModel;
}

- (BOOL)isValidCodeType:(LiveCodeType)liveCodeType{
    switch (liveCodeType) {
        case LIVE_CODE_LD:
            return ![NSString isBlankString:self.live_url_350.code];
            break;
        case LIVE_CODE_SD:
            return ![NSString isBlankString:self.live_url_1000.code];
            break;
        case LIVE_CODE_HD:
            return ![NSString isBlankString:self.live_url_1300.code];
            break;
        case LIVE_CODE_720P:
            return ![NSString isBlankString:self.live_url_720p.code];
            break;
        default:
            break;
    }
    return NO;
}
//add by qinxl 对码流进行容错
- (void)correctLiveStream{
    if ([NSString isBlankString:self.phoneStreamLiveUrls.streamId]) {
        PhoneStreamLiveUrlModel *LiveUrlModel =self.live_url_1000;
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel  = self.live_url_350;
        }
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel = self.live_url_1300;
        }
        if ([NSString isBlankString:LiveUrlModel.streamId]) {
            LiveUrlModel = self.live_url_720p;
        }
        
        self.phoneStreamLiveUrls = LiveUrlModel;
    }
    
}

@end
@implementation LiveTm

@end

#ifdef LT_LIVING_PAY

@implementation LiveAuthority
+(BOOL)propertyIsOptional:(NSString*)propertyName{
    return YES;
}

/**
 *  是否为单点付费类型
 *
 *  @return
 */
- (BOOL)isSinglePointPayType{
    if ([self.payType isEqualToString:@"5"]) {
        return YES;
    }
    return NO;
}
/**
 *  直播试看是否可以试看倒计时
 *
 *  @return
 */
- (BOOL)islivePreCanCountDown{
    NSString *preEndStr = [self.preend stringValue];
    NSString *curTimeStr = [self.curTime stringValue];
    //使用preEnd 获取结束时间 计算试看结束的提醒
    NSInteger preEnd = [preEndStr integerValue];
    NSInteger curTime = [curTimeStr integerValue];
    NSInteger countdown = preEnd - curTime;
    if (countdown>=0) {
        return YES;
    }
    return NO;
}
/**
 *  直播试看倒计时时间
 *
 *  @return
 */
- (NSInteger)livePreCountDownTime{
    NSString *preEndStr = [self.preend stringValue];
    NSString *curTimeStr = [self.curTime stringValue];
    //使用preEnd 获取结束时间 计算试看结束的提醒
    NSInteger preEnd = [preEndStr integerValue];
    NSInteger curTime = [curTimeStr integerValue];
    NSInteger countdown = preEnd - curTime;
    return countdown;
}

@end
@implementation LiveAuthorityInfo

@end
@implementation LiveAuthorityError

@end

@implementation LiveLunboAuthority

@end

@implementation LiveLunboAuthorityStatus

@end

@implementation LivePackages

@end
@implementation LivePrice

@end
@implementation LiveQueryPackages

@end
@implementation TicketInfo

@end
@implementation LiveUseTicket

@end

#endif


//#else
//
//
//@implementation LiveServerTime
//
//- (void)setDateWithNSString:(NSString*)date
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    if (![NSString isBlankString:date]) {
//        _date = [dateFormatter dateFromString:date];
//    }
//    else{
//        _date = nil;
//    }
//}
//
//@end
//
//@implementation LiveFocusItem
//
//@end
//
//@implementation LiveFocusModel
//
//@end
//
//@implementation LiveEpginfo
//
//- (void)setDateWithNSString:(NSString*)date
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    if (![NSString isBlankString:date]) {
//        _date = [dateFormatter dateFromString:date];
//    }
//    else{
//        _date = nil;
//    }
//}
//
//@end
//
//@implementation LiveItem
//
//- (void)setIsplayWithNSString:(NSString*)isplay
//{
//    _isplay = ([isplay integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (void)setIsbookedWithNSString:(NSString*)isbooked
//{
//    _isbooked = ([isbooked integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (NSString *)getLiveItemTitle
//{
//    return [NSString stringWithFormat:@"%@ %@", self.play_time, self.name];
//}
//
//@end
//
//@implementation LiveBookInfo
//
//@end
//
//@implementation LiveBillModel
//
//+(JSONKeyMapper*)keyMapper
//{
//    return [[JSONKeyMapper alloc] initWithDictionary:@{
//                                                       @"data" : @"liveItemList"
//                                                       }];
//}
//
//- (NSInteger)getCurrentPlayingIndex
//{
//    for (NSInteger i = 0; i < self.liveItemList.count; i++) {
//        LiveItem *item = self.liveItemList[i];
//        if (item.isplay) {
//            return i;
//        }
//    }
//    return -1;
//}
//
//#ifndef LT_IPAD_CLIENT
//- (BillStatus)getBillStatusOfLiveItemAtIndex:(NSInteger)idxOfItem
//                              forChannelCode:(NSString *)channelCode
//{
//    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
//    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
//    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm"];
//    
//    NSInteger playingIndex = [self getCurrentPlayingIndex];
//    
//    LiveItem *liveItem = self.liveItemList[idxOfItem];
//    if (liveItem.isplay){
//        return BILL_PLAY_STATUS;
//    }
//    
//    LiveItem *playingItem = nil;
//    if (playingIndex >= 0) {
//        playingItem = self.liveItemList[playingIndex];
//    }
//    
//    if (nil != playingItem) {
//        NSString *billTimeStr = [NSString stringWithFormat:@"%@ %@", [dateFormatter1 stringFromDate:self.epginfo.date], liveItem.play_time];
//        NSDate *billTime = [dateFormatter2 dateFromString:billTimeStr];
//        
//        NSString *playbillTimeStr = [NSString stringWithFormat:@"%@ %@", [dateFormatter1 stringFromDate:self.epginfo.date], playingItem.play_time];
//        NSDate *playbillTime = [dateFormatter2 dateFromString:playbillTimeStr];
//        
//        if ([[billTime earlierDate:playbillTime] isEqualToDate:billTime]) {
//            return ORDER_DISABLE;
//        }
//    }
//    
//    LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:[dateFormatter1 stringFromDate:self.epginfo.date]
//                                                              billTime:liveItem.play_time
//                                                           channelCode:channelCode];
//    if (nil != liveCommand) {
//        return CANCELORDER_STATUS;
//    }
//    return ORDER_STATUS;
//}
//#endif
//
//@end
//
//@implementation LiveChannelModel
//
//- (NSString *)getPlayUrl
//{
//    NSString *originalUrl = self.url;
//    NSString *streamId = self.stream_id;
//    if ([NSString isBlankString:originalUrl]) {
//        originalUrl = self.url_350;
//        streamId = self.stream_id_350;
//    }
//    
//    if ([NSString isBlankString:originalUrl]) {
//        return @"";
//    }
//    
//    originalUrl = [originalUrl stringByAppendingString:@"&format=1"];
//    originalUrl = [originalUrl stringByAppendingString:@"&expect=3"];
//    
//    NSString *keyValue = @"";
//    if (    ![NSString isBlankString:self.tm]
//        &&  ![NSString isBlankString:streamId]) {
//        keyValue = [NSString md5:[NSString stringWithFormat:@"%@,%@,%@",
//                                  streamId,
//                                  self.tm,
//                                  LT_SECRETKEY_LIVEPLAYURL]
//                    ];
//    }
//    
//    if ([NSString isBlankString:keyValue]) {
//        return originalUrl;
//    }
//    
//    return [originalUrl stringByAppendingFormat:@"&key=%@", keyValue];
//}
//
//@end
//
//@implementation LiveChannelListModel
//
//- (NSInteger)indexOfLiveChannelCode:(NSString *)code
//{
//    for (int i = 0; i < self.data.count; i++) {
//        LiveChannelModel *channelModel = self.data[i];
//        if ([channelModel.code isEqualToString:code]) {
//            return i;
//        }
//    }
//    
//    return -1;
//}
//
//@end
//
//@implementation LiveChannelProgram
//
//- (void)setDateWithNSString:(NSString*)date
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    if (![NSString isBlankString:date]) {
//        _date = [dateFormatter dateFromString:date];
//    }
//    else{
//        _date = nil;
//    }
//}
//
//@end
//
//@implementation LiveChannelInfo
//
//@end
//
//@implementation LiveCurrentEpgItem
//
//- (NSString*) getItemTitle
//{
//    return [NSString stringWithFormat:@"%@:%@", self.channelName, self.programName];
//}
//
//@end
//
//@implementation LiveCurrentEpgList
//
//@end
//
//@implementation LiveModel
//
//+ (NSString *)formatDateTitle:(NSDate *)date afterDays:(NSInteger)numberOfDays
//{
//    NSDate *dateCurr = date;
//    if (nil == dateCurr) {
//        dateCurr = [NSDate date];
//    }
//    NSDate *dateAfterDays = [dateCurr dateWithDaysFromNow:numberOfDays];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setDateFormat:NSLocalizedString(@"MM月dd日", @"MM月dd日")];
//    
//	NSString *st = [formatter stringFromDate:dateAfterDays];
//    NSString *m_weekday=nil;
//    switch (dateAfterDays.weekday) {
//        case 1:
//            m_weekday=NSLocalizedString(@"周日", nil);
//            break;
//        case 2:
//            m_weekday=NSLocalizedString(@"周一", nil);
//            break;
//        case 3:
//            m_weekday=NSLocalizedString(@"周二", nil);
//            break;
//        case 4:
//            m_weekday=NSLocalizedString(@"周三", nil);
//            break;
//        case 5:
//            m_weekday=NSLocalizedString(@"周四", nil);
//            break;
//        case 6:
//            m_weekday=NSLocalizedString(@"周五", nil);
//            break;
//        case 7:
//            m_weekday=NSLocalizedString(@"周六", nil);
//            break;
//        default:
//            break;
//    }
//    return [NSString stringWithFormat:@"%@(%@)",st,m_weekday];
//}
//
//@end


//#endif

@implementation LiveAuthenticationDetailModel
@end

@implementation LiveAuthenticationModel
- (BOOL)isHaveBuy:(NSString *)liveid
{
    for (LiveAuthenticationDetailModel *detailModel in self.result) {
        if ([detailModel.liveid isEqualToString:liveid]) {
            if ([detailModel.status integerValue] == 1) {
                return YES;
            }
            else {
                return NO;
            }
        }
    }
    return NO;
}
@end

