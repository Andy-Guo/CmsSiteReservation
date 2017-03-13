//
//  LTLivingPlayHistoryCommand.h
//  LetvIphoneClient
//
//  Created by letv_liuzb on 14-10-28.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTLiveModel.h>

@interface LTLivingPlayHistoryCommand : NSObject




+ (LTLiveChannelListDetailModel *)wrappResultSet:(id<PLResultSet>)rs;


//更新历史列表 通过对比所有频道列表，如果有喜欢的频道 在服务端已经不存在 则删除此喜欢的频道从列表中
+ (void)checkHistoryListWith:(NSArray *)allChannelList type:(LTLiveHistoryFavType)liveType;

//插入一条直播播放历史记录
+ (BOOL)insertWithObject:(LTLiveChannelListDetailModel*)LivingChannel type:(LTLiveHistoryFavType)liveType;
//搜索所有历史记录
+ (NSArray*)searchAll:(LTLiveHistoryFavType)liveType;
//根据ID获取一条频道播放记录
+ (LTLiveChannelListDetailModel *)searchByID:(NSInteger)ID type:(LTLiveHistoryFavType)liveType;
//根据ID删除一条频道播放记录
+ (BOOL)deleteByID:(NSInteger)ID type:(LTLiveHistoryFavType)liveType;
//根据channelId删除一条频道播放记录
+ (LTLiveChannelListDetailModel *)searchByChannelID:(NSString *)channelId type:(LTLiveHistoryFavType)liveType;

//根据channelId更新一条频道播放记录
+ (BOOL)upateWithChannelId:(NSString *)cid type:(LTLiveHistoryFavType)liveType;

+ (BOOL)upateWithChannelModel:(LTLiveChannelListDetailModel *)liveDetailModel type:(LTLiveHistoryFavType)liveType;

//根据channelID 获取相应播放记录数量
+ (int)countByChannelId:(NSString*)liveChannelId type:(LTLiveHistoryFavType)liveType;
+ (BOOL)deleteByChannelId:(NSString *)channelId type:(LTLiveHistoryFavType)liveType;

+ (int) countAll:(LTLiveHistoryFavType)liveType;


@end
