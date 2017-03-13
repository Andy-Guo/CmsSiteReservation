//
//  LivingHistoryCommand.h
//  LetvIphoneClient
//
//  Created by letv_liuzb on 14-10-28.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTLiveModel.h>

@interface LivingHistoryCommand : NSObject



+ (LTLiveChannelListDetailModel *)wrappResultSet:(id<PLResultSet>)rs;

//插入一条频道
+ (BOOL)insertWithObject:(LTLiveChannelListDetailModel*)LivingChannel type:(LTLiveHistoryFavType)liveType;
//搜索所有的频道
+ (NSArray*)searchAll:(LTLiveHistoryFavType)liveType;
//通过频道id 获取频道信息
+ (LTLiveChannelListDetailModel *)searchByID:(NSInteger)ID type:(LTLiveHistoryFavType)liveType;
//通过ID 删除频道信息
+ (BOOL)deleteByID:(NSInteger)ID type:(LTLiveHistoryFavType)liveType;
//通过channelId 获取频道信息
+ (LTLiveChannelListDetailModel *)searchByChannelId:(NSString *)channelId type:(LTLiveHistoryFavType)liveType;

//通过频道id 获取频道收藏状态
+ (BOOL)upateWithChannelId:(NSString *)cid isFovo:(BOOL)isFovo type:(LTLiveHistoryFavType)liveType;



//通过频道id 获取频道数量
+ (int)countByChannelId:(NSString*)liveChannelId type:(LTLiveHistoryFavType)liveType;
//通过频道收藏状态 获取频道数量
+ (int)countByFovoState:(BOOL)isFovo type:(LTLiveHistoryFavType)liveType;

//搜索所有的频道
+ (NSArray*)searchAllWithFovo:(BOOL)isFovo type:(LTLiveHistoryFavType)liveType;

//通过channelId 删除频道信息
+ (BOOL)deleteByChannelID:(NSString *)channelID type:(LTLiveHistoryFavType)liveType;

//更新喜欢列表 通过对比所有频道列表，如果有喜欢的频道 在服务端已经不存在 则删除此喜欢的频道从列表中
+ (void)checkFavoListWith:(NSArray *)allChannelList type:(LTLiveHistoryFavType)liveType;

//通过 model 更新频道数据 如果本地没有则插入
+ (BOOL)upateWithChannelModel:(LTLiveChannelListDetailModel *)model type:(LTLiveHistoryFavType)liveType;

+ (BOOL)searchFavStateByChannelID:(NSString *)channelID type:(LTLiveHistoryFavType)liveType;


@end
