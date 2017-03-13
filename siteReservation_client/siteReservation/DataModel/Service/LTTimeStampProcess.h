//
//  LTTimeStampProcess.h
//  LeTVMobileDataModel
//
//  Created by zhaocy on 14-12-11.
//  Copyright (c) 2014年 Kerberos Zhang. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface LTTimeStampProcess : NSObject
{
    //
}

+ (LTTimeStampProcess *)sharedInstance;
- (void)updateTmServer:(NSTimeInterval)tmServer;
- (void)getRoughSeverTimeStamp:(void (^)(NSString *tm))finishBlock;
- (void)getRoughSeverTimeStampInLive:(void (^)(NSString *tm))finishBlock;

- (void) requestServerTimeStamp:(void (^)())finishBlock;
- (void) requestServerTimeStampInLive:(void (^)())finishBlock;

- (NSString *)getRoughSeverTimeStamp;

@end
