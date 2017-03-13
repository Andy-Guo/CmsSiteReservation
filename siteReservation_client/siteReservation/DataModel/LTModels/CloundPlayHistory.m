//
//  CloundPlayHistory.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-10.
//
//

#import "CloundPlayHistory.h"

@implementation CloundPlayHistoryItem

- (void)setFromWithNSString:(NSString *)from
{
    switch ([from integerValue]) {
        case 1:
            _from = DEVICE_FROM_WEB;
            break;
        case 2:
            _from = DEVICE_FROM_PHONE;
            break;
        case 3:
            _from = DEVICE_FROM_PAD;
            break;
        case 4:
            _from = DEVICE_FROM_TV;
            break;
        case 5:
            _from = DEVICE_FROM_PCDESK;
            break;
        default:
            break;
    }
}

- (void)setVtypeWithNSString:(NSString *)vtype
{
    switch ([vtype integerValue]) {
        case 1:
            _vtype = ALBUM_FROM_VRS;
            break;
        case 2:
            _vtype = VIDEO_FROM_PTV;
            break;
        case 3:
            _vtype = VIDEO_FROM_VRS;
            break;
        default:
            break;
    }
}

- (NSDate *)getLastUpdateDate
{
    NSInteger seconds = self.utime / 1000;
    return (seconds > 0) ? [NSDate dateWithTimeIntervalSince1970:seconds] : nil;
}

@end
