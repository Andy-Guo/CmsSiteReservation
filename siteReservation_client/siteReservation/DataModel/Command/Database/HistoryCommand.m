//
//  HistoryCommand.m
//  iphone & ipad
//
//  Refactored by Guoyi You on 16/6/30.
//  Copyright 2016 le.com All rights reserved.
//


#import "HistoryCommand.h"
#import "SqlDBHelper.h"
#import "PushCommand.h"
#import "LTCloudFollowModel.h"
#import "VideoModel.h"
#import "LTDataModelEngine.h"
#import "FavouriteCloudModel.h"
#define FROM_TYPE @"3"

typedef NS_ENUM(NSInteger, FAV_PARAM_TYPE)
{
    FAV_PARAM_PID,
    FAV_PARAM_VID,
};

@implementation HistoryCommand

+(NSArray*)searchAll:(NSInteger)from count:(NSInteger)count{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM history Order By add_Time Desc limit %ld,%ld",(long)from,(long)count];
    rs  = [db executeQuery:sql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[self wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

#pragma mark - localFav : isExistedFavorite
//收藏: 根据dataType和movieID返回结果
+(MovieInfo*)searchByMovieId:(NSString *)movieID
                 andDataType:(NSString*)dataType {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;	
	rs  = [db executeQuery:@"SELECT * FROM history WHERE data_type = ? AND movie_ID = ? ",dataType, movieID];
	
    MovieInfo *movieInfo = nil;
	while ([rs next]) {				
		movieInfo = [self wrappResultSet:rs];
	}	    
	[rs close];
	return movieInfo;	
}

//v5.3新添加
+(MovieInfo*)searchByMovieIdOrPid:(NSString *)movieID andDataType:(NSString *)dataType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	rs  = [db executeQuery:@"SELECT * FROM history WHERE data_type = ? AND movie_ID = ? ",dataType, movieID];
	
    MovieInfo *movieInfo = nil;
	while ([rs next]) {
		movieInfo = [self wrappResultSet:rs];
	}
    if (movieInfo == nil) {
        rs = [db executeQuery:@"SELECT * FROM history WHERE data_type = ? AND p_ID = ? ",dataType, movieID];
            while ([rs next]) {
		movieInfo = [self wrappResultSet:rs];
	   }
    }
	[rs close];
	return movieInfo;
}

// 返回是否加入收藏/追剧，并且根据updateStatus更新DB中的收藏/追剧
+(NSString *)getFavAndFollowStatusByMovieId:(NSString *)movieID
                            andUpdateStatus:(Boolean)bUpdating {
    
    Boolean bAlreadyFav = NO;
    Boolean bAlreadyFollow = NO;
    if (nil != [HistoryCommand searchByMovieId:movieID
                                   andDataType:DATA_TYPE_FAVORITE]) {
        bAlreadyFav = YES;
    }
    else if([HistoryCommand searchByMovieId:movieID
                                andDataType:DATA_TYPE_FOLLOW]){
        bAlreadyFollow = YES;
    }
    if (    bAlreadyFav 
        &&  bUpdating) {
        // 移到追剧
        if ([HistoryCommand updateDataType:DATA_TYPE_FAVORITE
                                toDataType:DATA_TYPE_FOLLOW
                                 byMovieId:movieID]) {
            bAlreadyFav = NO;
            bAlreadyFollow = YES;
        }
    }
    else if(    bAlreadyFollow 
            &&  !bUpdating){
        // 移到收藏
        if ([HistoryCommand updateDataType:DATA_TYPE_FOLLOW
                                toDataType:DATA_TYPE_FAVORITE
                                 byMovieId:movieID]) {
            bAlreadyFav = YES;
            bAlreadyFollow = NO;
        }
    }
    
    if (bAlreadyFav) {
        return DATA_TYPE_FAVORITE;
    }    
    
    if (bAlreadyFollow) {
        return DATA_TYPE_FOLLOW;
    }
    
    return @"";
    
}

#pragma mark - deprecated method : move follow item to favorite
//追剧：上传最近10条记录到云端
+ (void)submitToCloudByFavWithFinishBlock:(void (^)())finishBlock
{
    if(     ![NetworkReachability connectedToNetwork]
       ||   ![SettingManager isUserLogin]){
        if (finishBlock) {
            finishBlock();
        }
        return;
    }
    NSMutableArray * allArray = (NSMutableArray *)[HistoryCommand searchAll];
    NSLog(@"%@",allArray);
    NSMutableArray *historyArray = (NSMutableArray *)[HistoryCommand searchByFavCount:10];
    if (!historyArray
        ||  historyArray.count <= 0) {
        if (finishBlock) {
            finishBlock();
        }
        return;
    }
    NSMutableString * dataString = [[NSMutableString alloc] initWithString:@""];
    for(int i = 0;i < [historyArray count];i++){
        MovieInfo * favHistory = [historyArray objectAtIndex:i];
        if (i > 0) {
            [dataString appendString:@"|"];
        }
        [dataString appendString:(NSMutableString *)[NSString safeString:favHistory.cid] ];
        [dataString appendString:@","];
        [dataString appendString:(NSMutableString *)[NSString safeString:favHistory.p_ID]];
        [dataString appendString:@","];
        [dataString appendString:(NSMutableString *)[NSString safeString:favHistory.movie_ID]];
        [dataString appendString:@","];
        NSString * dataType = @"1";
        if ([favHistory.cid isEqualToString:@"2"]||[favHistory.cid isEqualToString:@"5"]) {//2和5为电视剧和动漫，这两个频道是追剧
            dataType = @"2";
        }
        [dataString appendString:dataType];
        if ([NSString isBlankString:favHistory.lastRecordTime] ) {
            continue;
        }
        [dataString appendString:@","];
        NSTimeInterval timeInterval = [[HistoryCommand NSStringToNSDate:favHistory.lastRecordTime] timeIntervalSince1970];
        [dataString appendFormat:@"%.f",timeInterval];
    }
    
    NSArray *arrayParamValues = @[[SettingManager userCenterTVToken],[DeviceManager getDeviceUUID],
                                  [SettingManager alreadyLoginUserID]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    //    [params setObject:[SettingManager userCenterTVToken] forKey:@"sso_tk"];
    //    [params setObject:[NSNumber numberWithInteger:3] forKey:@"platform"];
    [params setObject:dataString forKey:@"data"];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_SubmitFavriteMore
                               andDynamicValues:arrayParamValues
                                  andHttpMethod:@"POST"
                                  andParameters:params
                              completionHandler:^(NSDictionary *responseDic) {
                                  if (![NSObject empty:responseDic]) {
                                      NSDictionary *header=[responseDic valueForKey:@"header"];
                                      if (![NSObject empty:header]) {
                                          NSString *status= [header valueForKey:@"status"];
                                          if ([status isEqualToString:@"1"]) {
                                              // 批量上传播放记录成功后，立即删除本地播放记录
                                              
                                              // 批量操作放到一个事务中
                                              PLSqliteDatabase *db = [SqlDBHelper setUp];
                                              [db beginTransaction];
                                              
                                              for(MovieInfo *playHistory in historyArray){
                                                  [HistoryCommand deleteByMovieID:playHistory.movie_ID andDataType:DATA_TYPE_FAVORITE];
                                              }
                                              
                                              [db commitTransaction];
                                              
                                              // 接着上传
                                              NSInteger countOfHistory = [HistoryCommand countByDataType:DATA_TYPE_FAVORITE];
                                              if (countOfHistory > 0) {
                                                  [HistoryCommand submitToCloudByFavWithFinishBlock:finishBlock];
                                              }
                                              else{
                                                  if (finishBlock) {
                                                      finishBlock();
                                                  }
                                              }
                                          }else  if ([status integerValue] == DataStatusTokenExpired) {
                                              //token 过期处理
                                              //                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"showToast"
                                              //                                                                                                  object:NSLocalizedString(@"请重新登录", @"请重新登录")];
                                              [SettingManager resetUserInfo];
                                          }
                                          if (finishBlock) {
                                              finishBlock();
                                          }
                                          
                                      }
                                      else
                                      {
                                          if (finishBlock) {
                                              finishBlock();
                                          }
                                      }
                                      
                                  }
                                  else
                                  {
                                      if (finishBlock) {
                                          finishBlock();
                                      }
                                  }
                                  
                              } errorHandler:^(NSError *error) {
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              }];
    return;
    
}

//追剧：更新追剧列表    ..v5.3
+ (void)updateDBWithCloudWithFinishBlock:(void (^)())finishBlock{}
//{
//    if(     ![NetworkReachability connectedToNetwork]
//       ||   ![SettingManager isUserLogin]){
//        if (finishBlock) {
//            finishBlock();
//        }
//        return;
//    }
//    
//    NSString *uid = [SettingManager alreadyLoginUserID];
//    NSString *token = [SettingManager userCenterTVToken];
//    if (    [NSString isBlankString:uid]
//        ||  [NSString isBlankString:token]) {
//        if (finishBlock) {
//            finishBlock();
//        }
//        return;
//    }
//    
//    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_GetAllFavrite
//                               andDynamicValues:@[token]
//                                    isNeedCache:NO
//                                  andHttpMethod:@"GET"
//                                  andParameters:nil
//                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
//                                  
//                                  NSDictionary * dict = bodyDict[@"result"];
//                                  
//                                  NSDictionary * data = dict[@"data"];
//                                  NSInteger mCode = [dict[@"code"] intValue];
//                                  NSLog(@"%@",dict);
//                                  if (mCode == 200) {
//                                      LTCloudFollowModel *cloudFollowData = [[LTCloudFollowModel alloc] initWithDictionary:data error:nil];
//                                      if (nil != cloudFollowData) {
//                                          // 批量操作放到同一个事务中
//                                          PLSqliteDatabase *db = [SqlDBHelper setUp];
//                                          [db beginTransaction];
//                                          
//                                          //                                      [HistoryCommand deleteByDataType:DATA_TYPE_FAVORITE];
//                                          for (LTCloudFollowItemModel *cloudItem in cloudFollowData.list) {
//                                              MovieInfo * mMovieInfo = [cloudItem wrapResultSet];
//                                              MovieInfo * sMovieInfo = [HistoryCommand searchByMovieId:mMovieInfo.movie_ID andDataType:DATA_TYPE_FAVORITE];
//                                              if (sMovieInfo==nil) {
//                                                  [HistoryCommand insertWithMovieInfo:mMovieInfo];
//                                              }
//                                              else
//                                              {
//                                                  [HistoryCommand update:mMovieInfo];
//                                              }
//                                              
//                                          }
//                                          [db commitTransaction];
//                                          if (finishBlock) {
//                                              finishBlock();
//                                          }
//                                      }
//                                      else
//                                      {
//                                          if (finishBlock) {
//                                              finishBlock();
//                                          }
//                                      }
//                                      
//                                  }
//                                  else
//                                  {
//                                      if (finishBlock) {
//                                          finishBlock();
//                                      }
//                                  }
//                              } nochangeHandler:^{
//                                  if (finishBlock) {
//                                      finishBlock();
//                                  }
//                              } emptyHandler:^{
//                                  if (finishBlock) {
//                                      finishBlock();
//                                  }
//                              } tokenExpiredHander:^{
//                                  [SettingManager resetUserInfo];
//                                  if (finishBlock) {
//                                      finishBlock();
//                                  }
//                              } errorHandler:^(NSError *error) {
//                                  if (finishBlock) {
//                                      finishBlock();
//                                  }
//                              }];
//}

//移动已存在“追剧” 到 “收藏”
+(BOOL) updateDataType:(NSString *)dataTypeSrc
            toDataType:(NSString *)dataTypeDes
             byMovieId:(NSString *)movieId {
    
    if (    [NSString isBlankString:dataTypeSrc]
        ||  [NSString isBlankString:dataTypeDes]
        ||  [NSString isBlankString:movieId]
        ||  [dataTypeDes isEqualToString:dataTypeSrc]) {
        return YES;
    }
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    int count = 0;
    id<PLResultSet> rs;
    rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM history WHERE data_type = ? AND movie_ID =? ",dataTypeSrc, movieId];
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    [rs close];
    
    if (count <= 0) {
        return NO;
    }
    
    BOOL bResult = NO;;
    BOOL bToDoDBAction = NO;
    if ([dataTypeSrc isEqualToString:DATA_TYPE_FOLLOW]) {
        bToDoDBAction = [PushCommand delTVUpdatePush:movieId];
        if (!bToDoDBAction) {
            return NO;
        }
    }
    else if([dataTypeDes isEqualToString:DATA_TYPE_FOLLOW]){
        bToDoDBAction = [PushCommand addTVUpdatePush:movieId];
        if (!bToDoDBAction) {
            return NO;
        }
    }
    
    bResult = [db executeUpdate:@"UPDATE history set data_type=? where movie_ID = ? and data_type = ?",
               dataTypeDes,
               movieId,
               dataTypeSrc];
    if (!bResult) {
        if ([dataTypeSrc isEqualToString:DATA_TYPE_FOLLOW]) {
            [PushCommand addTVUpdatePush:movieId];
        }
        else if([dataTypeDes isEqualToString:DATA_TYPE_FOLLOW]){
            [PushCommand delTVUpdatePush:movieId];
        }
    }
    
    return bResult;
    
}

+ (NSArray *)searchByFavCount:(NSInteger)count {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
    rs  = [db executeQuery:
           @"SELECT * FROM History Order By add_Time Desc limit ?",
           [NSString stringWithFormat:@"%ld", (long)count]];
    
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
	while ([rs next])
	{
		[dbArray addObject:[self wrappResultSet:rs]];
	}
	[rs close];
    
	return dbArray;
}



+(BOOL)deleteByDataType:(NSString *)dataType
              andMovieId:(NSString *)movieid{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    Boolean bPushFlag = [dataType isEqualToString:DATA_TYPE_FOLLOW];
    Boolean bToDoDBAction = YES;
    if (bPushFlag) {
        bToDoDBAction = [PushCommand delTVUpdatePush:movieid];
    }
    if (!bToDoDBAction) {
        return NO;
    }
    
	BOOL bResult = [db executeUpdate: @"DELETE FROM history WHERE data_type = ? AND movie_ID = ?",dataType, movieid];
    if (bPushFlag && !bResult) {
        // igore the result
        [PushCommand addTVUpdatePush:movieid];
    }
    
	return bResult;
}



//delete item from local db
+(BOOL)deleteByMovieID:(NSString *)movieID
            andDataType:(NSString *)dataType {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    Boolean bPushFlag = [dataType isEqualToString:DATA_TYPE_FOLLOW];
    Boolean bToDoDBAction = YES;
    if (bPushFlag) {
        bToDoDBAction = [PushCommand delTVUpdatePush:movieID];
    }
    if (!bToDoDBAction) {
        return NO;
    }
    
    BOOL bResult = [db executeUpdate:@"DELETE FROM history WHERE movie_ID = ? AND data_type = ?", movieID, dataType];
    if (bPushFlag && !bResult) {
        // igore the result
        [PushCommand addTVUpdatePush:movieID];
    }
    
    return bResult;
    
}



#pragma mark -- local db
//local db 清空
+(BOOL)deleteByDataType:(NSString *)dataType{
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    BOOL bResult;
    Boolean bPushFlag = [dataType isEqualToString:DATA_TYPE_FOLLOW];
    Boolean bToDoDBAction = YES;
    if (bPushFlag) {
        bToDoDBAction = [PushCommand cleanTVUpdatePush];
    }
    if (!bToDoDBAction) {
        return NO;
    }
    
    bResult = [db executeUpdate: @"DELETE FROM history WHERE data_type = ?",dataType];
    if (bPushFlag && !bResult) {
        // igore ,, fixme
    }
    return bResult;
}

//local db tables maintenance, contains Favorite and PlayHistory
+(BOOL)deleteAutoByDataType:(NSString *)dataType{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];	
	BOOL bResult = NO;
    
    if ([dataType isEqualToString:DATA_TYPE_HISTORY]){
        bResult = [db executeUpdate: @"DELETE FROM history  WHERE id in (SELECT id FROM (SELECT id, add_Time FROM history WHERE data_type = ? ORDER BY add_Time ASC limit 10 ))",dataType];
    }
    else if([dataType isEqualToString:DATA_TYPE_FAVORITE]){
        bResult = [db executeUpdate: @"DELETE FROM history  WHERE id in (SELECT id FROM history WHERE data_type = ? ORDER BY id ASC limit 10 )",dataType];
    }
    else if([dataType isEqualToString:DATA_TYPE_FOLLOW]){
        // fixme 追剧
        NSString *movieid = @"";
        NSString *dataType = @"";
        id<PLResultSet> rs;
        rs = [db executeQuery:@"SELECT movie_ID, data_type FROM history WHERE id in (SELECT id FROM history WHERE data_type = ? ORDER BY id ASC limit 1)", 
              dataType];	
        if([rs next]) {
            movieid = [rs objectForColumn:@"movie_ID"];
            dataType = [rs objectForColumn:@"data_type"];
        }
        else{
            return NO;
        }
        Boolean bToDoDBAction = [PushCommand delTVUpdatePush:movieid];
        if (!bToDoDBAction) {
            return NO;
        }

        bResult = [db executeUpdate: @"DELETE FROM history  WHERE id in (SELECT id FROM history WHERE data_type = ? ORDER BY id ASC limit 1)",dataType];
        
        if (!bResult) {
            // igore the result
            [PushCommand addTVUpdatePush:movieid];
        }
    }
    
	return bResult;
}

+(BOOL)deleteByID:(NSInteger)ID {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSString *movieid = @"";
    NSString *dataType = @"";
    id<PLResultSet> rs;
    NSString *sql_search = @"SELECT movie_ID, data_type FROM history WHERE id = ?";
    
    rs = [db executeQuery: sql_search, [NSString stringWithFormat:@"%ld",(long)ID]];
    
    if([rs next]) {
        movieid = [rs objectForColumn:@"movie_ID"];
        dataType = [rs objectForColumn:@"data_type"];
    } else {
        return NO;
    }
    Boolean bPushFlag = [dataType isEqualToString:DATA_TYPE_FOLLOW];
    Boolean bToDoDBAction = YES;
    if (bPushFlag) {
        bToDoDBAction = [PushCommand delTVUpdatePush:movieid];
    }
    if (!bToDoDBAction) {
        return NO;
    }
    
    NSString *sql_delete = @"DELETE FROM history WHERE id = %ld";
    BOOL bResult = [db executeUpdate:[NSString stringWithFormat: sql_delete, (long)ID]];
    if (bPushFlag && !bResult) {
        // igore the result
        [PushCommand addTVUpdatePush:movieid];
    }
    return bResult;
}

#pragma mark -- count current item in local db
+(int)countByMovieID:(NSString *)movieID
             andVType:(NSInteger)vType
           byDataType:(NSString *)dataType {
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	int count = 0;	
	id<PLResultSet> rs;
    if (vType < 0) {
        rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM history WHERE data_type = ? AND movie_ID = ? ",
              dataType,
              movieID];	
    }
    else{
        rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM history WHERE data_type = ? AND movie_ID = ? AND odumIndex = ?",
                  dataType,
                  movieID,
                  [NSString stringWithFormat:@"%ld", (long)vType]];
    }

	if([rs next])
	{
		count = [[rs objectForColumn:@"count"] intValue];
	}	
	[rs close];
	return count;
}


+(int)countByDataType:(NSString *)dataType {
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	int count = 0;	
	id<PLResultSet> rs;
	rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM history WHERE data_type = ? ",dataType];	
	if([rs next])
	{
		count = [[rs objectForColumn:@"count"] intValue];
	}	
	[rs close];
	return count;
}

+(MovieInfo *)wrappResultSet:(id<PLResultSet>)rs {

#ifdef LT_IPAD_CLIENT 
    if (rs) {
        MovieInfo *movieInfo = [[MovieInfo alloc] init];
        
        movieInfo.ID = [rs isNullForColumn:@"ID"] ? 0 : [[rs objectForColumn:@"ID"] intValue];
        
        movieInfo.movie_ID = [rs isNullForColumn:@"movie_ID"] ? @"" : [rs objectForColumn:@"movie_ID"];
        
    //	movieInfo.v_ID = [rs isNullForColumn:@"p_ID"] ? @"" : [rs objectForColumn:@"p_ID"];
        movieInfo.v_ID = [rs isNullForColumn:@"vid"] ? @"" : [rs objectForColumn:@"vid"];
        movieInfo.p_ID = [rs isNullForColumn:@"p_ID"] ? @"" : [rs objectForColumn:@"p_ID"];
        movieInfo.mmsID = [rs isNullForColumn:@"mmsID"] ? @"" : [rs objectForColumn:@"mmsID"];
        
        movieInfo.title = [rs isNullForColumn:@"title"] ? @"" : [rs objectForColumn:@"title"];	
        
        movieInfo.icon = [rs isNullForColumn:@"icon"] ? @"" : [rs objectForColumn:@"icon"];
        
        movieInfo.time_length = [rs isNullForColumn:@"time_length"] ? @"" : [rs objectForColumn:@"time_length"];
        
        movieInfo.play_times = [rs isNullForColumn:@"play_times"] ? @"" : [rs objectForColumn:@"play_times"];	
        
        movieInfo.intro = [rs isNullForColumn:@"intro"] ? @"" : [rs objectForColumn:@"intro"];
        
        movieInfo.sourceType = [rs isNullForColumn:@"sourceType"] ? @"" : [rs objectForColumn:@"sourceType"];	
        
        movieInfo.lp_url = [rs isNullForColumn:@"lp_url"] ? @"" : [rs objectForColumn:@"lp_url"];
        
        movieInfo.hp_url = [rs isNullForColumn:@"hp_url"] ? @"" : [rs objectForColumn:@"hp_url"];	
        
        movieInfo.tags = [rs isNullForColumn:@"tags"] ? @"" : [rs objectForColumn:@"tags"];
        
        movieInfo.release_year = [rs isNullForColumn:@"release_year"] ? @"" : [rs objectForColumn:@"release_year"];	
        
        movieInfo.director = [rs isNullForColumn:@"director"] ? @"" : [rs objectForColumn:@"director"];
        
        movieInfo.actor = [rs isNullForColumn:@"actor"] ? @"" : [rs objectForColumn:@"actor"];	
        
        movieInfo.score = [rs isNullForColumn:@"score"] ? @"" : [rs objectForColumn:@"score"];
        
        movieInfo.movie_cate = [rs isNullForColumn:@"movie_cate"] ? @"" : [rs objectForColumn:@"movie_cate"];	
        
        movieInfo.movie_area = [rs isNullForColumn:@"movie_area"] ? @"" : [rs objectForColumn:@"movie_area"];
        
        movieInfo.data_type = [rs isNullForColumn:@"data_type"] ? @"" : [rs objectForColumn:@"data_type"];
        
        movieInfo.cid = [rs isNullForColumn:@"cid"] ? @"" : [rs objectForColumn:@"cid"];
        
        movieInfo.offset =  [rs isNullForColumn:@"offset"] ? 0 :[rs intForColumn:@"offset"];
        
        movieInfo.vType = [rs isNullForColumn:@"odumIndex"] ? 0 :[rs intForColumn:@"odumIndex"];
        
        movieInfo.needpay = [rs isNullForColumn:@"vippf"] ? NO : [[rs objectForColumn:@"vippf"] boolValue];
        
        movieInfo.viptag = [rs isNullForColumn:@"viptag"] ? @"" : [rs objectForColumn:@"viptag"];
        
        movieInfo.lastRecordTime = [rs isNullForColumn:@"add_Time"] ? @"" : [rs objectForColumn:@"add_Time"];
        
        movieInfo.deviceFromType = [rs isNullForColumn:@"deviceType"] ? DEVICE_FROM_PAD : [[rs objectForColumn:@"deviceType"]intValue];
        movieInfo.favVersion = [rs isNullForColumn:@"letv_version"] ? @"0" : [rs objectForColumn:@"letv_version"];
        
        [[self class] setStarAndSingerInfo:movieInfo];
        
        return movieInfo;
    }
    return nil;
#else
    if (rs) {
        MovieInfo *movieInfo = [[MovieInfo alloc] init];
        
        movieInfo.ID = [[rs objectForColumn:@"ID"] intValue];
        movieInfo.movie_ID = [NSString safeString:[rs objectForColumn:@"movie_ID"]];
        movieInfo.p_ID = [NSString safeString:[rs objectForColumn:@"p_ID"]];
        movieInfo.mmsID = [NSString safeString:[rs objectForColumn:@"mmsID"]];
        movieInfo.cid = [NSString safeString:[rs objectForColumn:@"cid"]];
        movieInfo.title = [NSString safeString:[rs objectForColumn:@"title"]];
        movieInfo.icon = [NSString safeString:[rs objectForColumn:@"icon"]];
        movieInfo.time_length = [NSString safeString:[rs objectForColumn:@"time_length"]];
        movieInfo.curr_time = [NSString safeString:[rs objectForColumn:@"current_time"]];
        movieInfo.play_times = [NSString safeString:[rs objectForColumn:@"play_times"]];
        movieInfo.intro = [NSString safeString:[rs objectForColumn:@"intro"]];
        movieInfo.sourceType = [NSString safeString:[rs objectForColumn:@"sourceType"]];
        movieInfo.lp_url = [NSString safeString:[rs objectForColumn:@"lp_url"]];
        movieInfo.hp_url = [NSString safeString:[rs objectForColumn:@"hp_url"]];
        movieInfo.tags = [NSString safeString:[rs objectForColumn:@"tags"]];
        movieInfo.release_year = [NSString safeString:[rs objectForColumn:@"release_year"]];
        movieInfo.director = [NSString safeString:[rs objectForColumn:@"director"]];
        movieInfo.actor = [NSString safeString:[rs objectForColumn:@"actor"]];
        movieInfo.score = [NSString safeString:[rs objectForColumn:@"score"]];
        movieInfo.movie_cate = [NSString safeString:[rs objectForColumn:@"movie_cate"]];
        movieInfo.movie_area = [NSString safeString:[rs objectForColumn:@"movie_area"]];
        movieInfo.data_type = [NSString safeString:[rs objectForColumn:@"data_type"]];
        movieInfo.tag_num = [NSString safeString:[rs objectForColumn:@"other_ID"]];
        movieInfo.updating = [NSString safeString:[rs objectForColumn:@"update_status"]];
        movieInfo.v_ID = [NSString safeString:[rs objectForColumn:@"vid"]];
        movieInfo.videoType = [rs isNullForColumn:@"vtype"] ? 0 :[rs intForColumn:@"vtype"];
        movieInfo.atTag = [NSString safeString:[rs objectForColumn:@"at"]];
        movieInfo.albumType=[NSString safeString:[rs objectForColumn:@"albumtype"]];
        movieInfo.payfrom=[NSString safeString:[rs objectForColumn:@"payfrom"]];
        movieInfo.allowmonth=[NSString safeString:[rs objectForColumn:@"allowmonth"]];
        movieInfo.paydate=[NSString safeString:[rs objectForColumn:@"paydate"]];
        movieInfo.singleprice=[NSString safeString:[rs objectForColumn:@"singleprice"]];
        movieInfo.pay = [NSString safeString:[rs objectForColumn:@"pay"]];
        movieInfo.lastRecordTime= [rs isNullForColumn:@"add_Time"] ? @"" : [rs objectForColumn:@"add_Time"];
        movieInfo.deviceFromType=[rs isNullForColumn:@"deviceType"] ? DEVICE_FROM_PHONE : [[rs objectForColumn:@"deviceType"]intValue];
        movieInfo.favVersion = [rs isNullForColumn:@"letv_version"] ? @"0" : [rs objectForColumn:@"letv_version"];
    //    movieInfo.nvid = [NSString safeString:[rs objectForColumn:@"nvid"]];
    //    movieInfo.count = [rs objectForColumn:@"count"];

        [[self class] setStarAndSingerInfo:movieInfo];
        return movieInfo;
    }
    return nil;
#endif
}

+(void)setStarAndSingerInfo:(MovieInfo *)info {
    NSInteger category = [info.cid integerValue];
    if(category == NewCID_MOVIE)
    {
        info.actorAndStarInfo = info.actor;
    }
    else if (category == NewCID_Music)
    {
        info.actorAndStarInfo = info.director;//借用
    }
}

#pragma mark --Online Fav Methods
//local & online 列表--删除(取消)收藏操作
+ (void)removeFavWithArray:(NSArray *)array
               isDeleteAll:(BOOL)deleteAll
              successBlock:(LTHistoryCommandSuccessBlock)successBlock
                 failBlock:(LTHistoryCommandFailBlock)faileBlock
{
    if(![SettingManager isUserLogin]){
        
        NSMutableArray *idArray = [[NSMutableArray alloc]init];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if(obj)
            {
                MovieInfo *info = (MovieInfo *)obj;
                [idArray addObject:@(info.ID)];
            }
        }];
        
        [[self class] deleteHistoryByIds:idArray];
        
        if(successBlock)
        {
            successBlock();
        }
    } else {
        if(![NetworkReachability connectedToNetwork])
        {
            faileBlock(LTHistoryFailInfo_NetWrong);
            return;
        }
        
        if(array.count == 0)
        {
            faileBlock(LTHistoryFailInfo_UnKnown);
            return;
        }
        
        NSMutableArray *idArr = [[NSMutableArray alloc]init];
        [array enumerateObjectsUsingBlock:^(MovieInfo *obj, NSUInteger idx, BOOL *stop) {
            if(![NSString isBlankString:obj.favCloudId])
            {
                [idArr addObject:obj.favCloudId];
            }
        }];
        
        if(idArr.count == 0)
        {
            faileBlock(LTHistoryFailInfo_UnKnown);
            return;

        }
        
        NSString *flush = deleteAll ? @"1" : @"0"; // 1是全部删除
        NSString *ids = [idArr componentsJoinedByString:@","];
        NSString *sso_tk = [SettingManager userCenterTVToken];
        NSArray *arr = @[flush,ids,sso_tk];
        
        
        [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Fav_MultiDelete
                                   andDynamicValues:arr
                                        isNeedCache:NO
                                      andHttpMethod:@"GET"
                                      andParameters:nil
                                  completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                      
                                      if(bodyDict && [[bodyDict allKeys]containsObject:@"code"])
                                      {
                                          id code = bodyDict[@"code"];
                                          
                                          if([code isKindOfClass:[NSNumber class]] && [code integerValue] == 200)
                                          {
                                              successBlock();
                                          }
                                          else
                                          {
                                              faileBlock(LTHistoryFailInfo_UnKnown);
                                          }
                                      }
                                      else
                                      {
                                          faileBlock(LTHistoryFailInfo_UnKnown);
                                      }
                                      
                                  } nochangeHandler:^{
                                      faileBlock(LTHistoryFailInfo_UnKnown);
                                  } emptyHandler:^{
                                      faileBlock(LTHistoryFailInfo_UnKnown);
                                  } tokenExpiredHander:^{
                                      faileBlock(LTHistoryFailInfo_UnKnown);
                                  } errorHandler:^(NSError *error) {
                                      faileBlock(LTHistoryFailInfo_UnKnown);
                                  }];
    }

}

//半屏页面操作
//online: unFavoriteByloginedUser 登录状态取消收藏
+ (void)removeFavWithVideoInfo:(VideoModel *)movieInfo
                  successBlock:(LTHistoryCommandSuccessBlock)successBlock
                     failBlock:(LTHistoryCommandFailBlock)faileBlock
{

    if([SettingManager isUserLogin])
    {
        if(![NetworkReachability connectedToNetwork])
        {
            faileBlock(LTHistoryFailInfo_NetWrong);
            return;
        }
        if(!movieInfo)
        {
            faileBlock(LTHistoryFailInfo_UnKnown);
            return;
        }
        NSString * pid = @"0";
        NSString * vid = @"0";
        //VIDEOSOURCE type = -1;
        pid = [[self class] getFavParamWithVideoModel:movieInfo id_type:FAV_PARAM_PID];
        vid = [[self class] getFavParamWithVideoModel:movieInfo id_type:FAV_PARAM_VID];
        
        NSString *token = [SettingManager userCenterTVToken];
        NSArray *arr = @[pid,
                         vid,
                         @"1",//点播
                         token
                         ];
        
        [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Fav_Delete
                                   andDynamicValues:arr
                                        isNeedCache:NO
                                      andHttpMethod:@"GET"
                                      andParameters:nil
                                  completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                      
                                      if(bodyDict && [[bodyDict allKeys]containsObject:@"code"])
                                      {
                                          id code = bodyDict[@"code"];
                                          
                                          if([code isKindOfClass:[NSNumber class]] && [code integerValue] == 200)
                                          {
                                              successBlock();
                                          }
                                          else
                                          {
                                              faileBlock(LTHistoryFailInfo_UnKnown);
                                          }
                                      }
                                      else
                                      {
                                          faileBlock(LTHistoryFailInfo_UnKnown);
                                      }
                                      
                                  } nochangeHandler:^{
                                      faileBlock(LTHistoryFailInfo_UnKnown);
                                  } emptyHandler:^{
                                      faileBlock(LTHistoryFailInfo_UnKnown);
                                  } tokenExpiredHander:^{
                                      faileBlock(LTHistoryFailInfo_UnKnown);
                                  } errorHandler:^(NSError *error) {
                                      faileBlock(LTHistoryFailInfo_UnKnown);
                                  }];
        
    }
    else
    {
        if(faileBlock)
        {
            faileBlock(LTHistoryFailInfo_UnKnown);
        }
    }

}

//半屏页面操作
//online: addFavoriteByloginedUser
+ (void)addFavWithVideoInfo:(VideoModel *)movieInfo
               successBlock:(LTHistoryCommandSuccessBlock)successBlock
                  failBlock:(LTHistoryCommandFailBlock)faileBlock ;
{
    if([SettingManager isUserLogin]){
    
        if(![NetworkReachability connectedToNetwork])
        {
            faileBlock(LTHistoryFailInfo_NetWrong);
            return;
        }
        if(!movieInfo)
        {
            faileBlock(LTHistoryFailInfo_UnKnown);
            return;
        }
        NSString * pid = @"0";
        NSString * vid = @"0";
        pid = [[self class] getFavParamWithVideoModel:movieInfo id_type:FAV_PARAM_PID];
        vid = [[self class] getFavParamWithVideoModel:movieInfo id_type:FAV_PARAM_VID];
        
        NSString *token = [SettingManager userCenterTVToken];
        NSArray *arr = @[pid,
                         vid,
                         @"1",//点播
                         token,
                         FROM_TYPE
                         ];
        
        [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Fav_Add
                                   andDynamicValues:arr
                                        isNeedCache:NO
                                      andHttpMethod:@"GET"
                                      andParameters:nil
                                  completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                      
                                        if(bodyDict && [[bodyDict allKeys]containsObject:@"code"])
                                        {
                                            id code = bodyDict[@"code"];
                                                       
                                            if([code isKindOfClass:[NSNumber class]] && [code integerValue] == 200)
                                            {
                                                successBlock();
                                            }
                                            else
                                            {
                                                faileBlock(LTHistoryFailInfo_UnKnown);
                                            }
                                        }
                                      else
                                      {
                                          faileBlock(LTHistoryFailInfo_UnKnown);
                                      }
                                      
                                        } nochangeHandler:^{
                                            faileBlock(LTHistoryFailInfo_UnKnown);
                                        } emptyHandler:^{
                                            faileBlock(LTHistoryFailInfo_UnKnown);
                                        } tokenExpiredHander:^{
                                            faileBlock(LTHistoryFailInfo_UnKnown);
                                        } errorHandler:^(NSError *error) {
                                            faileBlock(LTHistoryFailInfo_UnKnown);
                                        }];
    } else {
        if(faileBlock)
        {
            faileBlock(LTHistoryFailInfo_UnKnown);
        }
    }
}

//online: synchronous favorite items
+ (void)commitLocalFav:(void (^)())finishBlock {
    if(![SettingManager isUserLogin])
    {
        finishBlock();
        return;
    }
    if(![NetworkReachability connectedToNetwork])
    {
        finishBlock();
        return;
    }
    NSArray *dataArr = [[self class] searchAll:DATA_TYPE_FAVORITE];
    
    if(dataArr.count == 0)
    {
        finishBlock();
        return;
    }
    
    NSMutableArray *upLoadArray = [[NSMutableArray alloc]init];
    
    [dataArr enumerateObjectsUsingBlock:^(MovieInfo *obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *pid = @"0";
        NSString *vid = @"0";
        pid = [[self class ]getFavParamWithMovieDetail:obj id_type:FAV_PARAM_PID];
        vid = [[self class ]getFavParamWithMovieDetail:obj id_type:FAV_PARAM_VID];
        if([pid isEqualToString:@"0"] && [vid isEqualToString:@"0"])
        {
            NSLog(@"....");
        }
        else
        {
            [dic setObject:pid forKey:@"play_id"];
            [dic setObject:vid forKey:@"video_id"];
            [dic setObject:@"1" forKey:@"favorite_type"];
            
            if(![NSString isBlankString:obj.lastRecordTime])
            {
                NSTimeInterval timeInterval = [[HistoryCommand NSStringToNSDate:obj.lastRecordTime] timeIntervalSince1970];
                [dic setObject:[NSString stringWithFormat:@"%.f",timeInterval] forKey:@"create_time"];
            }
            [upLoadArray addObject:dic];
        }
    }];
    
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:upLoadArray options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    [params setObject:[SettingManager userCenterTVToken] forKey:@"sso_tk"];
    [params setObject:@"3" forKey:@"from_type"];
    [params setObject:jsonString forKey:@"data"];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Fav_Dump
                               andDynamicValues:nil
                                    isNeedCache:NO
                                  andHttpMethod:@"POST"
                                  andParameters:params
                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                  
                                  if(bodyDict && [[bodyDict allKeys]containsObject:@"code"])
                                  {
                                      id code = bodyDict[@"code"];
                                      
                                      if([code isKindOfClass:[NSNumber class]] && [code integerValue] == 200)
                                      {
                                          [[self class]deleteByDataType:DATA_TYPE_FAVORITE];
                                          finishBlock();
                                      }
                                      else
                                      {
                                          finishBlock();
                                      }
                                  }
                                  else
                                  {
                                      finishBlock();
                                  }
                                  
                              } nochangeHandler:^{
                                  finishBlock();
                              } emptyHandler:^{
                                  finishBlock();
                              } tokenExpiredHander:^{
                                  finishBlock();
                              } errorHandler:^(NSError *error) {
                                  finishBlock();
                              }];
    
    
}

+(NSArray*)searchAll{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:@"SELECT * FROM history Order By add_Time Desc "];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[self wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

// 返回对应类型所有数据（播放记录：修改时间降序排列；收藏/追剧：ID降序）
+(NSArray*)searchAll:(NSString *)dataType {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    if ([dataType isEqualToString:DATA_TYPE_HISTORY]) {
        rs  = [db executeQuery:@"SELECT * FROM history WHERE data_type = ? Order By add_Time Desc ",dataType];
    }
    else {
#ifdef LT_IPAD_CLIENT
        rs  = [db executeQuery:@"SELECT * FROM history Order By ID Desc "];
#else
        rs  = [db executeQuery:@"SELECT * FROM history WHERE data_type = ? Order By ID Desc ",dataType];
#endif
    }
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[self wrappResultSet:rs]];
    }	
    [rs close];
    return dbArray;	
}

+(NSArray*)searchItems:(NSString *)dataType from:(NSInteger)from count:(NSInteger)count{
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    NSString *sql_searchHistory = @"SELECT * FROM history WHERE data_type = ? Order By add_Time Desc limit ? ,? ";
    NSString *ipad_sql_searchOther = @"SELECT * FROM history Order By ID Desc limit ?, ?";
    NSString *sql_searchOther = @"SELECT * FROM history WHERE data_type = ? Order By ID Desc limit ?,?";
    
    NSString *fromIndex = [NSString stringWithFormat:@"%ld",(long)from];
    NSString *countSize  = [NSString stringWithFormat:@"%ld",(long)count];
    
    if ([dataType isEqualToString:DATA_TYPE_HISTORY]) {
        
        rs  = [db executeQuery:sql_searchHistory, dataType, fromIndex, countSize];
    } else {
        
        rs  = [db executeQuery:sql_searchOther,dataType,fromIndex,countSize];

    }
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next]) {
        [dbArray addObject:[self wrappResultSet:rs]];
    }
    [rs close];
    return dbArray;
}

//local & online：收藏列表-获取数据操作
+ (void)getFavoritesByPageIndex:(NSInteger)pageIndex
                     pageSize:(NSInteger)pageSize
           successBlock:(LTHistoryGetListSuccessBlock)successBlock
              failBlock:(LTHistoryGetListFailBlock)faileBlock ;
{
    
    if(![SettingManager isUserLogin]) {
    
        NSInteger from = pageIndex * pageSize;
        NSInteger count = pageSize;
        NSMutableArray *arr = (NSMutableArray *)[[self class] searchItems:DATA_TYPE_FAVORITE
                                                                   from:from
                                                                  count:count];
        NSInteger allCount = [[self class] getCount];
        if(successBlock)
        {
            successBlock(arr,allCount,pageIndex);
        }
        return;
    }
    
//    if(![NetworkReachability connectedToNetwork])
//    {
//        faileBlock(LTHistoryFailInfo_NetWrong);
//        return;
//    }
    NSString *category = @"0";
    NSString *favorite_type = @"1";
    NSString *from_type = @"3";
    NSString *page_index = [NSString stringWithFormat:@"%ld",(long)(pageIndex+1)];
    NSString *page_size = [NSString stringWithFormat:@"%ld",(long)pageSize];
    NSString *sso_tk = [SettingManager userCenterTVToken];
    
    NSArray *arr = @[category,
                     favorite_type,
                     from_type,
                     page_index,
                     page_size,
                     sso_tk
                     ];
    
    BOOL needCatch = (pageIndex == 0) ? YES : NO;
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Fav_List
                               andDynamicValues:arr
                                    isNeedCache:needCatch
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                  
                                  if(bodyDict && [[bodyDict allKeys]containsObject:@"code"])
                                  {
                                      id code = bodyDict[@"code"];
                                      
                                      if([code isKindOfClass:[NSNumber class]] && [code integerValue] == 200)
                                      {
                                          if([[bodyDict allKeys]containsObject:@"data"])
                                          {
                                              NSDictionary *dic = bodyDict[@"data"];
                                              if(dic)
                                              {
                                                  NSError *err = nil;
                                                  FavListMode *model = [[FavListMode alloc]initWithDictionary:dic error:&err];
                                                  if(model)
                                                  {
                                                      NSMutableArray *favInfosArr = [[NSMutableArray alloc] init];
                                                      
                                                      [model.items enumerateObjectsUsingBlock:^(FavouriteCloudModel *model, NSUInteger idx, BOOL *stop) {
                                                          
                                                          MovieInfo *info = [model createMovieInfo];
                                                          if(info && ![NSString isBlankString:info.favCloudId])
                                                          {
                                                              [favInfosArr addObject:info];
                                                          }
                                                      }];
                                                      
                                                      successBlock(favInfosArr,[model.total integerValue],[model.page integerValue]);
                                                      return;
                                                  }
                                              }
                                          }
                                      }
                                  }
                                  
                                  faileBlock(LTHistoryFailInfo_UnKnown);
                                  
                              } nochangeHandler:^{
                                  faileBlock(LTHistoryFailInfo_UnKnown);
                              } emptyHandler:^{
                                  faileBlock(LTHistoryFailInfo_UnKnown);
                              } tokenExpiredHander:^{
                                  faileBlock(LTHistoryFailInfo_UnKnown);
                              } errorHandler:^(NSError *error) {
                                  faileBlock(LTHistoryFailInfo_UnKnown);
                              }];
}

//online: isFavorited
+ (void)getFavStateByVideoInfo:(VideoModel *)videoInfo
                  successBlock:(void(^)(BOOL isFav))successBlock
                     failBlock:(void(^)())failBlock
{
    
    if([SettingManager isUserLogin]){
    
        if(![NetworkReachability connectedToNetwork]){
            failBlock();
            return;
        }
        NSString * pid = [[self class] getFavParamWithVideoModel:videoInfo id_type:FAV_PARAM_PID];
        NSString * vid = [[self class] getFavParamWithVideoModel:videoInfo id_type:FAV_PARAM_VID];
        
        NSString *token = [SettingManager userCenterTVToken];
        NSArray *arr = @[pid,
                         vid,
                         @"1",//点播
                         token
                         ];
        
        [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Fav_IsFav
                                   andDynamicValues:arr
                                        isNeedCache:NO
                                      andHttpMethod:@"GET"
                                      andParameters:nil
                                  completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                      
                                      if(bodyDict && [[bodyDict allKeys]containsObject:@"code"])
                                      {
                                          id code = bodyDict[@"code"];
                                          
                                          if([code isKindOfClass:[NSNumber class]] && [code integerValue] == 200)
                                          {
                                              successBlock(YES);
                                          }
                                          else if([code isKindOfClass:[NSNumber class]] && [code integerValue] == 201)
                                          {
                                              successBlock(NO);
                                          }
                                          else
                                          {
                                              failBlock();
                                          }
                                      }
                                      else{
                                          failBlock();
                                      }
                                      
                                  } nochangeHandler:^{
                                      failBlock();
                                  } emptyHandler:^{
                                      failBlock();
                                  } tokenExpiredHander:^{
                                      failBlock();
                                  } errorHandler:^(NSError *error) {
                                      failBlock();
                                  }];
    } else {
        
        if(failBlock){
            failBlock();
        }
    }
}

#pragma mark --Local Fav Methods
+(NSDate *)NSStringToNSDate:(NSString *)string
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSDate *date = [formatter dateFromString :string];
    
    return date;
}

//localFav: count favorited items
+ (NSInteger)getCount {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    id<PLResultSet> rs;
    rs = [db executeQuery:@"SELECT COUNT(*) AS count FROM history WHERE data_type = ? ",DATA_TYPE_FAVORITE];
    if([rs next]) {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    [rs close];
    return count;
}

/*
 *以下
 *2015.7月
 *和moviedetial无关   只和videlModel 有关
 */
+ (NSString *)getKeyIdByVideoModel:(VideoModel *)video {

    if(!video) {
        return @"";
    }
    
    if ([NSString isBlankString:video.pid] || [video.pid isEqualToString:@"0"]) {
        return video.vid;
    }
    
    //电影、动漫、电视剧，按照专辑pid收藏
    BOOL flag = ([video.cid integerValue] == NewCID_Anime
                 || [video.cid integerValue] == NewCID_MOVIE
                 || [video.cid integerValue] == NewCID_TV);
    
    if(flag) {
        return video.pid;
    }
    
    return video.vid;
}

//localFav: is favorited
+ (BOOL)getFavStateByVideoInfo:(VideoModel *)video {

    NSString *keyId = [[self class] getKeyIdByVideoModel:video];
    
    if([NSString isBlankString:keyId])
        return NO;
    
    //set up a favorite type(in local db) to search
    NSString *type = DATA_TYPE_FAVORITE;
    
    MovieInfo *info = [HistoryCommand searchByMovieId:keyId
                                          andDataType:type];
    if (info) {
        return YES;
    } else {
        return NO;
    }
}

//localFav: add favorite
+ (BOOL)insertFavWithVideoInfo:(VideoModel *)video andMovieDetail:(MovieDetailModel *)andMovieDetail {

    if (nil == video) {
        return NO;
    }
    
    NSString *keyid = [[self class] getKeyIdByVideoModel:video];
    if([NSString isBlankString:keyid]) {
        return NO;
    }
    
    NSString *title = @"";
    NSString *singer = @"";
    NSString *actor = @"";
    NSString *icon = @"";
    
    if(andMovieDetail){
        
        BOOL flag = ([video.cid integerValue] == NewCID_Anime
                     || [video.cid integerValue] == NewCID_MOVIE
                     || [video.cid integerValue] == NewCID_TV);
        if (flag) {
            title = andMovieDetail.nameCn;
            singer = andMovieDetail.singer;
            icon = andMovieDetail.getFavIcon;
        }
        actor = andMovieDetail.starring;
    }
    //get some attributes from video's MovieDetailModel if the attribute is null
    if([NSString isBlankString:title]){
        title = video.nameCn;
    }
    
    if([NSString isBlankString:singer]){
        singer = video.singer;
    }
    
    if([NSString isBlankString:icon]){
        icon = video.icon;
    }

    NSString *dataType = DATA_TYPE_FAVORITE;
    
    //db: auto delete oldItem out of range;
    if ([HistoryCommand countByDataType: dataType] >= DB_HISTORY_NUM){
        
        [HistoryCommand deleteAutoByDataType: dataType];
    }
    
    //db: is existed in local db;
    if ([HistoryCommand countByMovieID:keyid
                              andVType:-1
                            byDataType:dataType] > 0){
        return YES;
    }

    //mark device type as iPhone or ipad
#ifdef LT_IPAD_CLIENT
    NSString *deviceType = @"3";
#else
    NSString *deviceType = @"2";
#endif
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
    NSString *_add_time = [formatter stringFromDate:[NSDate date]];
    
    
    BOOL bResult = [HistoryCommand initWithID:keyid
                                          Pid:video.pid
                                        mmsid:@""
                                          cid:video.cid
                                        title:title
                                         icon:icon
                                      timeLen:@""
                                    playTimes:@""
                                        intro:video.desc
                                   sourceType:[NSString stringWithFormat:@"%d", video.type]
                                        lpUrl:@""
                                        hpUrl:@""
                                         tags:@""
                                  releaseYear:video.releaseDate
                                     director:singer//借用一下
                                        actor:actor
                                        score:@""
                                         cate:video.subCategory
                                         area:video.area
                                     dataType:dataType
                                      addTime:_add_time
                                     updating:[NSString stringWithFormat:@"%d", 0]
                                          vid:video.vid
                                    videoType:0
                                        atTag:@"0"
                                    albumType:@""
                                      payFrom:@""
                                   allowMonth:@""
                                      payDate:@""
                                  singlePrice:@""
                                          pay:[NSString stringWithFormat:@"%d", video.pay]
                                   deviceType:deviceType
                    //deviceType:movieInfo.deviceFromType?[NSString stringWithFormat:@"%d",movieInfo.deviceFromType]:@"2"]
                    ];
    
    return bResult;
}

//localFav: remove favorite
+ (BOOL)removeFavWithVideoInfo:(VideoModel *)video {

    NSString *keyid = [self getKeyIdByVideoModel:video];
    
    if([NSString isBlankString:keyid]) {
        return NO;
    }
    NSString *type = DATA_TYPE_FAVORITE;
    return [[self class] deleteByMovieID:keyid
                             andDataType:type];
}



//insert item to local db
+ (BOOL)initWithID:(NSString*)_id
               Pid:(NSString*)_pid
             mmsid:(NSString*)_mmsid
               cid:(NSString*)_cid
             title:(NSString*)_title
              icon:(NSString*)_icon
           timeLen:(NSString*)_timelen
         playTimes:(NSString*)_playtimes
             intro:(NSString*)_intro
        sourceType:(NSString*)_sourceType
             lpUrl:(NSString*)_lpurl
             hpUrl:(NSString*)_hpurl
              tags:(NSString*)_tags
       releaseYear:(NSString*)_releaseyear
          director:(NSString*)_director
             actor:(NSString*)_actor
             score:(NSString*)_score
              cate:(NSString*)_cate
              area:(NSString*)_area
          dataType:(NSString*)_datatype
           addTime:(NSString*)_addTime
          updating:(NSString*)_updating
               vid:(NSString*)_vid
         videoType:(NSInteger)_videoType
             atTag:(NSString*)_atTag
         albumType:(NSString *)_albumType
           payFrom:(NSString *)_pf
        allowMonth:(NSString *)_allowMonth
           payDate:(NSString *)_payDate
       singlePrice:(NSString *)_singlePrice
               pay:(NSString *)_pay
        deviceType:(NSString *)_deviceType {

    NSString *_movieID = [NSString safeString:_id];
    NSString *_moviePid = [NSString safeString:_pid];
    NSString *_movieMmsid = [NSString safeString:_mmsid];
    NSString *_movieCid = [NSObject empty:_cid] ? @"86" : [NSString safeString:_cid];
    NSString *_movieTitle = [NSString safeString:_title];
    NSString *_movieIcon = [NSString safeString:_icon];
    NSString *_movieTimeLen = [NSString safeString:_timelen];
    NSString *_moviePlayTimes = [NSObject empty:_playtimes] ? @"0" : [NSString safeString:_playtimes];
    NSString *_movieIntro = [NSString safeString:_intro];
    NSString *_movieSourceType = [NSString safeString:_sourceType];
    NSString *_movieLpurl = [NSString safeString:_lpurl];
    NSString *_movieHpurl = [NSString safeString:_hpurl];
    NSString *_movieTags = [NSString safeString:_tags];
    NSString *_movieReleaseYear = [NSString safeString:_releaseyear];
    NSString *_movieDirector = [NSString safeString:_director];
    NSString *_movieActor = [NSString safeString:_actor];
    NSString *_movieScore = [NSString safeString:_score];
    NSString *_movieCate = [NSString safeString:_cate];
    NSString *_movieArea = [NSString safeString:_area];
    NSString *_movieDataType = [NSString safeString:_datatype];
    NSString *_movieAddTime = [NSString safeString:_addTime];
    NSString *_movieUpdating = [NSString safeString:_updating];
    NSString *_movieVid = [NSString safeString:_vid];
    NSInteger _movieVideoType = _videoType;
    NSString *_movieAtTag = [NSString safeString:_atTag];
    NSString *_moviewAlbumType=[NSString safeString:_albumType];
    NSString *_moviePayFrom=[NSString safeString:_pf];
    NSString *_movieAllowMonth=[NSString safeString:_allowMonth];
    NSString *_moviePayDate=[NSString safeString:_payDate];
    NSString *_movieSinglePrice=[NSString safeString:_singlePrice];
    NSString *_moviePay=[NSString safeString:_pay];
    NSString *_movieDeviceType=[NSString safeString:_deviceType];
    NSString *version = [NSString  safeString:CURRENT_VERSION];
#ifndef LT_IPAD_CLIENT
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"INSERT INTO history(movie_ID,p_ID,mmsID,cid,title,icon,time_length,play_times,intro,sourceType,lp_url,hp_url,tags,release_year,director,actor,score,movie_cate,movie_area,data_type,add_Time, update_status, vid, vtype, at,albumtype,payfrom,allowmonth,paydate,singleprice,pay,deviceType,letv_version) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    _movieID,
                    _moviePid,
                    _movieMmsid,
                    _movieCid,
                    _movieTitle,
                    _movieIcon,
                    _movieTimeLen,
                    _moviePlayTimes,
                    _movieIntro,
                    _movieSourceType,
                    _movieLpurl,
                    _movieHpurl,
                    _movieTags,
                    _movieReleaseYear,
                    _movieDirector,
                    _movieActor,
                    _movieScore,
                    _movieCate,
                    _movieArea,
                    _movieDataType,
                    _movieAddTime,
                    _movieUpdating,
                    _movieVid,
                    [NSString stringWithFormat:@"%ld",(long)_movieVideoType],
                    _movieAtTag,_moviewAlbumType,_moviePayFrom,_movieAllowMonth,_moviePayDate,_movieSinglePrice, _moviePay,_movieDeviceType,version];
    return bResult;
#else
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"INSERT INTO history(movie_ID,p_ID,mmsID,title,icon,time_length,play_times,intro,sourceType,lp_url,hp_url,tags,release_year,director,actor,score,movie_cate,movie_area,data_type,cid,offset,odumIndex,vippf,viptag,deviceType,vid,letv_version) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    _movieID,
                    _moviePid,
                    _movieMmsid,
                    _movieTitle,
                    _movieIcon,
                    _movieTimeLen,
                    _moviePlayTimes,
                    _movieIntro,
                    _movieSourceType,
                    _movieLpurl,
                    _movieHpurl,
                    _movieTags,
                    _movieReleaseYear,
                    _movieDirector,
                    _movieActor,
                    _movieScore,
                    _movieCate,
                    _movieArea,
                    _movieDataType,
                    _movieCid,
                    @"0",
                    @"0",
                    @"0",
                    @"0",
                    _movieDeviceType,
                    _movieVid,
                    version
                    ];

    return bResult;
    
#endif
}



/*
 v5.9 增加
 */
//delete items from local db
+ (BOOL)deleteHistoryByIds:(NSArray *)idArray
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    [db beginTransaction];
    
    for(NSNumber *mid in idArray){
        [HistoryCommand deleteByID:[mid integerValue]];
    }
    
    return [db commitTransaction];
}

#pragma mark -- create model from structure
+ (VideoModel *)createVideoModelByDictionary:(NSDictionary *)videoInfo
{
   
    VideoModel *model = [[VideoModel alloc]init];
    NSString *vid = [videoInfo safeValueForKey:@"vid"];
    NSString *pid = [videoInfo safeValueForKey:@"pid"];
    NSString *nameCn = [videoInfo safeValueForKey:@"nameCn"];

    model.vid = vid;
    model.pid = pid;
    model.nameCn = nameCn;
    model.cid = [NSString stringWithFormat:@"%d",NewCid_Other];
    model.type = VIDEO_FROM_VRS;
    
    PicCollectionModel *picCollection = [[PicCollectionModel alloc] init];
    picCollection.pic200_150 = [videoInfo objectForKey:@"picUrl"];
    model.picAll = picCollection;
    
    return model;
}

+ (MovieDetailModel *)createMovieDetailModelByDictionary:(NSDictionary *)videoInfo
{
    MovieDetailModel *model = [[MovieDetailModel alloc]init];
    NSString *pid = [videoInfo safeValueForKey:@"pid"];
    NSString *nameCn = [videoInfo safeValueForKey:@"nameCn"];
    
    model.pid = pid;
    model.nameCn = nameCn;
    model.cid = [NSString stringWithFormat:@"%d",NewCid_Other];
    model.type = VIDEO_FROM_VRS;
    PicCollectionModel *picCollection = [[PicCollectionModel alloc] init];
    picCollection.pic320_200 = [videoInfo objectForKey:@"picUrl"];
    
    model.picCollections = picCollection;
    
    return model;

}

//VideoModel -> p_id、v_id
+(NSString *)getFavParamWithVideoModel:(VideoModel *)video id_type:(FAV_PARAM_TYPE)type {
    //专辑
    NSString *pid = video.pid;
    NSString *vid = video.vid;
    
    if([NSString isBlankString:pid]){
        pid = @"0";
    }

    if([NSString isBlankString:vid]){
        vid = @"0";
    }
    return (type == FAV_PARAM_PID) ? pid : vid;
}

//MovieInfo -> p_id、v_id
+(NSString *)getFavParamWithMovieDetail:(id)info id_type:(FAV_PARAM_TYPE)id_type {
    
    NSString *play_id = @"0";
    NSString *video_id = @"0";
    if([info isKindOfClass:[MovieInfo class]]) {
        
        MovieInfo *movieInfo = (MovieInfo *)info;
        
        if([movieInfo.favVersion isEqualToString:@"0"])
        {
            //下述三个频道(电影、动漫、电视剧)按专辑收藏，否则按视频收藏（服务端逻辑）
            BOOL flag = ([movieInfo.cid integerValue] == NewCID_Anime || [movieInfo.cid integerValue] == NewCID_MOVIE || [movieInfo.cid integerValue] == NewCID_TV);
            
            if (flag) {
                if ([movieInfo.sourceType integerValue] == ALBUM_FROM_VRS) {
                    //专辑
                    play_id = movieInfo.movie_ID;// [movieInfo getAlbumId];
                    
                    if(![NSString isBlankString:movieInfo.v_ID] &&
                       ![movieInfo.movie_ID  isEqualToString:movieInfo.v_ID])
                    {
                        video_id = movieInfo.v_ID;
                    } else {
                        video_id = @"0";
                    }
                } else {
                    //视频
                    play_id =movieInfo.p_ID;// [movieInfo getAlbumId];
                    video_id = movieInfo.movie_ID;
                }
            } else {
                //本来是必须传vid的，但是客户端原有收藏逻辑是如果是专辑类型
                if ([movieInfo.sourceType integerValue] == ALBUM_FROM_VRS) {
                    //
                    play_id =movieInfo.movie_ID;// [movieInfo getAlbumId];
                    
                    if(![NSString isBlankString:movieInfo.v_ID] &&
                       ![movieInfo.movie_ID  isEqualToString:movieInfo.v_ID])
                    {
                        video_id = movieInfo.v_ID;
                    } else {
                        video_id = @"0";
                    }
                    
                } else {
                    //movieInfo.p_ID 为有意义Id;
                    if([NSString isBlankString:movieInfo.p_ID] && ![movieInfo.p_ID isEqualToString:@"0"])
                    {
                        //视频
                        play_id = movieInfo.p_ID;
                        video_id = movieInfo.movie_ID;
                        
                    } else {
                        //单视频
                        play_id = @"0";
                        video_id = movieInfo.movie_ID;
                    }
                }
            }
        } else {
            play_id = movieInfo.p_ID;
            video_id = movieInfo.v_ID;
        }
    }
    if([NSString isBlankString:play_id])
    {
        play_id = @"0";
    }
    if([NSString isBlankString:video_id])
    {
        video_id = @"0";
    }
    
    return (id_type == FAV_PARAM_PID) ? play_id : video_id;
}

//获取VideoInfo -> 半屏页面
+ (NSString *)getVideoInfoStr:(VideoModel *)video
{
    NSString *pidInfo = [[self class] getFavParamWithVideoModel:video id_type:FAV_PARAM_PID];
    NSString *vidInfo = [[self class] getFavParamWithVideoModel:video id_type:FAV_PARAM_VID];
    
    NSString *result = [NSString stringWithFormat:@"pid:%@vid:%@",pidInfo,vidInfo];
    return result;
}

/* =====================================================
 Note:
 ID integer primary key autoincrement unique, 【ID，主key】VVV
 movie_ID varchar(20),  【专辑ID（娱乐为视频ID）】VVV
 p_ID varchar(20),      【（V2.2及之前为专辑ID，但未使用过），视频ID（V2.3）】VVV
 mmsID varchar(20),     【mmsid】XXX
 title varchar(255),    【播放记录存单集title;收藏/追剧存专辑title】VVV
 icon varchar(255),     【icon】 XXX
 time_length varchar(15),   【总时长，播放记录用，--:--:--】VVV
 play_times varchar(20),    【播放次数】 XXX
 sourceType varchar(4),     【资源来源 1/2】VVV
 intro text,                【intro】 XXX
 lp_url varchar(255),       【lp_url】 XXX
 hp_url varchar(255),       【hp_url】 XXX
 tags varchar(255),         【tags】 XXX
 release_year varchar(4),   【release_year】 XXX
 director varchar(64),      【director】 XXX
 actor varchar(255),        【actor】 XXX
 score varchar(4),          【score】 XXX
 movie_cate varchar(32),    【movie_cate】 XXX
 movie_area varchar(32),    【movie_area】 XXX
 add_Time timestamp default (datetime('now', 'localtime')), 【修改时间】VVV
 data_type varchar(4),      【数据类型：播放记录/收藏/追剧】VVV
 cid varchar(4) default '86',   【cid】VVV
 odumIndex integer default 0,   【影片类型（原当前播放集数）：正片1/其它2】VVV
 offset integer default 0       【已播时长，播放记录用】VVV
 ===================================================== */
@end
