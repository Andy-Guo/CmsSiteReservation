//
//  LTLivingWeiShiOrderCommand.h
//  LetvMobileClient
//
//  Created by xingbo on 2017/2/14.
//  Copyright © 2017年 LeEco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTLiveModel.h"

/**
 卫视台排序记录
 */
@interface LTLivingWeiShiOrderCommand : NSObject

// 置顶某个频道
- (BOOL)stickTopChannelID:(NSString *)channelId;


- (NSArray *)sortDataArray:(NSArray<LTLiveChannelListDetailModel *>*)dataArray;

@end
