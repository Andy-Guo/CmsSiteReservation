//
//  LTPlayHistoryCommand.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-15.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDownloadCommand.h>
#import <CoreLocation/CoreLocation.h>
#import "LTCloudRecordModel.h"

/**
 *  获取播放记录的种类
 */
typedef NS_ENUM(NSInteger, LePlayRecordType) {
    /**
     *  获取普通记录
     */
    LePlayRecordNormal = 0,
    /**
     *  获取短视频记录
     */
    LePlayRecordShort = 1,
    /**
     *  获取所有记录
     */
    LePlayRecordAll = 2,

};


typedef void (^LTCloudRecordCompleteBlock) (NSArray *cloudArr);
typedef void (^LTCloudRecordFailedBlock) (NSError *error);

@class LTDownloadCommand;
@class MovieDetailModel;
@class VideoModel;
@class MovieInfo;
@class LTCloudRecordItemModel;

@interface LTPlayHistoryCommand : NSObject

@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString *movie_id;
@property (strong, nonatomic) NSString *nameCn;
@property (strong, nonatomic) NSString *subTitle;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *score;
@property (strong, nonatomic) NSString *cid;
@property (assign, nonatomic) VIDEOSOURCE type;
@property (assign, nonatomic) LT_VIDEO_AT at;
@property (strong, nonatomic) NSString *releaseDate;
@property (strong, nonatomic) NSString *directory;
@property (strong, nonatomic) NSString *starring;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *area;
@property (strong, nonatomic) NSString *subCategory;
@property (strong, nonatomic) NSString *playTv;
@property (strong, nonatomic) NSString *school;
@property (strong, nonatomic) NSString *pid;
@property (strong, nonatomic) NSString *vid;
@property (strong, nonatomic) NSString *vnameCn;
@property (strong, nonatomic) NSString *vmid;
@property (assign, nonatomic) NSInteger vepisode;
@property (assign, nonatomic) NSInteger vporder;
@property (strong, nonatomic) NSString *vicon;
@property (strong, nonatomic) NSString *nvid;   // 5.9 新加的字段
@property (strong, nonatomic) NSString *vtype;
@property (assign, nonatomic) BOOL pay;
@property (assign, nonatomic) BOOL isAbleSkipTail;
@property (assign, nonatomic) NSInteger duration;
@property (assign, nonatomic) NSInteger offset;
@property (strong, nonatomic) NSDate *updateTime;
@property (strong, nonatomic) NSString *deviceFrom;     //5.5增加，用于播放记录产生设备 1:web;2:mobile;3:pad;4:tv;5:pc桌面
@property (strong, nonatomic) NSString* videoKey; // 5.8.2 新增, 用于反查视频是否是专辑的正片.
 // v6.1 新增, 用于播放记录缩略图.
@property (strong, nonatomic) NSString *pic;
// v6.15新增，标记是否为短视频
@property (strong, nonatomic) NSString *shortFlag;

#pragma mark - 本地播放记录的操作
// 搜索第一条播放记录--首页蓝条使用
+ (LTPlayHistoryCommand *)searchFirstRecord;
// 搜索指定数据的播放记录
+ (NSArray *)searchSpecialNumberRecord:(NSInteger)number;

#pragma mark - search
+ (NSArray *)searchAll;
/*** 短视频增加 **/
// 获取所有短视频的播放记录
+ (NSArray *)searchAllShortVideoRecord;
+ (NSArray *)searchAllNormalVideoRecord;

+ (LTPlayHistoryCommand *)searchByID:(NSString *)ID;
+ (NSArray *)searchAllPlayHistoryByMovieID:(NSString *)movieID;
+ (LTPlayHistoryCommand *)searchByID:(NSString *)ID videoType:(NSString *)videoType;
+ (LTPlayHistoryCommand *)searchByMovieID:(NSString *)movieID;
+ (LTPlayHistoryCommand *)searchByMovieID:(NSString *)movieID videoType:(NSString *)videoType;
+ (LTPlayHistoryCommand *)searchByMovieVid:(NSString *)vid;
+ (LTPlayHistoryCommand *)searchByMovieVid:(NSString *)vid videoType:(NSString *)videoType;
+ (LTPlayHistoryCommand *)searchByMovieID:(NSString *)movieID andVid:(NSString *)vid;
+ (NSInteger)countOfHistory;
+ (LTPlayHistoryCommand *)searchAllPlayHistoryByVID:(NSString *)vID;

#pragma mark - del
+ (BOOL)deleteByMovieID:(NSString *)movieID;
+ (BOOL)deleteByID:(NSInteger)ID;
+ (BOOL)deleteByID:(NSInteger)ID videoType:(NSString *)videoType;
#pragma mark - clean
// 清空本地所有-包含普通视频和短视频的播放记录
+ (BOOL)clean;
// 清空本地所有普通视频的播放记录
+ (BOOL)cleanAllNormal;
// 清空本地所有短视频播放记录
+ (BOOL)cleanAllShort;

// update calls
- (void)updateWithVideo:(VideoModel *)video
            andDuration:(NSInteger)duration
              andOffset:(NSInteger)offset
          andUpdateTime:(NSDate *)updateTime;

- (void)updateWithVideo:(VideoModel *)video
            andDuration:(NSInteger)duration
              andOffset:(NSInteger)offset
          andUpdateTime:(NSDate *)updateTime
         isAbleSkipTail:(BOOL)isAbleSkipTail;

#pragma mark - 云端播放记录的操作
/* 上传操作 */
// 上传movieID对应记录到云端
+ (void)submitToCloudWithMovieID:(NSString *)movieID
                  WithDeleteFlag:(BOOL)isNeedDeleteLocal;

+ (void)submitToCloudWithMovieID:(NSString *)movieID
                       videoType:(NSString *)videoType
                  WithDeleteFlag:(BOOL)isNeedDeleteLocal;
// 上传最近20条记录到云端
+ (void)submitToCloudByRecentWithFinishBlock:(void (^)())finishBlock;

/* 删除操作 */
// 删除指定云端记录
+ (void)deleteFromCloud:(NSMutableArray *)delArray;
+ (void)deleteFromCloud:(NSMutableArray *)delArray
           isShortVideo:(BOOL)isShortVideo
                  block:(void (^)(BOOL isSuccess))finishBlock
                   fail:(void (^)())failBlock;
// 删除指定一条云端播放记录
+ (void)deleteFromCloudWithModel:(LTCloudRecordItemModel *)recordModel;
+ (void)deleteFromCloudWithPid:(NSString *)pid andVid:(NSString *)vid;
// 清除云端记录
+ (void)cleanFromCloud:(BOOL)isShortVideo
           finishBlock:(void (^)(BOOL isSuccess))finishBlock
             failBlock:(void (^)())failBlock;

/* 下载操作 */
// 下载所有云端记录，更新本地数据库
+ (void)updateDBWithCloudWithFinishBlock:(void (^)())finishBlock;
// 分页下载云端-新接口
+ (void)getFromCloundWithPage:(NSInteger)page
                  recordType:(LePlayRecordType)dataType
                finishBlock:(void (^)(BOOL isSuccess, NSInteger total))finishBlock;
// 从云端获取指定条数播放记录-新接口
+ (void)getFromCloundWithItemCount:(NSInteger)pageCount recordType:(LePlayRecordType)dataType finishBlock:(void (^)(BOOL isSuccess, NSInteger total))finishBlock;

/* 创建播放记录模型 */
// 兼容V3.7及以前版本
+ (LTPlayHistoryCommand *)localPlayHistoryFromOldHistoryModel:(MovieInfo *)oldHistoryModel;

// 根据详情数据和单集视频数据构造LocalPlayHistory model
+ (LTPlayHistoryCommand *)localPlayHistoryFromMovieDetailModel:(MovieDetailModel *)movieDetail
                                                    andVideoModel:(VideoModel *)video;

+ (LTPlayHistoryCommand *)localPlayHistoryFromDownloadInfo:(LTDownloadCommand *)downloadInfo;

+ (LTPlayHistoryCommand *)localPlayHistoryFromCloudRecordItem:(LTCloudRecordItemModel *)cloudRecordItem;


+ (LTPlayHistoryCommand *)localPlayHistoryFromVideoModel:(VideoModel *)video;


// 5.9 批量删除数据库指定的前N条记录
+ (BOOL)deleteFromDB:(NSMutableArray *)arrays;

+ (NSArray *)searchFrom:(NSInteger)from count:(NSInteger)count;

//6.0 分页
+ (void)getFromCloundWithFinishBlock:(void (^)())finishBlock
                           pageIndex:(NSInteger)pageIndex
                           pageCount:(NSInteger)pageCount
                          isReqLocal:(BOOL)isReqLocal;
@end
