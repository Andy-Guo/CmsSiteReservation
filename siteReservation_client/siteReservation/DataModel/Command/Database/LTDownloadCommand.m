//
//  LTDownloadCommand.m
//  LetvIpadClient
//
//  Created by chen on 13-7-23.
//
//

#import "LTDownloadCommand.h"
#import "SqlDBHelper.h"
//#import "NSString+HTTPExtensions.h"
#import "LTDataCenter.h"


@implementation LTDownloadFolder


+(LTDownloadFolder *)wrappResultSet:(id<PLResultSet>)rs
{
    LTDownloadFolder *downloadItem = [[LTDownloadFolder alloc] init];
    downloadItem.pid = [rs isNullForColumn:@"a_id"] ? @"" : [rs objectForColumn:@"a_id"];
    downloadItem.icon = [rs isNullForColumn:@"icon"] ? @"" : [rs objectForColumn:@"icon"];
    downloadItem.nameCn = [rs isNullForColumn:@"a_title"] ? @"" : [rs objectForColumn:@"a_title"];
    downloadItem.count = [rs isNullForColumn:@"count"] ? 0 : [[rs objectForColumn:@"count"] integerValue];
    downloadItem.fileSize = [rs isNullForColumn:@"filesize"] ? 0 : [NSNumber numberWithLongLong:[[rs objectForColumn:@"filesize"] longLongValue]];
    downloadItem.downloadSize = [rs isNullForColumn:@"downsize"] ? 0 : [NSNumber numberWithLongLong:[[rs objectForColumn:@"downsize"] longLongValue]];
    NSInteger playcount = [rs isNullForColumn:@"isPlay"] ? 0 : [[rs objectForColumn:@"isPlay"] integerValue];
    downloadItem.isPlay = (playcount == downloadItem.count);
    downloadItem.downloadStatus = [rs isNullForColumn:@"downloadstatus"] ? 0 : [[rs objectForColumn:@"downloadstatus"] integerValue];
    downloadItem.isVipDownload = [rs isNullForColumn:@"isVipDownload"] ? 0 : [[rs objectForColumn:@"isVipDownload"] integerValue];
    downloadItem.videoSource = [rs isNullForColumn:@"video_source"] ? 0 : [[rs objectForColumn:@"video_source"] integerValue];
    return downloadItem;
}

+(NSArray*) searchAllDownloadFold
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSMutableDictionary *dbDict = [[NSMutableDictionary alloc] init];
    id<LeTV_PLResultSet>rs2;
    NSString *sql = @"select a_id, count(*) as count, sum(is_play) as isPlay from LTDownloadHistory where download_status = '4' group by a_id;";
    rs2= [db executeQuery:sql];
    while ([rs2 next]){
        NSString *pid = [rs2 isNullForColumn:@"a_id"] ? @"" : [rs2 objectForColumn:@"a_id"];
        NSNumber *count = [rs2 isNullForColumn:@"count"] ? @(0) : [NSNumber numberWithInteger:[[rs2 objectForColumn:@"count"] integerValue]];
        NSNumber *play = [rs2 isNullForColumn:@"isPlay"] ? @(0) : [NSNumber numberWithInteger:[[rs2 objectForColumn:@"isPlay"] integerValue]];;
        NSArray *tempArr = @[count,play];
        if (pid) {
            [dbDict setObject:tempArr forKey:pid];
        }
    }
    [rs2 close];
    id<PLResultSet> rs;
    NSString *inSql = [NSString stringWithFormat:@"select a_id, a_title, icon, video_source, count(*) as count, sum(file_size) as filesize, sum(download_size) as downsize, sum(is_play) as isPlay,min(download_status) as downloadstatus, sum(isVipDownload) as isVipDownload from LTDownloadHistory group by a_id order by min(add_time);"];
    rs  = [db executeQuery:inSql];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    LTDownloadFolder *downloadInfo = nil;
    while ([rs next]){
        downloadInfo = [LTDownloadFolder wrappResultSet:rs];
        NSArray *arr = [dbDict objectForKey:downloadInfo.pid];
        if (arr) {
            downloadInfo.completeCount = [arr[0] integerValue];
            downloadInfo.isPlay = (downloadInfo.completeCount == [arr[1] integerValue]);
        }else{
            downloadInfo.isPlay = YES;
        }
        [dbArray addObject:downloadInfo];
    }
    [rs close];
    return dbArray;
}



+(NSArray*) searchAllDownloadFoldItemWith:(NSArray *)pids
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    NSString *inSql = [NSString string];
    inSql = @"(";
    for (int i=0;i<[pids count];i++){
        if (i<[pids count]-1) {
            inSql = [inSql stringByAppendingFormat:@" a_id='%@' or ",pids[i]];
        }else {
            inSql = [inSql stringByAppendingFormat:@" a_id='%@' ",pids[i]];
        }
    }
    inSql = [inSql stringByAppendingString:@")"];
    NSString *sql = @"select v_id from LTDownloadHistory ";
    if (pids && [pids count]>0) {
        sql = [sql stringByAppendingFormat:@" where %@ ",inSql];
    }
    rs  = [db executeQuery:sql];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    LTDownloadFolder *downloadInfo = nil;
    while ([rs next]){
        if(![rs isNullForColumn:@"v_id"]){
            [dbArray addObject:[rs objectForColumn:@"v_id"]];
        }
    }
    [rs close];
    return dbArray;
}



@end

@class LTDownloadFolder;

@implementation LTDownloadCommand

/* 查询全部 */
+(NSArray*) searchAll {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:@"select * from LTDownloadHistory Order By  ID desc"];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        [dbArray addObject:[LTDownloadCommand wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

/* 查询全部 文件夹 */
+(NSArray*) searchAllForAId
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select * from LTDownloadHistory"];
    rs  = [db executeQuery:inSql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    NSMutableArray *movieIdArray = [[NSMutableArray alloc] initWithCapacity:0];
    BOOL isFold = NO;
    LTDownloadCommand *downloadInfo = nil;
    
    while ([rs next])
    {
        downloadInfo = [LTDownloadCommand wrappResultSet:rs];
        isFold = (      [downloadInfo.movieDetailModel.cid integerValue] == NewCID_TV
                  ||    [downloadInfo.movieDetailModel.cid integerValue] == NewCID_Anime
                  ||    [downloadInfo.movieDetailModel.cid integerValue] == NewCID_LetvProduce);
        
        if (!([movieIdArray containsObject:downloadInfo.movieDetailModel.pid] && isFold)) {
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjects:@[@(isFold), downloadInfo]
                                                                                 forKeys:@[@"isFold", @"downloadInfo"]];
            [dbArray addObject:dictionary];
            [movieIdArray addObject:(isFold)?downloadInfo.movieDetailModel.pid:downloadInfo.videoModel.vid];
        }
    }
    [rs close];
    NSArray *array = [NSMutableArray arrayWithObjects:dbArray, movieIdArray, nil];
    return array;
}

+(NSArray*) searchAllDownloadFold
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select * from LTDownloadHistory"];
    rs  = [db executeQuery:inSql];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    LTDownloadCommand *downloadInfo = nil;
    
    while ([rs next])
    {
        downloadInfo = [LTDownloadCommand wrappResultSet:rs];
        
        NSMutableArray * tmpArray = [dic objectForKey:downloadInfo.videoModel.pid];
        if (tmpArray) {
            [tmpArray addObject:downloadInfo];
        }
        else
        {
            tmpArray = [NSMutableArray array];
            [tmpArray addObject:downloadInfo];
            [dic setObject:tmpArray forKey:downloadInfo.videoModel.pid];
        }
        
    }
    [rs close];
    
    NSArray * keyArray = [dic allKeys];
    for (NSString * key in keyArray) {
        NSArray *subArray = [dic objectForKey:key];
        if ([subArray count]>1) {
            NSArray *sorteArray = [subArray sortedArrayUsingComparator:^(id obj1, id obj2){
                LTDownloadCommand * compObj1 = (LTDownloadCommand *)obj1;
                LTDownloadCommand * compObj2 = (LTDownloadCommand *)obj2;
                BOOL _bIsSortByASC =([compObj1.movieDetailModel.cid integerValue] != NewCID_TVProgram);
                if ([compObj1.videoModel.episode/*JEASONepisode no del!!!!*/ integerValue] > [compObj2.videoModel.episode/*JEASONepisode no del!!!!*/ integerValue]) {
                    return (NSComparisonResult)(_bIsSortByASC ? NSOrderedDescending : NSOrderedAscending);
                }
                if ([compObj1.videoModel.episode/*JEASONepisode no del!!!!*/ integerValue] < [compObj2.videoModel.episode/*JEASONepisode no del!!!!*/ integerValue]) {
                    return (NSComparisonResult)(_bIsSortByASC ? NSOrderedAscending : NSOrderedDescending);
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            [dbArray addObject:sorteArray];
            
        }else{
            [dbArray addObject:subArray];
        }
    }
    
    
    return dbArray;
}

/* 查询当前aid的quanbu纪录 */
+(NSArray*) searchAllForSubFolderAId:(NSString*)aid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    LTDownloadCommand *downloadInfo = nil;
    NSMutableArray *subDownloadArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *subMmsidArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *inSql = [NSString stringWithFormat:@"select * from LTDownloadHistory where a_id = '%@' ",aid];
    rs  = [db executeQuery:inSql];
    
    while ([rs next])
    {
        downloadInfo = [LTDownloadCommand wrappResultSet:rs];
        if (![NSString isBlankString:downloadInfo.videoModel.cid]) {
            [subDownloadArray addObject:downloadInfo];
            [subMmsidArray addObject:downloadInfo.videoModel.vid];
        }
    }
    [rs close];
    
    NSArray *subFolderArray = [NSMutableArray arrayWithObjects:subDownloadArray, subMmsidArray, nil];
    return subFolderArray;
}

/* 查询 _column == _columnValue 的全部attribute */
+(NSArray*) searchAllForAttribute:(NSString*)attribute
                           column:(NSString*)_column
                      columnValue:(NSString*)_columnValue
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select %@ from LTDownloadHistory where %@ = '%@' ",attribute,_column,_columnValue];
    rs  = [db executeQuery:inSql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        [dbArray addObject:[rs objectForColumn:attribute]];
    }
    [rs close];
    return dbArray;
}

/* 查询全部attribute */
+(NSArray*)searchForAttribute:(NSString*)attribute
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select %@ from LTDownloadHistory",attribute];
    rs  = [db executeQuery:inSql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        [dbArray addObject:[rs objectForColumn:attribute]];
    }
    [rs close];
    return dbArray;
}

/* 查询全部 _column == _columnValue的记录 */
+(NSArray*)searchAllForColumn:(NSString*)_column
                  columnValue:(NSString*)_columnValue
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select * from LTDownloadHistory where %@ = '%@' ",_column,_columnValue];
    rs  = [db executeQuery:inSql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        [dbArray addObject:[LTDownloadCommand wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

/* 查询全部状态为_status的记录 */
+(NSArray*)searchAllByStatus:(NSArray *)_status {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    NSString *inSql = [NSString string];
#ifdef LT_IPAD_CLIENT
    inSql = @"(";
#else

#endif

    for (int i=0;i<[_status count];i++){
        if (i<[_status count]-1) {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' or ",_status[i]];
        }else {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' ",_status[i]];
        }
    }
#ifdef LT_IPAD_CLIENT
    inSql = [inSql stringByAppendingString:@")"];
#else

#endif
    NSString *sql = @"select * from LTDownloadHistory ";
    if ([_status count]>0) {
        sql = [sql stringByAppendingFormat:@" where %@ ",inSql];
    }
    sql = [sql stringByAppendingString:@"Order By  ID asc"];
    rs  = [db executeQuery:sql];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[LTDownloadCommand wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

/* 查询全部状态为downloading的记录 */
+(NSArray*)searchAllDownloading{
    NSArray *_status = @[[NSString stringWithFormat:@"%d",DownloadStatusWait],[NSString stringWithFormat:@"%d",DownloadStatusDownloading],[NSString stringWithFormat:@"%d",DownloadStatusError],[NSString stringWithFormat:@"%d",DownloadStatusPause]];
    return [LTDownloadCommand searchAllByStatus:_status];
}

+(NSArray *)searchAllDownloadCompleteByAID:(NSString *)aid
{
    NSArray *_status = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",DownloadStatusComplete],nil];

    return [LTDownloadCommand searchAllByStatus:_status andAID:aid];
}

+(NSArray *)searchAllDownloadCompleteByVid:(NSString *)vid
{
    NSArray *_status = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",DownloadStatusComplete],nil];
    return [LTDownloadCommand searchAllByStatus:_status andVid:vid];
}

+ (NSArray *)searchAllByStatus:(NSArray *)_status andAID:(NSString *)aid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    NSString *inSql = [NSString string];
#ifdef LT_IPAD_CLIENT
    inSql = @"(";
#else

#endif
    for (int i=0;i<[_status count];i++){
        if (i<[_status count]-1) {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' or ",[_status objectAtIndex:i]];
        }else {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' ",[_status objectAtIndex:i]];
        }
    }
#ifdef LT_IPAD_CLIENT
    inSql = [inSql stringByAppendingString:@")"];
#else

#endif
    NSString *sql = @"select * from LTDownloadHistory ";
    if ([_status count]>0) {
        sql = [sql stringByAppendingFormat:@" where %@ and a_id = '%@'",inSql,aid];
    }
    sql = [sql stringByAppendingString:@"Order By  ID asc"];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([db tableExists:@"LTDownloadHistory"]) {
        rs  = [db executeQuery:sql];
        while ([rs next])
        {
            [dbArray addObject:[LTDownloadCommand wrappResultSet:rs]];
        }
        [rs close];
    }
    
    return dbArray;
}


+ (NSArray *)searchAllByStatus:(NSArray *)_status andVid:(NSString *)vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    NSString *inSql = [NSString string];
#ifdef LT_IPAD_CLIENT
    inSql = @"(";
#else

#endif
    for (int i=0;i<[_status count];i++){
        if (i<[_status count]-1) {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' or ",[_status objectAtIndex:i]];
        }else {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' ",[_status objectAtIndex:i]];
        }
    }
#ifdef LT_IPAD_CLIENT
    inSql = [inSql stringByAppendingString:@")"];
#else

#endif
    NSString *sql = @"select * from LTDownloadHistory ";
    if ([_status count]>0) {
        sql = [sql stringByAppendingFormat:@" where %@ and v_id = '%@'",inSql,vid];
    }
    sql = [sql stringByAppendingString:@"Order By  ID asc"];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([db tableExists:@"LTDownloadHistory"]) {
        rs  = [db executeQuery:sql];
        while ([rs next])
        {
            [dbArray addObject:[LTDownloadCommand wrappResultSet:rs]];
        }
        [rs close];
    }
    
    return dbArray;
}


/* 查询全部状态为下载完成的记录 */
+(NSArray*)searchAllDownloadComplete{
    NSArray *_status = @[[NSString stringWithFormat:@"%d",DownloadStatusComplete]];
    return [LTDownloadCommand searchAllByStatus:_status];
}

+(id) searchByID:(int)_id{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select * from LTDownloadHistory where ID = %d limit 1",_id];
    
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    
    LTDownloadCommand *com = nil;
    if([rs next])
    {
        com = [LTDownloadCommand wrappResultSet:rs];
    }
    [rs close];
    return com;
}

/* 查询vid的记录是否存在 limit 1 */
+(id) searchByVID:(NSString *)_vid{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
#ifdef LT_IPAD_CLIENT
    NSString *sql = [NSString stringWithFormat:@"select * from LTDownloadHistory where v_id = '%@' limit 1",[NSString safeString:_vid]];
#else


    NSString *sql = [NSString stringWithFormat:@"select * from LTDownloadHistory where v_id = '%@' limit 1",_vid];
#endif    
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    
    LTDownloadCommand *com = nil;
    if([rs next])
    {
        com = [LTDownloadCommand wrappResultSet:rs];
    }
    
    [rs close];
    return com;
}

/* 查询aid vid的对应记录 */
+(id) searchByAID:(NSString *)_aid andVid:(NSString*)_vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select * from LTDownloadHistory where a_id = '%@' and v_id = '%@' limit 1", _aid, _vid];
    
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    
    LTDownloadCommand *com = nil;
    if([rs next])
    {
        com = [LTDownloadCommand wrappResultSet:rs];
    }
    
    [rs close];
    return com;
}


/* 查询aid 的对应记录是否存在  limit 1 */
+(id) searchByAID:(NSString *)_aid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select * from LTDownloadHistory where a_id = '%@' limit 1",_aid];
    
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    
    LTDownloadCommand *com = nil;
    if([rs next])
    {
        com = [LTDownloadCommand wrappResultSet:rs];
    }
    
    [rs close];
    return com;
}

+(NSString*)searchPlayUrlByAID:(NSString *)_aid andVid:(NSString*)_vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select locale_file_path from LTDownloadHistory where a_id = '%@' and v_id = '%@' and download_status = '4'", _aid, _vid];
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    NSString *path = @"";
    if([rs next])
    {
        path = [rs objectForColumn:@"locale_file_path"];
    }
    
    [rs close];
    return path;
}

/* 查询记录数量 */
+(int) downloadCount
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    rs = [db executeQuery:@"select count(*) as count from LTDownloadHistory"];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

/* 查询 _column == _columnValue的记录数量 */
+(int) countForColumn:(NSString*)_column
          columnValue:(NSString*)_columnValue
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    
    rs = [db executeQuery:[NSString stringWithFormat:@"select count(*) as count from LTDownloadHistory where %@ = '%@' ",_column,_columnValue]];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

/* 查询专辑id下的文件夹下的记录数量 */
+(int) countForSubFolder:(NSString*)_aid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    
    rs = [db executeQuery:[NSString stringWithFormat:@"select count(*) as count from LTDownloadHistory where a_id = '%@' and c_id != ''",_aid]];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}


/* 查询隶属文件夹的记录数量 */
+(int) countForSubFolderColumnArray:(NSArray*)_columnArray
                   columnValueArray:(NSArray*)_columnValueArray
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    NSString *mainSql = @"select count(*) as count from LTDownloadHistory";
    NSString *paraSql = @" where ";
    
    if (_columnArray != nil &&
        _columnValueArray != nil &&
        [_columnArray count] == [_columnValueArray count] &&
        [_columnArray count] > 0)
    {
        for (NSInteger i = 0; i < [_columnArray count]; i++) {
            if (i<[_columnArray count]) {
                paraSql = [paraSql stringByAppendingFormat:@" %@='%@' and ",_columnArray[i],_columnValueArray[i]];
            }
        }
        paraSql = [paraSql stringByAppendingFormat:@" c_id !=''"];
        mainSql = [mainSql stringByAppendingString:paraSql];
    }
    id<PLResultSet> rs;
    rs = [db executeQuery:mainSql];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

/* 查询状态为_download_status的记录数量 */
+(int) countForStatus:(NSString *)_download_status
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    rs = [db executeQuery:@"select count(*) as count from LTDownloadHistory where download_status=?",_download_status];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

/* 插入新记录*/
+(int) insertWithMovieDetail:(MovieDetailModel*)movieDetail
                  videoModel:(VideoModel*)video
               videoCodeType:(VideoCodeType)_videoCodeType
                        icon:(NSString *)_icon
                download_url:(NSString *)_url
                   file_Size:(NSString *)_file_size
               download_Size:(NSString *)_download_size
             download_Status:(NSString *)_download_status
            locale_File_Path:(NSString *)_locale_file_path
                  audioTrack:(NSString *)_audioTrack
      subtitleDownloadStatus:(NSString *)_subtitleDownloadStatus
                 subtitleKey:(NSString *)_subtitleKey{
    
    if([LTDownloadCommand movieCountByVID:video.vid] != 0)
    {
        [LTDownloadCommand deleteByVID:video.vid];
    }
    NSData *archivebrListData;
    if (nil == [video getInnerBrList]/*JEASONbrList no del!!!!*/) {
        archivebrListData = [NSKeyedArchiver archivedDataWithRootObject:[NSArray array]];
    }else{
        archivebrListData = [NSKeyedArchiver archivedDataWithRootObject:[video getInnerBrList]/*JEASONbrList no del!!!!*/];
    }
    NSData *archivepicListData = [NSKeyedArchiver archivedDataWithRootObject:video.picAll];
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_add_time = [formatter stringFromDate:[NSDate date]];
    
    BOOL bResult = [db executeUpdate:@"INSERT INTO LTDownloadHistory( \
                    a_id,v_id,m_id,c_id,video_number,video_index,video_source,video_type,score,is_end, \
                    duration,director,actor,area ,sub_category,play_tv,school,control_area,disable_type,   \
                    need_pay,stamp,btime,etime,desc,a_title,v_title,icon,subIcon,release_date,  \
                    video_code,down_url,add_time,file_size,download_size,download_status,locale_file_path,videotypekey,is_play,need_download,brlist,video_single_type,pic_collections,varietyShow,isVipDownload,audioTrack,subtitleDownloadStatus,subtitleKey) \
                    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    movieDetail.pid,
                    video.vid,
                    video.mid,
                    video.cid,
                    [NSString stringWithFormat:@"%@", movieDetail.episode],
                    [NSString stringWithFormat:@"%@", video.episode]/*JEASONepisode no del!!!!*/,
                    [NSString stringWithFormat:@"%d", movieDetail.type],
                    video.videoType,
                    movieDetail.score,
                    movieDetail.isEnd,
                    [NSString stringWithFormat:@"%@", video.duration]/*JEASONduration(non del!!)*/,
                    @"" ,
                    movieDetail.starring ,
                    movieDetail.area ,
                    movieDetail.subCategory ,
                    movieDetail.playTv,
                    movieDetail.school,
                    @"",
                    @"",
                    @(video.pay),
                    @"",//movieDetail.stamp,
                    [NSString stringWithFormat:@"%@", video.btime]/*JEASONbtime no del!!!!*/,
                    [NSString stringWithFormat:@"%@", video.etime]/*JEASONetime no del!!!!*/,
                    movieDetail.desc,
                    movieDetail.nameCn,
                    video.nameCn,
                    _icon,
                    video.picAll.pic320_200,
                    movieDetail.releaseDate,
                    [NSString stringWithFormat:@"%d", _videoCodeType],
                    _url,
                    _add_time,
                    _file_size,
                    _download_size,
                    _download_status,
                    _locale_file_path,
                    video.videoTypeKey,
                    @"0",
                    @(video.download),
                    archivebrListData,
                    [NSString stringWithFormat:@"%d", video.type],
                    archivepicListData,
                    movieDetail.varietyShow,
                    video.isVipDownload,
                    _audioTrack,
                    _subtitleDownloadStatus,
                    _subtitleKey
                    ];
    if (!bResult) {
    }
    
    return bResult;
}

/* 删除 _vid的记录 */
+(int) deleteByVID:(NSString *)_vid {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate: @"DELETE FROM LTDownloadHistory WHERE v_id=?",_vid];
    return bResult;
}

/* 获取_vid的记录数量 */
+(int) movieCountByVID:(NSString *)_vid {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    rs = [db executeQuery:@"select count(*) as count from LTDownloadHistory where v_id = ? ",_vid];
    if([rs next]) {
        NSString *_count = [rs objectForColumn:@"count"];
        return [_count intValue];
    }
    return 0;
}

/* 更新_vid的下载大小 */
+(int) updateByVid:(NSString *)_vid DownloadSize:(NSString*)_download_size {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update LTDownloadHistory set download_size=? where v_id = ?",
                    _download_size,
                    _vid];
    return bResult;
}

/* 更新_vid的下载状态 */
+(int) _updateByVid:(NSString *)_vid DownloadStatus:(NSString*)_download_status{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update LTDownloadHistory set download_status=? where v_id = ?",
                    _download_status,_vid];
    return bResult;
}

/* 更新_vid的下载状态 */
+(int) updateByVid:(NSString *)_vid DownloadStatus:(NSString*)_download_status{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update LTDownloadHistory set download_status=? where v_id = ?",
                    _download_status,_vid];
    return bResult;
}

/* 更新下载完成时间 */
+(int) updateByVid:(NSString *)_vid FinishTime:(NSString*)time {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update LTDownloadHistory set finish_time=? where v_id = ?",
                    time, _vid];
    return bResult;
}

/* 更新 _field = _fieldValue */
+(int) updateByVid:(NSString *)_vid field:(NSString *)_field FieldValue:(NSString *)_field_value
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"update LTDownloadHistory set %@='%@' where v_id = '%@'",
                     _field,_field_value,_vid];
    BOOL bResult = [db executeUpdate:sql];
    return bResult;
}

/* 更新 下载地址  文件大小  */
+(int) updateByVid:(NSString *)_vid download_url:(NSString *)url file_size:(NSString *)_file_size
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"update LTDownloadHistory set down_url='%@',file_size='%@' where v_id = '%@'" ,
                     url,_file_size,
                     _vid];
    BOOL bResult = [db executeUpdate:sql];
    
    return bResult;
}

/* 更新 下载地址 */
+(int)updateByVid:(NSString *)_vid download_url:(NSString *)url
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"update LTDownloadHistory set down_url='%@' where v_id = '%@'", url, _vid];
    BOOL bResult = [db executeUpdate:sql];
    
    return bResult;
}

/* 更新码流 */
+(int) updateByVid:(NSString *)_vid codeRate:(VideoCodeType)codeRate {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update LTDownloadHistory set video_code=? where v_id = ?",
                    [NSString stringWithFormat:@"%d", codeRate], _vid];
    
    return bResult;
}

/* 更新视频文件名称 */
+(int) updateByVid:(NSString *)_vid storePath:(NSString *)storepath
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:
                    @"update LTDownloadHistory set storepath=? where v_id = ?",
                    storepath,
                    _vid];
    
    return bResult;
}

/* 更新视频文件地址 */
+(int) updateByVid:(NSString *)_vid localFilePath:(NSString *)localFilePath {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:
                    @"update LTDownloadHistory set locale_file_path=? where v_id = ?",
                    localFilePath,
                    _vid];
    
    return bResult;
}

/* 更新_varietyShow的状态 */
+(int) update61UpdateVarietyShow_statusByVid:(NSString *)_vid VarietyShowStatus:(NSString*)_VarietyShow_status{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update LTDownloadHistory set varietyShow=? where v_id = ?",
                    _VarietyShow_status,_vid];
    return bResult;
}

/* 更新_isVipDownload的状态 */
+(int) update661UpdateisVipDownload_statusByVid:(NSString *)_vid isVipDownloadStatus:(NSString*)_isVipDownload_status{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update LTDownloadHistory set isVipDownload=? where v_id = ?",
                    _isVipDownload_status,_vid];
    return bResult;
}

/* 初始化和退出设置 状态设为pause */
+(int) processDataForInitAndTerminate{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"update LTDownloadHistory set download_status='%d' where download_status = '%d' or download_status = '%d' or download_status = '%d'",
                     DownloadStatusPause,
                     DownloadStatusDownloading,
                     DownloadStatusWait,
                     DownloadStatusError];
    NSLog(@"--SQL--%@",sql);
    BOOL bResult = [db executeUpdate:sql];
    return bResult;
}

+(int) processDataForWaitingStatus:(BOOL)isVipDownload{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = nil;
    if (isVipDownload) {
        sql = [NSString stringWithFormat:@"update LTDownloadHistory set download_status='%d' where (isVipDownload = '0') and (download_status = '%d' or download_status = '%d')",
               DownloadStatusWait,
               DownloadStatusPause,
               DownloadStatusError];
    }else{
        sql = [NSString stringWithFormat:@"update LTDownloadHistory set download_status='%d' where download_status = '%d' or download_status = '%d'",
               DownloadStatusWait,
               DownloadStatusPause,
               DownloadStatusError];
    }
    NSLog(@"--SQL--%@",sql);
    BOOL bResult = [db executeUpdate:sql];
    return bResult;
}

/*
 //下载数据库重置  V3.8
 #define SQL_DOWNLOADHISTORY38 @"CREATE TABLE LTDownloadHistory (ID integer primary key autoincrement unique,a_id varchar(255),v_id varchar(255),m_id varchar(255),c_id varchar(20),video_number varchar(20),video_index varchar(20),video_source varchar(4),video_type varchar(4),score varchar(20),is_end varchar(4),duration varchar(20),director varchar(255),actor varchar(255),area varchar(255),sub_category varchar(255),play_tv varchar(50),school varchar(50),control_area varchar(255),disable_type varchar(4),need_pay varchar(4),stamp varchar(4),btime integer default 0,etime integer default 0,desc text,a_title text,v_title text,icon varchar(255),release_date varchar(4),video_code integer default 0,down_url varchar(255),add_Time timestamp default (datetime('now', 'localtime')),file_size varchar(20),download_size varchar(20),download_status varchar(2),locale_file_path varchar(255),finish_time timestamp default (datetime('now', 'localtime')));"   //sourceType 1 竖图  2横图
 */
+(LTDownloadCommand *)wrappResultSet:(id<PLResultSet>)rs
{
    LTDownloadCommand *downloadItem = [[LTDownloadCommand alloc] init];
    
    @try {
        downloadItem.ID = [rs isNullForColumn:@"ID"] ? 0 : [[rs objectForColumn:@"ID"] intValue];
        downloadItem.icon = [rs isNullForColumn:@"icon"] ? @"" : [rs objectForColumn:@"icon"];
        downloadItem.subIcon = [rs isNullForColumn:@"subIcon"] ? @"" : [rs objectForColumn:@"subIcon"];
        downloadItem.add_time = [rs isNullForColumn:@"add_time"] ? @"" : [rs objectForColumn:@"add_time"];
        downloadItem.video_code = [rs isNullForColumn:@"video_code"] ? 0 : [[rs objectForColumn:@"video_code"] integerValue];
        downloadItem.download_url = [rs isNullForColumn:@"down_url"] ? @"" : [rs objectForColumn:@"down_url"];
        downloadItem.storepath = [rs isNullForColumn:@"storepath"] ? @"" : [rs objectForColumn:@"storepath"];
        downloadItem.file_size = [rs isNullForColumn:@"file_size"] ? @"" : [rs objectForColumn:@"file_size"];
        downloadItem.download_size = [rs isNullForColumn:@"download_size"] ? @"" : [rs objectForColumn:@"download_size"];
        downloadItem.download_size0 = [rs isNullForColumn:@"download_size0"] ? @"" : [rs objectForColumn:@"download_size0"];
        downloadItem.download_size1 = [rs isNullForColumn:@"download_size1"] ? @"" : [rs objectForColumn:@"download_size1"];
        downloadItem.download_size2 = [rs isNullForColumn:@"download_size2"] ? @"" : [rs objectForColumn:@"download_size2"];
        downloadItem.locale_file_path = [rs isNullForColumn:@"locale_file_path"] ? @"" : [rs objectForColumn:@"locale_file_path"];
        downloadItem.download_status = [rs isNullForColumn:@"download_status"] ? @"" : [rs objectForColumn:@"download_status"];
        downloadItem.videotypekey = [rs isNullForColumn:@"videotypekey"] ? @"" : [rs objectForColumn:@"videotypekey"];
        downloadItem.is_play = [rs isNullForColumn:@"is_play"] ? @"" : [rs objectForColumn:@"is_play"];
        downloadItem.audioTrack = [rs isNullForColumn:@"audioTrack"] ? @"" : [rs objectForColumn:@"audioTrack"];
        downloadItem.subtitleDownloadStatus = [rs isNullForColumn:@"subtitleDownloadStatus"] ? @"" : [rs objectForColumn:@"subtitleDownloadStatus"];
        downloadItem.subtitleKey = [rs isNullForColumn:@"subtitleKey"] ? @"" : [rs objectForColumn:@"subtitleKey"];
        
        downloadItem.movieDetailModel = [[MovieDetailModel alloc] init];
        downloadItem.movieDetailModel.pid = [rs isNullForColumn:@"a_id"] ? @"" : [rs objectForColumn:@"a_id"];
        downloadItem.movieDetailModel.cid = [rs isNullForColumn:@"c_id"] ? @"" : [rs objectForColumn:@"c_id"];
        downloadItem.movieDetailModel.episode = [rs isNullForColumn:@"video_number"] ? @"" : [rs objectForColumn:@"video_number"];
        NSString *videoSource = [rs isNullForColumn:@"video_source"] ? @"" : [rs objectForColumn:@"video_source"];
        downloadItem.movieDetailModel.type = [videoSource intValue];
        downloadItem.movieDetailModel.score = [rs isNullForColumn:@"score"] ? @"" : [rs objectForColumn:@"score"];
        downloadItem.movieDetailModel.isEnd = [rs isNullForColumn:@"is_end"] ? @"" : [rs objectForColumn:@"is_end"];
        NSString *directory = [rs isNullForColumn:@"director"] ? @"" : [rs objectForColumn:@"director"];
        downloadItem.movieDetailModel.directory = [NSString safeString:directory];
        NSString *starring = [rs isNullForColumn:@"actor"] ? @"" : [rs objectForColumn:@"actor"];
        downloadItem.movieDetailModel.starring = [NSString safeString:starring];
        NSString *area = [rs isNullForColumn:@"area"] ? @"" : [rs objectForColumn:@"area"];
        downloadItem.movieDetailModel.area = area;
        NSString *subcategory = [rs isNullForColumn:@"sub_category"] ? @"" : [rs objectForColumn:@"sub_category"];
        downloadItem.movieDetailModel.subCategory = [NSString safeString:subcategory];
        
        downloadItem.movieDetailModel.playTv = [rs isNullForColumn:@"play_tv"] ? @"" : [rs objectForColumn:@"play_tv"];
        downloadItem.movieDetailModel.school = [rs isNullForColumn:@"school"] ? @"" : [rs objectForColumn:@"school"];
        downloadItem.movieDetailModel.pay = [rs isNullForColumn:@"need_pay"] ? NO : [[rs objectForColumn:@"need_pay"] boolValue];
        downloadItem.movieDetailModel.stamp = [rs isNullForColumn:@"stamp"] ? @"" : [rs objectForColumn:@"stamp"];
        downloadItem.movieDetailModel.desc = [rs isNullForColumn:@"desc"] ? @"" : [rs objectForColumn:@"desc"];
        downloadItem.movieDetailModel.nameCn = [rs isNullForColumn:@"a_title"] ? @"" : [rs objectForColumn:@"a_title"];
        downloadItem.movieDetailModel.releaseDate = [rs isNullForColumn:@"release_date"] ? @"" : [rs objectForColumn:@"release_date"];
        
        downloadItem.videoModel = [[VideoModel alloc] init];
        downloadItem.videoModel.vid = [rs isNullForColumn:@"v_id"] ? @"" : [rs objectForColumn:@"v_id"];
        downloadItem.videoModel.mid = [rs isNullForColumn:@"m_id"] ? @"" : [rs objectForColumn:@"m_id"];
        downloadItem.videoModel.cid = [rs isNullForColumn:@"c_id"] ? @"" : [rs objectForColumn:@"c_id"];
        downloadItem.videoModel.pid = [rs isNullForColumn:@"a_id"] ? @"" : [rs objectForColumn:@"a_id"];
        downloadItem.videoModel.episode/*JEASONepisode no del!!!!*/ = [rs isNullForColumn:@"video_index"] ? @"" : [rs objectForColumn:@"video_index"];
        NSInteger type = [rs isNullForColumn:@"video_single_type"] ? 0 : [[rs objectForColumn:@"video_single_type"] integerValue];
        if (type > 0) {
            downloadItem.videoModel.type = (VIDEOSOURCE)type;
        }else{
            downloadItem.videoModel.type = (VIDEOSOURCE)([rs isNullForColumn:@"video_source"] ? ALBUM_FROM_VRS : [[rs objectForColumn:@"video_source"] integerValue]);
            downloadItem.videoModel.videoType = [rs isNullForColumn:@"video_type"] ? @"" : [rs objectForColumn:@"video_type"];
        }
        downloadItem.videoModel.type = [rs isNullForColumn:@"video_source"] ? ALBUM_FROM_VRS : [[rs objectForColumn:@"video_source"] intValue];
        downloadItem.videoModel.duration/*JEASONduration(non del!!)*/ = [rs isNullForColumn:@"duration"] ? @"" : [rs objectForColumn:@"duration"];
        downloadItem.videoModel.pay = [rs isNullForColumn:@"need_pay"] ? NO : [[rs objectForColumn:@"need_pay"] boolValue];
        downloadItem.videoModel.btime/*JEASONbtime no del!!!!*/ = [rs isNullForColumn:@"btime"] ? @"" : [rs objectForColumn:@"btime"];
        downloadItem.videoModel.etime/*JEASONetime no del!!!!*/ = [rs isNullForColumn:@"etime"] ? @"" : [rs objectForColumn:@"etime"];
        downloadItem.videoModel.nameCn = [rs isNullForColumn:@"v_title"] ? @"" : [rs objectForColumn:@"v_title"];
        downloadItem.videoModel.videoTypeKey = [rs isNullForColumn:@"videotypekey"] ? @"" : [rs objectForColumn:@"videotypekey"];
        
        downloadItem.videoModel.download = [rs isNullForColumn:@"need_download"] ? NO : [[rs objectForColumn:@"need_download"] boolValue];
        NSData *brData = [rs isNullForColumn:@"brlist"] ? nil : [rs dataForColumn:@"brlist"];
        if (nil == brData) {
            downloadItem.videoModel.brList/*JEASONbrList no del!!!!*/ = [NSArray array];
        }else{
            downloadItem.videoModel.brList/*JEASONbrList no del!!!!*/ =  [NSKeyedUnarchiver unarchiveObjectWithData:brData];
        }
        
        NSData *picsData = [rs isNullForColumn:@"pic_collections"] ? nil : [rs dataForColumn:@"pic_collections"];
        if (nil == picsData) {
            downloadItem.videoModel.picAll = nil;
        }else{
            downloadItem.videoModel.picAll = [NSKeyedUnarchiver unarchiveObjectWithData:picsData];
        }
        
        downloadItem.videoModel.upgc = [rs isNullForColumn:@"shortFlag"] ? @"0" : [rs objectForColumn:@"shortFlag"];
        downloadItem.movieDetailModel.varietyShow = [rs isNullForColumn:@"varietyShow"] ? @"" : [rs objectForColumn:@"varietyShow"];
        downloadItem.videoModel.isVipDownload = [rs isNullForColumn:@"isVipDownload"] ? @"" : [rs objectForColumn:@"isVipDownload"];
#ifdef LT_IPAD_CLIENT
        downloadItem.audioTrack = [rs isNullForColumn:@"audioTrack"] ? @"" : [rs objectForColumn:@"audioTrack"];
        downloadItem.subtitleDownloadStatus = [rs isNullForColumn:@"subtitleDownloadStatus"] ? @"" : [rs objectForColumn:@"subtitleDownloadStatus"];
        downloadItem.subtitleKey = [rs isNullForColumn:@"subtitleKey"] ? @"" : [rs objectForColumn:@"subtitleKey"];
#else

#endif
    } @catch (NSException *exception) {
        [LTDownloadCommand dealWithException:exception];
    } @finally {
        
    }
    
    return downloadItem;
}

+ (void)dealWithException:(NSException *)exception {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    NSString *exceptionStr = exception.description;
    
    if (![NSString empty:exceptionStr]) {
        if ([exceptionStr hasPrefix:@"unknowncolumn"]) {
            NSArray *dataArray = [exceptionStr componentsSeparatedByString:@":"];
            NSString *missingColumn = @"";
            
            if ([dataArray count] == 2) {
                missingColumn = [NSString safeString:[dataArray lastObject]];
            }
            
            if (![NSString empty:missingColumn]) {
                
                [SqlDBHelper addMissingColumn:@"LTDownloadHistory" missingColumnName:missingColumn];
            }
        }
    }
}

// 获取letv选择下载文件中已经下载文件总大小
+(NSNumber*)leTvDownloadedTotalSpace {
    return @([LTDownloadCommand searchAllDownloadedSize]);
}

// 获取letv选择下载文件容量总大小
+(NSNumber*)leTvDownloadFileSizeTotalSpace
{
    return @([LTDownloadCommand searchAllDownloadFileSize]);
}

/* 获取已下载大小 */
+ (long long)searchAllDownloadedSize {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    ////////////////////////////////
    long long space = 0;
    if ([db tableExists:@"LTDownloadHistory"]) {
        rs  = [db executeQuery:@"select download_size from LTDownloadHistory Order By  ID desc"];
        while ([rs next])
        {
            NSString *_download_size = @"";
            if (![rs isNullForColumn:@"download_size"]) {
                _download_size = [rs objectForColumn:@"download_size"];
            }
            space += [_download_size longLongValue];
        }
        [rs close];
    }
    return space;
}

+ (NSNumber*)searchAllOverDownloadSize {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    ////////////////////////////////
    long long space = 0;
    if ([db tableExists:@"LTDownloadHistory"]) {
        rs  = [db executeQuery:@"select download_size from LTDownloadHistory where download_status = '4' Order By  ID desc "];
        while ([rs next])
        {
            NSString *_download_size = @"";
            if (![rs isNullForColumn:@"download_size"]) {
                _download_size = [rs objectForColumn:@"download_size"];
            }
            space += [_download_size longLongValue];
        }
        [rs close];
    }
    return @(space);
}

/* 获取文件占用大小 */
+ (long long)searchAllDownloadFileSize {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    ////////////////////////////////
    long long space = 0;
    if ([db tableExists:@"LTDownloadHistory"]) {
        rs  = [db executeQuery:@"select file_size from LTDownloadHistory Order By  ID desc"];
        while ([rs next])
        {
            NSString *_download_size = @"";
            if (![rs isNullForColumn:@"file_size"]) {
                _download_size = [rs objectForColumn:@"file_size"];
            }
            space += [_download_size longLongValue];
        }
        [rs close];
    }
    return space;
}

/* 专辑文件大小 */
+ (long long)totalSizeForSubFolder:(NSString*)_aid {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    long long totalSize = 0;
    
    rs = [db executeQuery:[NSString stringWithFormat:
                           @"select file_size from LTDownloadHistory where a_id = '%@' and c_id != ''",
                           _aid]];
    
    while ([rs next])
    {
        NSString *strFileSize = @"";
        if (![rs isNullForColumn:@"file_size"]) {
            strFileSize = [rs objectForColumn:@"file_size"];
        }
        totalSize += [strFileSize longLongValue];
    }
    
    [rs close];
    
    return totalSize;
    
}

/* 专辑已下载大小 */
+ (long long)downloadedSizeForSubFolder:(NSString*)_aid {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    long long downloadedSize = 0;
    
    rs = [db executeQuery:[NSString stringWithFormat:
                           @"select download_size from LTDownloadHistory where a_id = '%@' and c_id != ''",
                           _aid]];
    
    while ([rs next])
    {
        NSString *strDownloadedSize = @"";
        if (![rs isNullForColumn:@"download_size"]) {
            strDownloadedSize = [rs objectForColumn:@"download_size"];
        }
        downloadedSize += [strDownloadedSize longLongValue];
    }
    
    [rs close];
    
    return downloadedSize;
    
}


/**
 查询特殊列数据并排序
 status:状态
 column:排序列
 asc:升序 反之降序
 */
+(NSArray *)searchAllByStatus:(NSArray *)status
                   andOrderBy:(NSString *)column
                       andAsc:(BOOL)asc{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    NSString *inSql = [NSString string];
#ifdef LT_IPAD_CLIENT
    inSql = @"(";
#else

#endif
    for (int i=0;i<[status count];i++){
        if (i<[status count]-1) {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' or ",status[i]];
        }else {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' ",status[i]];
        }
    }
#ifdef LT_IPAD_CLIENT
    inSql = [inSql stringByAppendingString:@")"];
#else

#endif

    NSString *sql = @"select * from LTDownloadHistory ";
    if ([status count]>0) {
        sql = [sql stringByAppendingFormat:@" where %@ ",inSql];
    }
    if (column!=nil) {
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@"Order By %@ %@",column,asc? @"asc":@"desc"]];
        
    }
    rs  = [db executeQuery:sql];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[LTDownloadCommand wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}


/* 更新 播放状态 */
+(int)updateByVid:(NSString *)_vid is_play:(NSString *)play
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
#ifdef LT_IPAD_CLIENT
    id<PLResultSet> rs;
#else

#endif
    BOOL bResult = [db executeUpdate:
                    @"update LTDownloadHistory set is_play=? where v_id = ?",
                    play,
                    _vid];
    
    return bResult;
}

/* 更新 音轨值 */
+ (int)updateByVid:(NSString *)_vid audioTrack:(NSString *)audioTrack
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:
                    @"update LTDownloadHistory set audioTrack=? where v_id = ?",
                    audioTrack,
                    _vid];
    
    return bResult;
}

/* 更新 字幕下载完成状态 */
+ (int)updateByVid:(NSString *)_vid subtitleDownloadStatus:(NSString *)status
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:
                    @"update LTDownloadHistory set subtitleDownloadStatus=? where v_id = ?",
                    status,
                    _vid];
    
    return bResult;
}

/* 更新 字幕值 */
+ (int)updateByVid:(NSString *)_vid subtitleKey:(NSString *)subtitle
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:
                    @"update LTDownloadHistory set subtitleKey=? where v_id = ?",
                    subtitle,
                    _vid];
    
    return bResult;
}

+(int) searchAllCountByStatus:(NSArray *)status andAID:(NSString *)pid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString string];
    inSql = @"(";
    for (int i=0;i<[status count];i++){
        if (i<[status count]-1) {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' or ",status[i]];
        }else {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' ",status[i]];
        }
    }
    inSql = [inSql stringByAppendingString:@")"];
    NSString *sql = @"select count(*) as count from LTDownloadHistory ";
    if ([status count]>0) {
        if ([NSString isBlankString:pid]) {
            sql = [sql stringByAppendingFormat:@" where %@",inSql];
        }else{
            sql = [sql stringByAppendingFormat:@" where %@ and a_id = '%@'",inSql,pid];
        }
        
    }
    rs = [db executeQuery:sql];
    while ([rs next])
    {
        NSString *strDownloadedSize = @"0";
        if (![rs isNullForColumn:@"count"]) {
            strDownloadedSize = [rs objectForColumn:@"count"];
        }
        return [strDownloadedSize integerValue];
    }
    [rs close];
    return 0;
}


@end
