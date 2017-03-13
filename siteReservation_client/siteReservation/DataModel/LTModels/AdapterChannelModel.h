//
//  AdapterChannelModel.h
//  LetvIphoneClient
//
//  Created by wd on 14-4-25.
//
//

//#import "JSONModel.h"
#import <LetvMobileOpensource/LetvMobileOpensource.h>
@interface AdapterChannelModel : JSONModel
@property (nonatomic, strong) NSString <Optional> *channelName;
@property (nonatomic, strong) NSString <Optional> *channelUrl;
@property (nonatomic, strong) NSString <Optional> *channelPosition;
@property (nonatomic, strong) NSString <Optional> *channelStatus;
@property (nonatomic, strong) NSString <Optional> *channelUrlPad;
@end
