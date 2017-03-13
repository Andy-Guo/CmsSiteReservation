//
//  LTTimeStampProcess.m
//  LeTVMobileDataModel
//
//  Created by zhaocy on 14-12-11.
//  Copyright (c) 2014年 Kerberos Zhang. All rights reserved.
//


#import "LTTimeStampProcess.h"
#import "LTDataModelEngine.h"
#import "LTRequestURLManager.h"
#import "LTDataCenter.h"
#import "LTDataModelEngineCurl.h"
@interface LTTimeStampProcess()

@property (nonatomic, assign) NSTimeInterval tmServer;
@property (nonatomic, assign) NSTimeInterval tmClient;

@end

static LTTimeStampProcess *sharedInstance = nil;

@implementation LTTimeStampProcess


+ (LTTimeStampProcess *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (void)updateTmServer:(NSTimeInterval)tmServer
{
    self.tmServer = tmServer;
    if (self.tmServer <= 0) {
        self.tmClient = 0;
        return;
    }
    
    self.tmClient = [[NSDate date] timeIntervalSince1970];
    
    return;
}

- (NSString *)getRoughSeverTimeStamp
{
    if (    self.tmServer <= 0
        ||  self.tmClient <= 0) {
        return @"";
    }
    
    NSTimeInterval currTmClient = [[NSDate date] timeIntervalSince1970];
    NSString *tm = [NSString stringWithFormat:@"%lld",
                    (long long)(self.tmServer + (currTmClient - self.tmClient))];
    return tm;
}

- (void)getRoughSeverTimeStamp:(void (^)(NSString *tm))finishBlock
{
    if (    self.tmServer <= 0
        ||  self.tmClient <= 0) {
        [self requestServerTimeStamp:^{
            NSString *tm = [self getRoughSeverTimeStamp];
            finishBlock(tm);
        }];
    }
    else{
        NSString *tm = [self getRoughSeverTimeStamp];
        finishBlock(tm);
    }
    
    return;
}

- (void)getRoughSeverTimeStampInLive:(void (^)(NSString *tm))finishBlock
{
    [self requestServerTimeStampInLive:^{
        NSString *tm = [self getRoughSeverTimeStamp];
        finishBlock(tm);
    }];
}

- (void) requestServerTimeStamp:(void (^)())finishBlock
{

    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Get_TimeStamp
                               andDynamicValues:nil
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  if ([NSObject empty:responseDic]) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Get_TimeStamp
                                                                                   andDynamicValues:nil];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Get_TimeStamp,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                      
                                  }
                                  NSString *tmValue = [responseDic valueForKey:@"time"];
                                  [self updateTmServer:[tmValue doubleValue]];
                                  finishBlock();
                              } errorHandler:^(NSError *error) {
                                  [self updateTmServer:0];
                                  finishBlock();
                              }];    return;
}

- (void) requestServerTimeStampInLive:(void (^)())finishBlock
{
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Get_TimeStamp
                               andDynamicValues:nil
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                                        outTime:3
                              completionHandler:^(NSDictionary *responseDic) {
                                  if ([NSObject empty:responseDic]) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Get_TimeStamp
                                                                                   andDynamicValues:nil];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Get_TimeStamp,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                      
                                  }
                                  NSString *tmValue = [responseDic valueForKey:@"time"];
                                  [self updateTmServer:[tmValue doubleValue]];
                                  finishBlock();
                              } errorHandler:^(NSError *error) {
                                  [self updateTmServer:0];
                                  finishBlock();
                              }];
    
    return;
}

@end
