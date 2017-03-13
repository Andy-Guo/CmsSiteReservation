//
//  LTNewChannelModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-8-20.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTNewChannelMainListModel @end
@interface LTNewChannelMainListModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *cid;                // String	频道id
@property (strong, nonatomic) NSString<Optional> *mzcid;    //String 大媒资频道id
@property (strong, nonatomic) NSString<Optional> *name;                     // String	频道标题
@property (strong, nonatomic) NSArray<Optional> *subtitle;                 // String 关键字、看点
@property (strong, nonatomic) NSString<Optional> *pic;                     // String 频道图片 5.7之前用
@property (strong, nonatomic) NSString<Optional> *pic1;                     // 未选中时的图片
@property (strong, nonatomic) NSString<Optional> *pic2;                     // 选中时的图片
@property (strong, nonatomic) NSString<Optional> *padPic;                   // 选中时大图
@property (assign, nonatomic) ChannelIntroType type;                     // String 频道类型：1-专辑、2-视频、3-精品推荐
@property (strong, nonatomic) NSString<Optional> *url;                  //5.4版本添加新字段。url为h5的url。
@property (strong, nonatomic) NSString<Optional> *update_num;           //5.4版本添加新字段，更新数。
@property (strong, nonatomic) NSString<Optional> *pageid;          //5.5版本新增字段：页面id
@property (strong, nonatomic) NSString<Optional> *lock;            //iPhone6.5 频道是否锁定(1-锁定，空为不锁定)

- (NSString *)getPicStringSelected:(BOOL)selected;
@end

@protocol LTChannelDataModel <NSObject>
@end

@interface LTChannelDataModel : JSONModel
@property (nonatomic, strong) NSMutableArray <LTNewChannelMainListModel, Optional> *data;
@property (nonatomic, strong) NSString<Optional> *title;
@end

@interface LTChannelWallModel : JSONModel
@property (strong, nonatomic) NSMutableArray<LTNewChannelMainListModel, Optional>* channel;
@property (nonatomic, strong) NSMutableArray<LTNewChannelMainListModel, Optional> *otherChannel;
@property (nonatomic, strong) NSString<Optional> *isEdit;
- (BOOL)isShouldCache;
- (void)saveDefaultNameAndPageID;
- (void)checkData:(NSDictionary *)dictionary;
@end

@interface LTNewChannelModel : JSONModel
#ifndef LT_IPAD_CLIENT
@property (strong, nonatomic)NSMutableArray<LTChannelDataModel, Optional>* channel;
#else
@property (strong, nonatomic)NSMutableArray<LTNewChannelMainListModel, Optional>* channel;
#endif

#ifdef LT_IPAD_CLIENT

- (ChannelID)getChannelIDByIndex:(NSInteger)index;
- (BOOL)isAlbumByIndex:(NSInteger)index;
- (NSString *)getDefaultIconByChannelID:(ChannelID)channelId forSelectedState:(BOOL)isSelected;
- (NSInteger)getChannelCount;

#endif

/**
 *  是否需要缓存数据
 *
 *  @return 返回YES需要，NO不需要
 */
- (BOOL)isShouldCache;
@end
