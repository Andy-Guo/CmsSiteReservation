//
//  LTletvPlayerInfo.h
//  LetvIpadClient
//
//  Created by Ji Pengfei on 14-9-5.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTLetvPlayerCommDef.h>

@interface LTLetvPlayerInfo : NSObject

@property (nonatomic ,strong)NSURL *contentUrl;
@property (nonatomic ,assign)LetvPlayerShowType  playShowType;
@property (nonatomic ,assign)VIDEOSOURCE movieType;
@property (nonatomic ,strong)NSString *vid;
@property (nonatomic ,strong)NSString *pid;
@property (nonatomic ,strong)NSString *zid;
@property (nonatomic ,assign)NSInteger historyOffset;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)LTStatisticInfo *statisticInfo;
@property (nonatomic ,assign)LTDCCodePlayFrom playFrom;
@property (nonatomic, assign) BOOL isCancelAnimate;

// 6.2 支持外部网页打开全景视频
@property (nonatomic, assign) BOOL isPanorama;

+ (LTLetvPlayerInfo *)sharedInstance;
@end
