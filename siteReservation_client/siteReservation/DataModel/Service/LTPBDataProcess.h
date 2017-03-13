//
//  LTPBDataProcess.h
//  LeTVMobileDataModel
//
//  Created by jeason on 16/2/29.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LiveModel.h>


typedef void (^LTLiveServerTimeCompleteBlock)(LiveServerTime * serverTime);
typedef void (^LTLiveServerTimeErrorBlock)(NSError * error);

@interface LTPBDataProcess : NSObject
+ (void)getLiveServerTimeWithCompleteBlock:(LTLiveServerTimeCompleteBlock)completeBlock
                             andErrorBlock:(LTLiveServerTimeErrorBlock)errorBlock;
@end
