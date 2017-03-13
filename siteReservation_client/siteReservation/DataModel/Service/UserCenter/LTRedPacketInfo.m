//
//  LTRedPacketInfo.m
//  LeTVMobileDataModel
//
//  Created by Qinxl on 15/11/9.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTRedPacketInfo.h"

@implementation LTRedPacketInfo

@end

@implementation StaringUpRedPacketInfo
- (BOOL) isNeedShowSkipWebPage{
    if (![NSString isBlankString:self.skipUrl]) {
        return YES;
    }
    
    return NO;
}
@end

@implementation StaringUpRedPacketModel
- (BOOL)isNeedShowRedPacketTip{
    if ([self.code isEqualToString:@"1"]) {
        return YES;
    }
    
    return NO;
}
@end

/* 支付成功红包 */

@implementation PaySuccessRedPacket
- (BOOL)isNeedShowRedPacketTip{
    if ([self.code isEqualToString:@"1"]) {
        return YES;
    }
    
    return NO;
}
@end
@implementation PaySuccessRedPacketInfo

@end