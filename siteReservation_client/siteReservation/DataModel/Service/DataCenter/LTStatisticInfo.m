//
//  LTStatisticInfo.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 14-8-14.
//
//

#import "LTStatisticInfo.h"

static LTStatisticInfo * sLTStatisticInfo = nil;

@implementation LTStatisticInfo

+ (LTStatisticInfo *)sharedInstance
{
    if (sLTStatisticInfo == nil) {
        @synchronized(self)
        {
            if (sLTStatisticInfo == nil) {
                sLTStatisticInfo = [[LTStatisticInfo alloc] init];
                assert(sLTStatisticInfo != nil);
            }
        }
    }
    return sLTStatisticInfo;
}

@end
