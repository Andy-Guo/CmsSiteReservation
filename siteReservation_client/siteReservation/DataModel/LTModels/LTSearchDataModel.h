//
//  LTSearchDataModel.h
//  LetvIphoneClient
//
//  Created by bob on 13-11-7.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTSearchImagesData @end

// 图片数据
@interface LTSearchImagesData : JSONModel
@property (nonatomic, strong) NSString<Optional> *img_150_200;
@property (nonatomic, strong) NSString<Optional> *img_300_400;
@property (nonatomic, strong) NSString<Optional> *img_400_300;
@property (nonatomic, strong) NSString<Optional> *img_200_150;
@property (nonatomic, strong) NSString<Optional> *img_120_160;

- (NSString *)getWidthImg;
- (NSString *)getHeightImg;

@end


@protocol LTSpecialAlbumData @end
@interface LTSpecialAlbumData : JSONModel
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *subTitle;
@property (nonatomic, strong) LTSearchImagesData *images;
@property (nonatomic, strong) NSString<Optional> *phoneUrl;
@property (nonatomic, strong) NSString<Optional> *padUrl;
@end

// 外网专辑下视频列表信息(用于外网电视剧、动漫等频道)
@protocol LTVideoPlayUrlsElemData @end
@interface LTVideoPlayUrlsElemData : JSONModel
@property (nonatomic, strong) NSString<Optional> *order;
@property (nonatomic, strong) NSString<Optional> *url;
@end

// 内网专辑剧集列表(用于内网电视剧、动漫等频道)
@protocol LTSearchVidEpisodeData @end
@interface LTSearchVidEpisodeData : JSONModel
@property (nonatomic, strong) NSString<Optional> *aorder;
@property (nonatomic, strong) NSString<Optional> *vid;
@end

// 专辑列表中单视频信息(综艺、音乐等频道)
@protocol LTSearchVideoListElemData @end
@interface LTSearchVideoListElemData : JSONModel
@property (nonatomic, strong) NSString<Optional> *name;   // 视频名称
@property (nonatomic, strong) NSString<Optional> *vid;    // 视频id
@property (nonatomic, strong) NSString<Optional> *url;    // 外网视频播放地址
@property (nonatomic, strong) NSString<Optional> *aorder; // 排序
@end

// 明星作品
@protocol LTSearchStarWorksData @end
@interface LTSearchStarWorksData : JSONModel
@property (nonatomic, strong) NSString<Optional> *aid;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *category;
@property (nonatomic, strong) NSString<Optional> *categoryName;
@property (nonatomic, strong) LTSearchImagesData *images;
@property (nonatomic, strong) NSString<Optional> *src;
@property (nonatomic, strong) NSString<Optional> *subSrc;
@property (nonatomic, strong) NSString<Optional> *url;
@property (nonatomic, strong) NSString<Optional> *play;
@property (nonatomic, strong) NSString<Optional> *jump;
@property (nonatomic, strong) NSString<Optional> *pay;
@end

// 明星信息
@protocol LTSearchStarInfoData @end
@interface LTSearchStarInfoData : JSONModel
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *birthday;
@property (nonatomic, strong) NSString<Optional> *professional;
@property (nonatomic, strong) NSString<Optional> *otherName;
@property (nonatomic, strong) NSString<Optional> *trueName;
@property (nonatomic, strong) NSString<Optional> *areaName;
@property (nonatomic, strong) LTSearchImagesData *images;
@property (nonatomic, strong) NSArray<LTSearchStarWorksData, Optional> *works;
@end

// 单视频数据
@protocol LTSearchVideoData @end
@interface LTSearchVideoData : JSONModel
@property (nonatomic, strong) NSString<Optional> *aid;
@property (nonatomic, strong) NSString<Optional> *vid;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *category;
@property (nonatomic, strong) NSString<Optional> *categoryName;
@property (nonatomic, strong) LTSearchImagesData *images;
@property (nonatomic, strong) NSString<Optional> *play;
@property (nonatomic, strong) NSString<Optional> *jump;
@end

// 专辑数据
@protocol LTSearchAlbumData @end
@interface LTSearchAlbumData : JSONModel
@property (nonatomic, strong) NSString<Optional> *aid;            // 专辑id
@property (nonatomic, strong) NSString<Optional> *videoType;      // 视频类型
@property (nonatomic, strong) NSString<Optional> *name;           // 中文名称
@property (nonatomic, strong) NSString<Optional> *category;       // 频道分类,具体值见接口字典表
@property (nonatomic, strong) NSString<Optional> *categoryName;   // 频道分类名称,具体值见接口字典表
@property (nonatomic, strong) NSString<Optional> *subCategoryName;
@property (nonatomic, strong) NSString<Optional> *releaseDate;    // 上映时间
@property (nonatomic, strong) NSString<Optional> *starring;        // 主演
@property (nonatomic, strong) NSString<Optional> *directory;       // 导演
@property (nonatomic, strong) NSString<Optional> *actor;          // 声优
@property (nonatomic, strong) NSString<Optional> *cast;           // 声优
@property (nonatomic, strong) NSString<Optional> *compere;        // 主持人
@property (nonatomic, strong) LTSearchImagesData *images;         // 图片
@property (nonatomic, strong) NSString<Optional> *src;            // 默认片源类型:1-乐视，2-外源
@property (nonatomic, strong) NSString<Optional> *subSrc;         // 默认片源
@property (nonatomic, strong) NSString<Optional> *url;            // 外网专辑链接地址
@property (nonatomic, strong) NSString<Optional> *episodes;       // 总集数
@property (nonatomic, strong) NSString<Optional> *nowEpisodes;    // 更新到总集数
@property (nonatomic, strong) NSString<Optional> *isEnd;          // 1:完结;0:未完结
@property (nonatomic, strong) NSString<Optional> *play;           // 1:播放;0:外跳
@property (nonatomic, strong) NSString<Optional> *jump;           // 1:外跳;0:不跳
@property (nonatomic, strong) NSString<Optional> *pay;            // 1:收费;0:免费

@property (nonatomic, strong) NSArray<LTVideoPlayUrlsElemData, Optional> *videoPlayUrls;
@property (nonatomic, strong) NSArray<LTSearchVidEpisodeData, Optional> *vidEpisode;
@property (nonatomic, strong) NSArray<LTSearchVideoListElemData, Optional> *videoList;

@property (nonatomic, strong) NSString<Optional> *isUnfold;      // 业务相关：是否展开（iPhone）
@property (nonatomic, strong) NSString<Optional> *selectedIndex;    // 业务相关：那个剧集被选中（iPad）
@property (nonatomic, strong) NSString<Optional> *isSourceUnfold;  // 业务相关：source是否被展开
@property (nonatomic, strong) NSArray<Optional> *sourceList;      // 业务相关：source列表
@property (nonatomic, strong) NSString<Optional> *sourceSelectedIndex; // 业务相关，source被选中的索引

- (void)setUnfold:(BOOL)isUnfold;
- (BOOL)getIsUnfold;
- (BOOL)isMainVideo;
- (NSString*)getReleaseDate;

@end

@interface LTSearchDataModel : JSONModel
@property (nonatomic, strong) NSArray<LTSearchStarInfoData, Optional> *star_list;
@property (nonatomic, strong) NSString<Optional> *star_count;
@property (nonatomic, strong) NSArray<LTSearchAlbumData, Optional> *album_list;
@property (nonatomic, strong) NSString<Optional> *album_count;
@property (nonatomic, strong) NSArray<LTSearchVideoData, Optional> *video_list;
@property (nonatomic, strong) NSString<Optional> *video_count;
@property (nonatomic, strong) NSArray<LTSpecialAlbumData, Optional> *special;
@end

