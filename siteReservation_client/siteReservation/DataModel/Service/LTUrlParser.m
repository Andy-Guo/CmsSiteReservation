//
//  LTUrlParser.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-12-3.
//
//

#import "LTUrlParser.h"
#import <LeTVMobileDataModel/LTTimeStampProcess.h>
#import <LeTVMobileDataModel/LTDataCenter.h>
//#import "SettingManager.h"
//#import "NSString+HTTPExtensions.h"

@interface LTUrlParser()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, assign) LTUrlParserComefrom parserFrom;//解析来源
@end

@implementation LTUrlParser

@synthesize delegate = _delegate;

- (void) dealloc{
    
    [self cancelParse];
    self.operationQueue = nil;
}

- (id)init{
    
    if (self = [super init]) {
        self.parserFrom = LTUrlParserComefromPlay;
    }
    
    return self;
}


- (void)cancelParse
{
    if (self.operationQueue) {
        [self.operationQueue cancelAllOperations];
    }
}

- (BOOL)parserUrl:(NSString *)strUrl completion:(void (^)(NSInteger startPlaybackTime, NSInteger endPlaybackTime, NSInteger currentPlaybackTime, NSInteger timeShift))completion
{
    [self cancelParse];
    
    if ([NSString isBlankString:strUrl]) {
        NSLog(@"failed to parse url, url error");
        return NO;
    }
    
    if (![NetworkReachability connectedToNetwork]) {
        NSLog(@"failed to parse url, network blocked");
        return NO;
    }
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (request == nil) {
        NSLog(@"failed to parse url, request nil");
        return NO;
    }
    
    if (!self.operationQueue) {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    
    [NSURLConnection  sendAsynchronousRequest:request
                                        queue:self.operationQueue
                            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                
                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                NSInteger statusCode = [httpResponse statusCode];
                                
                                BOOL isHttpSuccess = (    (statusCode == 200)
                                                      &&  nil == connectionError
                                                      &&  nil != data);
                                
                                BOOL bSuccess = NO;
                                BOOL bExpired = NO;
                                
                                NSMutableArray *finalUrls = [NSMutableArray array];
                                
                                NSInteger startPlaybackTime = 0;
                                NSInteger endPlaybackTime = 0;
                                NSInteger curentPlaybackTime = 0;
                                NSInteger timeShift = 0;
                                
                                if(isHttpSuccess){
                                    /*
                                     * ZhangQigang
                                     * TODO: 需要从接口中获取直播的开始时间,结束时间,当前播放时间,以及回拨的时间偏移.
                                     */
                                    NSError *error;
                                    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                    bExpired = NO;
                                    if (finalUrls.count <= 0) {
                                        if (![NSString isBlankString:[NSString safeString:resultDictionary[@"location"]]]) {
                                            [finalUrls addObject:[NSString safeString:resultDictionary[@"location"]]];
                                        }
                                    }
                                    
                                    NSArray *arrayNodeList = resultDictionary[@"nodelist"];
                                    for (NSDictionary *node in arrayNodeList) {
                                        if (![NSString isBlankString:[NSString safeString:node[@"location"]]]) {
                                            [finalUrls addObject:[NSString safeString:node[@"location"]]];
                                        }
                                    }
                                    
                                    bSuccess = (finalUrls.count > 0);
                                    startPlaybackTime = [resultDictionary[@"starttime"] integerValue];
                                    endPlaybackTime = [resultDictionary[@"endtime"] integerValue];
                                    curentPlaybackTime = [resultDictionary[@"curtime"] integerValue];
                                    timeShift = [resultDictionary[@"timeshift"] integerValue];
                                    //针对下载地址解析单独处理过期和错误码
                                    if (self.parserFrom == LTUrlParserComefromDownload) {
                                        NSInteger ercode = [[NSString safeString:resultDictionary[@"ercode"]] integerValue];
                                        if (ercode == LTUrlParserErcodeExpetion || ercode == LTUrlParserErcodeValidateFaild) {
                                            bExpired = YES;
                                            bSuccess = NO;
                                        }else if (ercode != LTUrlParserErcodeSuccess) {
                                            bSuccess = NO;
                                        }
                                        
                                        NSString *tm = [[LTTimeStampProcess sharedInstance] getRoughSeverTimeStamp];
                                        NSString *errorCodeInfo = [NSString stringWithFormat:@"[downloadLog : resolved gslb address sucess] serverTimeStamp:%@, httpStatusCode:%ld, 调度ercode:%ld, requestUrl:%@, responseUrls:%@", tm, (long)statusCode, (long)ercode, strUrl, finalUrls];
                                        [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                                    }
                                }
                                else {
                                    NSString *tm = [[LTTimeStampProcess sharedInstance] getRoughSeverTimeStamp];
                                    NSString *errorCodeInfo = [NSString stringWithFormat:@"[downloadLog : resolved gslb address failed] serverTimeStamp:%@, httpStatusCode:%ld, requestUrl:%@", tm, (long)statusCode, strUrl];
                                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                                }

                                /*
                                if (!bSuccess) {
                                    [finalUrls addObject:[NSString stringWithFormat:@"%@", request.URL]];
                                }
                                */
                                
                                if (nil != self.delegate) {
                                    if ([self.delegate respondsToSelector: @selector(LTUrlParser:isSuccess:isExpired:urls:)]) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self.delegate LTUrlParser:self
                                                             isSuccess:bSuccess
                                                             isExpired:bExpired
                                                                  urls:finalUrls];
                                        });
                                    }
                                    if ([self.delegate respondsToSelector: @selector(LTUrlParser:isSuccess:isExpired:startPlaybackTime:endPlaybackTime:currentPlaybackTime:timeShift:)]) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self.delegate LTUrlParser: self
                                                             isSuccess: bSuccess
                                                             isExpired: bExpired
                                                     startPlaybackTime: startPlaybackTime
                                                       endPlaybackTime: endPlaybackTime
                                                   currentPlaybackTime: curentPlaybackTime
                                                             timeShift: timeShift];
                                        });
                                    }
                                }
                                if (completion) {
                                    completion(startPlaybackTime, endPlaybackTime, curentPlaybackTime, timeShift);
                                }
                            }];
    return YES;
}

- (BOOL)parserUrlNew:(NSString *)strUrl finishBlock:(void (^)(bool isSuccess, bool isExpired, NSInteger startPlaybackTime,NSInteger endPlaybackTime,NSInteger curentPlaybackTime,NSInteger timeShift, NSArray * finalUrls))finishBlock {
    [self cancelParse];
    
    if ([NSString isBlankString:strUrl]) {
        NSLog(@"failed to parse url, url error");
        return NO;
    }
    
    if (![NetworkReachability connectedToNetwork]) {
        NSLog(@"failed to parse url, network blocked");
        return NO;
    }
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (request == nil) {
        NSLog(@"failed to parse url, request nil");
        return NO;
    }
    
    if (!self.operationQueue) {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    
    [NSURLConnection  sendAsynchronousRequest:request
                                        queue:self.operationQueue
                            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                
                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                NSInteger statusCode = [httpResponse statusCode];
                                
                                BOOL isHttpSuccess = (    (statusCode == 200)
                                                      &&  nil == connectionError
                                                      &&  nil != data);
                                
                                BOOL bSuccess = NO;
                                BOOL bExpired = NO;
                                
                                NSMutableArray *finalUrls = [NSMutableArray array];
                                
                                NSInteger startPlaybackTime = 0;
                                NSInteger endPlaybackTime = 0;
                                NSInteger curentPlaybackTime = 0;
                                NSInteger timeShift = 0;
                                
                                if(isHttpSuccess){
                                    /*
                                     * ZhangQigang
                                     * TODO: 需要从接口中获取直播的开始时间,结束时间,当前播放时间,以及回拨的时间偏移.
                                     */
                                    NSError *error;
                                    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                    bExpired = NO;
                                    if (finalUrls.count <= 0) {
                                        if (![NSString isBlankString:[NSString safeString:resultDictionary[@"location"]]]) {
                                            [finalUrls addObject:[NSString safeString:resultDictionary[@"location"]]];
                                        }
                                    }
                                    
                                    NSArray *arrayNodeList = resultDictionary[@"nodelist"];
                                    for (NSDictionary *node in arrayNodeList) {
                                        if (![NSString isBlankString:[NSString safeString:node[@"location"]]]) {
                                            [finalUrls addObject:[NSString safeString:node[@"location"]]];
                                        }
                                    }
                                    
                                    bSuccess = (finalUrls.count > 0);
                                    startPlaybackTime = [resultDictionary[@"starttime"] integerValue];
                                    endPlaybackTime = [resultDictionary[@"endtime"] integerValue];
                                    curentPlaybackTime = [resultDictionary[@"curtime"] integerValue];
                                    timeShift = [resultDictionary[@"timeshift"] integerValue];
                                    //针对下载地址解析单独处理过期和错误码
                                    if (self.parserFrom == LTUrlParserComefromDownload) {
                                        NSInteger ercode = [[NSString safeString:resultDictionary[@"ercode"]] integerValue];
                                        if (ercode == LTUrlParserErcodeExpetion || ercode == LTUrlParserErcodeValidateFaild) {
                                            bExpired = YES;
                                            bSuccess = NO;
                                        }else if (ercode != LTUrlParserErcodeSuccess) {
                                            bSuccess = NO;
                                        }
                                        
                                        NSString *tm = [[LTTimeStampProcess sharedInstance] getRoughSeverTimeStamp];
                                        NSString *errorCodeInfo = [NSString stringWithFormat:@"[downloadLog : resolved gslb address sucess] serverTimeStamp:%@, httpStatusCode:%ld, 调度ercode:%ld, requestUrl:%@, responseUrls:%@", tm, (long)statusCode, (long)ercode, strUrl, finalUrls];
                                        [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                                    }
                                }
                                else {
                                    NSString *tm = [[LTTimeStampProcess sharedInstance] getRoughSeverTimeStamp];
                                    NSString *errorCodeInfo = [NSString stringWithFormat:@"[downloadLog : resolved gslb address failed] serverTimeStamp:%@, httpStatusCode:%ld, requestUrl:%@", tm, (long)statusCode, strUrl];
                                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                                }
                                
                                /*
                                 if (!bSuccess) {
                                 [finalUrls addObject:[NSString stringWithFormat:@"%@", request.URL]];
                                 }
                                 */
                                if (finishBlock) {
                                    finishBlock(bSuccess,bExpired,startPlaybackTime,endPlaybackTime,curentPlaybackTime,timeShift,finalUrls);
                                }
                            }];
    return YES;
}

- (BOOL)parserUrl:(NSString *)strUrl finishBlock:(void (^)(bool isSuccess, bool isExpired, NSArray * finalUrls))finishBlock {
    [self cancelParse];
    
    if ([NSString isBlankString:strUrl]) {
        NSLog(@"failed to parse url, url error");
        return NO;
    }
    
    if (![NetworkReachability connectedToNetwork]) {
        NSLog(@"failed to parse url, network blocked");
        return NO;
    }
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (request == nil) {
        NSLog(@"failed to parse url, request nil");
        return NO;
    }
    
    if (!self.operationQueue) {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    
    [NSURLConnection  sendAsynchronousRequest:request
                                        queue:self.operationQueue
                            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                
                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                NSInteger statusCode = [httpResponse statusCode];
                                
                                BOOL isHttpSuccess = (    (statusCode == 200)
                                                      &&  nil == connectionError
                                                      &&  nil != data);
                                
                                BOOL bSuccess = NO;
                                BOOL bExpired = NO;
                                
                                NSMutableArray *finalUrls = [NSMutableArray array];
                                
                                NSInteger startPlaybackTime = 0;
                                NSInteger endPlaybackTime = 0;
                                NSInteger curentPlaybackTime = 0;
                                NSInteger timeShift = 0;
                                
                                if(isHttpSuccess){
                                    /*
                                     * ZhangQigang
                                     * TODO: 需要从接口中获取直播的开始时间,结束时间,当前播放时间,以及回拨的时间偏移.
                                     */
                                    NSError *error;
                                    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                    bExpired = NO;
                                    if (finalUrls.count <= 0) {
                                        if (![NSString isBlankString:[NSString safeString:resultDictionary[@"location"]]]) {
                                            [finalUrls addObject:[NSString safeString:resultDictionary[@"location"]]];
                                        }
                                    }
                                    
                                    NSArray *arrayNodeList = resultDictionary[@"nodelist"];
                                    for (NSDictionary *node in arrayNodeList) {
                                        if (![NSString isBlankString:[NSString safeString:node[@"location"]]]) {
                                            [finalUrls addObject:[NSString safeString:node[@"location"]]];
                                        }
                                    }
                                    
                                    bSuccess = (finalUrls.count > 0);
                                    startPlaybackTime = [resultDictionary[@"starttime"] integerValue];
                                    endPlaybackTime = [resultDictionary[@"endtime"] integerValue];
                                    curentPlaybackTime = [resultDictionary[@"curtime"] integerValue];
                                    timeShift = [resultDictionary[@"timeshift"] integerValue];
                                    //针对下载地址解析单独处理过期和错误码
                                    if (self.parserFrom == LTUrlParserComefromDownload) {
                                        NSInteger ercode = [[NSString safeString:resultDictionary[@"ercode"]] integerValue];
                                        if (ercode == LTUrlParserErcodeExpetion || ercode == LTUrlParserErcodeValidateFaild) {
                                            bExpired = YES;
                                            bSuccess = NO;
                                        }else if (ercode != LTUrlParserErcodeSuccess) {
                                            bSuccess = NO;
                                        }
                                        
                                        NSString *tm = [[LTTimeStampProcess sharedInstance] getRoughSeverTimeStamp];
                                        NSString *errorCodeInfo = [NSString stringWithFormat:@"[downloadLog : resolved gslb address sucess] serverTimeStamp:%@, httpStatusCode:%ld, 调度ercode:%ld, requestUrl:%@, responseUrls:%@", tm, (long)statusCode, (long)ercode, strUrl, finalUrls];
                                        [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                                    }
                                }
                                else {
                                    NSString *tm = [[LTTimeStampProcess sharedInstance] getRoughSeverTimeStamp];
                                    NSString *errorCodeInfo = [NSString stringWithFormat:@"[downloadLog : resolved gslb address failed] serverTimeStamp:%@, httpStatusCode:%ld, requestUrl:%@", tm, (long)statusCode, strUrl];
                                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                                }
                                
                                /*
                                 if (!bSuccess) {
                                 [finalUrls addObject:[NSString stringWithFormat:@"%@", request.URL]];
                                 }
                                 */
                                if (finishBlock) {
                                    finishBlock(bSuccess,bExpired,finalUrls);
                                }
                            }];
    return YES;
}

- (BOOL)parserUrl:(NSString*)strUrl
{
    return [self parserUrl: strUrl completion: nil];
}

- (BOOL)parserUrl:(NSString*)strUrl from:(LTUrlParserComefrom)parserState
{
    self.parserFrom = parserState;
    return [self parserUrl: strUrl completion: nil];
}

@end
