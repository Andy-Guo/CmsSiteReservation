//
//  CloundPlayHistory.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-10.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@interface CloundPlayHistoryItem : JSONModel

@property (strong, nonatomic) NSString*cid;    // 频道id
@property (strong, nonatomic) NSString* pid;	// 专辑id
@property (strong, nonatomic) NSString* vid;	// 视频id
@property (strong, nonatomic) NSString* nvid;	// 下一个视频id
@property (assign, nonatomic) DeviceFromType from; // 1:web;2:mobile;3:pad;4:tv;5:pc桌面
@property (assign, nonatomic) VIDEOSOURCE vtype;// 视频类型
@property (assign, nonatomic) int htime;        // 播放时间点（0开始播放 -1播放完闭）
@property (assign, nonatomic) long utime;       // 最后更新时间
@property (assign, nonatomic) int nc;           // 当前集数


- (NSDate *)getLastUpdateDate;

@end
