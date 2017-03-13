//
//  LTLiveEngine.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-11-18.
//
//
#import "LTLiveEngine.h"
#import "LiveModel.h"
//#import "NSObject+ObjectEmpty.h"
//#import "NSString+Date.h"
#import "LTLiveModel.h"
#import "LTDataModelEngine.h"
#import "LiveOrderCommand.h"


@implementation LTLiveEngine

#pragma mark OrderLive For Sports/Music/Ent
+(void)liveOrderWithDataModel:(id)dataModel
            completionHandler:(LTLiveDataCompletionBlock)completionBlock
                  errorHander:(LTLiveDataErrorCompletionBlock)errorBlock
{
    NSString *did_client = [DeviceManager getDeviceUUID];
#ifdef LT_IPAD_CLIENT
    NSString *deviceToken = nil;
    if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        BOOL isNotificationSwitch = [[UIApplication sharedApplication]isRegisteredForRemoteNotifications];
        if (isNotificationSwitch) {
            deviceToken = [SettingManager deviceToken];
        }
    }else if ([[UIApplication sharedApplication]respondsToSelector:@selector(enabledRemoteNotificationTypes)]) {
        UIRemoteNotificationType type = [[UIApplication sharedApplication]enabledRemoteNotificationTypes];
        if (type != UIRemoteNotificationTypeNone) {
            deviceToken = [SettingManager deviceToken];
        }
    }
#else


    NSString *deviceToken = [SettingManager deviceToken];
#endif
    NSString *orderDate;
    NSString *orderPlayTime;
    NSString *orderName;
    NSString *orderName_encoded;
    NSString *channel_code;
    NSString *channel_name;
    NSString *orderNewTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *channelType = @"2"; // 直播类型：1-轮播台、卫视台，2-直播厅
    NSString *liveID = @"";

    if ([dataModel isKindOfClass:[LTLiveRoomDetailModel class]]){
        // 体育｜娱乐｜音乐 传入LTLiveRoomDetailModel
        LTLiveRoomDetailModel *detailModel = dataModel;
        orderNewTime = [NSString formatTimeDateStr:detailModel.beginTime];
        
        orderName = detailModel.title;
        orderName_encoded = [detailModel.title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
        
        channel_code = [detailModel formatLiveType:detailModel.liveType];
        channel_name = detailModel.ch;
        channelType = @"2";
        liveID = detailModel.id;
        
        orderDate = [NSString formatTimeDateStr3:detailModel.beginTime];            // 2014-10-18
        orderPlayTime = [NSString formatTimeDateStr1:detailModel.beginTime];        // 08:20
    }


    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_BookLive_Add
                               andDynamicValues:[NSArray arrayWithObjects:
                                                 did_client,
                                                 deviceToken,
                                                 orderNewTime,
                                                 orderName,
                                                 channel_code,
                                                 channel_name,
                                                 channelType,
                                                 liveID,
                                                 nil]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *body, NSString *markid) {
                                  
                                  NSString *status=[body objectForKey:@"result"];
                                  if ([status integerValue]==1){
                                      if ([LiveOrderCommand searchByBillDate:orderDate
                                                                    billTime:orderPlayTime
                                                                 channelCode:channel_code
                                                                   orderName:orderName]==nil) {
                                          [LiveOrderCommand insertWithorderName:orderName andplayTime:orderPlayTime andChannelCode:channel_code andOrderDate:[dateFormatter dateFromString:orderDate] andChannelName:channel_name];
                                      }
                                     completionBlock();
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTRefreshAfterPlayerBackNotification object:nil];
                                      
                                  }else{
                                      errorBlock(nil);
                                  }
                              } nochangeHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              } emptyHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              }tokenExpiredHander:^{
                                  errorBlock(nil);
                              }errorHandler:^(NSError *error) {
                                  // fixme
                                  errorBlock(error);
                              }];
}

#pragma mark CancelLive For Sports/Music/Ent
+ (void)cancelLiveOrderWithDataModel:(id)dataModel
                   completionHandler:(LTLiveDataCompletionBlock)completionBlock
                         errorHander:(LTLiveDataErrorCompletionBlock)errorBlock{
    
    NSString *did_client = [DeviceManager getDeviceUUID];
    NSString *date;
    NSString *orderName;
    NSString *orderName_encoded;
    NSString *orderPlayTime;
    NSString *orderNewTime;
    NSString *channel_code;
    NSString *liveID;
    
    if ([dataModel isKindOfClass:[LTLiveRoomDetailModel class]]){
        // 体育｜娱乐｜音乐 传入LTLiveRoomDetailModel
        LTLiveRoomDetailModel *detailModel = dataModel;
        
        orderNewTime = [NSString formatTimeDateStr:detailModel.beginTime];
        orderName = detailModel.title;
        orderName_encoded = [detailModel.title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];

        channel_code = [detailModel formatLiveType:detailModel.liveType];
        liveID = [NSString safeString:detailModel.id];
        
        date = [NSString formatTimeDateStr3:detailModel.beginTime];             // 2014-10-18
        orderPlayTime = [NSString formatTimeDateStr1:detailModel.beginTime];    // 08:20
    }
    
    
    NSString *pid=[NSString stringWithFormat:@"%@|%@|%@|%@",orderNewTime,channel_code,orderName_encoded, liveID];
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_BookLive_Del
                               andDynamicValues:[NSArray arrayWithObjects:
                                                 did_client,
                                                 pid,
                                                 nil]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *body, NSString *markid) {
                                  NSString *status=[body objectForKey:@"result"];
                                  if ([status integerValue]==1) {
                                      
                                      [LiveOrderCommand deleteByDate:date playTime:orderPlayTime channel_code:channel_code orderName:orderName];
                                      completionBlock();
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTRefreshAfterPlayerBackNotification object:nil];
                                  }else{
                                      errorBlock(nil);
                                  }
                                  
                              } nochangeHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              } emptyHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              }tokenExpiredHander:^{
                                  errorBlock(nil);
                              }errorHandler:^(NSError *error) {
                                  // fixme
                                  errorBlock(error);
                                  
                              }];
    
    
}

#pragma mark OrderLive For WeiShi/LunBo
+ (void)liveOrderWithChannelModel:(LTLiveChannelListDetailModel *)channelModel channelDetailModel:(LTLiveChannelDetailModel *)detailModel completionHandler:(LTLiveDataCompletionBlock)completionBlock errorHander:(LTLiveDataErrorCompletionBlock)errorBlock
{
    NSString *did_client = [DeviceManager getDeviceUUID];
    NSString *deviceToken = [SettingManager deviceToken];
//    NSString *deviceToken = @"6eb24a1230d3e50f13726357b313d5530d99dd58c8112cbef8e20d76928f749a";
    NSString *orderDate = nil;
    NSString *orderPlayTime = nil;
    
    NSString *orderName;
    NSString *orderName_encoded;
    NSString *channel_code;
    NSString *channel_name;
    NSString *orderNewTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *channelType = nil;
    NSString *liveID = nil;
    
    orderDate = [NSString formatTimeDateStr3:detailModel.playTime];         // 2014-10-18
    orderPlayTime = [NSString formatTimeDateStr1:detailModel.playTime];     // 08:20

    orderNewTime = detailModel.playTime;
    orderName = detailModel.title;
    orderName_encoded = [detailModel.title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
    channel_code = channelModel.channelEname;
    channel_name = channelModel.channelName;
    channelType = @"1";
    liveID = @"";
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_BookLive_Add
                               andDynamicValues:[NSArray arrayWithObjects:
                                                 did_client,
                                                 deviceToken,
                                                 orderNewTime,
                                                 orderName_encoded,
                                                 channel_code,
                                                 channel_name,
                                                 channelType,
                                                 liveID,
                                                 nil]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *body, NSString *markid) {
                                  
                                  NSString *status=[body objectForKey:@"result"];
                                  if ([status integerValue]==1){
                                      if ([LiveOrderCommand searchByBillDate:orderDate
                                                                    billTime:orderPlayTime
                                                                 channelCode:channel_code
                                                                   orderName:orderName]==nil) {
                                          [LiveOrderCommand insertWithorderName:orderName andplayTime:orderPlayTime andChannelCode:channel_code andOrderDate:[dateFormatter dateFromString:orderDate] andChannelName:channel_name];
                                      }
                                      completionBlock();
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTRefreshAfterPlayerBackNotification object:nil];
                                      
                                  }else{
                                      errorBlock(nil);
                                  }
                              } nochangeHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              } emptyHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              }tokenExpiredHander:^{
                                  errorBlock(nil);
                              }errorHandler:^(NSError *error) {
                                  // fixme
                                  errorBlock(error);
                              }];
}

#pragma mark CancelLive For WeiShi/LunBo
+(void)cancelLiveOrderWithChannelModel:(LTLiveChannelListDetailModel *)channelModel channelDetailModel:(LTLiveChannelDetailModel *)detailModel completionHandler:(LTLiveDataCompletionBlock)completionBlock errorHander:(LTLiveDataErrorCompletionBlock)errorBlock{
    NSString *did_client = [DeviceManager getDeviceUUID];
    NSString *orderDate = nil;
    NSString *orderPlayTime = nil;
    
    NSString *orderName;
    NSString *orderName_encoded;
    NSString *channel_code;
    NSString *orderNewTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    orderDate = [NSString formatTimeDateStr3:detailModel.playTime];         // 2014-10-18
    orderPlayTime = [NSString formatTimeDateStr1:detailModel.playTime];     // 08:20
    channel_code = channelModel.channelEname;
    orderNewTime = detailModel.playTime;
    
    orderName = detailModel.title;
    orderName_encoded = detailModel.title; //[detailModel.title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
    NSString *pid=[NSString stringWithFormat:@"%@|%@|%@",orderNewTime,channel_code,orderName_encoded];
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_BookLive_Del
                               andDynamicValues:[NSArray arrayWithObjects:
                                                 did_client,
                                                 pid,
                                                 nil]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *body, NSString *markid) {
                                  NSString *status=[body objectForKey:@"result"];
                                  if ([status integerValue]==1) {
                                      [LiveOrderCommand deleteByDate:orderDate playTime:orderPlayTime channel_code:channel_code orderName:orderName];
                                      completionBlock();
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTRefreshAfterPlayerBackNotification object:nil];
                                  }else{
                                      errorBlock(nil);
                                  }
                                  
                              } nochangeHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              } emptyHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              }tokenExpiredHander:^{
                                  errorBlock(nil);
                              }errorHandler:^(NSError *error) {
                                  // fixme
                                  errorBlock(error);
                                  
                              }];
}


//690批量删预约操作
+ (void)cancelMultiOrdersWithParas:(NSArray *)models
                   completionHandler:(LTLiveDataCompletionBlock)completionBlock
                         errorHander:(LTLiveDataErrorCompletionBlock)errorBlock {
    NSString *pids = @"";//存储多个pid数据
    NSMutableArray *localParasTempArr = [NSMutableArray array];
    
    NSString *did_client = [DeviceManager getDeviceUUID];
    NSString *deviceToken = [SettingManager deviceToken];
    NSString *orderDate;
    NSString *orderPlayTime;
    NSString *orderName;
    NSString *orderName_encoded;
    NSString *channel_code;
    NSString *channel_name;
    NSString *orderNewTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *channelType = @"2"; // 直播类型：1-轮播台、卫视台，2-直播厅
    NSString *liveID = @"";
    
    for (int index = 0; index < [models count]; index++) {
        id model = [models safeObjectAtIndex:index];
        NSString *pid;
        NSArray *tempArr;
        /*
        if ([model isKindOfClass:[LTLiveOrderChannelDetailModel class]]){
            LTLiveOrderChannelDetailModel *detailModel = (LTLiveOrderChannelDetailModel *)model;
            orderNewTime = detailModel.play_time;
            channel_code = detailModel.code;
            orderName = detailModel.programName;
            
            orderDate = [NSString formatTimeDateStr3:detailModel.play_time];         // 2014-10-18
            orderPlayTime = [NSString formatTimeDateStr1:detailModel.play_time];     // 08:20
            pid = [NSString stringWithFormat:@"%@|%@|%@,",orderNewTime,channel_code,orderName];
            tempArr = @[orderDate,orderPlayTime,channel_code,orderName];
            
        }*/
        
        if ([model isKindOfClass:[LTLiveChannelListDetailModel class]]){
            LTLiveChannelListDetailModel *detailModel = (LTLiveChannelListDetailModel *)model;
            orderNewTime = detailModel.beginTime;
            channel_code = detailModel.channelEname;
            orderName = detailModel.programName;
            orderName_encoded = [detailModel.programName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];

            orderDate = [NSString formatTimeDateStr3:detailModel.beginTime];         // 2014-10-18
            orderPlayTime = [NSString formatTimeDateStr1:detailModel.beginTime];     // 08:20
            pid = [NSString stringWithFormat:@"%@|%@|%@,",orderNewTime,channel_code,orderName_encoded];
            tempArr = @[orderDate,orderPlayTime,channel_code,orderName];
            
        } else if ([model isKindOfClass:[LTLiveRoomDetailModel class]]) {
            LTLiveRoomDetailModel *detailModel = (LTLiveRoomDetailModel *)model;
            orderNewTime = [NSString formatTimeDateStr:detailModel.beginTime];
            orderName = detailModel.title;
            orderName_encoded = [detailModel.title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
            channel_code = [detailModel formatLiveType:detailModel.liveType];
            channel_name = detailModel.ch;
            channelType = @"2";
            liveID = detailModel.id;
            
            orderDate = [NSString formatTimeDateStr3:detailModel.beginTime];            // 2014-10-18
            orderPlayTime = [NSString formatTimeDateStr1:detailModel.beginTime];        // 08:20
            pid = [NSString stringWithFormat:@"%@|%@|%@|%@,",orderNewTime,channel_code,orderName_encoded, liveID];
            tempArr = @[orderDate,orderPlayTime,channel_code,orderName];

        }
        if (index == ([models count] - 1) ) {
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
            pid = [pid stringByTrimmingCharactersInSet:set];
        }
        pids = [pids stringByAppendingString:pid];
        [localParasTempArr addObject:tempArr];
    }
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_BookLive_Del
                               andDynamicValues:[NSArray arrayWithObjects:
                                                 did_client,
                                                 pids,
                                                 nil]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *body, NSString *markid) {
                                  NSString *status = [body objectForKey:@"result"];
                                  if ([status isEqualToString:@"1"]) {
                                      for (NSArray *arr in localParasTempArr) {
                                          //本地删除
                                          [LiveOrderCommand deleteByDate:[arr safeObjectAtIndex:0]
                                                                playTime:[arr safeObjectAtIndex:1]
                                                            channel_code:[arr safeObjectAtIndex:2]
                                                               orderName:[arr safeObjectAtIndex:3]];
                                      }
                                      completionBlock();
                                  }else{
                                      errorBlock(nil);
                                  }
                                  
                              } nochangeHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              } emptyHandler:^{
                                  // fixme
                                  errorBlock(nil);
                              }tokenExpiredHander:^{
                                  errorBlock(nil);
                              }errorHandler:^(NSError *error) {
                                  // fixme
                                  errorBlock(error);
                                  
                              }];

    
}
@end
