//
//  DownloadHistory.m
//  LeTV
//
//  Created by guangliang shen on 10-9-6.
//  Copyright 2010 letv. All rights reserved.
//

#import "DownloadHistoryCommand.h"
//#import "NSObject+ObjectEmpty.h"
#import "LTDataCenter.h"

#ifndef LT_MERGE_FROM_IPAD_CLIENT
@implementation DownloadHistoryCommand
@synthesize ID;
@synthesize icon;  
@synthesize movieID; 
@synthesize p_id;
@synthesize intro;
@synthesize play_count; 
@synthesize time_length;  
@synthesize title; 
@synthesize url; 
@synthesize add_time;
@synthesize mmsid;
@synthesize sourceType;
@synthesize file_size;
@synthesize download_size;
@synthesize download_status;
@synthesize locale_file_path;
@synthesize data_type;
@synthesize tag_num;
@synthesize vid;
@synthesize br;
@synthesize databaseVersion;
@synthesize videoType;
@synthesize btime;
@synthesize etime;
@synthesize quality;
@synthesize aidTitle;

+(NSArray*)searchAllDatabase21{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
      NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([db tableExists:@"downloadHistory"]) {
        id<PLResultSet> rs;
        
        rs  = [db executeQuery:@"select * from downloadHistory Order By  ID desc"];      
        
        while ([rs next]) 
        {
            [dbArray addObject:[DownloadHistoryCommand wrappResultSetDatabase21:rs]];
        }
        [rs close];
    }

	return dbArray;
}

+(NSArray*)searchAll{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([db tableExists:@"downloadHistory23"]) {
        id<PLResultSet> rs;
        
        rs  = [db executeQuery:@"select * from downloadHistory23 Order By  ID desc"];
        
        while ([rs next]) 
        {
            [dbArray addObject:[DownloadHistoryCommand wrappResultSet:rs]];
        }
        [rs close];
    }    

	return dbArray;
}

+(NSArray*)searchAllByStatus:(NSArray *)_status {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	NSString *inSql = [NSString string];
	for (int i=0;i<[_status count];i++){
		if (i<[_status count]-1) {
			inSql = [inSql stringByAppendingFormat:@" download_status='%@' or ",[_status objectAtIndex:i]];
		}else {
			inSql = [inSql stringByAppendingFormat:@" download_status='%@' ",[_status objectAtIndex:i]];
		}		
	}
	NSString *sql = @"select * from downloadHistory23 ";
	if ([_status count]>0) {
		sql = [sql stringByAppendingFormat:@" where %@ ",inSql];
	}
	sql = [sql stringByAppendingString:@"Order By  ID asc"];	
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([db tableExists:@"downloadHistory23"]) {
        rs  = [db executeQuery:sql];
        while ([rs next]) 
        {		
            [dbArray addObject:[DownloadHistoryCommand wrappResultSet:rs]];		
        }
        [rs close];
    }

	return dbArray;
}


+ (NSArray *)searchAllByStatus:(NSArray *)_status andMovieID:(NSString *)movieID
{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	NSString *inSql = [NSString string];
	for (int i=0;i<[_status count];i++){
		if (i<[_status count]-1) {
			inSql = [inSql stringByAppendingFormat:@" download_status='%@' or ",[_status objectAtIndex:i]];
		}else {
			inSql = [inSql stringByAppendingFormat:@" download_status='%@' ",[_status objectAtIndex:i]];
		}
	}
	NSString *sql = @"select * from downloadHistory23 ";
	if ([_status count]>0) {
		sql = [sql stringByAppendingFormat:@" where %@ and movie_id = '%@'",inSql,movieID];
	}
	sql = [sql stringByAppendingString:@"Order By  ID asc"];
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([db tableExists:@"downloadHistory23"]) {
        rs  = [db executeQuery:sql];
        while ([rs next])
        {
            [dbArray addObject:[DownloadHistoryCommand wrappResultSet:rs]];
        }
        [rs close];
    }
    
	return dbArray;    
}

+(NSArray*)searchAllDownloading{
	NSArray *_status = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",DownloadStatusWait],[NSString stringWithFormat:@"%d",DownloadStatusDownloading],[NSString stringWithFormat:@"%d",DownloadStatusError],[NSString stringWithFormat:@"%d",DownloadStatusPause],
        [NSString stringWithFormat:@"%d",DownloadStatusBackground],nil];
	return [DownloadHistoryCommand searchAllByStatus:_status];
}
+(NSArray*)searchAllDownloadComplete{
	NSArray *_status = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",DownloadStatusComplete],nil];
	return [DownloadHistoryCommand searchAllByStatus:_status];
}

+(NSArray *)searchAllDownloadCompleteByMovieID:(NSString *)movieID
{
    NSArray *_status = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",DownloadStatusComplete],nil];
    return [DownloadHistoryCommand searchAllByStatus:_status andMovieID:movieID];
}

+(NSArray*)searchAllWaiting{
	NSArray *_status = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",DownloadStatusWait],nil];
	return [DownloadHistoryCommand searchAllByStatus:_status];
}
+(NSArray*)searchAllWithOption:(int) _count{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	
	rs  = [db executeQuery:@"select * from downloadHistory23  Order By ID Desc limit ?",[NSNumber numberWithInt:_count]];
	
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
	
	while ([rs next]) 
	{
		[dbArray addObject:[DownloadHistoryCommand wrappResultSet:rs]];
	}
	
	[rs close];
	return dbArray;
	
}

+(NSArray*)searchAllForAttribute:(NSString*)attribute 
                          column:(NSString*)_column 
                     columnValue:(NSString*)_columnValue
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	
    NSString *inSql = [NSString stringWithFormat:@"select %@ from downloadHistory23 where %@ = '%@' ",attribute,_column,_columnValue];
	rs  = [db executeQuery:inSql];
	
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
	
	while ([rs next]) 
	{
		[dbArray addObject:[rs objectForColumn:attribute]];
	}
	[rs close];
	return dbArray;
}

+(id) searchByID:(int)_id{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	NSString *sql = [NSString stringWithFormat:@"select * from downloadHistory23 where ID = %d limit 1",_id];
	
	id<PLResultSet> rs;
	rs = [db executeQuery:sql];
	
	DownloadHistoryCommand *com = nil;
	if([rs next])
	{
		com = [DownloadHistoryCommand wrappResultSet:rs];				
	}
	[rs close];
	return com;
}
+(id) searchByMovieID:(NSString *)_movie_id{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	NSString *sql = [NSString stringWithFormat:@"select * from downloadHistory23 where movie_id = '%@' limit 1",_movie_id];
	
	id<PLResultSet> rs;
	rs = [db executeQuery:sql];
	
	DownloadHistoryCommand *com = nil;
	if([rs next])
	{
		com = [DownloadHistoryCommand wrappResultSet:rs];
	}
	
	[rs close];
	return com;
}

+(id) searchByMMSID:(NSString *)_mmsID{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	NSString *sql = [NSString stringWithFormat:@"select * from downloadHistory23 where mmsid = '%@' limit 1",_mmsID];
	
	id<PLResultSet> rs;
	rs = [db executeQuery:sql];
	
	DownloadHistoryCommand *com = nil;
	if([rs next])
	{
		com = [DownloadHistoryCommand wrappResultSet:rs];
	}
	
	[rs close];
	return com;
}

+(id)searchByMovieID:(NSString *)_movie_id andVid:(NSString*)_vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select * from downloadHistory23 where movie_id = '%@' and vid = '%@'", _movie_id, _vid];
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
	DownloadHistoryCommand *com = nil;
	if([rs next])
	{
		com = [DownloadHistoryCommand wrappResultSet:rs];
	}
	
	[rs close];
	return com;
}

+(NSString*)searchPlayUrlByMovieID:(NSString *)_movie_id andVid:(NSString*)_vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select locale_file_path from downloadHistory23 where movie_id = '%@' and vid = '%@' and download_status = '4'", _movie_id, _vid];
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

+(NSInteger)getQualityByMovieID:(NSString *)_movie_id vid:(NSString*)_vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select quality from downloadHistory23 where movie_id = '%@' and vid = '%@' and download_status = '4'", _movie_id, _vid];
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    NSString *result = @"";
	if([rs next])
	{
        result = [rs objectForColumn:@"quality"];
	}
	[rs close];
    
	return [result integerValue];
}

+(int) count{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	int count = 0;
	
	id<PLResultSet> rs;
	rs = [db executeQuery:@"select count(*) as count from downloadHistory23"];
	
	if([rs next])
	{
		count = [[rs objectForColumn:@"count"] intValue];
	}
	
	[rs close];
	return count;
}
+(int) count:(NSString *)_download_status{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	int count = 0;
	
	id<PLResultSet> rs;
	rs = [db executeQuery:@"select count(*) as count from downloadHistory23 where download_status=?",_download_status];
	
	if([rs next])
	{
		count = [[rs objectForColumn:@"count"] intValue];
	}
	
	[rs close];
	return count;
}
+(int) countWithFilePath:(NSString *)_file_path{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	int count = 0;
	
	id<PLResultSet> rs;
	rs = [db executeQuery:@"select count(*) as count from downloadHistory23 where locale_file_path=?",_file_path];
	
	if([rs next])
	{
		count = [[rs objectForColumn:@"count"] intValue];
	}
	
	[rs close];
	return count;
}

+(int) count21{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	int count = 0;
	if ([db tableExists:@"downloadHistory"]) {
        id<PLResultSet> rs;
        rs = [db executeQuery:@"select count(*) as count from downloadHistory"];
	
        if([rs next])
        {
            count = [[rs objectForColumn:@"count"] intValue];
        }
	
        [rs close];
    }
	return count;
}

//+(int) createTable{
//	PLSqliteDatabase *db = [SqlDBHelper setUp];
// 	[db executeUpdate:@"drop table downloadHistory;"];
//    [db executeUpdate:@" create table downloadHistory (id  integer primary key ,icon,movie_id,p_id,intro,play_count,time_length,title,url,file_size,download_size,download_status,locale_file_path,add_time,task_serial);"];
//	return 0;
//}

#pragma mark cfxiao:编译通不过，没有调用，先注释掉
//+(int) insertWithIcon:(NSString*)_icon
//              MovieID:(NSString*)_movieID
//                 P_ID:(NSString*)_p_ID
//                Intro:(NSString*)_intro
//           Play_Count:(NSString*)_play_count
//          Time_Length:(NSString*)_time_length
//                Title:(NSString*)_title
//                  Url:(NSString*)_url
//                MMSID:(NSString*)_mmsid
//            File_Size:(NSString *)_file_size
//        Download_Size:(NSString *)_download_size
//      Download_Status:(NSString *)_download_status
//     Locale_File_Path:(NSString *)_locale_file_path	
//              Tag_Num:(NSString *)_tag_num
//           SourceType:(NSString *)_sourceType
//                  Vid:(NSString*)_vid 
//            DbVersion:(NSString*)_dbVersion
//                Vtype:(NSInteger)_vtype
//                Btime:(NSString*)_btime
//                Etime:(NSString*)_etime
//                Quality:(NSString*)_quality
//                AidTitle:(NSString*)_aidTitle{
//    if([DownloadHistoryCommand movieCount:_mmsid] != 0)
//	{
//		[DownloadHistoryCommand deleteByMMSID:_mmsid];
//	}
//	PLSqliteDatabase *db = [SqlDBHelper setUp];
//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//	NSString *_add_time = [formatter stringFromDate:[NSDate date]];
//	BOOL bResult = [db executeUpdate:@"INSERT INTO downloadHistory23(icon,movie_id,p_id,intro,play_count,time_length,title,url,file_size,download_size,download_status,locale_file_path,add_time,mmsid,tag_num,sourceType,vid,dbVersion,vtype,btime,etime, quality, aidtitle) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
//					[NSString safeString:_icon],
//                    [NSString safeString:_movieID],
//                    [NSString safeString:_p_ID],
//                    [NSString safeString:_intro],
//                    [NSString safeString:_play_count],
//                    [NSString safeString:_time_length],
//                    [NSString safeString:_title],
//                    [NSString safeString:_url],
//                    [NSObject empty:_file_size] ? @"0" : [NSString safeString:_file_size],
//                    [NSString safeString:_download_size],
//                    [NSString safeString:_download_status],
//                    [NSString safeString:_locale_file_path],
//                    [NSString safeString:_add_time],
//                    [NSString safeString:_mmsid],
//                    [NSString safeString:_tag_num],
//                    [NSString safeString:_sourceType],
//                    [NSString safeString:_vid],
//                    [NSString safeString:_dbVersion],
//                    [NSString stringWithFormat:@"%ld",(long)_vtype],
//                    [NSString safeString:_btime],
//                    [NSString safeString:_etime],
//                    [NSString safeString:_quality],
//                    [NSString safeString:_aidTitle]];
//    
//	if (!bResult)
//    {
//        [LTDataCenter addErrorDataWithAid:_movieID
//                                      vid:_vid
//                                    title:_title
//                                videoType:[NSString stringWithFormat:@"%ld",(long)_vtype]
//                              originalUrl:@""
//                                    ddUrl:@""
//                                   action:ERROR_ACT_DOWNLOAD
//                               error_type:ERROR_DOWNLOAD];
//    }
//    else
//    {
//        [GlobalInterface updateDownloadBadgeValue];
//    }
//	return bResult;
//}

+(int) deleteByMovieID21:(NSString *)_movie_id {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate: @"DELETE FROM downloadHistory WHERE movie_id=?",_movie_id];
	return bResult;
}


+(int) delete:(NSString *)_movie_id {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate: @"DELETE FROM downloadHistory23 WHERE movie_id=?",_movie_id];
	return bResult;
}

+(int) deleteByID:(int)_id {
	PLSqliteDatabase *db = [SqlDBHelper setUp];	
	BOOL bResult = [db executeUpdate: @"DELETE FROM downloadHistory23 WHERE id = ?",[NSNumber numberWithInt: _id]];
	return bResult;
}

+(int) deleteByMMSID:(NSString *)_mmsid {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate: @"DELETE FROM downloadHistory23 WHERE mmsid=?",_mmsid];
	return bResult;
}

+(int) movieCount:(NSString *)_mmsid {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	rs = [db executeQuery:@"select count(*) as count from downloadHistory23 where mmsid = ? ",_mmsid];
	if([rs next]) {
		NSString *_count = [rs objectForColumn:@"count"];
        if ([NSObject empty:_count]) {
            return 0;
        }
		return [_count intValue];
	}
	return 0;
}

+(int) update:(NSString *)_mmsid DownloadSize:(NSString*)_download_size {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate:@"update downloadHistory23 set download_size=? where mmsid = ?",
					_download_size,
					_mmsid];
	return bResult;
}

+(int) update:(NSString *)_mmsid	DownloadStatus:(NSString*)_download_status{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = NO;
    if ([db tableExists:@"downloadHistory23"]) {
       bResult  = [db executeUpdate:@"update downloadHistory23 set download_status=? where mmsid = ?",
                        _download_status,_mmsid];
    }

	return bResult;
}

+(int)update:(NSString *)_mmsid codeRate:(VideoCodeType)codeRate {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate:@"update downloadHistory23 set quality=? where mmsid = ?",
                    [NSString stringWithFormat:@"%d", codeRate], _mmsid];
    
	return bResult;
}


+(int) updateForStartAllDownload{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	NSString *sql = [NSString stringWithFormat:@"update downloadHistory23 set download_status='%d' where download_status in ('%d','%d')",
					 DownloadStatusWait,DownloadStatusPause,DownloadStatusError];
	BOOL bResult = [db executeUpdate:sql];
	return bResult;
}
+(int) updateForStartAllDownloading{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	NSString *sql = [NSString stringWithFormat:@"update downloadHistory23 set download_status='%d' where download_status in ('%d','%d')",
					 DownloadStatusWait,DownloadStatusDownloading,DownloadStatusError];
	BOOL bResult = [db executeUpdate:sql];
	return bResult;
}

+(int)updateDownloadUrl:(NSString *)_mmsid url:(NSString*)_url {
   	PLSqliteDatabase *db = [SqlDBHelper setUp];
	//NSString *sql = [NSString stringWithFormat:@"update downloadHistory23 set url=? where mmsid = ?",
	//				 _url,_mmsid];
	BOOL bResult = [db executeUpdate:@"update downloadHistory23 set url=? where mmsid = ?",
                    [NSString safeString:_url], _mmsid];
	return bResult; 
}

+(int)update:(NSString *)_mmsid download_url:(NSString *)url file_size:(NSString *)_file_size{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	NSString *sql = [NSString stringWithFormat:@"update downloadHistory23 set url='%@',file_size='%@' where mmsid = '%@'" ,
                     url,_file_size,
                     _mmsid];
    BOOL bResult = [db executeUpdate:sql];
    
	return bResult;
}

+(int) update:(NSString *)_mmsid	DbVersion:(NSString*)_version {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate:@"update downloadHistory23 set dbVersion=? where mmsid = ?",
					_version,_mmsid];
	return bResult;
}

+(int) update:(NSString *)_mmsid field:(NSString *)_field FieldValue:(NSString *)_field_value{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	NSString *sql = [NSString stringWithFormat:@"update downloadHistory23 set %@='%@' where mmsid = '%@'",
					 _field,_field_value,_mmsid];
	BOOL bResult = [db executeUpdate:sql];
	return bResult;
}

+(int) processDataForInitAndTerminate{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = NO;
    if ([db tableExists:@"downloadHistory23"]) {
        NSString *sql = [NSString stringWithFormat:@"update downloadHistory23 set download_status='%d' where download_status = '%d' or download_status = '%d' or download_status = '%d'",
                         DownloadStatusPause,
                         DownloadStatusDownloading,
                         DownloadStatusWait,
                         DownloadStatusError];
//        NSLog(@"--SQL--%@",sql);
        bResult = [db executeUpdate:sql];
    }
	return bResult;
}

+ (long long)searchAllDownloadedSize {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
////////////////////////////////
    long long space = 0;
    if ([db tableExists:@"downloadHistory23"]) {
        rs  = [db executeQuery:@"select download_size from downloadHistory23 Order By  ID desc"];
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

+ (long long)searchAllDownloadFileSize {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
    ////////////////////////////////
    long long space = 0;
    if ([db tableExists:@"downloadHistory23"]) {
        rs  = [db executeQuery:@"select file_size from downloadHistory23 Order By  ID desc"];
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

// 获取letv选择下载文件中已经下载文件总大小
+(NSNumber*)leTvDownloadedTotalSpace {
	return [NSNumber numberWithLongLong:[DownloadHistoryCommand searchAllDownloadedSize]];
}

// 获取letv选择下载文件容量总大小
+(NSNumber*)leTvDownloadFileSizeTotalSpace
{
    return [NSNumber numberWithLongLong:[DownloadHistoryCommand searchAllDownloadFileSize]];
}

+(DownloadHistoryCommand *)wrappResultSet:(id<PLResultSet>)rs{
	int _ID = 0;
    if (![rs isNullForColumn:@"ID"]) {
        _ID = [[rs objectForColumn:@"ID"] intValue];
    }    
	NSString *_icon = [rs objectForColumn:@"icon"];
	NSString *_movieID = [rs objectForColumn:@"movie_id"];
	NSString *_p_ID = [rs objectForColumn:@"p_id"];
	NSString *_intro = [rs objectForColumn:@"intro"];
	NSString *_play_count = [rs objectForColumn:@"play_count"];
	NSString *_time_length = [rs objectForColumn:@"time_length"];
	NSString *_title = [rs objectForColumn:@"title"];
	NSString *_url = [rs objectForColumn:@"url"];
	NSString *_add_time = [rs objectForColumn:@"add_Time"];
	NSString *_mmsid = [rs objectForColumn:@"mmsid"];
	NSString *_file_size = [rs objectForColumn:@"file_size"];
	NSString *_download_size = [rs objectForColumn:@"download_size"];
	NSString *_download_status = [rs objectForColumn:@"download_status"];	
	NSString *_locale_file_path = [rs objectForColumn:@"locale_file_path"];	
	NSString *_tag_num = @"";
    @try {
        _tag_num = [NSString safeString:[rs objectForColumn:@"tag_num"]];
    }
    @catch (NSException *exception) {
        NSLog(@"exception");
    }
    @finally {
        
    }
	NSString *_sourceType = [rs objectForColumn:@"sourceType"];
    NSString *_vid = [rs objectForColumn:@"vid"];
    NSString *_br = [rs objectForColumn:@"br"];    
    NSString *_vtype = [rs objectForColumn:@"vtype"];    
    NSString *_btime = [rs objectForColumn:@"btime"];
    NSString *_etime = [rs objectForColumn:@"etime"];
    NSString *_quality = [rs objectForColumn:@"quality"];   
    NSString *_databaseVersion = [rs objectForColumn:@"dbVersion"];
    NSString *_aidTitle = [rs objectForColumn:@"aidtitle"];

	DownloadHistoryCommand *com = [[DownloadHistoryCommand alloc] initWithID:_ID 
                                                                        Icon:_icon 
                                                                     MovieID:_movieID
                                                                        P_ID:_p_ID 
                                                                       Intro:_intro 
                                                                  Play_Count:_play_count 
                                                                 Time_Length:_time_length 
                                                                       Title:_title
								                                         Url:_url 
                                                                    Add_Time:_add_time 
                                                                       MMSID:_mmsid 
                                                                   File_Size:_file_size 
                                                               Download_Size:_download_size
								                             Download_Status:_download_status 
                                                            Locale_File_Path:_locale_file_path 
                                                                     Tag_Num:_tag_num 
                                                                  SourceType:_sourceType
                                                                         Vid:(NSString*)_vid 
                                                                   DbVersion:_databaseVersion
                                                                       Vtype:_vtype
                                                                          Br:_br
                                                                       Btime:_btime 
                                                                       Etime:_etime
                                                                      Quality:_quality
                                                                        AidTitle:_aidTitle];
	
	return com;
}

+(DownloadHistoryCommand *)wrappResultSetDatabase21:(id<PLResultSet>)rs{
	int _ID = 0;
    if (![rs isNullForColumn:@"ID"]) {
        _ID = [[rs objectForColumn:@"ID"] intValue];
    }    
	NSString *_icon = [rs objectForColumn:@"icon"];
	NSString *_movieID = [rs objectForColumn:@"movie_id"];
	NSString *_p_ID = [rs objectForColumn:@"p_id"];
	NSString *_intro = [rs objectForColumn:@"intro"];
	NSString *_play_count = [rs objectForColumn:@"play_count"];
	NSString *_time_length = [rs objectForColumn:@"time_length"];
	NSString *_title = [rs objectForColumn:@"title"];
	NSString *_url = [rs objectForColumn:@"url"];
	NSString *_add_time = [rs objectForColumn:@"add_Time"];
	NSString *_mmsid = [rs objectForColumn:@"mmsid"];
	NSString *_file_size = [rs objectForColumn:@"file_size"];
	NSString *_download_size = [rs objectForColumn:@"download_size"];
	NSString *_download_status = [rs objectForColumn:@"download_status"];	
	NSString *_locale_file_path = [rs objectForColumn:@"locale_file_path"];	
    
	DownloadHistoryCommand *com = [[DownloadHistoryCommand alloc] initWithID:_ID 
                                                                        Icon:_icon 
                                                                     MovieID:_movieID
                                                                        P_ID:_p_ID 
                                                                       Intro:_intro 
                                                                  Play_Count:_play_count 
                                                                 Time_Length:_time_length 
                                                                       Title:_title
                                                                         Url:_url 
                                                                    Add_Time:_add_time
                                                                       MMSID:_mmsid 
                                                                   File_Size:_file_size 
                                                               Download_Size:_download_size
                                                             Download_Status:_download_status 
                                                            Locale_File_Path:_locale_file_path 
                                                                     Tag_Num:@"" 
                                                                  SourceType:@""
                                                                         Vid:@"" 
                                                                   DbVersion:@"21"
                                                                       Vtype:@"0"
                                                                          Br:@""
                                                                       Btime:@"" 
                                                                       Etime:@""
                                                                      Quality:@"0"
                                                                    AidTitle:@""];
	
	return com;
}


-(id)initWithID:(int)_id
           Icon:(NSString*)_icon
        MovieID:(NSString*)_movieID
           P_ID:(NSString*)_p_ID
          Intro:(NSString*)_intro
     Play_Count:(NSString*)_play_count
    Time_Length:(NSString*)_time_length
          Title:(NSString*)_title
            Url:(NSString*)_url
       Add_Time:(NSString*)_add_time
          MMSID:(NSString*)_mmsid
      File_Size:(NSString *)_file_size
  Download_Size:(NSString *)_download_size
Download_Status:(NSString *)_download_status
Locale_File_Path:(NSString *)_locale_file_path
        Tag_Num:(NSString *)_tag_num
     SourceType:(NSString *)_sourceType
            Vid:(NSString*)_vid 
      DbVersion:(NSString*)_dbVersion
          Vtype:(NSString*)_vtype
             Br:(NSString*)_br
          Btime:(NSString*)_btime
          Etime:(NSString*)_etime
         Quality:(NSString*)_quality
       AidTitle:(NSString*)_aidTitle
{
	if(self = [super init])
	{
		self.ID = _id;
		self.icon = [NSString safeString:_icon];
		self.movieID = [NSString safeString:_movieID];
		self.p_id = [NSString safeString:_p_ID];
		self.intro = [NSString safeString:_intro];
		self.play_count = [NSObject empty:_play_count] ? @"0" : [NSString safeString:_play_count];
		self.time_length = [NSString safeString:_time_length];
		self.title = [NSString safeString:_title];
		self.url = [NSString safeString:_url];
		self.add_time = [NSString safeString:_add_time];
		self.mmsid = [NSString safeString:_mmsid];
		self.file_size = [NSObject empty:_file_size] ? @"0" : _file_size;
		self.download_size = [NSObject empty:_download_size] ? @"0" :  _download_size;
		self.download_status = [NSString safeString:_download_status];
		self.locale_file_path = [NSString safeString:_locale_file_path];		
		self.sourceType = [NSString safeString:_sourceType];
		self.tag_num = [NSString safeString:_tag_num];
        self.vid = [NSString safeString:_vid];
        self.databaseVersion = [NSString safeString:_dbVersion];
        self.videoType = [NSString safeString:_vtype];
        self.br = [NSString safeString:_br];
        self.btime = [NSObject empty:_btime] ? @"0" : _btime;
        self.etime = [NSObject empty:_etime] ? @"0" : _etime;
        self.quality = [NSObject empty:_quality] ? @"0" : _quality;
        self.aidTitle = [NSString safeString:_aidTitle];
	}
	return self;
}


@end


#else

@implementation DownloadHistoryCommand

@synthesize ID, icon, movieID, v_id, c_id, intro, title, mainTitle, url, add_time, mmsid, sourceType,
file_size, download_size, download_status, locale_file_path, data_type, video_type, btime, etime, videCodeType, vippf, viptag;


+(NSArray*)searchAll{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:@"select * from downloadHistory Order By  ID desc"];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        [dbArray addObject:[DownloadHistoryCommand wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

+(NSArray*)searchAllForMovieId
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select * from downloadHistory"];
    rs  = [db executeQuery:inSql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    NSMutableArray *movieIdArray = [[NSMutableArray alloc] initWithCapacity:0];
    BOOL isFold = NO;
    DownloadHistoryCommand *downloadInfo = nil;
    
    while ([rs next])
    {
        downloadInfo = [DownloadHistoryCommand wrappResultSet:rs];
        isFold = (      [downloadInfo.c_id integerValue] == NewCID_TV
                  ||    [downloadInfo.c_id integerValue] == NewCID_Anime
                  ||    [downloadInfo.c_id integerValue] == NewCID_LetvProduce);
        
        if (!([movieIdArray containsObject:downloadInfo.movieID] && isFold)) {
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjects:@[@(isFold), downloadInfo]
                                                                                 forKeys:@[@"isFold", @"downloadInfo"]];
            [dbArray addObject:dictionary];
            [movieIdArray addObject:(isFold)?downloadInfo.movieID:downloadInfo.mmsid];
        }
    }
    [rs close];
    NSArray *array = [NSMutableArray arrayWithObjects:dbArray, movieIdArray, nil];
    //    NSLog(@"%d   %d",[dbArray retainCount],[movieIdArray retainCount]);
    return array;
}

+(NSArray*)searchAllForSubFolderMovieId:(NSString*)movieId
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    DownloadHistoryCommand *downloadInfo = nil;
    NSMutableArray *subDownloadArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *subMmsidArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *inSql = [NSString stringWithFormat:@"select * from downloadHistory where movie_id = '%@' ",movieId];
    rs  = [db executeQuery:inSql];
    
    while ([rs next])
    {
        downloadInfo = [DownloadHistoryCommand wrappResultSet:rs];
        if (![NSString isBlankString:downloadInfo.c_id]) {
            [subDownloadArray addObject:downloadInfo];
            [subMmsidArray addObject:downloadInfo.mmsid];
        }
    }
    [rs close];
    
    NSArray *subFolderArray = [NSMutableArray arrayWithObjects:subDownloadArray, subMmsidArray, nil];
    return subFolderArray;
}

+(NSArray*)searchAllForAttribute:(NSString*)attribute
                          column:(NSString*)_column
                     columnValue:(NSString*)_columnValue
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select %@ from downloadHistory where %@ = '%@' ",attribute,_column,_columnValue];
    rs  = [db executeQuery:inSql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        [dbArray addObject:[rs objectForColumn:attribute]];
    }
    [rs close];
    return dbArray;
}

+(NSArray*)searchForAttribute:(NSString*)attribute
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select %@ from downloadHistory",attribute];
    rs  = [db executeQuery:inSql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        [dbArray addObject:[rs objectForColumn:attribute]];
    }
    [rs close];
    return dbArray;
}

+(NSArray*)searchAllForColumn:(NSString*)_column
                  columnValue:(NSString*)_columnValue
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *inSql = [NSString stringWithFormat:@"select * from downloadHistory where %@ = '%@' ",_column,_columnValue];
    rs  = [db executeQuery:inSql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        [dbArray addObject:[DownloadHistoryCommand wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

+(NSArray*)searchAllByStatus:(NSArray *)_status {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    NSString *inSql = [NSString string];
    for (int i=0;i<[_status count];i++){
        if (i<[_status count]-1) {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' or ",_status[i]];
        }else {
            inSql = [inSql stringByAppendingFormat:@" download_status='%@' ",_status[i]];
        }
    }
    NSString *sql = @"select * from downloadHistory ";
    if ([_status count]>0) {
        sql = [sql stringByAppendingFormat:@" where %@ ",inSql];
    }
    sql = [sql stringByAppendingString:@"Order By  ID asc"];
    rs  = [db executeQuery:sql];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[DownloadHistoryCommand wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

+(NSArray*)searchAllDownloading{
    NSArray *_status = @[[NSString stringWithFormat:@"%d",DownloadStatusWait],[NSString stringWithFormat:@"%d",DownloadStatusDownloading],[NSString stringWithFormat:@"%d",DownloadStatusError],[NSString stringWithFormat:@"%d",DownloadStatusPause]];
    return [DownloadHistoryCommand searchAllByStatus:_status];
}

+(NSArray*)searchAllDownloadComplete{
    NSArray *_status = @[[NSString stringWithFormat:@"%d",DownloadStatusComplete]];
    return [DownloadHistoryCommand searchAllByStatus:_status];
}

//根据key:mmsid搜索
+(id) searchByMMSID:(NSString *)_mmsid{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select * from downloadHistory where mmsid = '%@' limit 1",_mmsid];
    
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    
    DownloadHistoryCommand *com = nil;
    if([rs next])
    {
        com = [DownloadHistoryCommand wrappResultSet:rs];
    }
    
    [rs close];
    return com;
}

+(id)searchByMovieID:(NSString *)_movie_id andVid:(NSString*)_vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select * from downloadHistory where movie_id = '%@' and vid = '%@' limit 1", _movie_id, _vid];
    
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    
    DownloadHistoryCommand *com = nil;
    if([rs next])
    {
        com = [DownloadHistoryCommand wrappResultSet:rs];
    }
    
    [rs close];
    return com;
}


+(id) searchByMovieID:(NSString *)_movieId{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"select * from downloadHistory where movie_id = '%@' limit 1",_movieId];
    
    id<PLResultSet> rs;
    rs = [db executeQuery:sql];
    
    DownloadHistoryCommand *com = nil;
    if([rs next])
    {
        com = [DownloadHistoryCommand wrappResultSet:rs];
    }
    
    [rs close];
    return com;
}

+(int) count{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    rs = [db executeQuery:@"select count(*) as count from downloadHistory"];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

+(int) countForColumn:(NSString*)_column
          columnValue:(NSString*)_columnValue
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    
    rs = [db executeQuery:[NSString stringWithFormat:@"select count(*) as count from downloadHistory where %@ = '%@' ",_column,_columnValue]];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

+ (long long)totalSizeForSubFolder:(NSString*)_movieId {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    long long totalSize = 0;
    
    rs = [db executeQuery:[NSString stringWithFormat:
                           @"select file_size from downloadHistory where movie_id = '%@' and cid != ''",
                           _movieId]];
    
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

+ (long long)downloadedSizeForSubFolder:(NSString*)_movieId {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    long long downloadedSize = 0;
    
    rs = [db executeQuery:[NSString stringWithFormat:
                           @"select download_size from downloadHistory where movie_id = '%@' and cid != ''",
                           _movieId]];
    
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

+(int) countForSubFolder:(NSString*)_movieId
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    
    rs = [db executeQuery:[NSString stringWithFormat:@"select count(*) as count from downloadHistory where movie_id = '%@' and cid != ''",_movieId]];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

+(int) countForSubFolderColumnArray:(NSArray*)_columnArray
                   columnValueArray:(NSArray*)_columnValueArray
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    NSString *mainSql = @"select count(*) as count from downloadHistory";
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
        paraSql = [paraSql stringByAppendingFormat:@" cid !=''"];
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

+(int) count:(NSString *)_download_status{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    rs = [db executeQuery:@"select count(*) as count from downloadHistory where download_status=?",_download_status];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

+(int) insertWithIcon:(NSString*)_icon
              MovieID:(NSString*)_movieID
                 V_ID:(NSString*)_v_ID
                 C_ID:(NSString*)_c_ID
                Intro:(NSString*)_intro
                Title:(NSString*)_title
            MainTitle:(NSString*)_mainTitle
                  Url:(NSString*)_url
                MMSID:(NSString*)_mmsid
            File_Size:(NSString *)_file_size
        Download_Size:(NSString *)_download_size
      Download_Status:(NSString *)_download_status
     Locale_File_Path:(NSString *)_locale_file_path
           SourceType:(NSString *)_sourceType
            VideoType:(NSInteger)_videoType
                BTime:(NSInteger)_btime
                ETime:(NSInteger)_etime
        VideoCodeType:(VideoCodeType)_videoCodeType
                vippf:(NSString *)_vippf
               viptag:(NSString *)_viptag{
    
    if([DownloadHistoryCommand movieCountByMMSID:_mmsid] != 0)
    {
        [DownloadHistoryCommand deleteByMMSID:_mmsid];
    }
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_add_time = [formatter stringFromDate:[NSDate date]];
    BOOL bResult = [db executeUpdate:@"INSERT INTO downloadHistory(icon,movie_id,vid,cid,intro,title,main_title,down_url,file_size,download_size,download_status,locale_file_path,add_time,mmsid,sourceType,vtype,btime,etime,videocode,vippf,viptag) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    _icon,
                    _movieID,
                    _v_ID,
                    _c_ID,
                    _intro,
                    _title,
                    _mainTitle,
                    _url,
                    _file_size,
                    _download_size,
                    _download_status,
                    _locale_file_path,
                    _add_time,
                    _mmsid,
                    _sourceType,
                    [NSString stringWithFormat:@"%d", _videoType],
                    [NSString stringWithFormat:@"%d", _btime],
                    [NSString stringWithFormat:@"%d", _etime],
                    [NSString stringWithFormat:@"%d", _videoCodeType],
                    _vippf,
                    _viptag
                    ];
    if (!bResult) {
        [LTDataCenter addErrorDataWithAid:_movieID
                                      vid:_v_ID
                                    title:_title
                                videoType:[NSString stringWithFormat:@"%d",_videoType]
                              originalUrl:@""
                                    ddUrl:@""
                                   action:ERROR_ACT_DOWNLOAD
                               error_type:ERROR_DOWNLOAD];
    }
    
    return bResult;
}

+(int) delete:(NSString *)_movie_id {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate: @"DELETE FROM downloadHistory WHERE movie_id=?",_movie_id];
    return bResult;
}

+(int) deleteByID:(int)_id {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate: @"DELETE FROM downloadHistory WHERE id = ?",@(_id)];
    return bResult;
}
//依据key:mmsid搜索
+(int) deleteByMMSID:(NSString *)_mmsid {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate: @"DELETE FROM downloadHistory WHERE mmsid=?",_mmsid];
    return bResult;
}

//依据key:mmsid获取数量
+(int) movieCountByMMSID:(NSString *)_mmsid {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    rs = [db executeQuery:@"select count(*) as count from downloadHistory where mmsid = ? ",_mmsid];
    if([rs next]) {
        NSString *_count = [rs objectForColumn:@"count"];
        return [_count intValue];
    }
    return 0;
}

//依据key:MMSID更新数据库
+(int) update:(NSString *)_mmsid DownloadSize:(NSString*)_download_size {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update downloadHistory set download_size=? where mmsid = ?",
                    _download_size,
                    _mmsid];
    return bResult;
}

+(int) update:(NSString *)_mmsid	DownloadStatus:(NSString*)_download_status{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update downloadHistory set download_status=? where mmsid = ?",
                    _download_status,_mmsid];
    return bResult;
}

+(int) update:(NSString *)_mmsid FinishTime:(NSString*)time {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update downloadHistory set finishtime=? where mmsid = ?",
                    time, _mmsid];
    return bResult;
}

+(int) update:(NSString *)_mmsid field:(NSString *)_field FieldValue:(NSString *)_field_value{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"update downloadHistory set %@='%@' where mmsid = '%@'",
                     _field,_field_value,_mmsid];
    BOOL bResult = [db executeUpdate:sql];
    return bResult;
}

+(int) updateForPre23:(NSString *)_mmsid vid:(NSString *)_vid vtype:(NSInteger)_vtype
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"update downloadHistory set vid='%@',vtype='%@' where mmsid='%@'",
                     _vid,[NSString stringWithFormat:@"%d", _vtype],_mmsid];
    BOOL bResult = [db executeUpdate:sql];
    
    return bResult;
}

+(int)update:(NSString *)_mmsid download_url:(NSString *)url file_size:(NSString *)_file_size{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"update downloadHistory set down_url='%@',file_size='%@' where mmsid = '%@'" ,
                     url,_file_size,
                     _mmsid];
    BOOL bResult = [db executeUpdate:sql];
    
    return bResult;
}

+(int)update:(NSString *)_mmsid codeRate:(VideoCodeType)codeRate {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"update downloadHistory set videocode=? where mmsid = ?",
                    [NSString stringWithFormat:@"%d", codeRate], _mmsid];
    
    return bResult;
}

+(int) processDataForInitAndTerminate{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *sql = [NSString stringWithFormat:@"update downloadHistory set download_status='%d' where download_status = '%d' or download_status = '%d' or download_status = '%d'",
                     DownloadStatusPause,
                     DownloadStatusDownloading,
                     DownloadStatusWait,
                     DownloadStatusError];
    NSLog(@"--SQL--%@",sql);
    BOOL bResult = [db executeUpdate:sql];
    return bResult;
}

+(DownloadHistoryCommand *)wrappResultSet:(id<PLResultSet>)rs{
    int _ID = [[rs objectForColumn:@"ID"] intValue];
    NSString *_icon = @"";
    if (![rs isNullForColumn:@"icon"]) {
        _icon = [rs objectForColumn:@"icon"];
    }
    NSString *_movieID = @"";
    if (![rs isNullForColumn:@"movie_id"]) {
        _movieID = [rs objectForColumn:@"movie_id"];
    }
    
    NSString *_v_ID = @"";
    if (![rs isNullForColumn:@"vid"]) {
        _v_ID = [rs objectForColumn:@"vid"];
    }
    
    NSString *_c_ID = @"";
    if (![rs isNullForColumn:@"cid"]) {
        _c_ID = [rs objectForColumn:@"cid"];
    }
    
    NSString *_intro = @"";
    if (![rs isNullForColumn:@"intro"]) {
        _intro = [rs objectForColumn:@"intro"];
    }
    
    NSString *_title = @"";
    if (![rs isNullForColumn:@"title"]) {
        _title = [rs objectForColumn:@"title"];
    }
    
    NSString *_mainTitle = @"";
    if (![rs isNullForColumn:@"main_title"]) {
        _mainTitle = [rs objectForColumn:@"main_title"];
    }
    
    NSString *_url = @"";
    if (![rs isNullForColumn:@"down_url"]) {
        _url = [rs objectForColumn:@"down_url"];
    }
    
    NSString *_add_time = @"";
    if (![rs isNullForColumn:@"add_Time"]) {
        _add_time = [rs objectForColumn:@"add_Time"];
    }
    NSString *_mmsid = @"";
    if (![rs isNullForColumn:@"mmsid"]) {
        _mmsid = [rs objectForColumn:@"mmsid"];
    }
    
    NSString *_file_size = @"";
    if (![rs isNullForColumn:@"file_size"]) {
        _file_size = [rs objectForColumn:@"file_size"];
    }
    
    NSString *_download_size = @"";
    if (![rs isNullForColumn:@"download_size"]) {
        _download_size = [rs objectForColumn:@"download_size"];
    }
    
    NSString *_download_status = @"";
    if (![rs isNullForColumn:@"download_status"]) {
        _download_status = [rs objectForColumn:@"download_status"];
    }
    NSString *_locale_file_path = @"";
    if (![rs isNullForColumn:@"locale_file_path"]) {
        _locale_file_path = [rs objectForColumn:@"locale_file_path"];
    }
    
    NSString *_sourceType = @"";
    if (![rs isNullForColumn:@"sourceType"]) {
        _sourceType = [rs objectForColumn:@"sourceType"];
    }
    
    NSString *_videoType = @"";
    if (![rs isNullForColumn:@"vtype"]) {
        _videoType = [rs objectForColumn:@"vtype"];
    }
    
    int _btime = 0;
    if (![rs isNullForColumn:@"btime"]) {
        _btime = [[rs objectForColumn:@"btime"] intValue];
    }
    int _etime = 0;
    if (![rs isNullForColumn:@"etime"]) {
        _etime = [[rs objectForColumn:@"etime"] intValue];
    }
    
    int _videoCodeType = 0;
    if (![rs isNullForColumn:@"videocode"]) {
        _videoCodeType = [[rs objectForColumn:@"videocode"] intValue];
    }
    
    NSString *_vippf = @"";
    if (![rs isNullForColumn:@"vippf"]) {
        _vippf = [rs objectForColumn:@"vippf"];
    }
    
    NSString *_viptag = @"";
    if (![rs isNullForColumn:@"viptag"]) {
        _viptag = [rs objectForColumn:@"viptag"];
    }
    
    DownloadHistoryCommand *com = [[DownloadHistoryCommand alloc] initWithID:_ID
                                                                        Icon:_icon
                                                                     MovieID:_movieID
                                                                        V_ID:_v_ID
                                                                        C_ID:_c_ID
                                                                       Intro:_intro
                                                                       Title:_title
                                                                   MainTitle:_mainTitle
                                                                         Url:_url
                                                                    Add_Time:_add_time
                                                                       MMSID:_mmsid
                                                                   File_Size:_file_size
                                                               Download_Size:_download_size
                                                             Download_Status:_download_status
                                                            Locale_File_Path:_locale_file_path
                                                                  SourceType:_sourceType
                                                                   VideoType:_videoType
                                                                       BTime:_btime
                                                                       ETime:_etime
                                                               VideoCodeType:_videoCodeType
                                                                       vippf:_vippf
                                                                      viptag:_viptag];
    
    return com;
}


// 获取letv选择缓存文件中已经缓存文件总大小
+(NSNumber*)leTvDownloadedTotalSpace {
    return @([DownloadHistoryCommand searchAllDownloadedSize]);
}

// 获取letv选择缓存文件容量总大小
+(NSNumber*)leTvDownloadFileSizeTotalSpace
{
    return @([DownloadHistoryCommand searchAllDownloadFileSize]);
}


+ (long long)searchAllDownloadedSize {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    ////////////////////////////////
    long long space = 0;
    if ([db tableExists:@"downloadHistory"]) {
        rs  = [db executeQuery:@"select download_size from downloadHistory Order By  ID desc"];
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

+ (long long)searchAllDownloadFileSize {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    ////////////////////////////////
    long long space = 0;
    if ([db tableExists:@"downloadHistory"]) {
        rs  = [db executeQuery:@"select file_size from downloadHistory Order By  ID desc"];
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

-(id)initWithID:(int)_id
           Icon:(NSString*)_icon
        MovieID:(NSString*)_movieID
           V_ID:(NSString*)_v_ID
           C_ID:(NSString*)_c_ID
          Intro:(NSString*)_intro
          Title:(NSString*)_title
      MainTitle:(NSString*)_mainTitle
            Url:(NSString*)_url
       Add_Time:(NSString*)_add_time
          MMSID:(NSString*)_mmsid
      File_Size:(NSString *)_file_size
  Download_Size:(NSString *)_download_size
Download_Status:(NSString *)_download_status
Locale_File_Path:(NSString *)_locale_file_path	
     SourceType:(NSString *)_sourceType 
      VideoType:(NSString *)_videoType
          BTime:(NSInteger)_btime
          ETime:(NSInteger)_etime
  VideoCodeType:(VideoCodeType)_videoCodeType
          vippf:(NSString *)_vippf
         viptag:(NSString *)_viptag{
    if(self = [super init])
    {
        self.ID = _id;
        self.icon = _icon;
        self.movieID = _movieID;
        self.v_id = _v_ID;
        self.c_id = _c_ID;
        self.intro = _intro;
        self.title = _title;
        self.mainTitle = _mainTitle;
        self.url = _url;
        self.add_time = _add_time;
        self.mmsid = _mmsid;
        self.file_size = _file_size;
        self.download_size = _download_size;
        self.download_status = _download_status;
        self.locale_file_path = _locale_file_path;
        self.sourceType = _sourceType;
        self.video_type = _videoType;
        self.btime = _btime;
        self.etime = _etime;
        self.videCodeType = _videoCodeType;
        self.vippf = _vippf;
        self.viptag = _viptag;
    }
    return self;
}

@end

#endif