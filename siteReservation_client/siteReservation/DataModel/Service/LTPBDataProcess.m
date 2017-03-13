//
//  LTPBDataProcess.m
//  LeTVMobileDataModel
//
//  Created by jeason on 16/2/29.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LTPBDataProcess.h"
#import "LTDataModelEngineCurl.h"
@implementation LTPBDataProcess

+ (void)getLiveServerTimeWithCompleteBlock:(LTLiveServerTimeCompleteBlock)completeBlock
                             andErrorBlock:(LTLiveServerTimeErrorBlock)errorBlock
{
    BOOL bUsePb = [SettingManager getStatusOfPB];
    if (bUsePb) {
        //@lyh 添加 NSDictionary* extraData 参数 TODO:网络接口上报参数传递
        [LTDataModelEngineCurl refreshUrlModule:LTURLModule_Live_SeverTimePB
                               andDynamicValues:nil
                               andUrlHeadValues:nil
                                  andHttpMethod:@"GET"
                                  andTimeoutSec:20
                                  andParameters:nil
                                andHeaderFields:nil
                          completionHandlerData:^(NSData *response,NSDictionary* extraData) {
                              LTServerTimestampModelPBOC *model = [[LTServerTimestampModelPBOC alloc] initWithData:response];
                              NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                              [dateFormatter setDateFormat:@"y-M-d HH:mm:ss"];
                              NSDate *date=[dateFormatter dateFromString:model.date];
                              LiveServerTime *serverTime = [[LiveServerTime alloc] init];
                              serverTime.date = date;
                              serverTime.week_day = [[NSString alloc] initWithFormat:@"%d",model.week_day];
                              if (completeBlock) {
                                  completeBlock(serverTime);
                              }
                          } errorHandler:^(NSError *error) {
                              if (errorBlock) {
                                  errorBlock(error);
                              }
                          }];
    }
    else {
        [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Live_SeverTime
                                   andDynamicValues:nil
                                        isNeedCache:NO
                                      andHttpMethod:@"GET"
                                      andParameters:nil
                                  completionHandler:^(NSDictionary *body, NSString *markid) {
                                      LiveServerTime *liveSeverTime = [[LiveServerTime alloc] initWithDictionary:body error:nil];
                                      if (completeBlock) {
                                          completeBlock(liveSeverTime);
                                      }
                                  } nochangeHandler:^{
                                      if (errorBlock) {
                                          errorBlock([NSError errorWithDomain:@"nochangeHandler!!!![jeason]" code:-1 userInfo:nil]);
                                      }
                                  } emptyHandler:^{
                                      if (errorBlock) {
                                          errorBlock([NSError errorWithDomain:@"emptyHandler!!!![jeason]" code:-1 userInfo:nil]);
                                      }
                                  } tokenExpiredHander:^{
                                      if (errorBlock) {
                                          errorBlock([NSError errorWithDomain:@"tokenExpiredHander!!!![jeason]" code:-1 userInfo:nil]);
                                      }
                                  } errorHandler:^(NSError *error) {
                                      if (errorBlock) {
                                          errorBlock(error);
                                      }
                                  }];
    }
}

@end
