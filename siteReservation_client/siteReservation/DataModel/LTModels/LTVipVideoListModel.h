//
//  LTVipVideoListModel.h
//  LetvIphoneClient
//
//  Created by Chen Jianjun on 14-2-11.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@class LTVipVideoListBlock;
@protocol LTVipVideoListBlock
@end
@interface LTVipVideoListModel : JSONModel

@property (nonatomic, strong) NSArray<LTVipVideoListBlock, Optional> *block;

@end

@class LTVipVideoListLinkProperty;
@protocol LTVipVideoListContent
@end
@interface LTVipVideoListBlock : JSONModel

@property (nonatomic, strong) NSArray<LTVipVideoListContent, Optional> *blockContent;
@property (nonatomic, strong) NSString<Optional> *limit;
@property (nonatomic, strong) LTVipVideoListLinkProperty<Optional> *linkProperty;
@property (nonatomic, strong) NSString<Optional> *name;

@end

@interface LTVipVideoListContent : JSONModel

// 视频类型
@property (nonatomic, strong) NSString<Optional> *at; //点击展示方式：1-半屏播放器 2-全屏无专辑单视频 3-全屏播放直播流 4-外跳web
@property (nonatomic, strong) NSString<Optional> *cid; //频道id
@property (nonatomic, strong) NSString<Optional> *nameCn; //视频名称
@property (nonatomic, strong) NSString<Optional> *padPic; //pad图片
@property (nonatomic, strong) NSString<Optional> *pic; //图片，尺寸：400 x 300
@property (nonatomic, strong) NSString<Optional> *pic_200_150; //图片，尺寸：200*150
@property (nonatomic, strong) NSString<Optional> *pid; //专辑id
@property (nonatomic, strong) NSString<Optional> *subTitle; //副标题
@property (nonatomic, strong) NSString<Optional> *tag; //盖章标签
@property (nonatomic, strong) NSString<Optional> *type; //影片来源标示：1-专辑,3-视频
@property (nonatomic, strong) NSString<Optional> *vid; //视频id
@property (nonatomic, strong) NSString<Optional> *isEnd; //是否完结 1:完结;0未完结

// 专辑类型
@property (nonatomic, strong) NSString<Optional> *episode; //总集数
@property (nonatomic, strong) NSString<Optional> *nowEpisodes; //跟播的当前总集数
@property (nonatomic, strong) NSString<Optional> *pay; //1:需要支付;0:免费（只有专辑有此属性）

//直播类型
@property (nonatomic, strong) NSString<Optional> *streamCode; //直播编号
@property (nonatomic, strong) NSString<Optional> *streamUrl; //直播流地址
@property (nonatomic, strong) NSString<Optional> *tm; //过期时间戳

//web外跳类型
@property (nonatomic, strong) NSString<Optional> *webUrl; //外跳url

- (NSString*)getIcon;

@end

@protocol LTVipVideoListFilter
@end
@interface LTVipVideoListLinkProperty : JSONModel

@property (nonatomic, strong) NSString<Optional> *cid;
@property (nonatomic, strong) NSArray<LTVipVideoListFilter, Optional> *filter;

@end

@interface LTVipVideoListFilter : JSONModel

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *key;
@property (nonatomic, strong) NSString<Optional> *value;

@end

