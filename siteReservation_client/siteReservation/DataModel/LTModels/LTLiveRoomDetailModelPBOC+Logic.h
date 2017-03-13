//
//  LTLiveRoomDetailModelPBOC+Logic.h
//  LeTVMobileDataModel
//
//  Created by Nigel Lee on 16/7/5.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

//#import <LetvMobileProtobuf/LetvMobileProtobuf.h>
#import <LetvMobileDataModel/LiveOrderCommand.h>
#import <Foundation/Foundation.h>

@class LTLiveRoomDetailModelPBOC;

@interface LTLiveRoomDetailModelPBOC (Logic)

//@property (nonatomic, strong) NSString<Optional> *typeICO;                      // 娱乐

- (NSString *)formatLiveType:(NSString *)liveType;
- (NSString *)getIconUrl;
- (BillStatus)getBillStatus;
@end
