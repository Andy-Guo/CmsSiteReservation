
//
//  LTDataModelEngineCurl.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import "LTDataModelEngineCurl.h"
#import "AFAppDotNetAPIClient.h"
#import "LTDataModel.h"
#import "NSString+MovieInfo.h"
#import "LTDataCenter.h"
#import "LTRequestURLManager.h"
#import "EncryptHelper.h"
#import "LTRecommendModel.h"
#import "LTChannelIndexModel.h"
#import "LTNewChannelModel.h"

//#import "LetvMobileNetwork/LTCurl.h"
#import <LetvMobileNetwork/LetvMobileNetwork.h>
#import <LetvMobileNetwork/LTHttpClient.h>

#define CURL_DEF_TIMEOUT    5




@implementation LTDataModelEngineCurl

+ (void)refreshUrlModule:(LTURLModule)urlModule
        andDynamicValues:(NSArray *)arrayDynamicValues
        andUrlHeadValues:(NSArray *)arrayHeadValues
           andHttpMethod:(NSString *)method
           andTimeoutSec:(NSInteger)timeout
           andParameters:(NSData *)parameters
         andHeaderFields:(NSDictionary *)headerFields
   completionHandlerData:(LTDataCompletionBlockCurlData)completionBlock
            errorHandler:(LTDataErrorBlock)errorBlock
{
    
    LTHttpClient *httpClient = [[LTHttpClient alloc] init];
    if (nil == httpClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    httpClient.tag = urlModule;
    
    NSString * sso_tk = @"";
    if ([SettingManager isUserLogin]) {
        sso_tk = [SettingManager userCenterTVToken];
        if ([NSString empty:sso_tk]) {
            sso_tk = @"";
        }
    }
    
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]];
#endif
    
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:headerFields];
    [headers setObject:@" application/json" forKey:@"Accept"];
    [headers setObject:userAgent forKey:@"User-Agent"];
    [headers setObject:@" zh-Hans-US;q=1, en-US;q=0.9" forKey:@"Accept-Language"];
    [headers setObject:@" gzip, deflate" forKey:@"Accept-Encoding"];
    [headers setObject:@" keep-alive" forKey:@"Connection"];

    
    [headers setObject:sso_tk forKey:@"SSOTK"];

//        //2016.12.24 添加dmsTK、dmsUID到headers中
//        BOOL dmsSwitch = [SettingManager DMSSwitch];  //暂代开机接口中的开关
//        BOOL isHK = [SettingManager isHK];
//        if (dmsSwitch && !isHK) {
//            NSString *dmsTK = [SettingManager DMSTK];
//            NSString *dmsUID = [SettingManager DMSUID];
//    
//            [headers setObject:@"dmstk" forKey:dmsTK];
//            [headers setObject:@"dmsuserid" forKey:dmsUID];
//    
//        }
//        //----end----
    
    // request url path
    
    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
                                                   andDynamicValues:arrayDynamicValues
                                                   andUrlHeadValues:arrayHeadValues];

    if ([NSString isBlankString:urlPath]) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }

    NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
    if(![NSString isBlankString:tk]) {
        [headers setObject:tk forKey:@"TK"];
    }

    NSString *urlNornal = [LTRequestURLManager formatRequestURLByModule:urlModule
                                                 andDynamicValues:arrayDynamicValues
                                                 andUrlHeadValues:arrayHeadValues];
#ifdef LT_IPAD_CLIENT
    NSString *url = urlNornal;
#else


    
    NSString *url =  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef) urlNornal,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 NULL,
                                                                                 kCFStringEncodingUTF8));
#endif
#if 0
    url = [url substringFromIndex:[@"http://" length]];
    url = [url substringFromIndex:[url rangeOfString:@"/"].location ];
    url = [NSString stringWithFormat:@"http://127.0.0.1:8080%@",url];
#endif
        
    
    if ([method isEqualToString:@"POST"]) {
        //@lyh TODO:网络接口上报参数传递
        [httpClient POST:url data:parameters timeout:(int)timeout httpHeader:headers completionHandler:^(NSData *data,NSDictionary* extraData) {
            if (completionBlock) {
                completionBlock(data,extraData);
            }
        } errorHandler:^(NSError *error) {
            if(errorBlock) {
                errorBlock(error);
            }
        }];        
    }else{
        //@lyh TODO:网络接口上报参数传递
        [httpClient GET:url timeout:(int)timeout httpHeader:headers completionHandler:^(NSData *data,NSDictionary* extraData) {
            if(completionBlock) {
                completionBlock(data,extraData);
            }
        } errorHandler:^(NSError *error) {
            if(errorBlock) {
                errorBlock(error);
            }
        }];
    }
    
    return;
    
}



+ (void)refreshUrlModule:(LTURLModule)urlModule
        andDynamicValues:(NSArray *)arrayDynamicValues
        andUrlHeadValues:(NSArray *)arrayHeadValues
             isNeedCache:(BOOL)isNeedCache
           andHttpMethod:(NSString *)method
           andTimeoutSec:(NSInteger)timeout
           andParameters:(NSData *)parameters
         andHeaderFields:(NSDictionary *)headerFields
   completionHandlerData:(LTDataCompletionBlockCurlPBData)completionBlock
         nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
            emptyHandler:(LTDataEmptyBlock)emptyBlock
      tokenExpiredHander:(LTDataTokenExpiredBlock)tokenExpiredBlock
         ipShieldHandler:(LTDataIPShieldBlock)ipShieldBlock
            errorHandler:(LTDataErrorBlock)errorBlock
{
    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
                                                 andDynamicValues:arrayDynamicValues];
    
    LTPBCommonModelOC *localCommonModel = nil;
    if(isNeedCache && [LTDataModelEngineCurl isLocalDataExisted:url])
    {
        NSData *dat = [LTDataModelEngineCurl getLocalData:url];
        localCommonModel = [[LTPBCommonModelOC alloc] initWithData:dat];
        if(completionBlock) {
            completionBlock(localCommonModel.data,localCommonModel.header,nil);
        }
    }
    
    if ([NetworkReachability connectedToNetwork]) {
        NSTimeInterval utimeStart = [[NSDate date]timeIntervalSince1970];
        //@lyh 添加 NSDictionary* extraData 参数 TODO:网络接口上报参数传递
        [LTDataModelEngineCurl refreshUrlModule:urlModule
                               andDynamicValues:arrayDynamicValues
                               andUrlHeadValues:arrayHeadValues
                                  andHttpMethod:method
                                  andTimeoutSec:timeout
                                  andParameters:parameters
                                andHeaderFields:headerFields
                          completionHandlerData:^(NSData *response,NSDictionary* extraData) {
                              LTPBCommonModelOC *common = [[LTPBCommonModelOC alloc] initWithData:response];
                              if(common) {
                                  switch (common.header.status) {
                                      case DataStatusNormal:
                                      {
                                          if (localCommonModel && [localCommonModel.data isEqualToData:common.data]) {
                                              return;
                                          }
                                          
                                          if(completionBlock) {
                                              completionBlock(common.data,common.header,extraData);
                                          }
                                          if (isNeedCache) {
                                              BOOL ret = [LTDataModelEngineCurl writeToFile:response andUrlPath:url];
                                              if (!ret) {
                                                  NSString *errlog =[NSString stringWithFormat:@"writeToFile error! url:%@",url];
                                                  [LTDataCenter writeToErrorLogFile:errlog];
                                              }
                                          }
                                      }
                                          break;
                                      case DataStatusNotChange:
                                      {
                                          if (nochangeBlock) {
                                              nochangeBlock();
                                          }
                                      }
                                          break;
                                      case DataStatusEmpty:
                                      {
                                          if (emptyBlock) {
                                              emptyBlock();
                                          }
                                          NSString *errlog =[NSString stringWithFormat:@"curl,DataStatusEmpty,urlModule:%d url:%@ response:%@",urlModule,url,response];
                                          [LTDataCenter writeToErrorLogFile:errlog];
                                      }
                                          break;
                                      case DataStatusTokenExpired:
                                      {
                                          if (tokenExpiredBlock) {
                                              tokenExpiredBlock();
                                          }
                                          NSString *errlog =[NSString stringWithFormat:@"curl,DataStatusTokenExpired,urlModule:%d url:%@ response:%@",urlModule,url,response];
                                          [LTDataCenter writeToErrorLogFile:errlog];
                                      }
                                          break;
                                      case DataStatusIPShield:
                                      {
                                          if (ipShieldBlock) {
                                              ipShieldBlock(common.header.error.code, common.header.error.content);
                                          }
                                          NSString *errlog =[NSString stringWithFormat:@"curl,DataStatusIPShield,urlModule:%d url:%@ response:%@",urlModule,url,response];
                                          [LTDataCenter writeToErrorLogFile:errlog];
                                      }
                                          break;
                                      case DataStatusAbnormal:
                                      {
                                          if (errorBlock) {
                                              errorBlock(nil);
                                          }
                                          
                                          NSString *errlog = [NSString stringWithFormat:@"curl,DataStatusAbnormal,urlModule:%d url:%@ response:%@",urlModule,url,response];
                                          [LTDataCenter writeToErrorLogFile:errlog];
                                      }
                                          break;
                                      default:
                                      {
                                          NSString *errlog = [NSString stringWithFormat:@"curl, status:%d,urlModule:%d url:%@ response:%@", common.header.status, urlModule,url,response];
                                          [LTDataCenter writeToErrorLogFile:errlog];
                                          
                                          if (errorBlock) {
                                              errorBlock(nil);
                                          }
                                      }
                                          break;
                                  }
                              }
                              else {
                                  NSString *errlog =[NSString stringWithFormat:@"CURL请求失败, urlModule:%d url:%@ response:%@",urlModule,url,response];
                                  [LTDataCenter writeToErrorLogFile:errlog];
                                  if (errorBlock) {
                                        errorBlock(nil);
                                  }
                                  return;
                              }
                          } errorHandler:^(NSError *error) {
                              
                              NSString *errlog =[NSString stringWithFormat:@"CURL请求失败, url:%@ errInfo:%@ discription:%@",url, [error userInfo], [error localizedDescription]];
                              [LTDataCenter writeToErrorLogFile:errlog];
                              
                              if (errorBlock) {
                                  errorBlock(error);
                              }
                          }];
    }else{
        if (![LTDataModelEngine getLocalData:url]||!isNeedCache) {
            if (errorBlock) {
                errorBlock(nil);
            }
        }
    }
}


+(void)cancelOperationWithUrlModule:(LTURLModule)urlModule
{
    [LTHttpClient cancelRequestWithTag:urlModule];
}

+ (BOOL)isLocalDataExisted:(NSString *)urlString
{
    NSString *strUrl = [urlString subStringByRemoveMutableParams];
    NSString *urlDataDir = [FileManager appUrlDataCachePath];
    NSString *path = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
        return YES;
    }
    return NO;
}

+ (NSData *)getLocalData:(NSString *)urlString
{
    NSString *strUrl = [urlString subStringByRemoveMutableParams];
    NSString *urlDataDir = [FileManager appUrlDataCachePath];
    NSString *path = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
        NSData *localData =[NSData dataWithContentsOfFile:fullPath];
        if (![NSObject empty:localData]) {
            return localData;
        }
    }
    return  nil;
}

+ (NSData *)getLocalDataBody:(NSString *)urlString{
    @autoreleasepool {
        LTPBCommonModelOC *localCommonModel = [[LTPBCommonModelOC alloc] initWithData:[LTDataModelEngineCurl getLocalData:urlString]];
        if (      nil == localCommonModel
            ||    nil == localCommonModel.header
            ||    nil == localCommonModel.data) {
            return nil;
        }
        
        if (localCommonModel.header.status == DataStatusNormal) {
            return localCommonModel.data;
        }
        return nil;
    }
}

+ (BOOL) writeToFile:(NSData *)dat andUrlPath:(NSString *)urlPath
{
    if ([NSString isBlankString:urlPath]) {
        return NO;
    }
    NSString *strUrl = [NSString stringWithFormat:@"%@",urlPath];
    strUrl = [strUrl subStringByRemoveMutableParams];
    NSString *urlDataDir = [FileManager appUrlDataCachePath];
    NSString *path = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
    return [dat writeToFile:fullPath atomically:YES];
}





@end




//@implementation LTDataModelEngineCurl
//
//+(void)cancelAllHttpOperationWithUrlModule:(LTURLModule)urlModule
//{
//    /*
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    */
//    // create AFAppDotNetAPIClient with base url
//    
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];
//
//    [afAppDotNetAPIClient cancelAllHTTPOperationsByUrlModule:urlModule];
//}
//
//+(void)cancelAllHttpOperationWithUrlModule:(LTURLModule)urlModule  andDynamicValues:(NSArray *)arrayDynamicValues{
//    /*
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    */
//    // create AFAppDotNetAPIClient with base url
//    
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];
//
//    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
//                                                   andDynamicValues:arrayDynamicValues];
//    
//    [afAppDotNetAPIClient cancelAllHTTPOperationsWithMethod:@"GET" path:urlPath];
//}
//
//
//
//
//
//+ (BOOL)isDataCached:(LTURLModule)urlModule andDynamicValues:(NSArray *)arrayDynamicValues {
//    BOOL isCached = NO;
//    
//    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                                 andDynamicValues:arrayDynamicValues];
//    
//    if ([LTDataModelEngineCurl isLocalDataExisted:url]) {
//        isCached = YES;
//    }
//    
//    return isCached;
//}
//
//
//+ (void)getDataFromUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                andUrlHeadValues:(NSArray *)arrayHeadValues
//                 andHeaderFields:(NSDictionary *)headerFields
//                     andTimeoutS:(int)timeout
//               completionHandler:(LTDataCompletionBlockPB)completionBlock
//                    errorHandler:(LTDataErrorBlockPB)errorBlock
//{
//    LTHttpClient *client = [[LTHttpClient alloc] init];
//    if (nil == client) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    NSString * sso_tk = @"";
//    if ([SettingManager isUserLogin]) {
//        sso_tk = [SettingManager userCenterTVToken];
//        if ([NSString empty:sso_tk]) {
//            sso_tk = @"";
//        }
//    }
//    
//    NSMutableDictionary *headDict = [[NSMutableDictionary alloc] initWithDictionary:headerFields];
//    [headDict setObject:sso_tk forKey:@"SSOTK"];
//    
//    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
//                                                   andDynamicValues:arrayDynamicValues
//                                                   andUrlHeadValues:arrayHeadValues];
//    
//    
//    if ([NSString isBlankString:urlPath]) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
//    if(![NSString isBlankString:tk]) {
//        [headDict setObject:tk forKey:@"TK"];
//    }
//    
//    
//    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                                 andDynamicValues:arrayDynamicValues
//                                                 andUrlHeadValues:arrayHeadValues];
//    
//    __block NSTimeInterval utimeStart = [[NSDate date]timeIntervalSince1970];
//    void (^sendErrorStatisticBlock)(NSString *errorCode,NSInteger httpStatusCode) =^(NSString *errorCode,NSInteger httpStatusCode){
//        NSTimeInterval  utimeEnd = [[NSDate date]timeIntervalSince1970];
//        CGFloat utime =utimeEnd-utimeStart;
//        NSString *utimeString =(utime>=0)?[NSString stringWithFormat:@"%.2f",utime]:@"";
//        
//        if ([NetworkReachability connectedToNetwork]){
//            [LTDataCenter addErrorData:errorCode
//                                andCid:@""
//                                andPid:@""
//                                adnVid:@""
//                        andDownloadUrl:@""
//                            andPlayUrl:@""
//                             andPlayVt:VIDEO_CODE_UNKNOWN
//                         andLivingCode:@""
//                         andRequestUrl:url
//                         andStatusCode:[NSString stringWithFormat:@"%ld_-",(long)httpStatusCode]
//                              andUtime:utimeString
//                           andPlayUUid:nil];
//        }
//        
//    };
//    
//    [client GET:urlPath timeout:timeout httpHeader:headDict completionHandler:^(NSData *data) {
//        if(completionBlock) {
//            completionBlock(data);
//        }
//    } errorHandler:^(NSError *error) {
//        if(errorBlock) {
//            errorBlock(error);
//        }
//        NSString *errCode = [NSString fomatEnumCode:urlModule];
//        sendErrorStatisticBlock(errCode,error.code);
//    }];
//    
//    return;
//}
//
//
//
//// 内部使用
//+ (void)getDataFromUrlModule:(LTURLModule)urlModule
//            andDynamicValues:(NSArray *)arrayDynamicValues
//            andUrlHeadValues:(NSArray *)arrayHeadValues
//             andHeaderFields:(NSDictionary *)headerFields
//                 andTimeoutS:(int)timeout
//                 isNeedCache:(BOOL)isNeedCache
//                         url:(NSString *)url
//                   localBody:(NSData *)localBody
//           completionHandler:(LTDataCompletionBodyBlockPB)completionBlock
//                errorHandler:(LTDataErrorBlockPB)errorBlock
//{
//    if ([NetworkReachability connectedToNetwork]) {
//        NSTimeInterval utimeStart = [[NSDate date]timeIntervalSince1970];
//        [LTDataModelEngineCurl getDataFromUrlModule:urlModule andDynamicValues:arrayDynamicValues andUrlHeadValues:arrayHeadValues andHeaderFields:headerFields andTimeoutS:timeout completionHandler:^(NSData *response) {
//            LTDataModelPBOC *dataModel = nil;
//            dataModel = [[LTDataModelPBOC alloc] initWithData:response];
//            
//            NSTimeInterval  utimeEnd = [[NSDate date]timeIntervalSince1970];
//            CGFloat utime =utimeEnd-utimeStart;
//            NSString *utimeString =(utime>=0)?[NSString stringWithFormat:@"%.2f",utime]:@"";
//            
//            if (    nil == dataModel
//                ||  nil == dataModel.header
//                ||  dataModel.header.status!=DataStatusNormal
//                ||  utime>[SettingManager getDefaultTimeOut]) {
//                NSString *errCode = [NSString fomatEnumCode:urlModule];
//                NSString *statusCode =(dataModel.header.status>0)?[NSString stringWithFormat:@"200_%d",dataModel.header.status]:@"200_-";
//                NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                                             andDynamicValues:arrayDynamicValues];
//                [LTDataCenter addErrorData:errCode
//                                    andCid:@""
//                                    andPid:@""
//                                    adnVid:@""
//                            andDownloadUrl:@""
//                                andPlayUrl:@""
//                                 andPlayVt:VIDEO_CODE_UNKNOWN
//                             andLivingCode:@""
//                             andRequestUrl:url
//                             andStatusCode:statusCode
//                                  andUtime:utimeString
//                               andPlayUUid:nil
//                            andisPlayError:YES];
//                
//                // 请求失败，写入错误日志
//                if (nil == dataModel
//                    ||  nil == dataModel.header
//                    ||  dataModel.header.status != DataStatusNormal) {
//                    NSString *errlog =[NSString stringWithFormat:@"请求失败, urlModule:%d url:%@",urlModule,url];
//                    [LTDataCenter writeToErrorLogFile:errlog];
//                }
//            }
//            
//            if (      nil == dataModel
//                ||    nil == dataModel.header
//                ||    nil == dataModel.body) {
//                if (errorBlock) {
//                    errorBlock(nil);
//                }
//                
//            }
//            else{
//                switch (dataModel.header.status) {
//                    case DataStatusNormal:
//                    {
//                        if (isNeedCache
//                            &&[LTDataModelEngineCurl isLocalDataExisted:url]
//                            &&[localBody isEqualToData:dataModel.body]) {
//                            //NSLog(@"取到的数据与缓存数据相同，不做变化");
//                            return;
//                        }
//                        if (completionBlock) {
//                            
////                            if(LTURLModule_Video_VF == urlModule
////                               || LTURLModule_Video_VF_And_Advertise == urlModule
////                               )
////                            {
////                                if(dataModel.body && dataModel.header)
////                                {
////                                    if(response && [[respondDict allKeys]containsObject:@"header"])
////                                    {
////                                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataModel.body];
////                                        [dic setObject:respondDict[@"header"] forKey:@"header"];
////                                        dataModel.body = dic;
////                                    }
////                                }
////                            }
//                            
//                            BOOL isNeed = [LTDataModelEngineCurl check:urlModule body:dataModel.body];
//                            
//                            if (!isNeed && isNeedCache) {
//                                if ([LTDataModelEngineCurl isLocalDataExisted:url]) {
//                                    // 如果有缓存直接return
//                                    
//                                    NSString *logInfo = [NSString stringWithFormat:@"数据展示缓存问题, 之前有缓存, url:%@, 当前：!isNeed && isNeedCache", url];
//                                    [LTDataCenter writeToErrorLogFile:logInfo];
//                                    return;
//                                } else {
//                                    
//                                    [LTDataCenter writeToErrorLogFile:@"数据展示缓存问题, 当前无缓存: !isNeed && isNeedCache"];
//                                    
//                                    // 没有的话返回error
//                                    if (errorBlock) {
//                                        errorBlock(nil);
//                                        return;
//                                    }
//                                }
//                            }
//                            
//                            completionBlock(dataModel.body, dataModel.header.markid);
//                            
//                            //NSLog(@"重新取到新的数据，覆盖缓存数据");
//                            //返回成功后，写入缓存
//                            if (isNeedCache) {
//                                if(!([LTDataModelEngineCurl isLocalDataExisted:url] &&
//                                     [response isEqualToData:[LTDataModelEngineCurl getLocalData:url]])){
//                                    [LTDataModelEngineCurl writeToFile:response andUrlPath:url];
//                                    
//                                }
//                                
//                            }
//                        }
//                        
//                    }
//                        break;
//                    case DataStatusNotChange:
////                    {
////                        if (nochangeBlock) {
////                            nochangeBlock();
////                        }
////                    }
//                        break;
//                    case DataStatusEmpty:
////                    {
////                        if (emptyBlock) {
////                            emptyBlock();
////                        }
////                        NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
////                        [LTDataCenter writeToErrorLogFile:errlog];
////                    }
//                        break;
//                    case DataStatusTokenExpired:
////                    {
////                        if (tokenExpiredBlock) {
////                            tokenExpiredBlock();
////                        }
////                        NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
////                        [LTDataCenter writeToErrorLogFile:errlog];
////                    }
//                        break;
//                    case DataStatusIPShield:
////                    {
////                        NSDictionary *dictBody = dataModel.body;
////                        NSString *country = [NSString safeString:dictBody[@"country"]];
////                        NSString *message = [NSString safeString:dictBody[@"message"]];
////                        if (ipShieldBlock) {
////                            ipShieldBlock(country, message);
////                        }
////                    }
//                        break;
//                    case DataStatusAbnormal:
//                    default:
////                    {
////                        if (errorBlock) {
////                            errorBlock(nil);
////                        }
////                        NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
////                        [LTDataCenter writeToErrorLogFile:errlog];
////                        
////                    }
//                        break;
//                }
//            }
//            
//        } errorHandler:^(NSError *error) {
//            if (errorBlock) {
//                errorBlock(error);
//            }
//        }];
//    }else{
//        if (![LTDataModelEngineCurl getLocalData:url]||!isNeedCache) {
//            if (errorBlock) {
//                errorBlock(nil);
//            }
//        }
//    }
//}
//
//
//+ (BOOL)check:(LTURLModule)urlModule body:(NSData *)body
//{
//    /*
//     App首页：除去焦点图、直播位、老的直播区块推广位、热词、搜索框、重磅推荐、数据为空区块后，区块还大于等于B且焦点图个数大于等于B，正常写入缓存
//     频道首页和子页面由于是同一个接口并且子页面也可能出现多个区块的情况
//     作如下处理: 除去直播位、热词、搜索框、电影付费入口、二级导航、数据为空区块后，区块还大于零，正常写入缓存
//     */
//    
//    BOOL isNeedCache = NO;
//    
////    NSError *parseError = nil;
////    switch (urlModule) {
////        case LTURLModule_Recommend_Personalized:
////        {
////            // app首页
////            @try {
////                LTRecommendModelPBOC *recommendModel = [[LTRecommendModelPBOC alloc] initWithData:body];
////                isNeedCache = [recommendModel isShouldCache];
////            }
////            @catch (NSException *exception) {
////                NSString *errorCodeInfo = [NSString stringWithFormat:@"首页:LTRecommendModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
////                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
////            }
////            @finally {}
////        }
////            break;
////        case LTURLModule_Channel_Index:
////        {
////            // 频道页
////            @try {
////                LTChannelIndexModel *channelIndexData = [[LTChannelIndexModel alloc] initWithDictionary:body error:nil];
////                isNeedCache = [channelIndexData isShouldCache];
////
////            }
////            @catch (NSException *exception) {
////                NSString *errorCodeInfo = [NSString stringWithFormat:@"频道页:LTChannelIndexModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
////                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
////            }
////            @finally {}
////        }
////            break;
////            
////        case LTURLModule_Channel_NewList_5_9:
////        {
////            // 频道墙
////            @try {
////                LTNewChannelModel *channelModel = [[LTNewChannelModel alloc]initWithDictionary:body error:nil];
////                isNeedCache = [channelModel isShouldCache];
////            }
////            @catch (NSException *exception) {
////                NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
////                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
////            }
////            @finally {}
////        }
////            break;
////        default:
////            isNeedCache = YES;
////            break;
////    }
//    return isNeedCache;
//}
//
//
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                     isNeedCache:(BOOL)isNeedCache
//                   andHttpMethod:(NSString *)method
//                   andParameters:(NSDictionary *)parameters
//               completionHandler:(LTDataCompletionBodyBlock)completionBlock
//                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
//                    emptyHandler:(LTDataEmptyBlock)emptyBlock
//              tokenExpiredHander:(LTDataTokenExpiredBlock)tokenExpiredBlock
//                 ipShieldHandler:(LTDataIPShieldBlock)ipShieldBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock
//{
//    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                                 andDynamicValues:arrayDynamicValues];
//    
//    //解决首页和频道首页因播放记录不同而导致获取缓存数据错误
//    if (urlModule == LTURLModule_Recommend_Personalized) {
//        //首页读取和存入缓存时移除所有拼接参数
//        url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                           andDynamicValues:nil];
//    }else if (urlModule == LTURLModule_Channel_Index){
//        //频道首页读取和存入缓存时移除播放记录参数
//        if (arrayDynamicValues.count >= 4) {
//            NSMutableArray *finalArray = [[NSMutableArray alloc] initWithObjects:[arrayDynamicValues firstObject], nil];
//            url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                               andDynamicValues:finalArray];
//        }
//    }
//    
//    NSLog(@"----->>>>>>>>>>>>url%@",url);
//    __block NSDictionary *localBody=[NSDictionary dictionary];
//    if (isNeedCache) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            if([LTDataModelEngineCurl isLocalDataExisted:url]){
//                NSDictionary *dict= [LTDataModelEngineCurl getLocalData:url];
//                LTDataModel *localDataModel = [[LTDataModel alloc] initWithDictionary:dict error:nil];
//                if ((localDataModel.header.status == DataStatusNormal) && completionBlock) {
//                    localBody = [NSDictionary dictionaryWithDictionary:localDataModel.body];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        // 标记是否缓存返回
//                        if (localDataModel.body && [localDataModel.body isKindOfClass:[NSDictionary class]]) {
//                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:localDataModel.body];
//                            [dic setValue:@(1) forKey:kIsCacheBack];
//                            localDataModel.body = dic;
//                        }
//                        completionBlock(localDataModel.body, localDataModel.header.markid);
//                        
//                        [LTDataModelEngineCurl refreshTaskWithUrlModule:urlModule
//                                                   andDynamicValues:arrayDynamicValues
//                                                        isNeedCache:isNeedCache
//                                                      andHttpMethod:method
//                                                      andParameters:parameters
//                                                                url:url
//                                                          localBody:localBody
//                                                  completionHandler:completionBlock
//                                                    nochangeHandler:nochangeBlock
//                                                       emptyHandler:emptyBlock
//                                                 tokenExpiredHander:tokenExpiredBlock
//                                                    ipShieldHandler:ipShieldBlock
//                                                       errorHandler:errorBlock];
//                    });
//                    
//                    return;
//                }
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [LTDataModelEngineCurl refreshTaskWithUrlModule:urlModule
//                                           andDynamicValues:arrayDynamicValues
//                                                isNeedCache:isNeedCache
//                                              andHttpMethod:method
//                                              andParameters:parameters
//                                                        url:url
//                                                  localBody:localBody
//                                          completionHandler:completionBlock
//                                            nochangeHandler:nochangeBlock
//                                               emptyHandler:emptyBlock
//                                         tokenExpiredHander:tokenExpiredBlock
//                                            ipShieldHandler:ipShieldBlock
//                                               errorHandler:errorBlock];
//            });
//        });
//    }
//    else {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [LTDataModelEngineCurl refreshTaskWithUrlModule:urlModule
//                                       andDynamicValues:arrayDynamicValues
//                                            isNeedCache:isNeedCache
//                                          andHttpMethod:method
//                                          andParameters:parameters
//                                                    url:url
//                                              localBody:localBody
//                                      completionHandler:completionBlock
//                                        nochangeHandler:nochangeBlock
//                                           emptyHandler:emptyBlock
//                                     tokenExpiredHander:tokenExpiredBlock
//                                        ipShieldHandler:ipShieldBlock
//                                           errorHandler:errorBlock];
//        });
//    }
//}
//
//
//#pragma mark - local data
//
//+ (BOOL) writeToFile:(NSDictionary *)responseData andUrlPath:(NSString *)urlPath
//{
//    if ([NSString isBlankString:urlPath]) {
//        return NO;
//    }
//    
//    NSString *strUrl = [NSString stringWithFormat:@"%@",urlPath];
//    strUrl = [strUrl subStringByRemoveMutableParams];
//    NSString *urlDataDir = [FileManager appUrlDataCachePath];
//    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W" withString:@"_"];
//    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
//    return [responseData writeToFile:fullPath atomically:YES];
//}
//
//+ (BOOL)isLocalDataExisted:(NSString *)urlString
//{
//    NSString *strUrl = [urlString subStringByRemoveMutableParams];
//    NSString *urlDataDir = [FileManager appUrlDataCachePath];
//    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W" withString:@"_"];
//    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
//    
//    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
//        return YES;
//    }
//    return NO;
//}
//
//+ (NSData *)getLocalData:(NSString *)urlString
//{
//    NSString *strUrl = [urlString subStringByRemoveMutableParams];
//    NSString *urlDataDir = [FileManager appUrlDataCachePath];
//    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W" withString:@"_"];
//    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
//    
//    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
//        NSData *responseData =[NSData dataWithContentsOfFile:fullPath];
//        if (![NSObject empty:responseData]) {
//            return responseData;
//        }
//    }
//    return  nil;
//}
//
//
//
//@end
