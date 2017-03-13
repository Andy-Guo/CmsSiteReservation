//
//  LTCloudRecordModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-10.
//
//

#import "LTCloudRecordModel.h"
#import "LTPlayHistoryCommand.h"
#import "NSString+MovieInfo.h"
#import "HistoryCommand.h"

@implementation LTCloudRecordItemPicAll

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"120*90"  : @"img_120_90",
                                                       @"400*225" : @"img_400_225",
                                                       @"300*300" : @"img_300_300",
                                                       @"120*90" : @"img_120_90",
                                                       @"400*250" : @"img_400_250"
                                                       }];
}

@end

@implementation LTCloudRecordItemModel

+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

#ifdef LT_IPAD_CLIENT
+ (LTCloudRecordItemModel *)createFromLocalPlayHistory:(LTPlayHistoryCommand *)localPlayHistory
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
    LTCloudRecordItemModel *cloudRecordModel = [[LTCloudRecordItemModel alloc] init];
    //pad 5.5 qinxl 与振威沟通，各平台图标对应
    cloudRecordModel.from = localPlayHistory.deviceFrom;
    cloudRecordModel.cid = localPlayHistory.cid;
    cloudRecordModel.htime = [NSString stringWithFormat:@"%ld", (long)localPlayHistory.offset];
    cloudRecordModel.img = localPlayHistory.vicon;
    cloudRecordModel.pid = localPlayHistory.movie_id;
    cloudRecordModel.title = localPlayHistory.vnameCn;
    cloudRecordModel.utime = [NSString stringWithFormat:@"%d", (int)[localPlayHistory.updateTime timeIntervalSince1970]];
    cloudRecordModel.vid = localPlayHistory.vid;
    cloudRecordModel.vtime = [NSString stringWithFormat:@"%ld", (long)localPlayHistory.duration];
    cloudRecordModel.vtype = [NSString stringWithFormat:@"%d", localPlayHistory.type];
    cloudRecordModel.nc = [NSString stringWithFormat:@"%ld", (long)localPlayHistory.vepisode];
    cloudRecordModel.nvid = localPlayHistory.nvid;
    LTCloudRecordItemPicAll * picAll = [[LTCloudRecordItemPicAll alloc] init];
    picAll.img_400_225 = localPlayHistory.pic;
    cloudRecordModel.picAll = picAll;
    
    return cloudRecordModel;
}
#else


+ (LTCloudRecordItemModel *)createFromLocalPlayHistory:(LTPlayHistoryCommand *)localPlayHistory
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
    
    LTCloudRecordItemModel *cloudRecordModel = [[LTCloudRecordItemModel alloc] init];

    cloudRecordModel.cid = localPlayHistory.cid;
    
    //pad 5.5 qinxl 与振威沟通，各平台图标对应
    cloudRecordModel.from = localPlayHistory.deviceFrom;

    cloudRecordModel.htime = [NSString stringWithFormat:@"%ld", (long)localPlayHistory.offset];
    cloudRecordModel.img = localPlayHistory.icon;
//    cloudRecordModel.isend =
//    cloudRecordModel.nvid = ;
    cloudRecordModel.pid = localPlayHistory.movie_id;
    cloudRecordModel.title = localPlayHistory.vnameCn;
    cloudRecordModel.utime = [NSString stringWithFormat:@"%d", (int)[localPlayHistory.updateTime timeIntervalSince1970]];
    cloudRecordModel.vid = localPlayHistory.vid;
    cloudRecordModel.vtime = [NSString stringWithFormat:@"%ld", (long)localPlayHistory.duration];
    cloudRecordModel.vtype = [NSString stringWithFormat:@"%d", localPlayHistory.type];
    cloudRecordModel.nc = [NSString stringWithFormat:@"%ld", (long)localPlayHistory.vepisode];
    cloudRecordModel.nvid = localPlayHistory.nvid;
    
    return cloudRecordModel;
}
#endif

- (NSString *)getPlayHistoryShowInfo
{
    NSString *result = @"";
    NSInteger nOffset	= [self.htime integerValue];	// 已观看时长
    NSInteger nLen	= [self.vtime integerValue];	// 总时长
    NSInteger nHour	= nOffset / 3600;
    NSInteger nMin	= (nOffset % 3600) / 60;
    NSInteger nSecond = nOffset % 60;
    if (nOffset >= nLen) {
        result = NSLocalizedString(@"观看结束", @"观看结束");
    }else if (nHour > 0 && nMin > 0) {
        result = [NSString stringWithFormat:NSLocalizedString(@"观看至%ld小时%ld分钟", @"观看至%ld小时%ld分钟"), (long)nHour, (long)nMin];
    }else if (nHour > 0 && nMin == 0)
    {
        result = [NSString stringWithFormat:NSLocalizedString(@"观看至%ld小时", @"观看至%ld小时"), (long)nHour];
    }else if (nMin >= 1 && nSecond > 0)
    {
        result = [NSString stringWithFormat:NSLocalizedString(@"观看至%ld分钟%ld秒", @"观看至%ld分钟%ld秒"), (long)nMin,(long)nSecond];
    }else if (nMin >= 1 && nSecond <= 0)
    {
         result = [NSString stringWithFormat:NSLocalizedString(@"观看至%ld分钟", @"观看至%ld分钟"), (long)nMin];
    }
    else if (nSecond > 0 && nSecond < 60)
    {
        result = [NSString stringWithString:NSLocalizedString(@"观看不足1分钟", @"观看不足1分钟")];
    }else if (nSecond == -1 || nSecond <= 0)
    {
        result = NSLocalizedString(@"观看结束", @"观看结束");
    }else
        return NSLocalizedString(@"观看不足1分钟", @"观看不足1分钟");
    return result;
}
@end


@implementation LTCloudRecordModel

-(MovieInfo *)wrapResultSet:(LTCloudRecordItemModel *)itemModel forID:(NSInteger)theID{
    MovieInfo *movieInfo = [[MovieInfo alloc] init];
    
    movieInfo.ID=theID;
    
#ifdef LT_IPAD_CLIENT
    movieInfo.cid=[NSString safeString:itemModel.cid];
    movieInfo.v_ID=[NSString safeString:itemModel.vid];
    movieInfo.offset=[[NSString safeString:itemModel.htime]intValue];
    movieInfo.vType=0;
#else
    movieInfo.cid=[NSString safeString:itemModel.cid];
    movieInfo.v_ID=[NSString safeString:itemModel.vid];
    NSString *htime=[NSString safeString:itemModel.htime];
    movieInfo.curr_time=[NSString formateTimeLength:htime];
    movieInfo.videoType=0;
#endif
    
    movieInfo.time_length=[NSString safeString:itemModel.vtime];
    movieInfo.time_length = [NSString formateTimeLength:movieInfo.time_length];

    NSString *utime=[NSString safeString:itemModel.utime];
    NSTimeInterval time=[utime doubleValue];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    movieInfo.lastRecordTime= [formatter stringFromDate:date];
    //    movieInfo.vType=[[NSString safeString:[dict valueForKey:@"vtype"]]intValue];
    
    movieInfo.title=[NSString safeString:itemModel.title];
    movieInfo.movie_ID=[NSString safeString:itemModel.pid];
    movieInfo.deviceFromType= (DeviceFromType)[[NSString safeString:itemModel.from]intValue];
    movieInfo.data_type=DATA_TYPE_HISTORY;
    movieInfo.icon=[NSString safeString:itemModel.img];
    
    return movieInfo;
    
    
}

@end
