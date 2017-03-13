//
//  LTLivingPlayHistoryCommand.m
//  LetvIphoneClient
//
//  Created by letv_liuzb on 14-10-28.
//
//
#import <LeTVMobileFoundation/LeTVMobileFoundation.h>
#import "LTLivingPlayHistoryCommand.h"
#import "SqlDBHelper.h"

@implementation LTLivingPlayHistoryCommand



+ (LTLiveChannelListDetailModel *)wrappResultSet:(id<PLResultSet>)rs
{
    LTLiveChannelListDetailModel *liveChannelDetail = [[LTLiveChannelListDetailModel alloc] init];
    
    liveChannelDetail.channelId = [NSString safeString:[rs objectForColumn:@"channel_id"]];
    liveChannelDetail.numericKeys = [NSString safeString:[rs objectForColumn:@"numericKeys"]];
    liveChannelDetail.channelEname = [NSString safeString:[rs objectForColumn:@"channelEname"]];
    liveChannelDetail.channelName = [NSString safeString:[rs objectForColumn:@"channelName"]];
    liveChannelDetail.cibnChannelName = [NSString safeString:[rs objectForColumn:@"cibn_channel_name"]];
    liveChannelDetail.beginTime = [NSString safeString:[rs objectForColumn:@"begin_time"]];
    liveChannelDetail.endTime = [NSString safeString:[rs objectForColumn:@"end_time"]];
    liveChannelDetail.channelClass = [NSString safeString:[rs objectForColumn:@"channel_class"]];
    liveChannelDetail.belongBrand = [NSString safeString:[rs objectForColumn:@"belong_brand"]];
    liveChannelDetail.demandId = [NSString safeString:[rs objectForColumn:@"demand_id"]];
    liveChannelDetail.sourceId = [NSString safeString:[rs objectForColumn:@"source_id"]];
    liveChannelDetail.is3D = [NSString safeString:[rs objectForColumn:@"is_3d"]];
    liveChannelDetail.is4K = [NSString safeString:[rs objectForColumn:@"is_4k"]];
    liveChannelDetail.ch = [NSString safeString:[rs objectForColumn:@"ch"]];
    liveChannelDetail.orderNo = [NSString safeString:[rs objectForColumn:@"order_no"]];
    liveChannelDetail.isRecommend = [NSString safeString:[rs objectForColumn:@"is_recommend"]];
    liveChannelDetail.pcWatermarkUrl = [NSString safeString:[rs objectForColumn:@"pc_watermarkUrl"]];
    liveChannelDetail.watermarkUrl = [NSString safeString:[rs objectForColumn:@"watermark_url"]];
    liveChannelDetail.cibnWatermarkUrl = [NSString safeString:[rs objectForColumn:@"cibnWatermark_url"]];
    liveChannelDetail.postH3 = [NSString safeString:[rs objectForColumn:@"post_H3"]];
    liveChannelDetail.postOrigin = [NSString safeString:[rs objectForColumn:@"post_Origin"]];
    liveChannelDetail.postS1 = [NSString safeString:[rs objectForColumn:@"post_S1"]];
    liveChannelDetail.postS2 = [NSString safeString:[rs objectForColumn:@"post_S2"]];
    liveChannelDetail.postS3 = [NSString safeString:[rs objectForColumn:@"post_S3"]];
    liveChannelDetail.postS4 = [NSString safeString:[rs objectForColumn:@"post_S4"]];
    liveChannelDetail.postS5 = [NSString safeString:[rs objectForColumn:@"post_S5"]];
    liveChannelDetail.lastRecordTime= [rs isNullForColumn:@"add_Time"] ? @"" : [rs objectForColumn:@"add_Time"];
    return liveChannelDetail;
}


+ (void)checkHistoryListWith:(NSArray *)allChannelList type:(LTLiveHistoryFavType)liveType
{
    
    dispatch_queue_t queue = dispatch_queue_create([@"setter2" UTF8String], NULL);
    @try {
        NSArray *nativeArray = [LTLivingPlayHistoryCommand searchAll:liveType];
        dispatch_apply([nativeArray count], queue, ^(size_t index) {
            __block LTLiveChannelListDetailModel * nModel=(LTLiveChannelListDetailModel*)OBJECT_OF_ATINDEX(nativeArray, index);
            __block BOOL isExit = NO;
            [allChannelList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                LTLiveChannelListDetailModel *model = obj;
                if ([nModel.channelId isEqualToString:model.channelId]) {
                    *stop = YES;
                    isExit = YES;
                }
            }];
            if (!isExit) {
                [LTLivingPlayHistoryCommand deleteByChannelId:nModel.channelId type:liveType];
            }
        });
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        ;
    }
#ifdef LT_IPAD_CLIENT
//    dispatch_release(queue);
#else


    // Deployment Target 改为7.0，ARC托管了dispatch_queue
//    dispatch_release(queue);
#endif
}


//插入一条直播播放历史记录
+ (BOOL)insertWithObject:(LTLiveChannelListDetailModel*)LivingChannel type:(LTLiveHistoryFavType)liveType
{
    if (nil == LivingChannel) {
        return NO;
    }
    
    // （1）超出上限，做自动删除操作 -------------------------
    if ([LTLivingPlayHistoryCommand countAll:liveType] >= DB_LIVING_HISTORY_NUM) {
        
    }
    
    // （2）判断DB中是否已经存在 -------------------------
    BOOL bIsExist = NO;
    if ([LTLivingPlayHistoryCommand countByChannelId:LivingChannel.channelId type:liveType] > 0) {
        bIsExist = YES;
    }
    if (bIsExist) {
        return YES;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
    NSString *_add_time = [formatter stringFromDate:[NSDate date]];
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"INSERT INTO ltLivingPlayHistory(channel_id,numericKeys,channelEname,channelName,\
                    cibn_channel_name,begin_time,end_time,channel_class,belong_brand,demand_id,source_id,is_3d,is_4k,ch,order_no,is_recommend,pc_watermarkUrl,watermark_url,cibnWatermark_url,add_Time,post_H3,post_Origin,post_S1,post_S2,post_S3,post_S4,post_S5,fromType) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    [NSString safeString:LivingChannel.channelId],
                    [NSString safeString:LivingChannel.numericKeys],
                    [NSString safeString:LivingChannel.channelEname],
                    [NSString safeString:LivingChannel.channelName],
                    [NSString safeString:LivingChannel.cibnChannelName],
                    [NSString safeString:LivingChannel.beginTime],
                    [NSString safeString:LivingChannel.endTime],
                    [NSString safeString:LivingChannel.channelClass],
                    [NSString safeString:LivingChannel.belongBrand],
                    [NSString safeString:LivingChannel.demandId],
                    [NSString safeString:LivingChannel.sourceId],
                    [NSString safeString:LivingChannel.is3D],
                    [NSString safeString:LivingChannel.is4K],
                    [NSString safeString:LivingChannel.ch],
                    [NSString safeString:LivingChannel.orderNo],
                    [NSString safeString:LivingChannel.isRecommend],
                    [NSString safeString:LivingChannel.pcWatermarkUrl],
                    [NSString safeString:LivingChannel.watermarkUrl],
                    [NSString safeString:LivingChannel.cibnWatermarkUrl],
                    _add_time,
                    [NSString safeString:LivingChannel.postH3],
                    [NSString safeString:LivingChannel.postOrigin],
                    [NSString safeString:LivingChannel.postS1],
                    [NSString safeString:LivingChannel.postS2],
                    [NSString safeString:LivingChannel.postS3],
                    [NSString safeString:LivingChannel.postS4],
                    [NSString safeString:LivingChannel.postS5],
                    [NSString stringWithFormat:@"%ld",(long)liveType]
                    ];
    return bResult;
}
//搜索所有历史记录
+ (NSArray*)searchAll:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ltLivingPlayHistory where fromType = %@ Order By add_Time Desc limit %d",[NSString stringWithFormat:@"%ld",(long)liveType],DB_LIVING_HISTORY_NUM]];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[self wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}
//根据ID获取一条频道播放记录
+ (LTLiveChannelListDetailModel *)searchByID:(NSInteger)ID type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    rs  = [db executeQuery:@"SELECT * FROM ltLivingPlayHistory WHERE id = ? and fromType = ？", [NSString stringWithFormat:@"%ld", (long)ID],[NSString stringWithFormat:@"%ld",(long)liveType]];
    
    LTLiveChannelListDetailModel *ChannelInfo = nil;
    while ([rs next]) {
        ChannelInfo = [self wrappResultSet:rs];
    }
    [rs close];
    
    return ChannelInfo;
}
//根据ID删除一条频道播放记录
+ (BOOL)deleteByID:(NSInteger)ID type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM ltLivingPlayHistory WHERE id = %ld and fromType = %@",(long)ID,[NSString stringWithFormat:@"%ld",(long)liveType]]];
   	return bResult;
}
//根据channelId删除一条频道播放记录
+ (LTLiveChannelListDetailModel *)searchByChannelID:(NSString *)channelId type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    rs  = [db executeQuery:@"SELECT * FROM ltLivingPlayHistory WHERE channel_id = ? and fromType = ?", [NSString safeString:channelId],[NSString stringWithFormat:@"%ld",(long)liveType]];
    
    LTLiveChannelListDetailModel *ChannelInfo = nil;
    while ([rs next]) {
        ChannelInfo = [self wrappResultSet:rs];
    }
    [rs close];
    
    return ChannelInfo;
}

//根据channelId更新一条频道播放记录
+ (BOOL)upateWithChannelId:(NSString *)cid type:(LTLiveHistoryFavType)liveType
{
    BOOL bIsExist = NO;
    if ([LTLivingPlayHistoryCommand countByChannelId:cid type:liveType] > 0) {
        bIsExist = YES;
    }
    if (bIsExist) {
        PLSqliteDatabase *db = [SqlDBHelper setUp];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
        NSString *_add_time = [formatter stringFromDate:[NSDate date]];
        BOOL bResult = [db executeUpdate:@"update ltLivingPlayHistory set add_Time =? where channel_id = ? and fromType = ?",
                        [NSString safeString:_add_time],
                        [NSString safeString:cid],[NSString stringWithFormat:@"%ld",(long)liveType]];
        return bResult;
    }else
    {
        return NO;
    }
}

+ (BOOL)upateWithChannelModel:(LTLiveChannelListDetailModel *)liveDetailModel type:(LTLiveHistoryFavType)liveType
{
    if (nil == liveDetailModel) {
        return NO;
    }
    BOOL bIsExist = NO;
    if ([LTLivingPlayHistoryCommand countByChannelId:liveDetailModel.channelId type:liveType] > 0) {
        bIsExist = YES;
    }
    if (bIsExist) {
        PLSqliteDatabase *db = [SqlDBHelper setUp];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
        NSString *_add_time = [formatter stringFromDate:[NSDate date]];
        BOOL bResult = [db executeUpdate:@"update ltLivingPlayHistory set add_Time =? where channel_id = ? and fromType = ?",
                        [NSString safeString:_add_time],
                        [NSString safeString:liveDetailModel.channelId],[NSString stringWithFormat:@"%ld",(long)liveType]];
        return bResult;
    }else
    {
        BOOL bResult = [LTLivingPlayHistoryCommand insertWithObject:liveDetailModel type:liveType];
        return bResult;
    }
}

//根据channelID 获取相应播放记录数量
+ (int)countByChannelId:(NSString*)liveChannelId type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    id<PLResultSet> rs;
    rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM ltLivingPlayHistory WHERE channel_id = ? and fromType = ?",[NSString safeString:liveChannelId],[NSString stringWithFormat:@"%ld",(long)liveType]];
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    [rs close];
    return count;
}
+ (BOOL)deleteByChannelId:(NSString *)channelId type:(LTLiveHistoryFavType)liveType
{
    int count = [LTLivingPlayHistoryCommand countByChannelId:channelId type:liveType];
    if (count <= 0) {
        return YES;
    }
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM ltLivingPlayHistory WHERE channel_id = %@ and fromType = %@",[NSString safeString:channelId],[NSString stringWithFormat:@"%ld",(long)liveType]]];
   	return bResult;
}

+ (int) countAll:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    id<PLResultSet> rs;
    rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM ltLivingPlayHistory WHERE fromType = ?",[NSString stringWithFormat:@"%ld",(long)liveType]];
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    [rs close];
    return count;
}



@end
