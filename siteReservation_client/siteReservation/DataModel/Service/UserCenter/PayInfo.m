//
//  PayInfo.m
//  LetvIphoneClient
//
//  Created by 鹏飞 季 on 12-8-31.
//  Copyright (c) 2012年 乐视网. All rights reserved.
//

#import "PayInfo.h"

@implementation PayInfo
@synthesize username=_username,
price=_price,
isVip=_isVip,
productName=_productName,
orderID=_orderID,
payType=_payType,
deadTime=_deadTime,
payStatus=_payStatus,
movieID=_movieID,
payfrom=_payfrom,
pType=_pType,
pid=_pid;

-(void)dealloc{
    self.payStatus=payStatus_UnKnown;
}

@end
