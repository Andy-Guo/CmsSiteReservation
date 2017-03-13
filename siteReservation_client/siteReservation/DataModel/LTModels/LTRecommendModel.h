//
//  LTRecommendModel.h
//  LetvIphoneClient
//
//  Created by bob on 13-8-15.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTChannelIndexModel.h>
#import <LetvMobileDataModel/LTLiveModel.h>

@protocol LTRecommendSearchWord @end
@interface LTRecommendSearchWord : JSONModel

@property (nonatomic, strong) NSString<Optional> *nameCn;

@end


@protocol LTRecommendShowTagListModel @end

@interface LTRecommendShowTagListModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *key;
@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *value;

@end

@protocol  LTRecommendVideoModel @end
@interface LTRecommendVideoModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *pid;
@property (nonatomic, strong) NSString<Optional> *vid;
@property (nonatomic, strong) NSString<Optional> *zid;
@property (nonatomic, strong) NSString<Optional> *cmsid;
@property (nonatomic, strong) NSString<Optional> *nameCn;
@property (nonatomic, strong) NSString<Optional> *subTitle;
@property (nonatomic, strong) NSString<Optional> *cid;
@property (nonatomic, strong) NSString<Optional> *type;
@property (nonatomic, strong) NSString<Optional> *at;
@property (nonatomic, strong) NSString<Optional> *episode;
@property (nonatomic, strong) NSString<Optional> *nowEpisodes;
@property (nonatomic, strong) NSString<Optional> *isEnd;
@property (nonatomic, strong) NSString<Optional> *play;
@property (nonatomic, strong) NSString<Optional> *jump;
@property (nonatomic, strong) NSString<Optional> *pay;
@property (nonatomic, strong) NSString<Optional> *stamp;
@property (nonatomic, strong) NSString<Optional> *pic;
@property (nonatomic, strong) NSString<Optional> *streamCode;
@property (nonatomic, strong) NSString<Optional> *webUrl;
@property (nonatomic, strong) NSString<Optional> *webViewUrl;
@property (nonatomic, strong) NSString<Optional> *pic_200_150;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
@property (nonatomic, strong) NSString<Optional> *padPic;
@property (nonatomic, strong) NSString<Optional> *homeMark;     // Pad首页标记直播Cell
#endif
@property (nonatomic, strong) NSString<Optional> *streamUrl;
@property (nonatomic, strong) NSString<Optional> *tm;
@property (nonatomic, strong) NSArray<FilterModel, Optional> *showTagList;
@property (nonatomic, strong) NSString<Optional> *duration;
@property (nonatomic, strong) NSString<Optional> *singer;
@property (nonatomic, strong) NSString<Optional> *is_rec;
@property (nonatomic, strong) NSString<Optional> *albumType;                    // 专辑类型
@property (nonatomic, strong) NSString<Optional> *varietyShow;                  // 是否是栏目:1 - 是，0 - 否
@property (nonatomic, strong) NSString<Optional> *videoType;                    // 视频类型

@property (nonatomic, strong) NSString<Optional> *pageid;                       // at点击跳转
@property (nonatomic, strong) NSString<Optional> *liveid;                       // 直播场次id
@property (nonatomic, strong) NSString<Optional> *homeImgUrl;                   // 主队图标
@property (nonatomic, strong) NSString<Optional> *guestImgUrl;                  // 客队图标
@property (nonatomic, strong) NSString<Optional> *id;                           // 直播id

@property (nonatomic, strong) NSString<Optional> *mobilePic;    // 5.8.1运营位添加
@property (nonatomic, strong) NSString<Optional> *shorDesc;     // 运营位的按钮文字

@property (nonatomic, strong) NSString<Optional> *pic1;         // 5.9首页直播图
@property (nonatomic, strong) NSString<Optional> *extendSubscript; // 角标
@property (nonatomic, strong) NSString<Optional> *subsciptColor; // 角标色值
// PageCard
@property (nonatomic, strong) NSString<Optional> *cellSpace;
@property (nonatomic, strong) NSDictionary<Optional> *picList;//图片list
@property (nonatomic, strong) NSString<Optional> *pic_300x300;//明星模块图片
@property (nonatomic, strong) NSString<Optional> *pic_400x300;//默认图片 当pageCard 样式在xml 中找不到时默认读取这个图片


// 明星模块 明星id
@property (nonatomic, strong) NSString<Optional> *leId;
// 全景视频 vtypeFlag包含2(字符串)的是全景视频
@property (strong, nonatomic) NSString<Optional> *vtypeFlag;

// 用于传值
@property (nonatomic, strong) NSString<Optional> *reID;

// 判断是否专辑，如果有pid只传pid，vid传空
@property (nonatomic, strong) NSString<Optional> *isalbum;

- (NSString *)getUpdateInfo;
- (NSString *)getDuration;
- (NSString *)getIcon;
- (NSString *)getIconForSize;
- (BOOL)isValid;

/**
 *  是否是全景视频
 *
 *  @return
 */
- (BOOL)isPanorama;
@end


@interface LTLiveCmsReccomendModel : JSONModel

@property (nonatomic, strong) NSArray<LTRecommendVideoModel,Optional> *blockContent;

@end

//专题
@protocol  LTSpecialTopicVideoModel @end
@interface LTSpecialTopicVideoModel : JSONModel


@property (nonatomic, strong) NSString<Optional> *zid;
@property (nonatomic, strong) NSString<Optional> *nameCn;
@property (nonatomic, strong) NSString<Optional> *subTitle;
@property (nonatomic, strong) NSString<Optional> *padPic;
@property (nonatomic, strong) NSString<Optional> *pic;
@property (nonatomic, strong) NSString<Optional> *webViewUrl;
@property (nonatomic, strong) NSString<Optional> *at;

@end


@protocol LTRecommendBootimgModel @end
@interface LTRecommendBootimgModel : JSONModel {
    
}

@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *pic_1;
@property (nonatomic, strong) NSString<Optional> *pic_2;
@property (nonatomic, strong) NSString<Optional> *pushpic_starttime;
@property (nonatomic, strong) NSString<Optional> *pushpic_endtime;
// @property (nonatomic, strong) NSString<Optional> *order;

// 获取开机推送图名称
- (NSString *)getPushPicName;

// 获取开机推送图优先级
- (LTBootImagePriority)getPushPicPriority;

@end


@protocol LTRecommendFocusPic @end
@interface LTRecommendFocusPic : JSONModel

@property (nonatomic, strong) NSString<Optional> *pid;
@property (nonatomic, strong) NSString<Optional> *vid;
@property (nonatomic, strong) NSString<Optional> *zid;
@property (nonatomic, strong) NSString<Optional> *nameCn;
@property (nonatomic, strong) NSString<Optional> *subTitle;
@property (nonatomic, strong) NSString<Optional> *cid;
@property (nonatomic, strong) NSString<Optional> *type;
@property (nonatomic, strong) NSString<Optional> *at;
@property (nonatomic, strong) NSString<Optional> *episode;
@property (nonatomic, strong) NSString<Optional> *nowEpisodes;
@property (nonatomic, strong) NSString<Optional> *isEnd;
@property (nonatomic, strong) NSString<Optional> *play;
@property (nonatomic, strong) NSString<Optional> *jump;
@property (nonatomic, strong) NSString<Optional> *pay;
@property (nonatomic, strong) NSString<Optional> *stamp;
@property (nonatomic, strong) NSString<Optional> *pic;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
@property (nonatomic, strong) NSString<Optional> *padPic;
#endif
@property (nonatomic, strong) NSString<Optional> *streamCode;
@property (nonatomic, strong) NSString<Optional> *webUrl;
@property (nonatomic, strong) NSString<Optional> *webViewUrl;
@property (nonatomic, strong) NSString<Optional> *pic_200_150;
@property (nonatomic, strong) NSString<Optional> *streamUrl;
@property (nonatomic, strong) NSString<Optional> *tm;
@property (nonatomic, strong) NSArray<LTRecommendShowTagListModel, Optional> *showTagList;
@property (nonatomic, strong) NSString<Optional> *albumType;                    // 专辑类型
@property (nonatomic, strong) NSString<Optional> *varietyShow;                  // 是否是栏目:1 - 是，0 - 否
@property (nonatomic, strong) NSString<Optional> *videoType;                    // 视频类型
@property (nonatomic, strong) NSString<Optional> *pageid;                       // at点击跳转
@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *liveid;    // 场次id
#ifdef LT_MERGE_FROM_IPAD_CLIENT
@property (nonatomic, strong) NSString<Optional> *homeImgUrl;                   // 主队图标
@property (nonatomic, strong) NSString<Optional> *guestImgUrl;                  // 客队图标
#endif


- (BOOL)isShortVideoSeries;

- (BOOL)isValid;

@end

@protocol LTRecommendRedFieldModel @end
@interface LTRecommendRedFieldModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *redFieldTypeList;     // 跳转字段类型
@property (nonatomic, strong) NSString<Optional> *redFieldDetailList;   // 跳转字段内容
@end

@protocol LTRecommendBlockModel @end

@interface LTRecommendBlockModel : JSONModel

/**
 *  PageCard section相关信息
 */
@property (strong, nonatomic) LTPageCardSectionModel <Optional> *sectionModel;

@property (nonatomic, strong) NSString<Optional> *templateType;                 // 5.3版本以后去掉
@property (nonatomic, strong) NSString<Optional> *blockname;
@property (nonatomic, strong) NSString<Optional> *cid;
@property (nonatomic, strong) NSMutableArray<LTRecommendVideoModel, Optional> *video;
@property (nonatomic, strong) NSString<Optional> *area;
@property (nonatomic, strong) NSString<Optional> *bucket;
@property (nonatomic, strong) NSString<Optional> *cms_num;
@property (nonatomic, strong) NSString<Optional> *reid;
@property (nonatomic, strong) NSString<Optional> *fragId;

@property (nonatomic, strong) NSString<Optional> *contentStyle;         // 以下5.5版本添加，用于显示类型区分
@property (nonatomic, strong) NSString<Optional> *redirectCid;          // 跳转频道id
@property (nonatomic, strong) NSArray<LTRecommendRedFieldModel, Optional> *redField; 
@property (nonatomic, strong) NSString<Optional> *redirectPageId;       // 跳转页面id
@property (nonatomic, strong) NSString<Optional> *redirectType;         // 跳转类型 1 搜索 2 首页 3 h5
@property (nonatomic, strong) NSString<Optional> *redirectUrl;          // 跳转url
@property (nonatomic, strong) NSString<Optional> *redirectVideoType;    // 专辑/视频 1 视频 2 专题
@property (strong, nonatomic) NSMutableArray<ChannelListBlockModel, Optional> *subBlock;  //6.2新加subblock

- (void)addStatisticAction:(LTDCPageID)pageID index:(NSInteger)index section:(NSInteger)sctioin;
- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index;
@end

// CMS数据
@interface LTRecommendModel : JSONModel

@property (nonatomic, strong) NSMutableArray<LTRecommendVideoModel, Optional> *focuspic;
@property (nonatomic, strong) NSMutableArray<LTRecommendBlockModel, Optional> *block; // 推荐频道数据
@property (nonatomic, strong) NSArray<LTRecommendBootimgModel, Optional> *bootimg;
@property (nonatomic, strong) NSNumber<Optional> *isCacheBack;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
@property (nonatomic, strong) NSMutableArray<LTRecommendVideoModel, Optional> *recommend;
@property (nonatomic, strong) NSMutableArray<LTRecommendSearchWord, Optional> *searchwords;
#endif

- (BOOL)isPushPicExisted:(NSString *)picname;

- (void)removeInvalidData;

/**
 *  是否需要缓存数据
 *
 *  @return 返回YES需要，NO不需要
 */
- (BOOL)isShouldCache;
@end
//专题
@interface LTSpecialTopicModel : JSONModel
@property (nonatomic, strong) NSMutableArray<LTSpecialTopicVideoModel, Optional> *block; // 推荐频道数据

@end

// 个性化推荐数据
@interface LTPersonalizedRecommendModel : JSONModel

@property (nonatomic, strong) NSArray<LTRecommendBlockModel, Optional> *block;

- (void)removeInvalidData;

@end

@interface LTRecommendBlockContentModel : JSONModel
@property (nonatomic, strong) NSMutableArray<LTRecommendVideoModel, Optional> *blockContent;
@end


//** 6.1添加启动图logo图片 **//
@interface LTRecommendLaunchLogoPicModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *pic1;         // iPhone4图
@property (nonatomic, strong) NSString<Optional> *pic2;         // iPhone5图
@property (nonatomic, strong) NSString<Optional> *mobilePic;    // iPhone6图
@property (nonatomic, strong) NSString<Optional> *padPic;       // iPhone6Plus图
@end

@interface LTRecommendLauchLogoModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) LTRecommendLaunchLogoPicModel<Optional> *picList;
@end

@interface LTRecommendLaunchLogoBlockModel : JSONModel
@property (nonatomic, strong) LTRecommendLauchLogoModel<Optional> *blockContent;
- (NSString *)getIconForSize;
@end
//****//

// 首页推广位的数据

@protocol LTRecommendPromotionBlockModel @end

@interface LTRecommendPromotionCMSModel : JSONModel
@property (nonatomic, strong) NSArray<LTRecommendVideoModel, Optional> *rows;
@end

@interface LTRecommendPromotionLiveDataModel : JSONModel
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel, Optional> *rows;
@end

@interface LTRecommendPromotionTVDataModel : JSONModel
@property (nonatomic, strong) NSArray<LTLiveChannelListDetailModel, Optional> *rows;
@end

@interface LTRecommendPromotionBlockModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *type; // live:直播、cms:CMS数据、tv:卫视台
@property (nonatomic, strong) NSDictionary<Optional> *content;
@property (nonatomic, strong) id<Optional> detailModel;
@end

@interface LTRecommendPromotionReusltModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *style;
@property (nonatomic, strong) LTRecommendPromotionCMSModel<Optional> *cmsData;
@property (nonatomic, strong) LTRecommendPromotionLiveDataModel<Optional> *liveData;
@property (nonatomic, strong) LTRecommendPromotionTVDataModel<Optional> *tvData;
@property (nonatomic, strong) NSArray<Optional> *rows;
@property (nonatomic, strong) NSString<Optional> *liveNum;
@end

@interface LTRecommendPromotionModel : JSONModel
@property (nonatomic, strong) LTRecommendPromotionReusltModel<Optional> *result;
@end
