//
//  LTLiveRoomDetailModelPBOC+Logic.m
//  LeTVMobileDataModel
//
//  Created by Nigel Lee on 16/7/5.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "LTLiveRoomDetailModelPBOC+Logic.h"
#import "LiveOrderCommand.h"

@implementation LTLiveRoomDetailModelPBOC (Logic)

- (NSString *)formatLiveType:(NSString *)liveType
{
    if ([liveType isEqualToString:@"entertainment"]) {
        return @"ent";
    }
    return liveType;
}

- (NSString *)getIconUrl
{
    NSString *imgUrl = self.typeICO1;
    if ([self.liveType isEqualToString:@"sports"]) {
        imgUrl = self.level2ImgUrl;
    }
    return imgUrl;
}

- (BillStatus)getBillStatus
{
    BillStatus billStatus = ORDER_STATUS;
    NSInteger status = [[NSString safeString:self.status] integerValue];
    if (status == 1) {
        if ([self.isPay integerValue] == 1) {
            billStatus = BILL_BUY_STATUS;
        } else {
            NSString *orderDate = [NSString formatTimeDateStr3:self.beginTime];
            NSString *playTime = [NSString formatTimeDateStr1:self.beginTime];
            
            LiveOrderCommand *liveCommand = [LiveOrderCommand searchByBillDate:orderDate
                                                                      billTime:playTime
                                                                   channelCode:[self formatLiveType:self.liveType]
                                                                     orderName:self.title];
            if (nil != liveCommand) {
                billStatus = CANCELORDER_STATUS;
            } else {
                billStatus = ORDER_STATUS;
            }
        }
    } else if (status == 2) {
        billStatus = BILL_PLAY_STATUS;
    } else {
        if (![NSString isBlankString:self.recordingId]){
            billStatus = BILL_REPLAY_STATUS;   // 回看
        } else {
            billStatus = BILL_UPLOADING;       // 上传中
        }
    }
    return billStatus;
}


@end
