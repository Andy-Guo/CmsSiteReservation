//
//  LTPlayRecommendModel.h
//  LetvIphoneClient
//
//  Created by zhaocy on 14-5-19.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>



@protocol LTPlayRecommendItem @end
@interface LTPlayRecommendItem : JSONModel

@property (strong, nonatomic) NSString<Optional>* cmsid;
@property (strong, nonatomic) NSString<Optional>* pid;
@property (strong, nonatomic) NSString<Optional>* vid;
@property (strong, nonatomic) NSString<Optional>* zid;
@property (strong, nonatomic) NSString<Optional>* nameCn;
@property (strong, nonatomic) NSString<Optional>* subTitle;
@property (strong, nonatomic) NSString<Optional>* cid;
@property (strong, nonatomic) NSString<Optional>* type;
@property (strong, nonatomic) NSString<Optional>* is_rec; // 是否为自动个性化推荐内容 true - 是，false - 否
@property (strong, nonatomic) NSString<Optional>* reid;
@property (strong, nonatomic) NSString<Optional>* mobilePic;

/*
 // 暂时不用
@property (strong, nonatomic) NSString<Optional>* at;
@property (strong, nonatomic) NSString<Optional>* episode;
@property (strong, nonatomic) NSString<Optional>* nowEpisodes;
@property (strong, nonatomic) NSString<Optional>* isEnd;
@property (strong, nonatomic) NSString<Optional>* pay;
@property (strong, nonatomic) NSString<Optional>* tag;
@property (strong, nonatomic) NSString<Optional>* streamCode;
@property (strong, nonatomic) NSString<Optional>* webUrl;
@property (strong, nonatomic) NSString<Optional>* webViewUrl;
@property (strong, nonatomic) NSString<Optional>* streamUrl;
@property (strong, nonatomic) NSString<Optional>* showTagList;
@property (strong, nonatomic) NSString<Optional>* tm;
@property (strong, nonatomic) NSString<Optional>* duration;
@property (strong, nonatomic) NSString<Optional>* singer;
*/

// 推荐视频是否支持
- (BOOL)isRecommendItemSupported;
// 是否系统算法推荐
- (BOOL)isItemRecommendedByMachine;

@end

@protocol LTPlayRecommendBlock @end
@interface LTPlayRecommendBlock : JSONModel

@property (strong, nonatomic) NSString<Optional> *blockname;	// String	区块名称
@property (strong, nonatomic) NSString<Optional> *area;         // String	推荐后台区域编号 - 上报需要
@property (strong, nonatomic) NSString<Optional> *bucket;       // String	后台测试桶编号 - 上报需要
@property (strong, nonatomic) NSString<Optional> *cms_num;      // String	该板块运营数据的条数 - 上报需要
@property (strong, nonatomic) NSString<Optional> *reid;         // String	该板块本次推荐的全局唯一标识 - 上报需要

@property (strong, nonatomic) NSMutableArray<LTPlayRecommendItem, ConvertOnDemand, Optional>* list; // array 影片列表

@end

@interface LTPlayRecommendModel : JSONModel

// block, 根据产品要求，目前只取第1组数据，block[0]
@property (strong, nonatomic) NSMutableArray<LTPlayRecommendBlock, ConvertOnDemand, Optional>* block;

// 返回第1个支持的recommendItem
- (LTPlayRecommendItem *)nextValidRecommendItem;

// 移除第1个recommendItem
- (void)removeRecommendItem;

- (NSString *)getReid;

@end
