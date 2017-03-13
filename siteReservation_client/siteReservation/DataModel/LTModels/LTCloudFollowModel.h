//
//  LTCloudCollectModel.h
//  LetvIphoneClient
//
//  Created by wangduan on 14-3-31.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/MovieInfo.h>

@protocol LTCloudFollowItemModel @end
@interface LTCloudFollowItemModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *id;               // String   播放单ID
@property (strong, nonatomic) NSString<Optional> *cid;              // String	频道id
@property (strong, nonatomic) NSString<Optional> *vid;              // String   视频id
@property (strong, nonatomic) NSString<Optional> *pid;              // String	专辑id
@property (strong, nonatomic) NSString<Optional> *title;            // String	标题
@property (strong, nonatomic) NSString<Optional> *pic;              // String   封面图
@property (strong, nonatomic) NSString<Optional> *subname;          // String   一句话点评
@property (strong, nonatomic) NSString<Optional> *url;              // String   视频链接
@property (strong, nonatomic) NSString<Optional> *category;         // String   视频类型
@property (strong, nonatomic) NSString<Optional> *videoStatus;      // String   视频状态
@property (strong, nonatomic) NSString<Optional> *fromtype;         // String   视频状态。
-(MovieInfo *)wrapResultSet; //追剧收藏总数。

@end


@interface LTCloudFollowModel : JSONModel

@property(strong, nonatomic) NSMutableArray<LTCloudFollowItemModel,Optional>* list;  //云追剧收藏内容
@property(strong, nonatomic) NSString<Optional> *total;

@end
