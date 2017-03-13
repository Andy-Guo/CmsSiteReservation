//
//  LTletvPlayerInfo.m
//  LetvIpadClient
//
//  Created by Ji Pengfei on 14-9-5.
//
//

#import "LTLetvPlayerInfo.h"

static LTLetvPlayerInfo * sLTLetvPlayerInfo = nil;

@implementation LTLetvPlayerInfo

+ (LTLetvPlayerInfo *)sharedInstance
{
    if (sLTLetvPlayerInfo == nil) {
        @synchronized(self)
        {
            if (sLTLetvPlayerInfo == nil) {
                sLTLetvPlayerInfo = [[LTLetvPlayerInfo alloc] init];
                assert(sLTLetvPlayerInfo != nil);
            }
        }
    }
    return sLTLetvPlayerInfo;
}
@end
