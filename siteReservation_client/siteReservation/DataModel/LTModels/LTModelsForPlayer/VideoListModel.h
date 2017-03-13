//
//  VideoListModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/VideoModel.h>
#import <LetvMobileDataModel/LTDataModelCommDef.h>

@interface VideoListModel : JSONModel

@property (strong, nonatomic) NSMutableArray<VideoModel>* videoInfo;                // array	正片列表

@property (strong, nonatomic) NSString<Optional>* __pagenum;
@property (strong, nonatomic) NSString<Optional>* __videoPosition;
@property (strong, nonatomic) NSArray <Optional>* pagenavi;  // 分页标题，NSString
// 分栏目类剧集列表
@property (strong, nonatomic) NSString<Optional>* year;
@property (strong, nonatomic) NSString<Optional>* month;
@property (strong, nonatomic) NSString<Optional>* totalNum;//总共的集数
@property (strong, nonatomic) NSString<Optional>* episodeNum;//更新的集数
@property (strong, nonatomic) NSString<Optional>* showOuterVideolist;//是否要请求周边视频
@property (strong, nonatomic) NSMutableArray<VideoModel, ConvertOnDemand,Optional>* previewList;//预告片
@property (nonatomic, assign) MovieShowStyle style;// 1:九宫格剧集  2:长列表剧集  3:按月显示
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSNumber<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *nStyle;
/*
 V3.8版本电视剧/电影/综艺只取正片，其它频道正片和非正片合并。即，只取videoInfo字段
 
@property (strong, nonatomic) NSMutableArray<VideoModel, ConvertOnDemand, Optional>* huaxuInfo;      // array	花絮列表
@property (strong, nonatomic) NSMutableArray<VideoModel, ConvertOnDemand, Optional>* yugaopianInfo;  // array	预告片列表
@property (strong, nonatomic) NSMutableArray<VideoModel, ConvertOnDemand, Optional>* zixunInfo;      // array	咨讯列表
@property (strong, nonatomic) NSMutableArray<VideoModel, ConvertOnDemand, Optional>* otherInfo;      // array	其他列表
 
 */

+ (VideoListModel *)videoListModelWithSubjectVideoArray:(NSArray *)subjectVideoArray;

+ (VideoListModel *)videoListModelWithFragmentsData:(NSDictionary *)fragmentDic;

// 栏目videolist
+ (VideoListModel *)videoListModelWithVideoJsonArray:(NSArray *)videoJsonArray
                                              atYear:(NSString *)year
                                            andMonth:(NSString *)month;
+ (VideoListModel *)videoListModelWithVideoJsonArray:(NSArray *)videoJsonArray
                                              atYear:(NSString *)year;
+ (VideoListModel *)videoListModelWithVideoJsonArray:(NSArray *)videoJsonArray;

// 是否为栏目类list
- (BOOL)isVarietyList;

// vid在第*页, index从0开始
- (NSInteger)pagenum;
// vid在第*个位置, index从0开始
- (NSInteger)videoPosition;

// vid为指定值的video在列表中的位置，不在列表中返回-1
- (NSInteger)indexOfVideoWithVid:(NSString*)vid;

// vid为指定值的video，不存在返回nil
- (VideoModel *)videoWithVid:(NSString *)vid;

// 在当前videoInfo list前面插入一个list
- (void)insertAtFrontWithVideoList:(VideoListModel *)other;

// 在当前videoInfo list后面追加一个list
- (void)appendWithVideoList:(VideoListModel *)other;
- (void)appendWithVideo:(VideoModel *)video;

// 是否能支持给定码率的播放/缓存，列表中有一个支持及返回TRUE
- (BOOL)isSupportedCodeType:(VideoCodeType)vct;

- (VideoCodeType)getSupportedCodeType;

- (NSString *)getIDs;

/**
 *  更新一个list中video的选中态属性
 *
 *  @param video 被选中video
 */
- (void)updateVideoListSelectedStateWithSelectedVideo:(VideoModel*)video;
@end
