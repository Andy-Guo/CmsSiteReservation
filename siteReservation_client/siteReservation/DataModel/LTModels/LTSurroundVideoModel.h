//
//  LTSurroundVideoModel.h
//  LetvIpadClient
//
//  Created by liuxuan on 14-9-12.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/VideoModel.h>
#import <LetvMobileDataModel/LTMySelfFocusImageModel.h>
@class VideoModel,VideoListModel;
@interface LTSurroundVideoModel : JSONModel

@property(strong,nonatomic)NSMutableArray<BlockContent,ConvertOnDemand,Optional>*cmsdata;
@property(strong,nonatomic)NSArray<Optional,ConvertOnDemand,VideoModel>*relationVideos;//周边视频
@property(strong,nonatomic)VideoListModel<Optional>*otherVideos;//同专辑非正片
@end
