//
//  OldMovieDetailModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-3.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/AtListModel.h>
#import <LetvMobileDataModel/OldVideoListModel.h>

@protocol OldMovieDetailModel @end

@interface OldMovieDetailModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *id;                         // String	专辑id
@property (strong, nonatomic) NSString *title;                     // String	专辑标题
@property (strong, nonatomic) NSString<Optional> *subtitle;         // String	副标题
@property (strong, nonatomic) NSString<Optional> *icon;                        //	图片地址
@property (strong, nonatomic) NSString<Optional> *icon_300x400;
@property (strong, nonatomic) NSString<Optional> *icon_400x300;
@property (strong, nonatomic) NSString<Optional> *icon_200x150;
@property (strong, nonatomic) NSString<Optional> *score;            // string	评分
@property (strong, nonatomic) NSString *cid;                        // String	频道id
@property (strong, nonatomic) NSString *type;                       // String	影片来源标示：1-vrs专辑,2-ptv视频,3-vrs视频
@property (strong, nonatomic) NSString<Optional> *at;                       // String	点击展示方式：1-进详情，2-直接播放，默认为直接播放
@property (strong, nonatomic) AtListModel<Optional> *atList;        // atList   扩展点击展示方式所需属性列表
@property (strong, nonatomic) NSString<Optional> *year;      // string	上映时间
@property (strong, nonatomic) NSString<Optional> *episode;          // String	总集数
@property (strong, nonatomic) NSString<Optional> *nowEpisodes;      //	String	跟播的当前总集数
@property (strong, nonatomic) NSString<Optional> *count;       //专辑的集数信息,和isend结合使用，完结时为总集数、未完结为当前集数
@property (strong, nonatomic) NSString<Optional> *isEnd;            // String	是否完结 1:完结;0未完结
@property (strong, nonatomic) NSString<Optional> *play;                            // String	1:可以播放;0:不可以播放
@property (strong, nonatomic) NSString<Optional> *duration;         // string	时长
@property (strong, nonatomic) NSString<Optional> *directory;        // string	导演(多个空格分隔)
@property (strong, nonatomic) NSString<Optional> *starring;         // string	主演(多个空格分隔)
@property (strong, nonatomic) NSString<Optional> *desc;             // description string	描述
@property (strong, nonatomic) NSString<Optional> *area;             // string	地区(多个空格分隔)
@property (strong, nonatomic) NSString<Optional> *subCategory;      // string	子分类(多个空格分隔)
@property (strong, nonatomic) NSString<Optional> *style;            // string	详情页面类型：1-剧集形式,2-列表形式,3-单片形式；非以上类型，默认为进列表形式
@property (strong, nonatomic) NSString<Optional> *playTv;           // string	播出电视台
@property (strong, nonatomic) NSString<Optional> *school;           // string	学校
@property (strong, nonatomic) NSString<Optional> *ctime;           // string   视频创建时间
@property (strong, nonatomic) NSArray<OldVideoListModel, Optional>* vl; //  VL 视频列表

@property (strong,nonatomic)   NSArray<OldVideoListModel, Optional> *l_list;
@property (strong,nonatomic)   NSArray<OldVideoListModel, Optional> *d_list;
@property (strong,nonatomic)   NSArray<OldVideoListModel, Optional> *a_list;
@property (strong,nonatomic)   NSString<Optional> *albumtype;
@property (strong,nonatomic)   NSString<Optional> *tags;
@property (strong,nonatomic)   NSString<Optional> *playcount;
@property (strong, nonatomic) NSString<Optional> *jump;                            // String	1:外跳，0:不外跳
@property (strong, nonatomic) NSString<Optional>  *pay;                             // String	1:需要支付;0:免费
@property (strong, nonatomic) NSString<Optional> *download;         // string	1:支持下载;0:禁止下载
@property (strong, nonatomic) NSString<Optional> *payDate;          // string	服务期限
@property (strong, nonatomic) NSString<Optional> *singlePrice;      // string	单片价格
@property (strong, nonatomic) NSString<Optional> *allowMonth;       // string	1:单点且支持包月;0:仅单点;2:仅支持包月;
@property (strong, nonatomic) NSString<Optional> *aid;              // String	视频所属的专辑id，不属于任何专辑时为空字符串（专辑无此属性）
//@property (strong, nonatomic) NSString<Optional> *vid; //String 视频id(排行榜toplist使用）
@property (strong, nonatomic) NSString<Optional> *stamp;            // String	盖章类型：new-最新，hot-最热，exclusive-独播，final-大结局，titbits-花絮，prevue-预告，clear-高清，end-完结，classic-经典
@property (strong, nonatomic) NSString<Optional> *url;
@property (strong, nonatomic) NSString<Optional> *albumtype_stamp;
@property (strong, nonatomic) NSString<Optional> *filmstyle;

- (NSString*)getIcon;
- (NSString *)getSinglePrice;
- (VIPAllowMonth) getAllowMonth;
- (LT_VIDEO_AT)getVideoAt;
- (BOOL)isAlbum;
- (BOOL)IsNeedJump;
- (BOOL)isNeedPay;
- (BOOL) isPrevue;
- (NSString *)getUpdateInfo:(BOOL)bNeedEndInfo;
- (BOOL)isJuji;
- (NSString*) getVipTag;
- (NSMutableArray *)getSpecArray;
- (BOOL)isMiniFilm;

@end
