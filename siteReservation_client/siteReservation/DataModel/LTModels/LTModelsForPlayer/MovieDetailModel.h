//
//  MovieDetailModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-2.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

#import <LetvMobileDataModel/PicCollectionModel.h>
#import <LetvMobileDataModel/AtListModel.h>
#import <LetvMobileDataModel/LTOrderInfo.h>
#import <LetvMobileDataModel/LTDataModelCommDef.h>
#import <LetvMobileDataModel/VideoModel.h>

#ifndef LT_IPAD_CLIENT

@protocol MovieDetailModel

@end

@interface MovieDetailModel : JSONModel

/**
 *  @brief  该id只用作兼容旧接口  请不要使用，请使用pid
 */
@property (strong, nonatomic) NSString<Optional> *id DEPRECATED_ATTRIBUTE;                         // String	专辑id
@property (strong, nonatomic) NSString<Optional> *nameCn;                     // String	专辑标题
@property (strong, nonatomic) NSString<Optional> *subTitle;         // String	副标题
@property (strong, nonatomic) PicCollectionModel<Optional> *picCollections;   // picCollections	图片列表
@property (strong, nonatomic) NSString<Optional> *score;            // string	评分
@property (strong, nonatomic) NSString *cid;                        // String	频道id
@property (assign, nonatomic) VIDEOSOURCE type;                     // String	影片来源标示：1-vrs专辑,2-ptv视频,3-vrs视频
@property (assign, nonatomic) LT_VIDEO_AT at;                       // String	点击展示方式：1-进详情，2-直接播放，默认为直接播放
@property (strong, nonatomic) AtListModel<Optional> *atList;        // atList   扩展点击展示方式所需属性列表
@property (strong, nonatomic) NSString<Optional> *releaseDate;      // string	上映时间
@property (strong, nonatomic) NSString<Optional> *episode;        // String	总集数（编辑填写的）
@property (strong, nonatomic) NSString<Optional> *nowEpisodes;    // String	当前已经更新的正片集数（编辑填写的最大值）
@property (strong, nonatomic) NSString<Optional> *platformVideoNum; // string	代表推送到移动端视频总数,包含正片和非正片
@property (strong, nonatomic) NSString<Optional> *platformVideoInfo;// string 代表推送到移动端视频总数,只包含正片总数  V5.1 added.(后台系统算出来的)
@property (strong, nonatomic) NSString<Optional> *isEnd;          // String	是否完结 1:完结;0未完结
@property (assign, nonatomic) BOOL play;                            // String	1:可以播放;0:不可以播放
@property (strong, nonatomic) NSString<Optional> *albumTypeKey;    //是否为正片专辑
@property (strong, nonatomic) NSString<Optional> *duration;         // string	时长
@property (strong, nonatomic) NSString<Optional> *directory;         // string	导演
@property (strong, nonatomic) NSString<Optional> *starring;          // string	主演
@property (strong, nonatomic) NSString<Optional> *desc;             // description string	描述
@property (strong, nonatomic) NSString<Optional> *pidsubtitle;      //专辑副标题
@property (strong, nonatomic) NSString<Optional> *area;              // string	地区
@property (strong, nonatomic) NSString<Optional> *subCategory;       // string	子分类
@property (strong, nonatomic) NSString<Optional> *style;            // string	详情页面类型：1-剧集形式,2-列表形式,3-单片形式；非以上类型，默认为进列表形式
@property (strong, nonatomic) NSString<Optional> *playTv;           // string	播出电视台
@property (strong, nonatomic) NSString<Optional> *school;           // string	学校
@property (strong, nonatomic) NSString<Optional> *language;         // string   语言
@property (strong, nonatomic) NSString<Optional> *instructor;       // string   讲师
@property (strong, nonatomic) NSString<Optional> *tag;              // string   标签
@property (assign, nonatomic) BOOL jump;                            // String	1:外跳，0:不外跳
@property (assign, nonatomic) BOOL pay;                             // String	1:需要支付;0:免费
@property (strong, nonatomic) NSString<Optional> *download;       // string	1:支持缓存;0:禁止缓存
@property (strong, nonatomic) NSString<Optional> *pid;              // String	视频所属的专辑id，不属于任何专辑时为空字符串（专辑无此属性）
@property (strong, nonatomic) NSString<Optional> *stamp;          // String	盖章类型：new-最新，hot-最热，exclusive-独播，final-大结局，titbits-花絮，prevue-预告，clear-高清，end-完结，classic-经典
@property (strong, nonatomic) NSString<Optional> *musicStyle;       // String   音乐类型
@property (strong, nonatomic) NSString<Optional> *singer;           // String   歌手名字。
@property (strong, nonatomic) NSString<Optional> *filmstyle;
@property (strong, nonatomic) NSString<Optional> *travelType;

@property (strong, nonatomic) NSString<Optional> *varietyShow;
@property (strong, nonatomic) NSString<Optional> *relationAlbumId;
@property (strong, nonatomic) NSString<Optional> *relationId;
@property (strong, nonatomic) NSString<Optional> *playCount;
@property (strong, nonatomic) NSString<Optional> *isSelected; //非服务器字段
//iPad 5.5添加  iPhone 5.7也需要。
@property (strong, nonatomic) NSString<Optional> *compere;          //主持人
//@property (strong, nonatomic) NSString<Optional> *subcid;
@property (strong, nonatomic) NSString<Optional> *controlAreas;     //受控区域。
@property (strong, nonatomic) NSString<Optional> *disableType;      //1:全部允许;2:部分允许;3:中国大陆外全部屏蔽;4:部分屏蔽
@property (strong, nonatomic) NSString<Optional> *alias;            //别名(电影)
@property (strong, nonatomic) NSString<Optional> *playStatus;       //更新频率(电视剧、动漫、综艺)
@property (strong, nonatomic) NSString<Optional> *cast;              //声优(动漫)
@property (strong, nonatomic) NSString<Optional> *fitAge;            //适应年龄(动漫)                                          OK
@property (strong, nonatomic) NSString<Optional> *originator;        //原作(动漫)
@property (strong, nonatomic) NSString<Optional> *supervise;         //监督(动漫)
@property (strong, nonatomic) NSString<Optional> *dub;               //配音(动漫)
//@property (strong, nonatomic) NSString<Optional> *rCompany;         //节目来源(纪录片)
@property (strong, nonatomic) NSString<Optional> *isHomemade;        //是否为自制(0为否,1为是)
@property (strong, nonatomic) NSString<Optional> *cornerMark;         // 角标
@property (strong, nonatomic) NSString<Optional>* isVipDownload;   //仅会员下载判断
//iPhone V6.8添加的新字段
- (instancetype)initWithVideoModel:(VideoModel*)model;
// 对应属性（__propertyName）的类型转换
//- (BOOL)download;
//- (LT_STAMP_TYPE)stamp;
//- (BOOL)isEnd;
//- (BOOL)varietyShow;
////该专辑总集数(编辑填写)
//- (NSInteger)episode;
////当前已经更新的正片集数(编辑填写的最大值)
//- (NSInteger)nowEpisodes;
////代表推送到移动端视频总数,包含正片和非正片
//- (NSInteger)platformVideoNum;
////代表推送到移动端视频总数,只包含正片总数(后台系统算出来的)
//- (NSInteger)platformVideoInfo;

// 获取专辑ID
- (NSString *)getAlbumId;
// 是否为短视频连播，首页使用
- (BOOL)isShortVideoSeries;
// 是否支持缓存
- (BOOL)isDownloadSupported;
// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload;
// 更新集数显示字符串
- (NSString *)getUpdateInfo;
// at url
- (NSString *)getAtUrl;
// 是否支持分享到大咔
- (BOOL)isShareToStarcastSupported;

// 显示样式
- (MovieShowStyle)getMovieShowStyle;
// 付费片子显示信息 vip/price
- (NSString *)getVipTag;
// 付费片子订单信息
- (LTOrderInfo *)getOrderInfo;
//得到收藏icon
- (NSString *)getFavIcon;
// icon
- (NSString *)icon;
- (NSString *)getDownloadIcon;
// 是否为跟播剧
- (BOOL)isTVUpdating;
// 是否需要合并VideoList
- (BOOL)isNeedMergeVideoList;
// 是否需要倒序显示
- (BOOL)isNeedOrderVideoListDesc;
// videoList 总数
- (NSInteger)getTotalCountOfVideoInfo;
// 是否已经添加到收藏/追剧
- (BOOL)isAlreadyFavorited;
- (BOOL)isAlreadyFav;


-(BOOL)isMiniFilm;
- (BOOL)isShowWithGroup;

@end

#else

@protocol MovieDetailModel

@end

@interface MovieDetailModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *albumType;       // 专辑类型
/**
 *  @brief  该id只用作兼容旧接口  请不要使用，请使用pid
 */
@property (strong, nonatomic) NSString<Optional> *id DEPRECATED_ATTRIBUTE;                         // String	专辑id
@property (strong, nonatomic) NSString *nameCn;                     // String	专辑标题
@property (strong, nonatomic) NSString<Optional> *subTitle;         // String	副标题
@property (strong, nonatomic) PicCollectionModel<Optional> *picCollections;   // picCollections	图片列表
@property (strong, nonatomic) NSString<Optional> *score;            // string	评分
@property (strong, nonatomic) NSString *cid;                        // String	频道id
@property (assign, nonatomic) VIDEOSOURCE type;                     // String	影片来源标示：1-vrs专辑,2-ptv视频,3-vrs视频
@property (assign, nonatomic) LT_VIDEO_AT at;                       // String	点击展示方式：1-进详情，2-直接播放，默认为直接播放
@property (strong, nonatomic) AtListModel<Optional> *atList;        // atList   扩展点击展示方式所需属性列表
@property (strong, nonatomic) NSString<Optional> *releaseDate;      // string	上映时间
@property (strong, nonatomic) NSString<Optional> *episode;        // String	总集数（编辑填写的）
@property (strong, nonatomic) NSString<Optional> *nowEpisodes;    // String	当前已经更新的正片集数（编辑填写的最大值）
@property (strong, nonatomic) NSString<Optional> *platformVideoNum; // string	代表推送到移动端视频总数,包含正片和非正片
@property (strong, nonatomic) NSString<Optional> *platformVideoInfo;// string 代表推送到移动端视频总数,只包含正片总数  V5.1 added.(后台系统算出来的)
@property (strong, nonatomic) NSString<Optional> *isEnd;          // String	是否完结 1:完结;0未完结
@property (assign, nonatomic) BOOL play;                            // String	1:可以播放;0:不可以播放
@property (strong, nonatomic) NSString<Optional> *albumTypeKey;    //是否为正片专辑
@property (strong, nonatomic) NSString<Optional> *duration;         // string	时长
@property (strong, nonatomic) NSString<Optional> *directory;         // string	导演
@property (strong, nonatomic) NSString<Optional> *starring;          // string	主演
@property (strong, nonatomic) NSString<Optional> *desc;             // description string	描述
@property (strong, nonatomic) NSString<Optional> *pidsubtitle;      //专辑副标题
@property (strong, nonatomic) NSString<Optional> *area;              // string	地区
@property (strong, nonatomic) NSString<Optional> *subCategory;       // string	子分类
@property (strong, nonatomic) NSString<Optional> *style;            // string	详情页面类型：1-剧集形式,2-列表形式,3-单片形式；非以上类型，默认为进列表形式
@property (strong, nonatomic) NSString<Optional> *playTv;           // string	播出电视台
@property (strong, nonatomic) NSString<Optional> *school;           // string	学校
@property (strong, nonatomic) NSString<Optional> *language;         // string   语言
@property (strong, nonatomic) NSString<Optional> *instructor;       // string   讲师
@property (strong, nonatomic) NSString<Optional> *tag;              // string   标签
@property (assign, nonatomic) BOOL jump;                            // String	1:外跳，0:不外跳
@property (assign, nonatomic) BOOL pay;                             // String	1:需要支付;0:免费
@property (strong, nonatomic) NSString<Optional> *download;       // string	1:支持缓存;0:禁止缓存
@property (strong, nonatomic) NSString<Optional> *pid;              // String	视频所属的专辑id，不属于任何专辑时为空字符串（专辑无此属性）
@property (strong, nonatomic) NSString<Optional> *stamp;          // String	盖章类型：new-最新，hot-最热，exclusive-独播，final-大结局，titbits-花絮，prevue-预告，clear-高清，end-完结，classic-经典
@property (strong, nonatomic) NSString<Optional> *musicStyle;       // String   音乐类型
@property (strong, nonatomic) NSString<Optional> *singer;           // String   歌手名字。
@property (strong, nonatomic) NSString<Optional> *filmstyle;
@property (strong, nonatomic) NSString<Optional> *travelType;
@property (strong, nonatomic) NSString<Optional> *relationAlbumId;
@property (strong, nonatomic) NSString<Optional> *relationId;
@property (strong, nonatomic) NSString<Optional> *varietyShow;
@property (strong, nonatomic) NSString<Optional> *playCount;
@property (strong, nonatomic) NSString<Optional> *isSelected; //非服务器字段

//iPad 5.5添加。
@property (strong, nonatomic) NSString<Optional> *compere;          //主持人
//@property (strong, nonatomic) NSString<Optional> *subcid;
@property (strong, nonatomic) NSString<Optional> *controlAreas;     //受控区域。
@property (strong, nonatomic) NSString<Optional> *disableType;      //1:全部允许;2:部分允许;3:中国大陆外全部屏蔽;4:部分屏蔽
@property (strong, nonatomic) NSString<Optional> *alias;            //别名(电影)
@property (strong, nonatomic) NSString<Optional> *playStatus;       //更新频率(电视剧、动漫、综艺)
@property (strong, nonatomic) NSString<Optional> *cast;              //声优(动漫)
@property (strong, nonatomic) NSString<Optional> *fitAge;            //适应年龄(动漫)                                          OK
@property (strong, nonatomic) NSString<Optional> *originator;        //原作(动漫)
@property (strong, nonatomic) NSString<Optional> *supervise;         //监督(动漫)
@property (strong, nonatomic) NSString<Optional> *dub;               //配音(动漫)
//@property (strong, nonatomic) NSString<Optional> *rCompany;         //节目来源(纪录片)
@property (strong, nonatomic) NSString<Optional> *isHomemade;        //是否为自制(0为否,1为是)

@property (strong, nonatomic) NSString<Optional>* cornerMark;         //海报角标文案
@property (strong, nonatomic) NSString<Optional>* isVipDownload;   //仅会员下载判断

- (instancetype)initWithVideoModel:(VideoModel*)model;
// 对应属性（__propertyName）的类型转换
//- (BOOL)varietyShow;
//- (BOOL)download;
//- (LT_STAMP_TYPE)stamp;
//- (BOOL)isEnd;
////该专辑总集数(编辑填写)
//- (NSInteger)episode;
////当前已经更新的正片集数(编辑填写的最大值)
//- (NSInteger)nowEpisodes;
////代表推送到移动端视频总数,包含正片和非正片
//- (NSInteger)platformVideoNum;
////代表推送到移动端视频总数,只包含正片总数(后台系统算出来的)
//- (NSInteger)platformVideoInfo;

// 是否按月显示
- (BOOL)isShowWithGroup;
// 获取专辑ID
- (NSString *)getAlbumId;
// 是否为短视频连播，首页使用
- (BOOL)isShortVideoSeries;
// 是否支持缓存
- (BOOL)isDownloadSupported;
// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload;
// 更新集数显示字符串
- (NSString *)getUpdateInfo;
// at url
- (NSString *)getAtUrl;
// 是否支持分享到大咔
- (BOOL)isShareToStarcastSupported;

// 显示样式
- (MovieShowStyle)getMovieShowStyle;
// 付费片子显示信息 vip/price
- (NSString *)getVipTag;
// 付费片子订单信息
- (LTOrderInfo *)getOrderInfo;
//得到收藏icon
- (NSString *)getFavIcon;
// icon
- (NSString *)icon;
- (NSString *)getDownloadIcon;
// 是否为跟播剧
- (BOOL)isTVUpdating;
// 是否需要合并VideoList
- (BOOL)isNeedMergeVideoList;
// 是否需要倒序显示
- (BOOL)isNeedOrderVideoListDesc;
// videoList 总数
- (NSInteger)getTotalCountOfVideoInfo;
// 是否已经添加到收藏/追剧
- (BOOL)isAlreadyFavorited;


-(BOOL)isMiniFilm;

// 是否正片
- (BOOL)isPositive;

@end


#endif
