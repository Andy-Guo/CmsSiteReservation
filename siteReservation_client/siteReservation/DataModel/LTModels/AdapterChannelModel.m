//
//  AdapterChannelModel.m
//  LetvIphoneClient
//
//  Created by wd on 14-4-25.
//
//

#import "AdapterChannelModel.h"

@implementation AdapterChannelModel

/*
 channel_name	string	频道名称
 channel_url	string	频道URL
 channel_position	string	频道位置
 channel_status	string	频道状态:1-上线,0-下线
 */
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"channel_name":@"channelName",
                                                       @"channel_url": @"channelUrl",
                                                       @"channel_position": @"channelPosition",
                                                       @"channel_status": @"channelStatus",
                                                       @"channel_url_pad": @"channelUrlPad"}];
}
@end
