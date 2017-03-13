//
//  LTMySelfFocusImageModel.h
//  LetvIphoneClient
//
//  Created by LC on 14-8-4.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTChannelIndexModel.h>
#import <LetvMobileDataModel/LTDataModel.h>
#import <LetvMobileDataModel/LTRecommendModel.h>

@protocol BlockPicList @end
@interface BlockPicList : JSONModel

@property(strong,nonatomic)NSString<Optional> *pic_400_250;
@property(strong,nonatomic)NSString<Optional> *pic_400_225;

-(NSString*)getPic;
@end

@protocol BlockContent @end

@interface BlockContent : JSONModel
@property(nonatomic, strong)NSString<Optional> *cmsid;     // CMS中的记录唯一标示id
@property(nonatomic, strong)NSString<Optional> *pid;       //专辑id
@property(nonatomic, strong)NSString<Optional> *vid;       //视频id
@property(nonatomic, strong)NSString<Optional> *nameCn;    //视频名称
@property(nonatomic, strong)NSString<Optional> *subTitle;  //副标题
@property(nonatomic, strong)NSString<Optional> *cid;       //频道id
@property(nonatomic, strong)NSString<Optional> *type;      //影片来源标示：1-vrs专辑,2-ptv视频,3-vrs
@property(nonatomic, strong)NSString<Optional> *style;      //半屏页推广位图片样式 1：横图 2：左图右文
@property(nonatomic, strong)NSString<Optional> *at;        //点击展示方式
@property(nonatomic, strong)NSString<Optional> *episode;
@property(nonatomic, strong)NSString<Optional> *nowEpisodes;  //专辑id
@property(nonatomic, strong)NSString<Optional> *isEnd;     // String	是否完结 1:完结;0未完结
@property(nonatomic, strong)NSString<Optional> *pay;       // String	1:需要支付;0:免费
@property(nonatomic, strong)NSString<Optional> *tag;       // 专题id
@property(nonatomic, strong)NSString<Optional> *mobilePic; // string	时长
@property(nonatomic, strong)NSString<Optional> *streamCode;  //直播编号
@property(nonatomic, strong)NSString<Optional> *webUrl;    //外跳web地址
@property(nonatomic, strong)NSString<Optional> *webViewUrl;//内嵌webview地址
@property(nonatomic, strong) NSString<Optional> *streamUrl;    //直播流地址
@property(nonatomic, strong)NSArray<LTRecommendShowTagListModel, Optional> *showTagList;
@property(nonatomic, strong) NSString<Optional> *tm;    //过期时间戳
@property(nonatomic, strong)NSString<Optional> *duration;  // string	时长
@property(nonatomic, strong)NSString<Optional> *is_rec;    // string	时长
@property(nonatomic, strong)NSString<Optional> *singer;    //
@property(nonatomic, strong)BlockPicList<Optional>*picList;
//@property (nonatomic,strong)NSString<Optional>*albumType;  //专辑类型
@property (nonatomic,strong)NSString<Optional>*varietyShow; //是否是栏目:1 - 是，0 - 否
@property (nonatomic, strong) NSString<Optional> *videoType;// 视频类型
@property (nonatomic, strong)NSString<Optional> *zid;       //频道id
@property( nonatomic, strong)NSString<Optional> *ref;
@property( nonatomic, strong)NSString<Optional> *extends_extendRange;
@property( nonatomic, strong)NSString<Optional> *extends_extendCid;
@property( nonatomic, strong)NSString<Optional> *extends_extendPid;

@end


@interface LTMySelfFocusImageModel : JSONModel
@property (strong, nonatomic) NSMutableArray<BlockContent, Optional>*blockContent; // 焦点图
//@property (strong, nonatomic) LTHeaderModel* header;                            // object	接口信息节点
@end
