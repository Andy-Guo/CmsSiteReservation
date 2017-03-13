//
//  LTChannelListModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-11-6.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/PicCollectionModel.h>

@protocol LTChannelAlbumListModel @end
@interface LTChannelAlbumListModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *aid;
@property(nonatomic,strong)NSString<Optional> *vid;
@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSString<Optional> *subname;
@property(nonatomic,strong)NSString<Optional> *category;
@property(nonatomic,strong)NSString<Optional> *categoryName;
@property(nonatomic,strong)PicCollectionModel<Optional> *images;
@property(nonatomic,strong)NSString<Optional> *__episodes;  //专辑id
@property(nonatomic,strong)NSString<Optional> *__nowEpisodes;  //专辑id
@property (strong, nonatomic) NSString<Optional> *__isEnd;     // String	是否完结 1:完结;0未完结
@property (strong, nonatomic) NSString<Optional> * __play;      // String	1:可以播放;0:不可以播放
@property (strong, nonatomic) NSString<Optional> *__jump;      // String	1:外跳，0:不外跳
@property (strong, nonatomic) NSString<Optional> *__pay;       // String	1:需要支付;0:免费
@property (strong, nonatomic) NSString<Optional> *actor; //音乐频道表演者
@property (nonatomic, strong) NSString<Optional> *cid;
@property (nonatomic, strong) NSString<Optional> *leftSubscipt;//左上角标
@property (nonatomic, strong) NSString<Optional> *leftSubsciptColor;//左上角标颜色
@property (nonatomic, strong) NSString<Optional> *extendSubscript;//右上角标
@property (nonatomic, strong) NSString<Optional> *subSciptColor;//右上角标颜色
@property (nonatomic, strong) NSString<Optional> *rightCorner;
@property (nonatomic, strong) NSString<Optional> *leftCorner;

- (NSInteger)episode;
- (NSInteger)nowEpisodes;
- (BOOL)pay;
- (BOOL)jump;

-(NSString *)getIcon;
- (NSString *)getUpdateInfo;
- (NSString *)getUpdateInfoWithCid:(NewMovieCid)cid;
- (NSString *)getUpdateInfoNew;

@end

@interface LTChannelListModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *album_count;
@property(nonatomic,strong)NSString<Optional> *video_count;
@property(nonatomic,strong)NSArray<LTChannelAlbumListModel,Optional> *album_list;
@property(nonatomic,strong)NSArray<LTChannelAlbumListModel,Optional> *video_list;
@end
