//
//  LTSubjectDetailModel.h
//  LetvIphoneClient
//
//  Created by zhaocy on 14-3-26.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/VideoListModel.h>
#import <LetvMobileDataModel/MovieDetailModel.h>
@class VideoModel,VarityShowInfoModel,MovieDetailModel;
@protocol LTSubjectInfo
@end
@interface LTSubjectInfo : JSONModel

@property (strong, nonatomic) NSString<Optional>* name;         // string	专题名称;
@property (strong, nonatomic) NSString<Optional>* desc;         // string	简介
@property (strong, nonatomic) NSString<Optional>* pubName;      // string	专辑类型
@property (assign, nonatomic) LTSubjectType type;               // string	1、专辑，3、视频
@property (strong, nonatomic) NSString<Optional>* tag;          // string	副标题
@property (strong, nonatomic) NSString<Optional>* ctime;        // json	时间
@property (strong, nonatomic) NSString<Optional>* cid;          // string	频道id

@end

@protocol LTSubjectAlbum @end
@interface LTSubjectAlbum : JSONModel

@property (strong, nonatomic) NSString<Optional>* pid;                    // string	专辑ID;
@property (assign, nonatomic) VIDEOSOURCE type;                 // String	影片来源标示：1-vrs专辑,3-vrs视频
@property (strong, nonatomic) NSString<Optional>* title;
@property (strong, nonatomic) NSString<Optional>* pidname;                   // string	标题
@property (strong, nonatomic) NSString<Optional>* subname;      // string	副标题
@property (strong, nonatomic) NSString<Optional>* play;
@property (strong, nonatomic) NSString<Optional>* download;
@property (strong, nonatomic) NSString<Optional>* isEnd;
@property (strong, nonatomic) NSString<Optional>* episode;
@property (strong, nonatomic) NSString<Optional>* nowEpisodes;
@property (strong, nonatomic) NSString<Optional>* albumType;
@property (strong, nonatomic) NSString<Optional>* varietyShow;//是否为栏目
@property (strong, nonatomic) NSString<Optional>* cid;
@property (strong, nonatomic) NSString<Optional>* platformVideoInfo;
@property (strong, nonatomic) NSString<Optional>* isSelected; //非服务端返回字段，用于记录是否选中
@property (strong, nonatomic) NSString<Optional>* pic320_200; //
@property (strong, nonatomic) NSString<Optional>* pic400_300; //
@property (strong, nonatomic) NSString<Optional>* pic150_200; //

- (BOOL)isPlaySupported;
- (BOOL)isDownloadSupported;
-(MovieDetailModel*)subjectWithAlbum:(LTSubjectAlbum*)album;

@end


//content = "";
//down = "";
//title = "54\U88ab\U6b3a\U5c0f\U5b69\U77ac\U95f4\U53d8\U7eff\U5de8\U4eba\U770b\U50bb\U8def\U4eba\U3010\U56fd\U5916\U641e\U7b11\U6076\U641e\U89c6\U9891\U3011\U7cbe\U9009";
//up = "";
//"user_photo" = "<null>";
//username = "<null>";
//"vcomm_count" = 0;
//"vcomm_title" = "";
//vid = 21505564;

@protocol LTSubjectVideo
@end
@interface LTSubjectVideo : JSONModel

@property (strong, nonatomic) NSString<Optional>* voteid;
@property (strong, nonatomic) NSString<Optional>* pid;
@property (strong, nonatomic) NSString<Optional>* nameCn;
@property (strong, nonatomic) NSString<Optional>* type;
@property (strong, nonatomic) NSString<Optional>* play;
@property (strong, nonatomic) NSString<Optional>* download;
@property (strong, nonatomic) NSString<Optional>* videoType;
@property (strong, nonatomic) PicCollectionModel<Optional>* picCollections;
@property (strong, nonatomic) NSString<Optional>* duration;
@property (strong, nonatomic) NSString<Optional> *isSelected; //非服务端返回字段，用于记录是否选中
@property (strong, nonatomic) NSString<Optional>* vid;
@property (strong, nonatomic) NSString<Optional>* title;
@property (strong, nonatomic) NSString<Optional>* up;
@property (strong, nonatomic) NSString<Optional>* down;
@property (strong, nonatomic) NSString<Optional>* vcomm_count;
@property (strong, nonatomic) NSString<Optional>* vcomm_title;
@property (strong, nonatomic) NSString<Optional>* content;
@property (strong, nonatomic) NSString<Optional>* username;
@property (strong, nonatomic) NSString<Optional>* user_photo;
@property (strong, nonatomic) NSString<Optional>* pic400_300;
@property (strong, nonatomic) NSString<Optional>* pic320_200;
@property (assign, nonatomic) BOOL isUpClick;
@property (assign, nonatomic) BOOL isDownClick;
@property (assign, nonatomic) CGFloat rowHeight;

+ (LTSubjectVideo *)subjectVideoWithVideoModel:(VideoModel *)videoModel;
- (NSString*)getMinSizeImage;
- (BOOL)isPlaySupported;
- (BOOL)isDownloadSupported;
- (BOOL)isAlreadyDownloadComplete;

@end

@class RecommendModel;
@interface LTSubjectDetailModel : JSONModel

@property (strong, nonatomic) LTSubjectInfo<Optional> *subject;         // string	专题信息;
@property (strong, nonatomic) NSDictionary<Optional> * tabVideoList;//专题专辑初次带过来的剧集信息(专题单视频列表、普通剧集、按期数)
@property (readonly, nonatomic) VideoListModel<Optional>* subjectVideoList; //专题单视频列表/专辑专题普通剧集列表
@property (readonly, nonatomic) VarityShowInfoModel<Optional>* albumVarityShowVideoList; //专辑专题期数类视频列表

@property (strong, nonatomic) NSMutableArray<MovieDetailModel,ConvertOnDemand,Optional>* albumList; // array 专题专辑列表

//热点还在用，点播不用了
@property (strong, nonatomic) NSMutableArray<LTSubjectVideo,ConvertOnDemand,Optional>* videoList; // array 专题视频列表
/**
 *这两个属性做兼容逻辑用
 */
//专辑专题数据会出现异常情况，吐出来推荐数据
@property (readonly, nonatomic) RecommendModel<Optional> * recommendModel;
//是不应该出现的专题数据
@property (readonly, nonatomic)BOOL isRecommendData;

//专题剧集样式
@property (readonly, nonatomic)MovieShowStyle  style;
// aid为指定值的subject专辑在列表中的位置，不在列表中返回-1
- (NSInteger)indexOfSubjectAlbumWithAid:(NSString*)aid;
// aid为指定值的subject专辑，不存在返回nil
- (MovieDetailModel *)subjectAlbumWithAid:(NSString *)aid;
// 下一个可以播放的album
- (MovieDetailModel *)nextValidSubjectAlbumWithAid:(NSString *)aid;
// 第一个可以播放的album
- (MovieDetailModel *)firstValidSubjectAlbumWithAid:(NSString *)aid;

// vid为指定值的subject视频在列表中的位置，不在列表中返回-1
- (NSInteger)indexOfSubjectVideoWithVid:(NSString*)vid;
// vid为指定值的subject视频，不存在返回nil
- (VideoModel *)subjectVideoWithVid:(NSString *)vid;
// 下一个可以播放的video
- (VideoModel *)nextValidSubjectVideoWithVid:(NSString *)vid;
// 第一个可以播放的video
- (VideoModel *)firstValidSubjectVideoWithVid:(NSString *)vid;

@end
