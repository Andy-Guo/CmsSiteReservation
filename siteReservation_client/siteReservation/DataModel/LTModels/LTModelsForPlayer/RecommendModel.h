//
//  RecommendModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-11.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>
#import <LetvMobileDataModel/LTCMSBlockDataModel.h>
#import <LetvMobileDataModel/VideoModel.h>
#import <LetvMobileDataModel/MovieDetailModel.h>

@protocol RecommendItem @end
@interface RecommendItem : JSONModel

@property (strong, nonatomic) NSString<Optional>* vid;                // 视频id 新接口用这个
@property (strong, nonatomic) NSString<Optional>* pid;                // 视频专辑 id
@property (strong, nonatomic) NSString<Optional>* title;              // 视频标题
@property (strong, nonatomic) NSString<Optional>* subname;            // 副标题
@property (strong, nonatomic) NSString<Optional>* picHT;    // 横图	尺寸：200*150
@property (strong, nonatomic) NSString<Optional>* picST;              // 竖图	尺寸：150*200
@property (strong, nonatomic) NSString<Optional>* pic320_200;
@property (strong, nonatomic) NSString<Optional>* pic300_400;
@property (strong, nonatomic) NSString<Optional>* type;               // 类型	1:专辑;3:视频
@property (assign, nonatomic) BOOL jump;                    // 外跳	1:跳;0:不跳
@property (strong, nonatomic) NSString<Optional> *pidname;
@property (strong, nonatomic) NSString<Optional>* pay;
@property (strong, nonatomic) NSString<Optional>* episode;
@property (strong, nonatomic) NSString<Optional>* isEnd;
@property (strong, nonatomic) NSString<Optional>* nowEpisode;
@property (strong, nonatomic) NSString<Optional>* playCount;  // 临时字段，非服务端返回
@property (strong, nonatomic) NSString<Optional>* isSelected; // 临时字段，非服务端返回
@property (strong, nonatomic) NSString<Optional>* score;      //评分
@property (strong, nonatomic) NSString<Optional>* cid;
@property (strong, nonatomic) NSString<Optional>* starring;
@property (strong, nonatomic) NSString<Optional>* director;
@property (strong, nonatomic) NSString<Optional>* nowEpisodes; //更新到多少集
@property (strong, nonatomic) NSString<Optional>* duration;    // 视频时长
@property (strong, nonatomic) NSString<Optional>* singer;      // 歌手
@property (strong, nonatomic) NSString<Optional>* area;        //用于数据统计
@property (strong, nonatomic) NSString<Optional>* dataArea;     //片子所属地区
@property (strong, nonatomic) NSString<Optional>* releaseDate;
@property (strong, nonatomic) NSString<Optional>* subCategory;  //类型
@property (strong, nonatomic) NSString<Optional>* playTv;       //电视台
@property (strong, nonatomic) NSString<Optional>* style;        //风格
@property (strong, nonatomic) NSString<Optional>* videoType;
@property (strong, nonatomic) NSString<Optional>* videoTypeName;
@property (strong, nonatomic) NSString<Optional>* guest;        //嘉宾
@property (strong, nonatomic) NSString<Optional>* pidsubtitle; //type为专辑的副标题(例如综艺频道正片相关中副标题)
@property (strong, nonatomic) NSString<Optional>* cornerMark;  //海报角标文案
@property (strong, nonatomic) NSString<Optional>* reid;
@property (strong, nonatomic) NSString<Optional>* bucket;
@property (strong, nonatomic) NSString<Optional>* is_rec;
@property (assign, nonatomic) BOOL download;
@property (strong, nonatomic) NSArray<Optional>* brList;
@property (strong, nonatomic) NSString<Optional>* mid;    // string	媒资ID(一个视频可能对应着多 个媒资id,移动端只取第一个)
@property (strong, nonatomic) NSString<Optional> *isalbum; // 推荐是否专辑(如果是专辑，进入播放器就不传vid)

-(void)addStatisticAction:(LTDCPageID)pageID index:(NSInteger)index;
-(void)addStatisticShow:(LTDCPageID)pageID;


// 是否为有效的单视频Item
- (BOOL)isValidSingleVideoRecommendItem;

- (NSString *)getImageName;
- (BOOL)isAlreadyDownloadComplete;
- (BOOL) isAlreadyDownloading;
- (NSString *)getDisplayTitle;

/**
 *  把专辑详情model转化为推荐model
 *
 *  @param movieDetail 专辑信息model
 */
- (void)convertMovieDetailModel:(MovieDetailModel*)movieDetail;

/**
 *  把一个视频信息model转化成推荐item
 *
 *  @param video 视频信息model
 *
 */
- (void)convertVideoModelToRecommendItem:(VideoModel*)video;
- (BOOL)isAlreadyDownloaded;
@end


@interface RecommendModel : JSONModel

@property (strong, nonatomic) NSMutableArray<RecommendItem, ConvertOnDemand,Optional>* r;   //推荐列表（废弃）
@property (strong, nonatomic) NSMutableArray<MovieDetailModel, ConvertOnDemand,Optional>* relateAlbums;   // array 相关系列
@property (strong, nonatomic) NSMutableArray<RecommendItem, ConvertOnDemand,Optional>* recData;   // array 猜你喜欢
@property (strong, nonatomic) NSMutableArray<BlockContent, ConvertOnDemand,Optional>* cmsdata;   // array cms
@property (strong, nonatomic) VideoModel<Optional>*selfVideo;//插入推荐列表中的第一个视频
@property (strong, nonatomic) MovieDetailModel * recAlbumInfo;//正片推荐信息

// vid之后的第一个有效的单视频item
- (RecommendItem *)nextValidSingleVideoRecommendItemAfterItemWithVid:(NSString *)vid;
@end
