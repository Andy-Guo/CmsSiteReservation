//
//  HistoryCommand.h
//  LetvIpadClient
//
//  Created by guangliang shen on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/SqlDBHelper.h>
#import <LetvMobileDataModel/MovieDetailModel.h>
#import <LetvMobileDataModel/LTCloudFollowModel.h>

#define DATA_TYPE_HISTORY  @"0001"
#define DATA_TYPE_FAVORITE @"0002"
#define DATA_TYPE_FOLLOW   @"0003"
#define DATA_TYPE_RECORD   @"0004"

@class VideoModel;

typedef void (^LTFollowFailure)();
typedef void (^LTFollowSuccess)();
typedef void (^LTFollowList)(NSMutableArray* responseArray);


//云收藏 定义

typedef NS_ENUM(NSInteger, LTHistoryFailInfo) {
    LTHistoryFailInfo_NetWrong = 0,
    LTHistoryFailInfo_NotLogin = 1,
    LTHistoryFailInfo_UnKnown
};

//
typedef void (^LTHistoryCommandSuccessBlock)();
typedef void (^LTHistoryCommandFailBlock)(LTHistoryFailInfo info);

//同步操作
typedef void (^LTHistoryCommitSuccessBlock)();
typedef void (^LTHistoryCommitFailBlock)();

//获取list
typedef void (^LTHistoryGetListSuccessBlock)(NSMutableArray *arr,NSInteger count,NSInteger currentPageIndex);
typedef void (^LTHistoryGetListFailBlock)();

//end

@class MovieInfo;

@interface HistoryCommand : NSObject {

}

+(NSArray*)searchAll:(NSString *)dataType;
+(NSArray*)searchAll;
+(MovieInfo*)searchByMovieId:(NSString *)movieID andDataType:(NSString*)dataType;
//v5.3新添加
+(MovieInfo*)searchByMovieIdOrPid:(NSString *)movieID andDataType:(NSString *)dataType;
+(void)submitToCloudByFavWithFinishBlock:(void(^)())finishBlock;
//+(void)updateDBWithCloudWithFinishBlock:(void (^)())finishBlock;
#ifdef LT_IPAD_CLIENT

+(BOOL)deleteByDataType:(NSString *)dataType
              andMovieId:(NSString *)movieid;

#else

+(BOOL)deleteByMovieID:(NSString *)movieID
            andDataType:(NSString *)dataType;

#endif



+(BOOL)deleteByID:(NSInteger)ID;
+(BOOL)deleteByDataType:(NSString *)dataType;


+(BOOL)deleteAutoByDataType:(NSString *)dataType;

+(MovieInfo *)wrappResultSet:(id<PLResultSet>)rs;

+(int)countByDataType:(NSString *)dataType;

+(int)countByMovieID:(NSString *)movieID
            andVType:(NSInteger)vType
          byDataType:(NSString *)dataType;



+(BOOL)updateDataType:(NSString *)dataTypeSrc
           toDataType:(NSString *)dataTypeDes
            byMovieId:(NSString *)movieId;

+(NSString *)getFavAndFollowStatusByMovieId:(NSString *)movieID
                            andUpdateStatus:(Boolean)bUpdating;
+(NSArray *)searchByFavCount:(NSInteger)count;//搜索出前十条

+(NSDate *)NSStringToNSDate:(NSString *)string;

/*
 v5.9 增加
 */

+ (BOOL)deleteHistoryByIds:(NSArray *)idArray;

+ (void)removeFavWithArray:(NSArray *)array
               isDeleteAll:(BOOL)deleteAll
              successBlock:(LTHistoryCommandSuccessBlock)successBlock
                 failBlock:(LTHistoryCommandFailBlock)faileBlock;


+ (void)removeFavWithVideoInfo:(VideoModel *)movieInfo
                  successBlock:(LTHistoryCommandSuccessBlock)successBlock
                     failBlock:(LTHistoryCommandFailBlock)faileBlock ;

+ (void)addFavWithVideoInfo:(VideoModel *)movieInfo
               successBlock:(LTHistoryCommandSuccessBlock)successBlock
                  failBlock:(LTHistoryCommandFailBlock)faileBlock ;;

+ (void)commitLocalFav:(void (^)())finishBlock;

+ (void)getFavStateByVideoInfo:(VideoModel *)videoInfo
                successBlock:(void(^)(BOOL isFav))successBlock
                   failBlock:(void(^)())failBlock;

+ (void)getFavoritesByPageIndex:(NSInteger)pageIndex
                     pageSize:(NSInteger)pageSize
                 successBlock:(LTHistoryGetListSuccessBlock)successBlock
                    failBlock:(LTHistoryGetListFailBlock)faileBlock ;

+(NSArray*)searchAll:(NSInteger)from count:(NSInteger)count;

+ (NSInteger)getCount;

+ (NSString *)getVideoInfoStr:(VideoModel *)video;


//---------------------
// 2015.7月
//和moviedetial无关   只和videlModel 有关
+ (BOOL)getFavStateByVideoInfo:(VideoModel *)video;

+ (BOOL)insertFavWithVideoInfo:(VideoModel *)video andMovieDetail:(MovieDetailModel *)andMovieDetail;

+ (BOOL)removeFavWithVideoInfo:(VideoModel *)video;


//iwatch 使用  收藏热点视频
+ (VideoModel *)createVideoModelByDictionary:(NSDictionary *)dic;

+ (MovieDetailModel *)createMovieDetailModelByDictionary:(NSDictionary *)dic;


@end
