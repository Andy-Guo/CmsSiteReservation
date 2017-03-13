//
//  DownloadHistory.h
//  LeTV
//
//  Created by guangliang shen on 10-9-6.
//  Copyright 2010 letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/SqlDBHelper.h>
#ifndef LT_MERGE_FROM_IPAD_CLIENT
@interface DownloadHistoryCommand : NSObject {
	NSInteger ID ;
	NSString *icon;  
	NSString *movieID; 
	NSString *p_id;
	NSString *intro;
	NSString *play_count; 
	NSString *time_length;  
	NSString *title; 
	NSString *url; 
	NSString *add_time;
	NSString *mmsid;
	
	NSString *sourceType;
	
	NSString *file_size;
	NSString *download_size;
	NSString *download_status;
	NSString *locale_file_path;	
	NSString *data_type;
	NSString *tag_num;
    NSString *vid;
    NSString *br;  //(视频码率){350,800}
    NSString *databaseVersion; //数据库版本
    NSString *videoType;
    NSString *btime;
    NSString *etime;
    NSString *quality;
    NSString *aidTitle;
}
@property(nonatomic,assign) NSInteger ID ;
@property(nonatomic,copy) NSString *icon;  
@property(nonatomic,copy) NSString *movieID; 
@property(nonatomic,copy) NSString *p_id;
@property(nonatomic,copy) NSString *intro;
@property(nonatomic,copy) NSString *play_count; 
@property(nonatomic,copy) NSString *time_length;  
@property(nonatomic,copy) NSString *title; 
@property(nonatomic,copy) NSString *url; 
@property(nonatomic,copy) NSString *add_time;
@property(nonatomic,copy) NSString *mmsid;

@property(nonatomic,copy) NSString *sourceType;

@property(nonatomic,copy) NSString *file_size;
@property(nonatomic,copy) NSString *download_size;
@property(nonatomic,copy) NSString *download_status;
@property(nonatomic,copy) NSString *locale_file_path;
@property(nonatomic,copy) NSString *data_type;
@property(nonatomic,copy) NSString *tag_num;
@property(nonatomic,copy) NSString *vid;
@property(nonatomic,copy) NSString *br;
@property(nonatomic,copy) NSString *databaseVersion;
@property(nonatomic,copy) NSString *videoType;
@property(nonatomic,copy) NSString *btime;
@property(nonatomic,copy) NSString *etime;
@property(nonatomic,copy) NSString *quality;
@property(nonatomic,copy) NSString *aidTitle;

+(NSArray*)searchAllDatabase21;
+(NSArray*)searchAll;
+(NSArray*)searchAllByStatus:(NSArray *)_status;
+(NSArray*)searchAllByStatus:(NSArray *)_status andMovieID:(NSString *)movieID;
+(NSArray*)searchAllDownloading;
+(NSArray*)searchAllDownloadComplete;
+(NSArray*)searchAllDownloadCompleteByMovieID:(NSString *)movieID;
+(NSArray*)searchAllWaiting;
+(NSArray*)searchAllWithOption:(int) _count;
+(NSArray*)searchAllForAttribute:(NSString*)attribute 
                          column:(NSString*)_column 
                     columnValue:(NSString*)_columnValue;
+(id) searchByID:(int)_id;
+(id) searchByMovieID:(NSString *)_movie_id;
+(id) searchByMMSID:(NSString *)_mmsID;
+(int) count;
+(int) count:(NSString *)_download_status;
+(int) countWithFilePath:(NSString *)_file_path;
+(int) count21;
//+(int) createTable;
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
//             AidTitle:(NSString*)_aidTitle;

+(int) delete:(NSString *)_movie_id;
+(int) deleteByID:(int)_id;
+(int) deleteByMMSID:(NSString *)_mmsid;
+(int) movieCount:(NSString *)_movie_id;

+(int) update:(NSString *)_mmsid DownloadSize:(NSString*)_download_size;
+(int) update:(NSString *)_mmsid	DownloadStatus:(NSString*)_download_status;
+(int)update:(NSString *)_mmsid codeRate:(VideoCodeType)codeRate;
+(int) updateDownloadUrl:(NSString *)_mmsid url:(NSString*)_url;
+(int)update:(NSString *)_mmsid download_url:(NSString *)url file_size:(NSString *)_file_size;
+(int) update:(NSString *)_mmsid	DbVersion:(NSString*)_version;
+(int) update:(NSString *)_mmsid field:(NSString *)_field FieldValue:(NSString *)_field_value;
+(int) updateForStartAllDownload;
+(int) updateForStartAllDownloading;
+(int) processDataForInitAndTerminate;
// 获取letv选择下载文件中已经下载文件总大小
+(NSNumber*)leTvDownloadedTotalSpace;

// 获取letv选择下载文件容量总大小
+(NSNumber*)leTvDownloadFileSizeTotalSpace;

+(DownloadHistoryCommand *)wrappResultSet:(id<PLResultSet>)rs;

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
       AidTitle:(NSString*)_aidTitle;
      

+(DownloadHistoryCommand *)wrappResultSetDatabase21:(id<PLResultSet>)rs;
+(int) deleteByMovieID21:(NSString *)_movie_id;
+(NSString*)searchPlayUrlByMovieID:(NSString *)_movie_id andVid:(NSString*)_vid;
+(id)searchByMovieID:(NSString *)_movie_id andVid:(NSString*)_vid;
+(NSInteger)getQualityByMovieID:(NSString *)_movie_id vid:(NSString*)_vid;
@end
#else
@interface DownloadHistoryCommand : NSObject {
    NSInteger ID ;
    NSString *icon;
    NSString *movieID;
    NSString *v_id;
    NSString *c_id;
    NSString *intro;
    NSString *title;
    NSString *mainTitle;
    NSString *url;
    NSString *add_time;
    NSString *mmsid;
    NSString *sourceType;
    NSString *file_size;
    NSString *download_size;
    NSString *download_status;
    NSString *locale_file_path;
    NSString *data_type;
    NSString *video_type;
    NSInteger btime;
    NSInteger etime;
    VideoCodeType videoCodeType;
    NSString *vippf;
    NSString *viptag;
}

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *movieID;
@property (nonatomic, copy) NSString *v_id;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *mainTitle;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *mmsid;
@property (nonatomic, copy) NSString *sourceType;
@property (nonatomic, copy) NSString *file_size;
@property (nonatomic, copy) NSString *download_size;
@property (nonatomic, copy) NSString *download_status;
@property (nonatomic, copy) NSString *locale_file_path;
@property (nonatomic, copy) NSString *data_type;
@property (nonatomic, copy) NSString *video_type;
@property (nonatomic, assign) NSInteger btime;
@property (nonatomic, assign) NSInteger etime;
@property (nonatomic, assign) VideoCodeType videCodeType;
@property (nonatomic, copy) NSString *vippf;
@property (nonatomic, copy) NSString *viptag;

+(NSArray*)searchAll;
+(NSArray*)searchAllForMovieId;
+(NSArray*)searchAllForSubFolderMovieId:(NSString*)movieId;
+(NSArray*)searchAllForAttribute:(NSString*)attribute
                          column:(NSString*)_column
                     columnValue:(NSString*)_columnValue;
+(NSArray*)searchForAttribute:(NSString*)attribute;
+(NSArray*)searchAllForColumn:(NSString*)_column
                  columnValue:(NSString*)_columnValue;
+(NSArray*)searchAllByStatus:(NSArray *)_status;
+(NSArray*)searchAllDownloading;
+(NSArray*)searchAllDownloadComplete;
+(id) searchByMMSID:(NSString *)_mmsid;
+(id)searchByMovieID:(NSString *)_movie_id andVid:(NSString*)_vid;
+(id) searchByMovieID:(NSString *)_movieId;

+(int) count;
+(int) countForColumn:(NSString*)_column
          columnValue:(NSString*)_columnValue;
+(int) countForSubFolder:(NSString*)_movieId;
+(int) countForSubFolderColumnArray:(NSArray*)_columnArray
                   columnValueArray:(NSArray*)_columnValueArray;
+(int) count:(NSString *)_download_status;
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
               viptag:(NSString *)_viptag;

+(int) delete:(NSString *)_movie_id;
+(int) deleteByID:(NSInteger)_id;
+(int) deleteByMMSID:(NSString *)_mmsid;
+(int) movieCountByMMSID:(NSString *)_mmsid;

+(int) update:(NSString *)_mmsid DownloadSize:(NSString*)_download_size;
+(int) update:(NSString *)_mmsid DownloadStatus:(NSString*)_download_status;
+(int) update:(NSString *)_mmsid FinishTime:(NSString*)time;
+(int) update:(NSString *)_mmsid field:(NSString *)_field FieldValue:(NSString *)_field_value;
+(int) updateForPre23:(NSString *)_mmsid vid:(NSString *)_vid vtype:(NSInteger)_vtype;
+(int)update:(NSString *)_mmsid download_url:(NSString *)url file_size:(NSString *)_file_size;
+(int)update:(NSString *)_mmsid codeRate:(VideoCodeType)codeRate;

+(int) processDataForInitAndTerminate;
+(DownloadHistoryCommand *)wrappResultSet:(id<PLResultSet>)rs;

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
         viptag:(NSString *)_viptag;

+ (long long)searchAllDownloadedSize;
+ (long long)searchAllDownloadFileSize;
+(NSNumber*)leTvDownloadedTotalSpace;
+(NSNumber*)leTvDownloadFileSizeTotalSpace;

+ (long long)totalSizeForSubFolder:(NSString*)_movieId;
+ (long long)downloadedSizeForSubFolder:(NSString*)_movieId;

@end
#endif
