//
//  LTDownloadCommand.h
//  LetvIpadClient
//
//  Created by chen on 13-7-23.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/MovieDetailModel.h>
#import <LetvMobileDataModel/VideoModel.h>
#import <LetvMobileDataModel/LTDataModelCommDef.h>
#import <LetvMobileDataModel/LTDownloadCommand.h>
#import <LetvMobileDataModel/LTDownTasker.h>
/*
 //下载数据库重置  V3.8
 #define SQL_DOWNLOADHISTORY38 @"CREATE TABLE LTDownloadHistory (ID integer primary key autoincrement unique,a_id varchar(255),v_id varchar(255),mmsid varchar(255),c_id varchar(20),video_number varchar(20),video_index varchar(20),video_source varchar(4),video_type varchar(4),score varchar(20),is_end varchar(4),duration varchar(20),director varchar(255),actor varchar(255),area varchar(255),sub_category varchar(255),play_tv varchar(50),school varchar(50),control_area varchar(255),disable_type varchar(4),need_pay varchar(4),single_price varchar(4),allow_month varchar(4),stamp varchar(4),btime integer default 0,etime integer default 0,desc text,a_title text,v_title text,icon varchar(255),release_year varchar(4),video_code integer default 0,down_url varchar(255),add_Time timestamp default (datetime('now', 'localtime')),file_size varchar(20),download_size varchar(20),download_status varchar(2),locale_file_path varchar(255),finish_time timestamp default (datetime('now', 'localtime')));"   //sourceType 1 竖图  2横图
 */
@class MovieDetailModel;
@class VideoModel;
@protocol PLResultSet;



@interface LTDownloadFolder : NSObject

@property (strong,nonatomic) NSString *pid;
@property (strong,nonatomic) NSString *nameCn;
@property (assign,nonatomic) NSInteger count;
@property (strong,nonatomic) NSNumber *fileSize;
@property (strong,nonatomic) NSNumber *downloadSize;
@property (strong,nonatomic) NSString *icon;
@property (assign,nonatomic) BOOL isPlay;
@property (assign,nonatomic) NSInteger downloadStatus;
@property (assign,nonatomic) BOOL isSelect;
@property (assign,nonatomic) NSInteger completeCount;
@property (assign,nonatomic) BOOL isVipDownload;
@property (assign,nonatomic) NSInteger videoSource;

+(LTDownloadFolder *)wrappResultSet:(id<PLResultSet>)rs;
+(NSArray*) searchAllDownloadFold;
+(NSArray*) searchAllDownloadFoldItemWith:(NSArray *)pids;

@end


@interface LTDownloadCommand : NSObject

@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString* directory;
@property (strong, nonatomic) NSString *starring;
@property (assign, nonatomic) NSInteger video_code;
@property (strong, nonatomic) NSString* icon;
@property (strong, nonatomic) NSString* subIcon;
@property (strong, nonatomic) NSString* download_url;
@property (strong, nonatomic) NSString* storepath;
@property (strong, nonatomic) NSString* add_time;
@property (strong, nonatomic) NSString* file_size;
@property (strong, nonatomic) NSString* download_size;  //总下载大小
@property (strong, nonatomic) NSString* download_size0; //分片下载大小
@property (strong, nonatomic) NSString* download_size1; //分片下载大小
@property (strong, nonatomic) NSString* download_size2; //分片下载大小
@property (strong, nonatomic) NSString* download_status;
@property (strong, nonatomic) NSString* locale_file_path;
@property (strong, nonatomic) NSString* videotypekey;// 新加视频类型(正片，预告片等)
@property (strong, nonatomic) MovieDetailModel* movieDetailModel;
@property (strong, nonatomic) VideoModel *videoModel;
@property (strong, nonatomic) NSString* is_play;//是否已经播放过
@property (strong, nonatomic) NSString* audioTrack;
@property (strong, nonatomic) NSString* subtitleDownloadStatus;
@property (strong, nonatomic) NSString* subtitleKey;
/* 查询全部 */
+(NSArray*) searchAll;

/* 查询全部 文件夹 */
+(NSArray*) searchAllForAId;

+(NSArray*) searchAllDownloadFold;

/* 查询当前aid的quanbu纪录 */
+(NSArray*) searchAllForSubFolderAId:(NSString*)aid;

/* 查询 _column == _columnValue 的全部attribute */
+(NSArray*) searchAllForAttribute:(NSString*)attribute
                           column:(NSString*)_column
                      columnValue:(NSString*)_columnValue;

/* 查询全部attribute */
+(NSArray*)searchForAttribute:(NSString*)attribute;

/* 查询全部 _column == _columnValue的记录 */
+(NSArray*)searchAllForColumn:(NSString*)_column
                  columnValue:(NSString*)_columnValue;

/* 查询全部状态为_status的记录 */
+(NSArray*)searchAllByStatus:(NSArray *)_status;

/* 查询全部状态为downloading的记录 */
+(NSArray*)searchAllDownloading;

+(NSArray *)searchAllDownloadCompleteByAID:(NSString *)aid;

+(NSArray *)searchAllDownloadCompleteByVid:(NSString *)vid;

+ (NSArray *)searchAllByStatus:(NSArray *)_status andAID:(NSString *)aid;

+ (NSArray *)searchAllByStatus:(NSArray *)_status andVid:(NSString *)vid;

/* 查询全部状态为下载完成的记录 */
+(NSArray*)searchAllDownloadComplete;



+(id) searchByID:(int)_id;

/* 查询全部vid的记录 */
+(id) searchByVID:(NSString *)_vid;

/* 查询aid vid的对应记录 */
+(id) searchByAID:(NSString *)_aid andVid:(NSString*)_vid;

/* 查询aid 的对应记录是否存在  limit 1 */
+(id) searchByAID:(NSString *)_aid;

+(NSString*)searchPlayUrlByAID:(NSString *)_aid andVid:(NSString*)_vid;

/* 查询记录数量 */
+(int) downloadCount;

/* 查询 _column == _columnValue的记录数量 */
+(int) countForColumn:(NSString*)_column
          columnValue:(NSString*)_columnValue;

/* 查询专辑id下的文件夹下的记录数量 */
+(int) countForSubFolder:(NSString*)_aid;

/* 查询隶属文件夹的记录数量 */
+(int) countForSubFolderColumnArray:(NSArray*)_columnArray
                   columnValueArray:(NSArray*)_columnValueArray;

/* 查询状态为_download_status的记录数量 */
+(int) countForStatus:(NSString *)_download_status;

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
                 subtitleKey:(NSString *)_subtitleKey;

/* 删除 _vid的记录 */
+(int) deleteByVID:(NSString *)_vid;

/* 获取_vid的记录数量 */
+(int) movieCountByVID:(NSString *)_vid;

/* 更新_vid的下载大小 */
+(int) updateByVid:(NSString *)_vid DownloadSize:(NSString*)_download_size;

/* 更新_vid的下载状态 */
+(int) _updateByVid:(NSString *)_vid DownloadStatus:(NSString*)_download_status;
/* 更新_vid的下载状态 */
+(int) updateByVid:(NSString *)_vid DownloadStatus:(NSString*)_download_status;

/* 更新下载完成时间 */
+(int) updateByVid:(NSString *)_vid FinishTime:(NSString*)time;

/* 更新 _field = _fieldValue */
+(int) updateByVid:(NSString *)_vid field:(NSString *)_field FieldValue:(NSString *)_field_value;

/* 更新 下载地址  文件大小  */
+(int) updateByVid:(NSString *)_vid download_url:(NSString *)url file_size:(NSString *)_file_size;

/* 更新 下载地址 */
+(int)updateByVid:(NSString *)_vid download_url:(NSString *)url;

/* 更新码流 */
+(int) updateByVid:(NSString *)_vid codeRate:(VideoCodeType)codeRate;

/* 更新视频文件名称 */
+(int) updateByVid:(NSString *)_vid storePath:(NSString *)storepath;

/* 更新视频文件地址 */
+(int) updateByVid:(NSString *)_vid localFilePath:(NSString *)localFilePath;

/* 初始化和退出设置 */
+(int) processDataForInitAndTerminate;

+(int) processDataForWaitingStatus:(BOOL)isVipDownload;

/* command wrapp */
+(LTDownloadCommand *)wrappResultSet:(id<PLResultSet>)rs;

/* 获取已下载大小 */
+ (long long)searchAllDownloadedSize;
/* 获取已完成视频大小 */
+ (NSNumber*)searchAllOverDownloadSize;
/* 获取文件占用大小 */
+ (long long)searchAllDownloadFileSize;

/* 下载总大小 */
+(NSNumber*)leTvDownloadedTotalSpace;

/* 文件占用总大小 */
+(NSNumber*)leTvDownloadFileSizeTotalSpace;

/* 专辑文件大小 */
+ (long long)totalSizeForSubFolder:(NSString*)_aid;

/* 专辑已下载大小 */
+ (long long)downloadedSizeForSubFolder:(NSString*)_aid;

/**
 查询特殊列数据并排序
 status:状态
 column:排序列
 asc:升序 反之降序
 */
+(NSArray *)searchAllByStatus:(NSArray *)status
                   andOrderBy:(NSString *)column
                       andAsc:(BOOL)asc;

/* 更新 播放状态 */
+(int)updateByVid:(NSString *)_vid is_play:(NSString *)play;

/* 更新_varietyShow的状态 */
+ (int)update61UpdateVarietyShow_statusByVid:(NSString *)_vid VarietyShowStatus:(NSString*)_VarietyShow_status;

/* 更新_isVipDownload的状态 */
+ (int)update661UpdateisVipDownload_statusByVid:(NSString *)_vid isVipDownloadStatus:(NSString*)_isVipDownload_status;

/* 更新 音轨值 */
+ (int)updateByVid:(NSString *)_vid audioTrack:(NSString *)audioTrack;

/* 更新 字幕下载完成状态 */
+ (int)updateByVid:(NSString *)_vid subtitleDownloadStatus:(NSString *)status;


/* 更新 字幕值 */
+ (int)updateByVid:(NSString *)_vid subtitleKey:(NSString *)subtitle;

/* 当前状态所有的数量 */
+(int) searchAllCountByStatus:(NSArray *)status andAID:(NSString *)pid;

@end
