//
//  UCConsumeModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-18.
//
//

#import "UCConsumeModel.h"

@implementation UCConsumeInfoModel
- (LTOrderInfo *) getOrderInfo
{
    LTOrderInfo *orderInfo = [[LTOrderInfo alloc] init];
    NSString *orderType = self.payType;
    if ([orderType isEqualToString:@"1"] || [orderType isEqualToString:@"2"]) {
        orderInfo.ptype = @"1";
//        orderInfo.pid = self.videoId;
        orderInfo.productName = [NSString stringWithFormat:
                                 NSLocalizedString(@"乐视会员%@服务", @"乐视会员%@服务"),
                                 self.orderName
                                 ];
    } else {
        orderInfo.ptype = @"2";
        orderInfo.pid = orderType;
        orderInfo.productName = self.orderName;
    }
    
    orderInfo.orderId = self.id;
    orderInfo.singlePrice = [self.money integerValue] / 10.f;
    double nSeconds = ([self.cancelTime doubleValue] - [self.addTime doubleValue]) / 1000;
    if (nSeconds > 0) {
        orderInfo.dateExpired = [NSDate dateWithTimeIntervalSince1970:[self.cancelTime longLongValue]/1000];
        orderInfo.periodOfValidity = nSeconds / kSecondsOfDay;
    }
    else{
        orderInfo.dateExpired = nil;
        orderInfo.periodOfValidity = 0;
    }
    
    NSString *status = self.status;
    if ([status isEqualToString:@"-1"] || [status isEqualToString:@"-2"]) {
        orderInfo.isExpired = YES;
        orderInfo.isPaySuccess = NO;
    }
    else if ([status isEqualToString:@"1"] || [status isEqualToString:@"2"]) {
        orderInfo.isExpired = NO;
        orderInfo.isPaySuccess = YES;
    }
    else{
        orderInfo.isExpired = NO;
        orderInfo.isPaySuccess = NO;
    }
    
    return orderInfo;
}


@end

@implementation UCConsumeModel

@end
