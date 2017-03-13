//
//  LTChannelModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-3.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/OldMovieDetailModel.h>


@protocol LTChartPic <NSObject>
@end

@interface LTChartPic : JSONModel

@property (strong, nonatomic) NSString <Optional> *icon_400_300;
@property (strong, nonatomic) NSString <Optional> *icon_200_150;
@property (strong, nonatomic) NSString <Optional> *icon_400_225;

@end

@protocol ChannelMainListModel

@end

@interface ChannelMainListModel : JSONModel

@property (strong, nonatomic) NSString *id;                // String	频道id
@property (strong, nonatomic) NSString *name;                     // String	频道标题
@property (strong, nonatomic) NSString *subtitle;                 // String 关键字、看点
@property (strong, nonatomic) NSString *icon;                     // String 频道图片
@property (strong, nonatomic) NSString *type;                     // String 频道类型：1-基础频道，2-会员频道求
@property (strong, nonatomic) NSString<Optional> *icon_normal_small;        // String pad未选中小图标
@property (strong, nonatomic) NSString<Optional> *icon_normal_big;          // String pad未选中大图标
@property (strong, nonatomic) NSString<Optional> *icon_selected_small;      // String pad选中小图标
@property (strong, nonatomic) NSString<Optional> *icon_selected_big;        // String pad选中大图标
@end

@protocol SpecialListModel @end
@interface SpecialListModel : JSONModel
@property (strong, nonatomic) NSString *sid;                // String	专题id
@property (strong, nonatomic) NSString *sname;                     // String	频道标题
@property (strong, nonatomic) NSString <Optional>*subtitle;                 // String 关键字、看点
@property (strong, nonatomic) NSString <Optional>*icon;                     // String 频道图片
@property (strong, nonatomic) NSArray<OldMovieDetailModel,Optional>* video;

@end


@protocol CharTopListModel @end
@interface CharTopListModel : JSONModel
@property (strong, nonatomic) NSString <Optional>*vid;
@property (strong, nonatomic) NSString <Optional>*aid;
@property (strong, nonatomic) NSString <Optional>*title;
@property (strong, nonatomic) NSString <Optional>*subtitle;
@property (strong, nonatomic) NSString <Optional>*icon_400x300;
@property (strong, nonatomic) NSString <Optional>*cid;
@property (strong, nonatomic) NSString <Optional>*type;
@property (strong, nonatomic) NSString <Optional>*count;
//@property (strong, nonatomic) NSString <Optional>*isend;
@property (strong, nonatomic) NSString <Optional>*needJump;
@property (strong, nonatomic) NSString <Optional>*pay;
@property (strong, nonatomic) LTChartPic<Optional> *picall;
@property (strong, nonatomic) NSString<Optional> *tag;
@property (strong, nonatomic) NSString<Optional> *isEnd;
@property (strong, nonatomic) NSString<Optional> *episode;
@property (strong, nonatomic) NSString<Optional> *nowEpisodes;
@property (strong, nonatomic) NSString<Optional> *play;
@property (strong, nonatomic) NSString<Optional> *starring;
@property (nonatomic, strong) NSString<Optional> *extendSubscript; // 角标
@property (nonatomic, strong) NSString<Optional> *subsciptColor; // 右上角角标背景色
@property (nonatomic, strong) NSString<Optional> *leftSubscipt; // 左上角角标
@property (nonatomic, strong) NSString<Optional> *leftSubsciptColor; // 左上角角标背景色

- (NSString *)getIcon;
- (NSString *)getUpdateInfo;

@end


@protocol SubCharListModel <NSObject> @end
@interface SubCharListModel : JSONModel

@property (strong, nonatomic)  NSMutableArray<CharTopListModel,Optional>* list;

@end



// 杜比频道专辑model
@protocol LTDoblyAlbumModel <NSObject>
@end

@interface LTDoblyAlbumModel : JSONModel
@property (strong, nonatomic) NSString <Optional>*aid;
@property (strong, nonatomic) NSString <Optional>*name;
@property (strong, nonatomic) NSString <Optional>*subname;
@property (strong, nonatomic) NSString <Optional>*catagory;
@property (strong, nonatomic) NSString <Optional>*catagoryName;
@property (strong, nonatomic) NSString<Optional> *episode;
@property (strong, nonatomic) NSString<Optional> *nowEpisodes;
@property (strong, nonatomic) NSString<Optional> *isEnd;
@property (strong, nonatomic) NSString <Optional>*no_copyright;
@property (strong, nonatomic) NSString<Optional> *externalURL;
@property (strong, nonatomic) NSString<Optional> *play;
@property (strong, nonatomic) NSString <Optional>*needJump;
@property (strong, nonatomic) NSString <Optional>*pay;
@property (nonatomic, strong) NSString<Optional> *rightCorner; // 右上角角标背景色
@property (nonatomic, strong) NSString<Optional> *leftSubscipt; // 左上角角标
@property (nonatomic, strong) NSString<Optional> *leftSubsciptColor; // 左上角角标背景色
@property (strong, nonatomic) NSDictionary<Optional> *images;//图片list
@end

@interface LTDoblyAlbumListModel : JSONModel
@property (strong, nonatomic) NSString <Optional>*album_count;
@property (strong, nonatomic)  NSMutableArray<LTDoblyAlbumModel,Optional>* album_list;
@end

// 杜比频道视频model
@protocol LTDoblyVideoModel <NSObject>
@end

@interface LTDoblyVideoModel : JSONModel
@property (strong, nonatomic) NSString <Optional>*vid;
@property (strong, nonatomic) NSString <Optional>*aid;
@property (strong, nonatomic) NSString <Optional>*name;
@property (strong, nonatomic) NSString <Optional>*subName;
@property (strong, nonatomic) NSString <Optional>*actor;
@property (strong, nonatomic) NSString <Optional>*catagory;
@property (strong, nonatomic) NSString <Optional>*catagoryName;
@property (strong, nonatomic) NSString <Optional>*no_copyright;
@property (strong, nonatomic) NSString<Optional> *external_url;
@property (strong, nonatomic) NSDictionary<Optional> *images;//图片list
@property (strong, nonatomic) NSString<Optional> *play;
@property (strong, nonatomic) NSString <Optional>*jump;
@property (nonatomic, strong) NSString<Optional> *leftSubscipt; // 左上角角标
@property (nonatomic, strong) NSString<Optional> *leftSubsciptColor; // 左上角角标背景色
@property (nonatomic, strong) NSString<Optional> *extendSubscript; // 右角标
@property (nonatomic, strong) NSString<Optional> *subSciptColor; // 右上角角标背景色
@end

@interface LTDoblyVideoListModel : JSONModel
@property (strong, nonatomic) NSString <Optional>*video_count;
@property (strong, nonatomic)  NSMutableArray<LTDoblyVideoModel,Optional>* video_list;
@end



@protocol CharListModel @end
@interface CharListModel : JSONModel
@property (strong, nonatomic) NSString *cid;
@property (strong, nonatomic) NSString *cname;
@property (strong, nonatomic)  NSArray<OldMovieDetailModel,Optional>* video;
@property (strong, nonatomic)  NSArray<CharTopListModel,Optional>* toplist;
@end


@interface LTChannelModel : JSONModel

// 这三个变量是否应该删掉
@property (strong, nonatomic) NSArray<ChannelMainListModel, Optional>* channelList;
@property (strong, nonatomic) NSArray<SpecialListModel, Optional>* specialList;
@property (strong, nonatomic) CharListModel<Optional>* chartList;

@property (strong, nonatomic) NSArray<CharListModel,Optional>* chartNavList;

- (void)resetData;
- (NSInteger)getArrayCount:(CHANNEL_MAINLIST_TYPE)requestModes;
- (NSString *)getIconByIndex:(NSInteger)index RequestMode:(CHANNEL_MAINLIST_TYPE)requestMode;
- (NSString *)getIdByIndex:(NSInteger)index RequestMode:(CHANNEL_MAINLIST_TYPE)requestMode;
- (NSString *)getNameByIndex:(NSInteger)index RequestMode:(CHANNEL_MAINLIST_TYPE)requestMode;
- (NSString *)getSubtitleByIndex:(NSInteger)index RequestMode:(CHANNEL_MAINLIST_TYPE)requestMode;
- (BOOL)isDataNull:(CHANNEL_MAINLIST_TYPE)requestMode;

#ifdef LT_IPAD_CLIENT
- (ChannelID)getChannelIDByIndex:(NSInteger)index;
- (NSInteger) getIndexByChannelID:(ChannelID)channelId;
- (NSString *)getIconByChannelID:(ChannelID)channelId
                forSelectedState:(BOOL)isSelected;
- (NSString *)getDefaultIconByChannelID:(ChannelID)channelId
                       forSelectedState:(BOOL)isSelected;
#endif

//for 排行榜
- (NSInteger) getCurrentNavIndex;
- (BOOL) getItemNeedJumpByIndex:(NSInteger)_index;
- (LT_VIDEO_AT) getItemAtByIndex:(NSInteger)_index;
- (NSString *)getItemTypeByIndex:(NSInteger)_index;
- (NSString*) getItemUrlByIndex:(NSInteger)_index;
- (NSString*) getItemScoreByIndex:(NSInteger)_index;
- (NSMutableArray *)getSpecArrayByIndex:(NSInteger)_index;
- (NSString*) getNavNameByIndex:(NSInteger)_index;
- (NSString*) getNavIdByIndex:(NSInteger)_index;
@end


#ifdef LT_IPAD_CLIENT
/* the data model for chart.... for iPad */
@interface ChartModel : JSONModel

@property (strong, nonatomic) CharListModel<Optional>* block;
@property (strong, nonatomic) NSArray<CharListModel,Optional>* nav;

- (NSInteger) getCurrentNavIndex;

@end

/* the data model for subject.... for iPad */
@interface SubjectModel : JSONModel

@property (strong, nonatomic) SpecialListModel<Optional>* block;
@property (strong, nonatomic) NSArray<SpecialListModel,Optional>* nav;

- (NSInteger) getCurrentNavIndex;

@end
#endif

