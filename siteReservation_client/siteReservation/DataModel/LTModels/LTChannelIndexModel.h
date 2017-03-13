//
//  LTChannelIndexModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-11-5.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>
#import <LetvMobileDataModel/LTLiveModel.h>

@protocol  FocusPicModel@end
@interface FocusPicModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *pid;  //专辑id
@property (strong, nonatomic) NSString<Optional> *vid;  //视频id
@property (strong, nonatomic) NSString<Optional> *zid; // 专题id
@property (strong, nonatomic) NSString<Optional> *cmsid; // CMS中的记录唯一标示id
@property (strong, nonatomic) NSString<Optional> *nameCn;  //视频名称
@property (strong, nonatomic) NSString<Optional> *subTitle;  //副标题
@property (strong, nonatomic) NSString<Optional> *cid;  //频道id
@property (strong, nonatomic) NSString<Optional> *type;  //影片来源标示：1-vrs专辑,2-ptv视频,3-vrs视频
@property (strong, nonatomic) NSString<Optional> *at;  //点击展示方式
@property (strong, nonatomic) NSString<Optional> *__nowEpisodes;  //专辑id
@property (strong, nonatomic) NSString<Optional> *__episode;
@property (strong, nonatomic) NSString<Optional> *__isEnd;     // String	是否完结 1:完结;0未完结
@property (strong, nonatomic) NSString<Optional> * __play;      // String	1:可以播放;0:不可以播放
@property (strong, nonatomic) NSString<Optional> *__jump;      // String	1:外跳，0:不外跳
@property (strong, nonatomic) NSString<Optional> *__pay;       // String	1:需要支付;0:免费
@property (strong, nonatomic) NSString<Optional> *tag;   // string   标签
@property (strong, nonatomic) NSString<Optional> *pic;  //图片，尺寸：640 x 316
@property (strong, nonatomic) NSString<Optional> *pic_200_150;  //图片，尺寸：200*150
@property (strong, nonatomic) NSString<Optional> *padPic;  //pad图片，尺寸：984*288
@property (strong, nonatomic) NSString<Optional> *streamCode;  //直播编号
@property (strong, nonatomic) NSString<Optional> *streamUrl;    //直播流地址
@property (strong, nonatomic) NSString<Optional> *tm;    //过期时间戳
@property (strong, nonatomic) NSString<Optional> *webUrl; //外跳url
@property (strong, nonatomic) NSString<Optional> *webViewUrl; // 内嵌url
@property (strong, nonatomic) NSString<Optional> *is_rec;   // 是否是推荐
@property (strong, nonatomic) NSString<Optional> *singer;//5.5新增 歌手
@property (strong, nonatomic) NSString<Optional> *duration;//5.5新增 时长（秒）
@property (strong, nonatomic) NSString<Optional> *pageid;

@property (strong, nonatomic) NSString<Optional> *__id;//直播用
@property (nonatomic, strong) NSString<Optional> *liveid;    // 场次id
// 全景视频 vtypeFlag包含2(字符串)的是全景视频
@property (strong, nonatomic) NSString<Optional> *vtypeFlag;

// 判断是否专辑，如果有pid只传pid，vid传空
@property (nonatomic, strong) NSString<Optional> *isalbum;

- (NSInteger)episode;
- (NSInteger)nowEpisodes;

-(NSString *)getIcon;
// 更新集数显示字符串
- (NSString *)getUpdateInfo;

- (BOOL)pay;
- (BOOL)jump;

- (BOOL)isValid;

/**
 *  是否是全景视频
 *
 *  @return
 */
- (BOOL)isPanorama;
@end

@protocol ChannelNavigationModel@end
@interface ChannelNavigationModel : JSONModel
@property (strong, nonatomic) NSString<Optional> *nameCn;
@property (strong, nonatomic) NSString<Optional> *pageid;
@property (strong, nonatomic) NSString<Optional> *mobilePic;
@property (strong, nonatomic) NSString<Optional> *at;
@property (strong, nonatomic) NSString<Optional> *cid;
@property (strong, nonatomic) NSString<Optional> *skipPage;
@end

@protocol  FilterModel@end
@interface FilterModel : JSONModel
@property (strong, nonatomic) NSString<Optional> *id;
@property (strong, nonatomic) NSString<Optional> *key;
@property (strong, nonatomic) NSString<Optional> *value;
@end

@protocol  RedirectModel@end
@interface RedirectModel : JSONModel
@property (strong, nonatomic) NSString<Optional> *redFieldTypeList; //跳转字段类型
@property (strong, nonatomic) NSString<Optional> *redFieldDetailList; //跳转字段内容
@end

@protocol  LinkPropertyModel@end
@interface LinkPropertyModel : JSONModel
@property (strong, nonatomic) NSString<Optional> *cid; //频道id
@property (strong, nonatomic) NSArray<FilterModel, Optional>* filter;
@end

@protocol LTPageCardSectionModel@end
@interface LTPageCardSectionModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *cellCount;

@property (strong, nonatomic) NSMutableArray<Optional> *cellItems;

@property (strong, nonatomic) NSString<Optional> *sectionTitle;

/**
 *  cell外部的间距
 */
@property (strong, nonatomic) NSString<Optional> *cellMargin;

/**
 *  cell内部的填充
 */
@property (strong, nonatomic) NSString<Optional> *cellPadding;

/**
 *  id
 */
@property (strong, nonatomic) NSString<Optional> *id;

/**
 *  header的view样式
 */
@property (strong, nonatomic) NSString<Optional> *sectionHeaderSpace;

/**
 *  每个section头部的高度 （用来标示 该模块是否 进行 多机型不同屏幕尺寸适配，不填代表适配 1 代表不适配）
 */
@property (strong, nonatomic) NSString<Optional> *sectionHeaderHeight;

/**
 *  每个section的列
 */
@property (strong, nonatomic) NSString<Optional> *sectionColumn;

/**
 *  每行的高度(像素)
 *  通过这个值算出section的column,这样就算出来sectionRow
 */
@property (strong, nonatomic) NSString<Optional> *rowHeight;

/**
 *  每行最多能有几行(几行格子)
 *  如果没有设置,默认只是-1
 *  如果是-1,那么优先水平排列
 *  如果不是-1,那么优先垂直排列,当大于这个值的时候往右水平排列
 *  如果排不开那么折行
 */
@property (strong, nonatomic) NSString<Optional> *cellMaxRowCount;

@property (strong, nonatomic) NSArray<Optional> *cellSpace;

@end

@protocol  FilmListModel@end  //5.5新增
@interface FilmListModel : JSONModel

/**
 *  指定当前cell的style类型
 */
@property (strong, nonatomic) NSString<Optional> *cellSpace;
@property (strong, nonatomic) NSDictionary<Optional> *picList;//图片list
@property (strong, nonatomic) NSString<Optional> *pic_300x300;//明星板块图片
@property (strong, nonatomic) NSString<Optional> *pic_400x300;//默认图片

@property (strong, nonatomic) NSString<Optional> *cmsid;  //CMS中的记录唯一标示id（个性化推荐数据无此属性）
@property (strong, nonatomic) NSString<Optional> *pid;  //专辑id
@property (strong, nonatomic) NSString<Optional> *vid; //视频id
@property (strong, nonatomic) NSString<Optional> *zid; //专题id
@property (strong, nonatomic) NSString<Optional> *extends_extendPid; //扩展vid
@property (strong, nonatomic) NSString<Optional> *nameCn;  //视频名称
@property (strong, nonatomic) NSString<Optional> *subTitle;  //副标题
@property (strong, nonatomic) NSString<Optional> *cid;  //频道id
@property (strong, nonatomic) NSString<Optional> *type;  //影片来源标示：1-专辑,3-视频,4-专题
@property (strong, nonatomic) NSString<Optional> *at;  //点击展示方式
@property (strong, nonatomic) NSString<Optional> *episode;  //总集数
@property (strong, nonatomic) NSString<Optional> *nowEpisodes; //跟播的当前总集数
@property (strong, nonatomic) NSString<Optional> *isEnd;     //是否完结 1:完结;0未完结
@property (strong, nonatomic) NSString<Optional> *pay;      //1:需要支付;0:免费（只有专辑有此属性）
@property (strong, nonatomic) NSString<Optional> *tag;   //盖章标签
@property (strong, nonatomic) NSString<Optional> *mobilePic;  //图片
#ifdef LT_MERGE_FROM_IPAD_CLIENT
@property (strong, nonatomic) NSString<Optional> *padPic;  //pad图片
@property (strong, nonatomic) NSString<Optional> *shorDesc;  //大图简介
#endif
@property (strong, nonatomic) NSString<Optional> *streamCode;  //直播编号
@property (strong, nonatomic) NSString<Optional> *webUrl;    //外跳web地址
@property (strong, nonatomic) NSString<Optional> *webViewUrl;    //内嵌webview地址
@property (strong, nonatomic) NSString<Optional> *streamUrl; //直播流地址
@property (strong, nonatomic) NSArray<FilterModel,Optional> *showTagList; //分类标签列表
@property (strong, nonatomic) NSString<Optional> *tm;//过期时间戳
@property (strong, nonatomic) NSString<Optional> *duration;//时长（秒）
@property (strong, nonatomic) NSString<Optional> *singer; //歌手
@property (strong, nonatomic) NSString<Optional> *is_rec; //是否为自动个性化推荐内容：true - 是，false - 否
@property (strong, nonatomic) NSString<Optional> *albumType; //专辑类型
@property (strong, nonatomic) NSString<Optional> *varietyShow; //是否是栏目:1 - 是，0 - 否
@property (strong, nonatomic) NSString<Optional> *videoType; //视频类型
@property (strong, nonatomic) NSString<Optional> *pageid;
@property (nonatomic, strong) NSString<Optional> *id;                           // 直播id
@property (nonatomic, strong) NSString<Optional> *liveid;    // 场次id
@property (nonatomic, strong) NSString<Optional> *playCount;   //播放数
@property (nonatomic, strong) NSString<Optional> *extendSubscript; // 右上角角标
@property (nonatomic, strong) NSString<Optional> *subsciptColor; // 右上角角标背景色
@property (nonatomic, strong) NSString<Optional> *leftSubscipt; // 左上角角标
@property (nonatomic, strong) NSString<Optional> *leftSubsciptColor; // 左上角角标背景色
@property (nonatomic, strong) NSString<Optional> *leftCorner; // 左下角角标
@property (nonatomic, strong) NSString<Optional> *rightCorner; // 右下角角标
@property (nonatomic, strong) NSString<Optional> *director;   //导演（电影频道定制化）
@property (nonatomic, strong) NSString<Optional> *starring;   //主演（电影频道定制化）
@property (nonatomic, strong) NSString<Optional> *score;   //影片得分（电影频道定制化）
@property (nonatomic, strong) NSString<Optional> *sub_category;   //影片类型（电影频道定制化）
// 全景视频 vtypeFlag包含2(字符串)的是全景视频
@property (strong, nonatomic) NSString<Optional> *vtypeFlag;
//明星页 明星id
@property (strong, nonatomic) NSString<Optional> *leId;
// 用于传值
@property (nonatomic, strong) NSString<Optional> *reID;

// 判断是否专辑，如果有pid只传pid，vid传空
@property (nonatomic, strong) NSString<Optional> *isalbum;

#ifdef LT_MERGE_FROM_IPAD_CLIENT
@property (nonatomic, strong) NSString<Optional> *jump;
#endif

@property (nonatomic, strong) LTLiveRoomDetailModel <Optional> *livedata;
@property (nonatomic, strong) NSString<Optional> *skipPage;

- (NSString *)playCountTextFromPlayCount;
- (NSString *)getUpdateInfo;
- (BOOL)isValid;
- (NSString *)getIcon;
- (NSString *)getNewIcon;

/**
 *  是否是全景视频
 *
 *  @return
 */
- (BOOL)isPanorama;
@end


@interface FilmListModelWrapper : JSONModel

@property (nonatomic, strong) FilmListModel *filmListModel;
@property (nonatomic, assign) CGFloat playOffset;
@end


@protocol ChannelListBlockModel@end
@interface ChannelListBlockModel : JSONModel

/**
 *  section相关信息
 */
@property (strong, nonatomic) LTPageCardSectionModel <Optional> *sectionModel;

@property (strong, nonatomic) LinkPropertyModel <Optional>* linkProperty; // 内容列表
@property (strong, nonatomic) LinkPropertyModel <Optional>* linkProperty1; // 附加内容列表
@property (strong, nonatomic) NSString<Optional> *limit;

@property (strong, nonatomic) NSString<Optional> *name;
@property (strong, nonatomic) NSString<Optional> *cid;
@property (strong, nonatomic) NSString<Optional> *area;
@property (strong, nonatomic) NSString<Optional> *bucket;
@property (strong, nonatomic) NSString<Optional> *cms_num;
@property (strong, nonatomic) NSString<Optional> *reid;
@property (strong, nonatomic) NSMutableArray<FilmListModel, Optional> *blockContent;
@property (strong, nonatomic) NSString<Optional> *contentStyle;
//跳转参数
@property (strong, nonatomic) NSString<Optional> *redirectCid; //跳转频道id
@property (strong, nonatomic) NSMutableArray<RedirectModel, Optional> *redField; //跳转字段内容
@property (strong, nonatomic) NSString<Optional> *redirectPageId; //跳转页面id
@property (strong, nonatomic) NSString<Optional> *redirectType; //跳转类型 1 搜索 2 首页 3 h5
@property (strong, nonatomic) NSString<Optional> *redirectUrl; //跳转url
@property (strong, nonatomic) NSString<Optional> *redirectVideoType;//专辑/视频 1 视频 2 专题
@property (nonatomic, strong) NSString<Optional> *fragId;
@property (nonatomic, strong) NSString<Optional> *pageid;
@property (nonatomic, strong) NSString<Optional> *contentType; // 二级页面判断是否是搜索 5 搜索
@property (nonatomic, strong) NSString<Optional> *date; // 节目单新增日期字段
@property (strong, nonatomic) NSMutableArray<ChannelListBlockModel, Optional> *subBlock;  //6.2新加subblock
@property (nonatomic, strong) NSString<Optional> *isLock;  //iPhone 6.6 首页排序

@property (strong, nonatomic) NSString<Optional> *type;         // 分页加载用
@property (strong, nonatomic) NSString<Optional> *isPage;       // 是否支持分页加载1支持 0不支持
@property (strong, nonatomic) NSString<Optional> *num;          // 每页的个数

@property (strong, nonatomic) NSNumber<Optional> *sortId;       //直播首页pagecard排列ID

- (void)addStatisticAction:(LTDCPageID)pageID row:(NSInteger)index section:(NSInteger)section flag:(NSString *)flag;
- (void)addStatisticAction:(LTDCPageID)pageID row:(NSInteger)index section:(NSInteger)section;

- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index;
- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index flag:(NSString *)flag;

@end

@interface LTChannelIndexModel : JSONModel
@property (strong, nonatomic) NSMutableArray<ChannelNavigationModel, Optional> *navigation;//二级导航，5.5增加
@property (strong, nonatomic) NSMutableArray<FilmListModel, Optional> *focuspic; // 焦点图
@property (strong, nonatomic) NSMutableArray<ChannelListBlockModel, Optional> *block; // 内容
@property (nonatomic, strong) NSNumber<Optional> *isCacheBack;
@property (nonatomic, strong) NSString<Optional> *isEdit;
@property (nonatomic, strong) NSString<Optional> *isFromFilter; //分页加载


- (void)removeInvalidData;
- (BOOL)isContainPageID:(NSString *)pageID;
- (BOOL)isContainFilter;
#ifdef LT_IPAD_CLIENT
- (BOOL)isShouldCache:(BOOL)isHome;
#else
#endif

- (NSUInteger)indexOfFilter;
- (BOOL)isContainNav;
/**
 *  是否需要缓存数据
 *
 *  @return 返回YES需要，NO不需要
 */
- (BOOL)isShouldCache;


- (void)checkBody:(NSDictionary *)body;
- (void)removeDonotConformData:(void (^)(NSDictionary *locks, NSDictionary *removes))finishBlock;
- (NSMutableArray<ChannelListBlockModel, Optional> *)modelsArray:(NSMutableArray<ChannelListBlockModel, Optional> *)array addModelFromDictionary:(NSDictionary *)dictionary;

- (BOOL)hasAdvertisementContentStyle;

@end

// 进入频道条件Model
@interface LTChannelConditionModel : NSObject
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pageID;
@property (nonatomic, assign) ChannelIntroType channelType;
@property (nonatomic, assign) CHANNEL_INIT_TYPE initType;
@property (nonatomic, copy) NSArray *filters;
@property (nonatomic, strong) NSString *at;
@property (nonatomic, strong) NSString *skipPage;



// app首页初始化需要
@property (nonatomic, strong) NSString *urlString;      // 网页
@property (nonatomic, assign) BOOL isFromAppHome;       // 来自首页的，由于区分频道首页和app首页的频道
@end

@interface LTEmotionMetaDataModel : JSONModel<NSCoding>

typedef NS_ENUM(NSInteger, EmotionType) {
    EmotionType_none,
    EmotionType_image,
    EmotionType_color
};

@property (nonatomic, copy) NSString<Optional> *icon_2x_checked;
@property (nonatomic, copy) NSString<Optional> *icon_2x_unchecked;
@property (nonatomic, copy) NSString<Optional> *icon_3x_checked;
@property (nonatomic, copy) NSString<Optional> *icon_3x_unchecked;
@property (nonatomic, copy) NSString<Optional> *color_checked;
@property (nonatomic, copy) NSString<Optional> *color_unchecked;

@property (nonatomic, copy) NSString<Optional> *type;//1图片  2颜色

- (EmotionType)getType;
- (UIColor *)getCheckColor;
- (UIColor *)getUncheckColor;
- (NSString *)getUncheckedImageUrl;
- (NSString *)getChecedkImageUrl;
- (NSString *)getSpecialConfigImage;
- (NSMutableArray *)getDownLoadImagesUrl;
+ (BOOL)isSpecialConfig:(NSString *)configName;//特殊配置的图片名称
@end


@interface LTEmotionMaterialModel : JSONModel<NSCoding>
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *le_search_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *top_statusbar_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *le_mall_icon;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *le_game_icon;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *home_history;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *home_download;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *top_pic;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *top_channel_pic;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *home_navigation_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *top_navigation_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *top_navigation_bgcolor;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *bottom_navigation_pic;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *home_pic;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *home_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *vip_pic;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *vip_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *living_pic;;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *living_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *find_pic;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *find_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *myself_pic;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *myself_color;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *le_search_icon;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *le_search_pic;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *le_search_wdcolor;
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *service_bgcolor;

@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *back_pic;//VC返回图片
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *home_logo_pic;//首页乐视视频图片

//611废弃字段
//@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *logo_icon;
//@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *bottom_navigation_line;

//611新增字段
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *le_search_outline;//顶部搜索框轮廓线
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *search_ball;//search_ball
@property (nonatomic, strong) LTEmotionMetaDataModel<Optional> *filter_ball;//filter_ball

@end


@interface LTEmotionDesignModel : JSONModel<NSCoding>

@property (nonatomic, strong) LTEmotionMaterialModel *material;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *startTime;
@property (nonatomic, copy) NSString<Optional> *endTime;
@property (nonatomic, copy) NSString<Optional> *startTimestamp;	//开始时间（时间戳）
@property (nonatomic, copy) NSString<Optional> *endTimestamp;	//结束时间(时间戳)
@property (nonatomic, strong) LTEmotionDesignModel<Optional> *validEmotionModel;

- (NSMutableArray *)getDownloadUrls;
- (BOOL)isInEmotion;
+ (LTEmotionDesignModel *)shareInstance;
+ (UIImage *)convertImageToDeviceScale:(UIImage *)image;
@end


