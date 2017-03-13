//
//  LTDataInfo.m
//  LetvIpadClient
//
//  Created by iosdev on 14-10-9.
//
//

#import "LTDataInfo.h"

@implementation LTDataInfo

static LTDataInfo * sLTDataInfo = nil;

+ (LTDataInfo *)sharedInstance
{
    if (sLTDataInfo == nil) {
        @synchronized(self)
        {
            if (sLTDataInfo == nil) {
                sLTDataInfo = [[LTDataInfo alloc] init];
                assert(sLTDataInfo != nil);
            }
        }
    }
    return sLTDataInfo;
}

@end
