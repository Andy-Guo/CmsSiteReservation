//
//  SqlDBHelper.m
//  BookManagement
//
//  Created by CheungChing on 10-5-27.
//  Copyright 2010 iBokanWisdom. All rights reserved.
//
#import <sqlite3.h>
#import <LeTVMobileFoundation/LeTVMobileFoundation.h>
#import "SqlDBHelper.h"

static PLSqliteDatabase *dbPointer;

@implementation SqlDBHelper


+(PLSqliteDatabase*) setUp
{
    if(dbPointer)
    {
        return dbPointer;
    }
    
    NSString *oldDbFilePath = [[FileManager appDocumentPath] stringByAppendingPathComponent:DBPath];
    NSString *dbFilePath = [[FileManager appLetvProtectedPath] stringByAppendingPathComponent:DBPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:oldDbFilePath]) {
        [FileManager moveFile:oldDbFilePath dest:dbFilePath];
    }
    
    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"Letv" ofType:@"sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:dbFilePath])
    {
        NSError * error;
        if(![fileManager copyItemAtPath:srcPath toPath:dbFilePath error:&error])
        {
            NSLog(@"When setup db:%@",[error localizedDescription]);
        }
    }
    
    dbPointer = [[PLSqliteDatabase alloc] initWithPath:dbFilePath];
    
    sqlite3_shutdown();
    NSLog(@"sqlite3 lib version: %s", sqlite3_libversion());
    int err = sqlite3_config(SQLITE_CONFIG_SERIALIZED);
    if (err == SQLITE_OK) {
        NSLog(@"Can now use sqlite on multiple threads, using the same connection");
    }
    else {
        NSLog(@"setting sqlite thread safe mode to serialized failed!!! return code: %d", err);
    }
    
    BOOL dbStatus = [dbPointer open];
    
    NSLog(@"%d,%d",dbStatus,__LINE__);
    return dbPointer;
    
}

+(void) close
{
    if(dbPointer)
    {
        @try {
            [dbPointer close];
        }
        @catch (NSException * e)
        {
        }
        @finally {
            dbPointer = NULL;
        }
        
    }
}

/* 查询表是否存在 */
+(BOOL) isTableExist:(NSString*)tableName
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    return [db tableExists:tableName];
}

#ifdef LT_MERGE_FROM_IPAD_CLIENT
+(BOOL) isTable:(NSString *)tableName existCloum:(NSString *)cloumName
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
    if ([db tableExists:tableName]) {
        rs  = [db executeQuery:@"select sql from sqlite_master where tbl_name=? and type=?",tableName,@"table"];
        NSString *sqlStr = @"";
        while ([rs next])
        {
           
            if (![rs isNullForColumnIndex:0]) {
                sqlStr = [rs objectForColumnIndex:0];
            }
            
        }
        [rs close];
        NSRange range = [sqlStr rangeOfString:cloumName];
        if (range.location> 0 && range.length > 0) {
            return YES;
        }
    }
    return NO;
}
#endif

+(void) dropTable:(NSString*)tableName
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:tableName]) {
        NSString *executeString = [NSString stringWithFormat:@"drop table %@;", tableName];
        [db executeUpdate:executeString];
    }
}

+(void) dropDatabase
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *realPath =[documentPath stringByAppendingPathComponent:DBPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath: realPath error: nil];
}

+(void)updateDownloadHistoryFor38{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"LTDownloadHistory"]) {
        [db executeUpdate:LT_DB_CREATE_DOWNLOADHISTORY38];
    }
}

#ifdef LT_IPAD_CLIENT

/*
 V2.3 downloadhistory表增加vid,vtype字段
 */
+(void) updateFor23{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    update = [db executeUpdate:SQL_UPDATE23_ADD_VID];
    NSLog(@"vid updage %d", update);
    update = [db executeUpdate:SQL_UPDATE23_ADD_VTYPE];
    NSLog(@"vtype updage %d", update);
}

/*
 V2.6 downloadhistory表增加btime,etime,videocode字段
 */
+(void) updateFor26{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    update = [db executeUpdate:SQL_BOOTIMAGE];
    NSLog(@"table bootimage updage %d", update);
}

/*
 V2.6.1 downloadhistory表增加cid字段
 */
+(void) updateFor261{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    update = [db executeUpdate:SQL_UPDATE261_ADD_CID];
    NSLog(@"table cid updage %d", update);
    update = [db executeUpdate:SQL_UPDATE261_ADD_MAINTITLE];
    NSLog(@"table main_title updage %d", update);
}

+ (void) updateFor27
{
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    update = [db executeUpdate:SQL_SEARCHHISTORY];
    NSLog(@"search history %d", update);
}

+ (void) updateFor29
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    update = [db executeUpdate:SQL_UPDATE29_ADD_HISTORY_VIPPF];
    NSLog(@"history vpf update %d", update);
    update = [db executeUpdate:SQL_UPDATE29_ADD_HISTORY_VIPTAG];
    NSLog(@"history viptag update %d", update);
}

+(void) updateFor33{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    update = [db executeUpdate:SQL_ITUNESMOVIE];
    NSLog(@"table itunesmovie updage %d", update);
}

+(void) initFor21{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_HISTORY21];
    [db executeUpdate:SQL_DOWNLOADHISTORY21];
}

+(void)updateHistoryFor35 {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:@"history"]) {
        [db executeUpdate:SQL_ADD_HISORY_DEVICETYPE];
    }
}

+(void)updateBootImgFor38{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:@"bootimage"]) {
        [db executeUpdate:SQL_ADD_BOOTIMAGE_TYPE];
        [db executeUpdate:SQL_ADD_BOOTIMAGE_ID];
    }
}

#else

+(void) initDatabase{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *history = @"drop table history;";
    [db executeUpdate:history];
    [db executeUpdate:SQL_HISTORY23];
    //[db executeUpdate:SQL_UPDATE23_ADD_VTYPE];
    if (![db tableExists:@"searchhistory"]) {
        [db executeUpdate:SQL_SEARCHHISTORY38];
    }
}

// V2.3升级到V2.3.1
+(void) updateDatabaseFrom23To231{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *history = @"drop table history;";
    [db executeUpdate:history];
    [db executeUpdate:SQL_HISTORY23];
}

+(void) updateDownloadHistoryFor24
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_UPDATE24_DOWNLOAD_ADD_VTYPE];
}

+(void) updateHistoryFor24
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_UPDATE24_HISTORY_ADD_VID];
    [db executeUpdate:SQL_UPDATE24_HISTORY_ADD_VTYPE];
}

+(void) updateDownloadHistoryFor26
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_UPDATE26_HISTORY_ADD_QUALITY];
}

+(void)updateDatabaseFor21{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_SEARCHHISTORY];
    [db executeUpdate:SQL_UPDATE_FOR21_1];
    [db executeUpdate:SQL_UPDATE_FOR21_2];
    [db executeUpdate:SQL_UPDATE_FOR21_3];
    [db executeUpdate:SQL_UPDATE_FOR21_4];
}

+ (void)updateDownloadHistoryFor242
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:@"downloadHistory23"]) {
        [db executeUpdate:SQL_ADD_DOWNLOAD_BTIME];
        [db executeUpdate:SQL_ADD_DOWNLOAD_ETIME];
    }
}

/*
 V2.5 增加bootimage表
 */
+(void) updateFor25{
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"bootimage"]) {
        update = [db executeUpdate:SQL_BOOTIMAGE];
        NSLog(@"table bootimage update %d", update);
    }
}

+(void)updateHistoryFor25 {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:@"history"]) {
        [db executeUpdate:SQL_ADD_HISTORY_AT];
        [db executeUpdate:SQL_ADD_HISTORY_ALBUMTYPE];
    }
}

+(void)updateBootImgFor27{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:@"bootimage"]) {
        [db executeUpdate:SQL_ADD_BOOTIMAGE_TYPE];
        [db executeUpdate:SQL_ADD_BOOTIMAGE_ID];
    }
}

+(void)updateHistoryFor28{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:@"history"]) {
        [db executeUpdate:SQL_ADD_HISTORY_PAYFROM];
        [db executeUpdate:SQL_ADD_HISTORY_ALLOWMONTH];
        [db executeUpdate:SQL_ADD_HISTORY_PAYDATE];
        [db executeUpdate:SQL_ADD_HISTORY_SINGLEPRICE];
    }
}

/*
 V2.9 增加liveOrder表
 */
+(void)updateLiveOrderFor29{
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"liveOrder"]) {
        update = [db executeUpdate:SQL_LIVEORDER];
        NSLog(@"table liveOrder update %d", update);
    }
}

+(void) updateFor33{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"itunesmovie"]){
        update = [db executeUpdate:SQL_ITUNESMOVIE];
        NSLog(@"table itunesmovie updage %d", update);
    }
    
    if ([db tableExists:@"history"])
    {
        [db executeUpdate:SQL_ADD_HISTORY_PAY];
    }
}

+(void)updateHistoryFor35 {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:@"history"]) {
        [db executeUpdate:SQL_ADD_HISORY_DEVICETYPE];
    }
}

+(void)updateSearchHistoryFor38 {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *history = @"drop table searchHistory;";
    [db executeUpdate:history];
    
    [db executeUpdate:SQL_SEARCHHISTORY38];
}

#endif

+(void)updateHistoryFor38{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"ltPlayHistory"]) {
        [db executeUpdate:LT_DB_CREATE_HISTORY];
    }
}



+ (void) updateFor512
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_UPDATE512_ADD_DOWNLOADHISTORY_STOREPATH];
    update =[db executeUpdate:SQL_UPDATE512_ADD_DOWNLOADHISTORY_SUBICON];
    NSLog(@"downloadhistory storepath update %d", update);
}

+ (void) updateFor522
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_UPDATE522_ADD_DOWNLOADHISTORY_SIZE0];
    [db executeUpdate:SQL_UPDATE522_ADD_DOWNLOADHISTORY_SIZE1];
    update = [db executeUpdate:SQL_UPDATE522_ADD_DOWNLOADHISTORY_SIZE2];
    NSLog(@"downloadhistory download size 1 2 3 update %d", update);
}

+(void)updateLiveOrderFor53{
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"liveOrder"]) {
        update = [db executeUpdate:SQL_LIVEORDER];
        NSLog(@"table liveOrder update %d", update);
    }
}

+ (void)updatePlayHistoryFor55{
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if ([db tableExists:@"ltPlayHistory"]) {
        update = [db executeUpdate:SQL_UpdatePlayHistoryForAddColumn];
        
    }
    NSLog(@"ltPlayHistory ADD COLUMN deviceFrom  %d", update);
    
}

#ifdef LT_MERGE_FROM_IPAD_CLIENT
+ (void) updateDownloadHistoryFor55
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    update = [db executeUpdate:SQL_UPDATE55_ADD_DOWNLOADHISTORY_VIDEOTYPEKEY];
    update = [db executeUpdate:SQL_UPDATE55_ADD_DOWNLOADHISTORY_ISPALY];
    update = [db executeUpdate:SQL_UPDATE55_ADD_DOWNLOADHISTORY_DOWNLOAD];
    update = [db executeUpdate:SQL_UPDATE55_ADD_DOWNLOADHISTORY_BRLIST];
    update = [db executeUpdate:SQL_UPDATE55_ADD_DOWNLOADHISTORY_VIDEO_SINGLE_TYPE];
    update = [db executeUpdate:SQL_UPDATE55_ADD_DOWNLOADHISTORY_PIC_COLLECTIONS_TYPE];
    NSLog(@"downloadhistory videotypekey update %d", update);
}
#endif

+ (void) updateDownloadHistoryFor56
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_UPDATE56_ADD_DOWNLOADHISTORY_VIDEOTYPEKEY];
    [db executeUpdate:SQL_UPDATE56_ADD_DOWNLOADHISTORY_ISPALY];
    [db executeUpdate:SQL_UPDATE56_ADD_DOWNLOADHISTORY_DOWNLOAD];
    [db executeUpdate:SQL_UPDATE56_ADD_DOWNLOADHISTORY_BRLIST];
    [db executeUpdate:SQL_UPDATE56_ADD_DOWNLOADHISTORY_VIDEO_SINGLE_TYPE];
    update = [db executeUpdate:SQL_UPDATE56_ADD_DOWNLOADHISTORY_PIC_COLLECTIONS_TYPE];
    NSLog(@"downloadhistory videotypekey update %d", update);
}


+(void)updateLivingHistoryFor57
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"ltLivingPlayHistory"]) {
        [db executeUpdate:SQL_LIVINGPLAYHISTORY];
    }
    if (![db tableExists:@"livingHistory"]) {
        [db executeUpdate:SQL_LIVINGHISTORY];
    }
}

+(void)updateHistoryVidFor58{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"ltPlayHistoryVid"]) {
        [db executeUpdate:LT_DB_CREATE_HISTORY_VID];
    }
}

+(void)updateLivingHistoryFor581
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate:SQL_LIVINGHISTORY_ADD_FORMTYPE];
    update = [db executeUpdate:SQL_LIVINGPLAYHISTORY_ADD_FORMTYPE];
    NSLog(@" fromType update %d", update);
}

+(void)updatePlayHistoryFor582
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate: SQL_PLAYHISTORY_ADD_VIDEOKEY];
    update = [db executeUpdate: SQL_PLAYHISTORYVID_ADD_VIDEOKEY];

    NSLog(@" videoKey update %d", update);
}


+(void)updatePlayHistoryFor59
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate: SQL_PLAYHISTORY_ADD_NVID];
    update = [db executeUpdate: SQL_PLAYHISTORYVID_ADD_NVID];
    
    NSLog(@" nvid update %d", update);
}//
+(void)updatePlayHistoryFor615
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate: SQL_PLAYHISTORY_ADD_SHORTFLAG];
    update = [db executeUpdate: SQL_PLAYHISTORYVID_ADD_SHORTFLAG];
    [db executeUpdate: SQL_UPDATE615_ADD_SHORTFLAG];
    
    NSLog(@"shortFlag update %d", update);
}

+(void)updatePlayHistoryForIpad602
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db executeUpdate: SQL_PLAYHISTORY_ADD_PIC];
    update = [db executeUpdate: SQL_PLAYHISTORYVID_ADD_PIC];
    
    NSLog(@" nvid update %d", update);
}


+(void)updateLivingHistoryForIpad561
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"ltLivingPlayHistory"]) {
        [db executeUpdate:SQL_LIVINGPLAYHISTORY];
    }
    if (![db tableExists:@"livingHistory"]) {
        [db executeUpdate:SQL_LIVINGHISTORY];
    }
}

+(void)updateHistoryVidForIpad561{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"ltPlayHistoryVid"]) {
        [db executeUpdate:LT_DB_CREATE_HISTORY_VID];
    }
}


+(void)updatePadHistoryFor58
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    [db executeUpdate: SQL_UPDATE24_HISTORY_ADD_VID];
    update = [db executeUpdate: SQL_UPDATE60_ADD_HISTORY_LETVVERSION];
    
    NSLog(@" nvid update %d", update);
}

+(void)updateHistoryFor60
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];

    update = [db executeUpdate: SQL_UPDATE60_ADD_HISTORY_LETVVERSION];
    
    NSLog(@" nvid update %d", update);
}

+(void)updateDownLoadFor61
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    update = [db executeUpdate: SQL_UPDATE61_ADD_VARIETYSHOW];
    
    NSLog(@" varietyShow update %d", update);
    
    if (![db tableExists:@"LTDemandLoadingImage"]) {
        update = [db executeUpdate:SQL_CREATE_LTDEMANDLOADIMAGE];
        NSLog(@" varietyShow update %d", update);
    }
}

+ (void)updateDownLoadFor661
{
    NSLog(@"-----------%s--------------%d",__FUNCTION__,__LINE__);
    BOOL update = FALSE;
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    update = [db executeUpdate: SQL_UPDATE661_ADD_ISVIPDOWNLOAD];
}

+ (void)updateDownLoadFor67
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    [db executeUpdate:SQL_UPDATE67_ADD_AUDIOTRACK];

    [db executeUpdate:SQL_UPDATE67_ADD_SUBTITLDOWNLOADSTATUS];
    
    [db executeUpdate:SQL_UPDATE67_ADD_SUBTITLEKEY];
}

+ (BOOL)addMissingColumn:(NSString *)tableName missingColumnName:(NSString *)missingColumnName {
    if ([NSString empty:tableName] || [NSString empty:missingColumnName]) {
        return NO;
    }
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    if (![db tableExists:tableName]) {
        return NO;
    }
    
    NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ varchar(20) default '';", tableName, missingColumnName];
    
    BOOL result = [db executeUpdate:sql];
    
    return result;
}

@end
