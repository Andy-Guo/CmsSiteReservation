//
//  LivingHistoryCommand.m
//  LetvIphoneClient
//
//  Created by letv_liuzb on 14-10-28.
//
//

#import "LivingHistoryCommand.h"
//#import "NSString+HTTPExtensions.h"
#import "SqlDBHelper.h"

@implementation LivingHistoryCommand

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
    liveChannelDetail.isFovo = [rs isNullForColumn:@"favo_state"] ? @"0" : [NSString safeString:[rs objectForColumn:@"favo_state"]];
    liveChannelDetail.lastRecordTime= [rs isNullForColumn:@"add_Time"] ? @"" : [rs objectForColumn:@"add_Time"];
    return liveChannelDetail;
}


+ (void)checkFavoListWith:(NSArray *)allChannelList type:(LTLiveHistoryFavType)liveType
{
    dispatch_queue_t queue = dispatch_queue_create([@"setter1" UTF8String], NULL);
    @try {
        NSArray *nativeArray = [LivingHistoryCommand searchAll:liveType];
        if (allChannelList && allChannelList.count > 0) {
            dispatch_apply([allChannelList count], queue, ^(size_t index) {
                LTLiveChannelListDetailModel * model=(LTLiveChannelListDetailModel*)OBJECT_OF_ATINDEX(allChannelList, index);
                [LivingHistoryCommand upateWithChannelModel:model type:liveType];;
            });
        }else{
            return;
        }
        /* 不再移除不存在的记录
        nativeArray = [LivingHistoryCommand searchAll:liveType];
        
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
                [LivingHistoryCommand deleteByChannelID:nModel.channelId type:liveType];
            }
        });
         */
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

//插入一条频道
+ (BOOL)insertWithObject:(LTLiveChannelListDetailModel*)LivingChannel type:(LTLiveHistoryFavType)liveType
{
    if (nil == LivingChannel) {
        return NO;
    }
    /*
     // （1）超出上限，做自动删除操作 -------------------------
     if ([HistoryCommand countByDataType:dataType] >= DB_HISTORY_NUM) {
     [HistoryCommand deleteAutoByDataType:dataType];
     }
     */
    // （2）判断DB中是否已经存在 -------------------------
    BOOL bIsExist = NO;
    if ([LivingHistoryCommand countByChannelId:LivingChannel.channelId type:liveType] > 0) {
        bIsExist = YES;
    }
    if (bIsExist) {
        return YES;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
    NSString *_add_time = [formatter stringFromDate:[NSDate date]];
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"INSERT INTO livingHistory(channel_id,numericKeys,channelEname,channelName,\
                    cibn_channel_name,begin_time,end_time,channel_class,belong_brand,demand_id,source_id,is_3d,is_4k,ch,order_no,is_recommend,pc_watermarkUrl,watermark_url,cibnWatermark_url,add_Time,post_H3,post_Origin,post_S1,post_S2,post_S3,post_S4,post_S5,favo_state,fromType) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
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
                    @"0",
                    [NSString stringWithFormat:@"%d",liveType]
                    ];
    return bResult;
}
//搜索所有的频道
+ (NSArray*)searchAll:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:@"SELECT * FROM livingHistory WHERE fromType = ? Order By order_no Desc ",[NSString stringWithFormat:@"%d",liveType]];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[self wrappResultSet:rs]];
    }
    [rs close];
    [dbArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        LTLiveChannelListDetailModel *order1 = obj1;
        LTLiveChannelListDetailModel *order2 = obj2;
        NSInteger value1 = [[NSString safeString:order1.numericKeys] integerValue];
        if ([NSString isBlankString:order1.numericKeys]) {//numericKeys 为空的情况放到最后
            value1 = dbArray.count + 100;
        }
        NSInteger value2 = [[NSString safeString:order2.numericKeys] integerValue];
        if ([NSString isBlankString:order2.numericKeys]) {//numericKeys 为空的情况放到最后
            value2 = dbArray.count + 100;
        }
        if (value1 > value2) {
            return NSOrderedDescending;
        }else if (value1 < value2) {
            return NSOrderedAscending;
        }else{
            return NSOrderedSame;
        }
    }];
    return dbArray;
}
//通过频道id 获取频道信息
+ (LTLiveChannelListDetailModel *)searchByID:(NSInteger)ID type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    rs  = [db executeQuery:@"SELECT * FROM livingHistory WHERE id = ? and fromType = ?", [NSString stringWithFormat:@"%ld", (long)ID],[NSString stringWithFormat:@"%d",liveType]];
    
    LTLiveChannelListDetailModel *ChannelInfo = nil;
    while ([rs next]) {
        ChannelInfo = [self wrappResultSet:rs];
    }
    [rs close];
    
    return ChannelInfo;
}
//通过ID 删除频道信息
+ (BOOL)deleteByID:(NSInteger)ID type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM livingHistory WHERE id = %ld and fromType = %@",(long)ID,[NSString stringWithFormat:@"%d",liveType]]];
   	return bResult;
}
//通过channelId 获取频道信息
+ (LTLiveChannelListDetailModel *)searchByChannelId:(NSString *)channelId type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:@"SELECT * FROM livingHistory where channel_id = ? and fromType = ?",[NSString safeString:channelId],[NSString stringWithFormat:@"%d",liveType]];
    
    LTLiveChannelListDetailModel *ChannelInfo = nil;
    while ([rs next]) {
        ChannelInfo = [self wrappResultSet:rs];
    }
    [rs close];
    
    return ChannelInfo;
}

//通过频道id 获取频道收藏状态
+ (BOOL)upateWithChannelId:(NSString *)cid isFovo:(BOOL)isFovo type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_add_time = [formatter stringFromDate:[NSDate date]];
    BOOL bResult = [db executeUpdate:@"update livingHistory set favo_state =?, add_Time =? where channel_id = ? and fromType = ?",
                    [NSString stringWithFormat:@"%d",isFovo],
                    [NSString safeString:_add_time],
                    [NSString safeString:cid],
                    [NSString stringWithFormat:@"%d",liveType]];
    return bResult;
}



//通过频道id 获取频道数量
+ (int)countByChannelId:(NSString*)liveChannelId type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    id<PLResultSet> rs;
    rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM livingHistory WHERE channel_id = ? and fromType = ?",[NSString safeString:liveChannelId],[NSString stringWithFormat:@"%d",liveType]];
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    [rs close];
    return count;
}
//通过频道收藏状态 获取频道数量
+ (int)countByFovoState:(BOOL)isFovo type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    id<PLResultSet> rs;
    rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM livingHistory WHERE favo_state = ? and fromType = ?",[NSString stringWithFormat:@"%d",isFovo],[NSString stringWithFormat:@"%d",liveType]];
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    [rs close];
    return count;
}

//搜索所有的频道
+ (NSArray*)searchAllWithFovo:(BOOL)isFovo type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:@"SELECT * FROM livingHistory where favo_state =? and fromType = ? Order By add_Time Desc ",[NSString stringWithFormat:@"%d",isFovo],[NSString stringWithFormat:@"%d",liveType]];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[self wrappResultSet:rs]];
    }
    [rs close];
    [dbArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        LTLiveChannelListDetailModel *order1 = obj1;
        LTLiveChannelListDetailModel *order2 = obj2;
        NSInteger value1 = [[NSString safeString:order1.numericKeys] integerValue];
        if ([NSString isBlankString:order1.numericKeys]) {//numericKeys 为空的情况放到最后
            value1 = dbArray.count + 100;
        }
        NSInteger value2 = [[NSString safeString:order2.numericKeys] integerValue];
        if ([NSString isBlankString:order2.numericKeys]) {//numericKeys 为空的情况放到最后
            value2 = dbArray.count + 100;
        }
        if (value1 > value2) {
            return NSOrderedDescending;
        }else if (value1 < value2) {
            return NSOrderedAscending;
        }else{
            return NSOrderedSame;
        }
    }];
    return dbArray;
}

//通过channelId 删除频道信息
+ (BOOL)deleteByChannelID:(NSString *)channelID type:(LTLiveHistoryFavType)liveType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM livingHistory WHERE channel_id = %@ and fromType = %d",channelID,liveType]];
   	return bResult;
}

//通过 model 更新频道数据 如果本地没有则插入
+ (BOOL)upateWithChannelModel:(LTLiveChannelListDetailModel *)model type:(LTLiveHistoryFavType)liveType
{
    LTLiveChannelListDetailModel *nativeModel = [LivingHistoryCommand searchByChannelId:model.channelId type:liveType];
    
    if (nativeModel) {
        model.isFovo = nativeModel.isFovo;
    }else{
        return [LivingHistoryCommand insertWithObject:model type:liveType];
    }
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_add_time = [formatter stringFromDate:[NSDate date]];
    BOOL bResult = [db executeUpdate:@"update livingHistory set numericKeys =?,channelEname =?,channelName =?,favo_state =?, add_Time =? ,order_no =? where channel_id = ? and fromType = ?",
                    [NSString safeString:model.numericKeys],[NSString safeString:model.channelEname],[NSString safeString:model.channelName],[NSString safeString:model.isFovo],
                    [NSString safeString:_add_time],
                    [NSString safeString:model.orderNo],
                    [NSString safeString:model.channelId],
                    [NSString stringWithFormat:@"%d",liveType]];
    return bResult;
}

+ (BOOL)searchFavStateByChannelID:(NSString *)channelID type:(LTLiveHistoryFavType)liveType {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:@"SELECT * FROM livingHistory where channel_id =? and fromType = ? Order By add_Time Desc ",channelID,[NSString stringWithFormat:@"%d",liveType]];
    
    BOOL favState = NO;
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([rs next])
    {
//        detailModel = [self wrappResultSet:rs];
        favState = [[rs objectForColumn:@"favo_state"] boolValue];
    }
    [rs close];
    return favState;
}

@end
