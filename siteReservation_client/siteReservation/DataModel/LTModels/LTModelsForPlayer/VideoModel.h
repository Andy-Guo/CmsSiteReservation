//
//  VideoModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/PicCollectionModel.h>
#import <LetvMobileDataModel/LTDataModelCommDef.h>

@protocol VideoWatchingFocusModel

@end

@interface VideoWatchingFocusModel : JSONModel

@property(strong,nonatomic) NSString <Optional>* desc;
@property(strong,nonatomic) NSString <Optional>* id;
@property(strong,nonatomic) NSString <Optional>* pic;
@property(strong,nonatomic) NSString <Optional>* time;

@end

@protocol LTVideoPosterModel
@end

@interface LTVideoPosterModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *pic1;
@property (nonatomic, strong) NSString<Optional> *pic2;
@end

@class LTSubjectVideo;
@class LTDownloadCommand,RecommendItem;
@protocol VideoModel

@end

@interface VideoModel : JSONModel
/**
 *  @brief  该id只用作兼容旧接口  请不要使用，请使用vid
 */
@property (strong, nonatomic) NSString<Optional>* id DEPRECATED_ATTRIBUTE;     // string	视频ID
@property (strong, nonatomic) NSString<Optional>* vid;    //合并接口后，新接口的用这个
@property (strong, nonatomic) NSString<Optional>* cid;    // string	频道ID
@property (strong, nonatomic) NSString<Optional>* nameCn; // string	标题
@property (assign, nonatomic) VIDEOSOURCE type; // string	影片来源:3(1:专辑;3:视频)
@property (strong, nonatomic) NSString<Optional> *btime/*JEASONbtime no del!!!!*/;      // string	片头时间
@property (strong, nonatomic) NSString<Optional> *etime/*JEASONetime no del!!!!*/;      // string	片尾时间
@property (strong, nonatomic) NSString<Optional> *duration/*JEASONduration(non del!!)*/;	// string	时长
@property (strong, nonatomic) NSString<Optional>* mid;    // string	媒资ID(一个视频可能对应着多 个媒资id,移动端只取第一个)
@property (strong, nonatomic) NSString<Optional> *episode/*JEASONepisode no del!!!!*/;    // string	正片集数
@property (strong, nonatomic) NSString<Optional> *porder/*JEASONporder no del!!!!*/;     // string	在专辑顺序
@property (assign, nonatomic) BOOL play;        // string	1:可以;0:不可以
@property (assign, nonatomic) BOOL jump;        // string	1:外跳;0:不外跳
@property (assign, nonatomic) BOOL pay;         // string	1:需要支付;0:免费
@property (assign, nonatomic) BOOL album_pay;    // string   1:专辑需要付费; 0:专辑免费
@property (assign, nonatomic) BOOL download;    // string	1:支持下载;0:禁止下载
@property (strong, nonatomic) PicCollectionModel<Optional>* picAll;   // json	图片列表
@property (strong, nonatomic) NSArray<Optional>* brList;                // array	码流支持列表
@property (strong, nonatomic) NSString<Optional>* videoType;    // string	视频类型(参考[视频类型]字典)
@property (strong, nonatomic) NSString<Optional>* pid;          // string	专辑ID
@property (strong, nonatomic) NSString<Optional>* singer;       // string	歌手
@property (strong, nonatomic) NSString<Optional>* subTitle;     // string	副标题
@property (strong, nonatomic) NSString<Optional>* createYear;   // string   创建年份
@property (strong, nonatomic) NSString<Optional>* createMonth;  // string   创建月份
@property (strong, nonatomic) NSString<Optional>* releaseDate;  // string   发布年月日
@property (strong, nonatomic) NSArray<Optional,ConvertOnDemand,VideoWatchingFocusModel>* watchingFocus;//看点
@property (strong, nonatomic) NSString<Optional>* videoTypeKey; // 视频类型的key
@property (strong, nonatomic) NSString<Optional>* cornerMark;   //视频作为列表形式显示，海报图角标内容
@property (strong, nonatomic) NSString<Optional>* copyrightCompany;//公司版权
@property (strong, nonatomic) NSString<Optional>* playMark;//是否为独播
@property (strong, nonatomic) NSString<Optional>* videoTypeName;
@property (strong, nonatomic) NSString<Optional>* style;
//iPad V5.5添加。
@property (strong, nonatomic) NSString<Optional>* videoTypeValue;//视频类型得value
@property (strong, nonatomic) NSString<Optional>* area;             //国家地区
@property (strong, nonatomic) NSString<Optional>* desc;             //iPad 5.5视频简介。
@property (strong, nonatomic) NSString<Optional>* tag;              //标签,多个空格分隔。
@property (strong, nonatomic) NSString<Optional>* subCategory;      //子分类,多个空格分隔。
@property (strong, nonatomic) NSString<Optional>* language;         //语言,多个逗号分隔。
@property (strong, nonatomic) NSString<Optional>* musicStyle;       //音乐类型,多个逗号分隔。
@property (strong, nonatomic) NSString<Optional>* controlAreas;     //受控区域，多个逗号分隔，结合disableType字段处理，空为全部允许。
@property (strong, nonatomic) NSString<Optional>* disableType;      //1:全部允许;2:部分允许;3:中国大陆外全部屏蔽;4:部分屏蔽。
@property (strong, nonatomic) NSString <Optional>* fitAge;           //适应年龄(亲子)。                                            OK
//@property (strong, nonatomic) NSString<Optional>* recreationType;   //娱乐分类(娱乐)
//@property (strong, nonatomic) NSString<Optional>* style;            //分类(资讯（热点）)
//@property (strong, nonatomic) NSString<Optional>* travelTheme;      //旅游主题(旅游)
//@property (strong, nonatomic) NSString<Optional>* sportsType;       //体育分类(体育)
//@property (strong, nonatomic) NSString<Optional>* carfilmType;  //影片类型(财经)
//@property (strong, nonatomic) NSString<Optional>* fieldType;    //领域类型(汽车)
@property (strong, nonatomic) NSString<Optional>* isHomemade;       //是否为自制(0为否,1为是)
@property (strong, nonatomic) NSString<Optional>* guest;            // 嘉宾
@property (strong, nonatomic) NSString<Optional>* playCount;
@property (strong, nonatomic) NSString<Optional>* isSelected;//非服务器
//iPhone V5.7添加新字段。
@property (strong, nonatomic) NSString<Optional>* createTime;       //发布时间。

@property (strong, nonatomic) NSString<Optional>* isVipDownload;   //仅会员下载判断
//iPhone V5.9添加的新字段
/*
 //外跳类型： WEB、WEB_JUMP、TV_JUMP
 //WEB：应该提示“使用网页观看”，但是没外跳地址
 //WEB_JUMP：提示“使用网页观看”，并且提供链接，链接至 jumplink
 //TV_JUMP：提示“使用TV投屏观看”
 */
@property (strong, nonatomic) NSString<Optional>* jumptype;
@property (strong, nonatomic) NSString<Optional>* jumplink;// ""
@property (strong, nonatomic) NSString<Optional>* openby;////是否webview打开，1是  0否。jump = 1 时才会有值，通过cms（cmsid 线上：2938 测试：2939）控制
// iPhone 5.9 新加字段 下一集的vid
@property (strong, nonatomic) NSString<Optional>*nvid; //下一集de vid

// iPhone 6.0 新加字段 是否支持弹幕。
@property (strong, nonatomic) NSString<Optional>* isDanmaku;//1 支持，0，不支持。

//iPhone6.1 新增loading海报图
@property (strong, nonatomic) LTVideoPosterModel<Optional>* poster;//loading海报图
@property (nonatomic, copy) NSString<Optional>* allowVote;//是否支持投票
@property (nonatomic, copy) NSString<Optional> *voteType;//投票类型

//iPhone6.5 新增乐盒视频清晰度
@property (assign, nonatomic) VideoCodeType leBoxMediaCodeType;

// 全景视频 包含2(字符串)的时候是全景视频
@property (strong, nonatomic) NSString<Optional>* vtypeFlag;
@property (strong, nonatomic) NSString<Optional>* dolbyFlag;

@property (strong, nonatomic) NSString<Optional>*  drmFlag; // DRM 判断 YES: 走drm NO: 走防盗链
@property (strong, nonatomic) NSString<Optional>*  pidname;  //专辑名
// iPhone6.15 新增标记是否为短视频
@property (strong, nonatomic) NSString<Optional>*  upgc;  // upgc=1标记短视频 0 普通视频

+ (VideoModel *)videoModelWithSubjectVideoModel:(LTSubjectVideo *)subjectVideo;

+ (BOOL)isAlreadyDownloadCompleteWith:(NSString*)vid;

+ (LTDownloadCommand *)getDBDownloadedInfoWith:(NSString*)vid;

// 对应属性（__propertyName）的类型转换
//- (NSInteger)episode;
//- (NSInteger)porder;
//- (NSArray *)brList;
//- (NSInteger)btime;
//- (NSInteger)etime;
//- (NSInteger)duration;

//- (NSString *)episodeInfo;
- (NSArray *)getInnerBrList;
// 获取icon
- (NSString *)icon;
// 获取小的icon
- (NSString *)smallIcon;
// 是否是正片
- (BOOL)isMainVideo;
// 是否支持播放
- (BOOL)isPlaySupported;
// 是否支持缓存
- (BOOL)isDownloadSupported;
// 是否vip禁止缓存
- (BOOL)isDownloadDisabledByVIP;
// 外跳播放地址
- (NSString *)getJumpOutPlayUrl;
// 是否已经添加到缓存列表
- (BOOL)isAlreadyDownloaded;
- (BOOL) isAlreadyDownloading;
- (BOOL) isDownloadPause;
// 是否已经缓存完成
- (BOOL)isAlreadyDownloadComplete;
// 获取缓存信息
- (LTDownloadCommand*) getDBDownloadedInfo;
// 获取valid缓存码率
- (VideoCodeType)getValidDownloadBitrate;
// UI展示title
- (NSString *)getDisplayTitle;
- (NSString *)getVipTag;

//是否是付费电视剧
- (BOOL) isTVSerialAndPay;
// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload;
/**
 *  是否是全景视频
 *
 *  @return
 */
- (BOOL)isPanorama;

- (BOOL)isDolbyVideo;

/**
 *  是否播的是本地视频
 *
 *  @return
 */
- (BOOL)isPlayingLocal;

/**
 *  转换一个推荐模型为视频信息模型
 *
 *  @param item 推荐模型
 */
- (void)convertToRecommendItem:(RecommendItem*)item;
@end
