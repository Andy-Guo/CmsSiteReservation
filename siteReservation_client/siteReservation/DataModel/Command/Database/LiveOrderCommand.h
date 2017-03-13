//
//  LiveOrderCommand.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 12-9-26.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/SqlDBHelper.h>

@interface LiveOrderCommand : NSObject
{
    NSInteger _id;
    NSString *_orderName;
    NSString *_playTime;
    NSString *_channel_code;
    NSDate *_orderDate;
    NSString *_channel_name;
}
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *orderName;
@property (nonatomic, copy) NSString *playTime;
@property (nonatomic, copy) NSString *channel_code;
@property (nonatomic, strong) NSDate *orderDate;
@property (nonatomic, copy) NSString *channel_name;

+(BOOL) insertWithorderName:(NSString *)name
                andplayTime:(NSString *)playtime
             andChannelCode:(NSString *)channelCode
               andOrderDate:(NSDate *)orderDate
             andChannelName:(NSString *)channelName;
+(NSArray*)searchAll;
+(id)searchByName:(NSString *)ordername;
+(id)searchByBillDate:(NSString *)billDate billTime:(NSString *)billTime channelCode:(NSString *)channel_code;
+ (id)searchByBillDate:(NSString *)billDate billTime:(NSString *)billTime channelCode:(NSString *)channel_code orderName:(NSString *)orderName;
+(NSArray*)searchByOrderDate:(NSDate *)orderDate;
+(BOOL)deleteByName:(NSString *)ordername;
+(BOOL) deleteByExpiredTime:(NSDate *)curdate;
-(void)logDebug;
+(BOOL)deleteByPlayTime:(NSString *)playTime channel_code:(NSString *)channelCode;
+(BOOL)deleteByDate:(NSString *)date playTime:(NSString *)playTime channel_code:(NSString *)channel_code orderName:(NSString *)orderName;
+(BOOL) deleteByID:(NSInteger)ID;
+(BOOL)deleteAll;
+(BOOL)openLiveOrder;
+(BOOL)closeLiveOrder;
+ (BOOL)addOpt:(NSString *)urlString;
@end
