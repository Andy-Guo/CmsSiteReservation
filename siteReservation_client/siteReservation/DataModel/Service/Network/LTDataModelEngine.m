//
//  LTDataModelEngine.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import "LTDataModelEngine.h"
#import "AFAppDotNetAPIClient.h"
//#import "AFJSONRequestOperation.h"
#import "LTDataModel.h"
//#import "FileManager.h"
//#import "AFHTTPClient+Extension.h"
//#import "NSObject+SBJSON.h"
//#import "NSString+HTTPExtensions.h"
#import "NSString+MovieInfo.h"
//#import "NSObject+ObjectEmpty.h"
//#import "AFHTTPClient.h"
#import "LTDataCenter.h"
#import "LTRequestURLManager.h"
#import "EncryptHelper.h"

#import "LTRecommendModel.h"
#import "LTChannelIndexModel.h"
#import "LTNewChannelModel.h"
//#import "RCTBridgeModule.h"

//#ifdef LT_IPAD_CLIENT
//
//@interface LTDataModelEngine()<RCTBridgeModule>
//
//@end
//
//@implementation LTDataModelEngine
//
//#pragma mark - React Methods
//
//RCT_EXPORT_MODULE(LTDataModelEngine)
//
//RCT_EXPORT_METHOD(getTKByUrlPath:(NSString *)path callback:(RCTResponseSenderBlock)callback) {
//    if (path == nil || path.length == 0) {
//        callback(@[@""]);
//    } else {
//        NSString *tk = [EncryptHelper getLTTKByUrlPath:path];
//        callback(@[tk]);
//    }
//}
//
//#pragma mark - common
//
//+ (void)sendStatistics:(LTDataCenterStatisticsType)sType
//           withUrlPath:(NSString *)path
//     completionHandler:(LTDataCenterCompletionBlock)completionBlock
//          errorHandler:(LTDataErrorBlock)errorBlock
//{
//    /*
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"image/gif"]]; // fixme
//     */
//    
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = nil;
//#ifdef DEVELOP_MODE_FOR_STATISTICS
//    if (    sType == LTDataCenterStatisticsTypeKVAction
//        ||  sType == LTDataCenterStatisticsTypeKVLogin
//        ||  sType == LTDataCenterStatisticsTypeKVLogout
//        ||  sType == LTDataCenterStatisticsTypeKVEnv
//        ||  sType == LTDataCenterStatisticsTypeKVPlay
//        ||  sType == LTDataCenterStatisticsTypeKVQuery
//        ||  sType == LTDataCenterStatisticsTypeKVError) {
//        afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterKVClient];
//    }
//    else if (sType == LTDataCenterStatisticsTypeKVAd)
//    {
//         afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterKVClientForAd];
//    }
//    else{
//        afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterClient];
//    }
//#else
//    if (    sType == LTDataCenterStatisticsTypeKVAction
//        ||  sType == LTDataCenterStatisticsTypeKVLogin
//        ||  sType == LTDataCenterStatisticsTypeKVLogout
//        ||  sType == LTDataCenterStatisticsTypeKVEnv
//        ||  sType == LTDataCenterStatisticsTypeKVPlay
//        ||  sType == LTDataCenterStatisticsTypeKVAd
//        ||  sType == LTDataCenterStatisticsTypeKVQuery
//        ||  sType == LTDataCenterStatisticsTypeKVError) {
//        afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterKVClient];
//    }
//    else{
//        afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterClient];
//    }
//    
//#endif
//    
//    if (nil == afAppDotNetAPIClient) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    if ([NSString isBlankString:path]) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    
//    NSString *dcFlag = [LTDataCenter urlFlagForStatisticsType:sType];
//    if ([NSString isBlankString:dcFlag]) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    NSString *fullPath = [dcFlag stringByAppendingString:path];
//    
//#ifdef SWITCH_OFF_FOR_STATISTICS
//    NSLog(@"data center switch off, %d, %@%@", sType, afAppDotNetAPIClient.baseURL.absoluteString, fullPath);
//    return;
//#endif
//    
//    fullPath = [NSString stringWithFormat:@"%@&apprunid=%@", fullPath, [SettingManager getVirtualLoginUUID]];
//    
//    [afAppDotNetAPIClient GET:fullPath
//                   parameters:nil
//                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                          if (completionBlock) {
//                              completionBlock();
//                          }
//                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                          if (errorBlock) {
//                              errorBlock(nil);
//                          }
//                      }];
//}
//
//+ (void)requestWithUrl:(NSString *)url
//      completionHandler:(LTDataCompletionBlock)completionBlock
//          errorHandler:(LTDataErrorBlock)errorBlock
//{
//    /*
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//     */
//    AFAppDotNetAPIClient *afAppDotNetAPIClient =[AFAppDotNetAPIClient sharedClientWithUrl:url];
//    if (nil == afAppDotNetAPIClient) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    [afAppDotNetAPIClient GET:url
//                   parameters:nil
//                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                          NSData *data =(NSData *)responseObject;
//                          
//                          NSError *error;
//                          NSDictionary *JSONDict = nil;
//                          
//                          if (data != nil) {
//                              JSONDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                          }
//                          
//                          if (![NSJSONSerialization isValidJSONObject:JSONDict]) {
//                              if (errorBlock) {
//                                  errorBlock(nil);
//                              }
//                          }
//                          else{
//                              if (completionBlock) {
//                                  completionBlock(JSONDict);
//                              }
//                          }
//                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                          if (errorBlock) {
//                              errorBlock(error);
//                          }
//                      }];
//
//    return;
//}
//
//+ (void)requestXMLWithUrl:(NSString *)url
//                urlModule:(LTURLModule)urlModule
//        completionHandler:(void (^)(NSXMLParser *responseXMLParser))completionBlock
//             errorHandler:(LTDataErrorBlock)errorBlock
//
//{
//    NSURL *requestURL = [NSURL URLWithString:url];
//    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
//    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    op.requestTag = urlModule;
//    op.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSXMLParser *parser = (NSXMLParser *)responseObject;
//
//        if (parser == nil) {
//            
//            if (errorBlock) {
//                
//                errorBlock(nil);
//                
//            }
//            
//        }else{
//            
//            if (completionBlock) {
//                
//                completionBlock(parser);
//                
//            }
//        }
//
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"Error: %@", error);
//         if (errorBlock) {
//             
//             errorBlock(error);
//             
//         }
//     }];
//
//    [[AFAppDotNetAPIClient sharedDataCenterClient].operationQueue addOperation:op];
//    
//    return;
//    
//}
//
//
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                   andHttpMethod:(NSString *)method
//                   andParameters:(NSDictionary *)parameters
//               completionHandler:(LTDataCompletionBlock)completionBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock{
//    // add additional contentTypes which is not supported by default
//    
//    [LTDataModelEngine refreshTaskWithUrlModule:urlModule
//                               andDynamicValues:arrayDynamicValues
//                               andUrlHeadValues:nil
//                                  andHttpMethod:method
//                                  andParameters:parameters
//                              completionHandler:completionBlock
//                                   errorHandler:errorBlock];
//}
//
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                   andHttpMethod:(NSString *)method
//                   andParameters:(NSDictionary *)parameters
//                         outTime:(float)time
//               completionHandler:(LTDataCompletionBlock)completionBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock
//{
//    return [LTDataModelEngine refreshTaskWithUrlModule:urlModule
//                                      andDynamicValues:arrayDynamicValues
//                                         andHttpMethod:method
//                                         andParameters:parameters
//                                       andHeaderFields:nil
//                                               outTime:time
//                                     completionHandler:completionBlock
//                                          errorHandler:errorBlock];
//}
//
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                   andHttpMethod:(NSString *)method
//                   andParameters:(NSDictionary *)parameters
//                 andHeaderFields:(NSDictionary *)headerFields
//                         outTime:(float)time
//               completionHandler:(LTDataCompletionBlock)completionBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock
//{
//    // add additional contentTypes which is not supported by default
//    /*
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    */
//    // create AFAppDotNetAPIClient with base url
//    
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];
//    NSString * sso_tk = @"";
//    if ([SettingManager isUserLogin]) {
//        sso_tk = [SettingManager userCenterTVToken];
//        if ([NSString empty:sso_tk]) {
//            sso_tk = @"";
//        }
//    }
//    
//    [afAppDotNetAPIClient setHttpHeader:@"SSOTK" value:sso_tk];
//    if (nil == afAppDotNetAPIClient) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    // request url path
//    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
//                                                   andDynamicValues:arrayDynamicValues];
//    
//    if ([NSString isBlankString:urlPath]) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    //add header-TK  yjyan 20150410
//    {
//        NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
//        if(![NSString isBlankString:tk])
//        {
//            [afAppDotNetAPIClient setHttpHeader:@"TK" value:tk];
//        }
//    }
//    
//    if ([method isEqualToString:@"POST"]) {
//        [afAppDotNetAPIClient postPath:urlPath
//                            parameters:parameters
//                          headerFields:headerFields
//                               timeOut:time
//                               success:^(AFHTTPRequestOperation *operation, id JSON) {
//                                   
//                                   NSInteger httpStatusCode =[operation.response statusCode];
//                                   
//                                   if (httpStatusCode != 200) {
//                                       NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
//                                       [LTDataCenter writeToErrorLogFile:logInfo];
//                                   }
//                                   
//                                   if (![NSJSONSerialization isValidJSONObject:JSON]) {
//                                       
//                                       NSString *logInfo = [NSString stringWithFormat:@"接口返回错误, 不是合法的JSON httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
//                                       [LTDataCenter writeToErrorLogFile:logInfo];
//                                       
//                                       if (errorBlock) {
//                                           errorBlock(nil);
//                                       }
//                                   }
//                                   else{
//                                       if (completionBlock) {
//                                           completionBlock(JSON);
//                                       }
//                                   }
//
//                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                   
//                                   NSInteger httpStatusCode =[operation.response statusCode];
//                                   
//                                   NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, error:%@", httpStatusCode, urlModule, urlPath, error];
//                                   [LTDataCenter writeToErrorLogFile:logInfo];
//                                   
//                                   if (errorBlock) {
//                                       errorBlock(nil);
//                                   }
//                               }];
//    }else{
//        [afAppDotNetAPIClient getPath:urlPath
//                           parameters:nil
//                         headerFields:headerFields
//                              timeOut:time
//                              success:^(AFHTTPRequestOperation *operation, id JSON) {
//                                  
//                              NSInteger httpStatusCode =[operation.response statusCode];
//                                  
//                              if (httpStatusCode != 200) {
//                                    NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
//                                    [LTDataCenter writeToErrorLogFile:logInfo];
//                              }
//                                  
//                              if (![NSJSONSerialization isValidJSONObject:JSON]) {
//                                  
//                                  NSString *logInfo = [NSString stringWithFormat:@"接口返回错误, 不是合法的JSON httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
//                                  [LTDataCenter writeToErrorLogFile:logInfo];
//                                  
//                                  if (errorBlock) {
//                                      errorBlock(nil);
//                                  }
//                              }
//                              else{
//                                  if (completionBlock) {
//                                      completionBlock(JSON);
//                                  }
//                              }
//                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                
//                                NSInteger httpStatusCode =[operation.response statusCode];
//                                
//                                NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, error:%@", httpStatusCode, urlModule, urlPath, error];
//                                [LTDataCenter writeToErrorLogFile:logInfo];
//                                
//                                if (errorBlock) {
//                                    errorBlock(error);
//                                }
//                            }];
//    }
//    return;
//}
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
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//               completionHandler:(LTDataCompletionBodyBlock)completionBlock
//                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
//                    emptyHandler:(LTDataEmptyBlock)emptyBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock{
//    
//    return  [LTDataModelEngine refreshTaskWithUrlModule:urlModule andDynamicValues:arrayDynamicValues
//                                            isNeedCache:YES
//                                          andHttpMethod:@"GET"
//                                          andParameters:nil
//                                      completionHandler:completionBlock
//                                        nochangeHandler:nochangeBlock
//                                           emptyHandler:emptyBlock
//                                     tokenExpiredHander:nil
//                                           errorHandler:errorBlock];
//}
//
//
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                andUrlHeadValues:(NSArray *)arrayHeadValues
//                   andHttpMethod:(NSString *)method
//                   andParameters:(NSDictionary *)parameters
//               completionHandler:(LTDataCompletionBlock)completionBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock{
//    [LTDataModelEngine refreshTaskWithUrlModule:urlModule andDynamicValues:arrayDynamicValues andUrlHeadValues:arrayHeadValues andHttpMethod:method andParameters:parameters andHeaderFields:nil completionHandler:completionBlock errorHandler:errorBlock];
//}
//
//
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                andUrlHeadValues:(NSArray *)arrayHeadValues
//                   andHttpMethod:(NSString *)method
//                   andParameters:(NSDictionary *)parameters
//                 andHeaderFields:(NSDictionary *)headerFields
//               completionHandler:(LTDataCompletionBlock)completionBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock{
//    // add additional contentTypes which is not supported by default
//    
//    /*
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    */
//    // create AFAppDotNetAPIClient with base url
//    
//    
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];
//    NSString * sso_tk = @"";
//    if ([SettingManager isUserLogin]) {
//        sso_tk = [SettingManager userCenterTVToken];
//        if ([NSString empty:sso_tk]) {
//                sso_tk = @"";
//        }
//    }
//    
//    [afAppDotNetAPIClient setHttpHeader:@"SSOTK" value:sso_tk];
//    if (nil == afAppDotNetAPIClient) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    // request url path
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
//    //add header-TK  yjyan 20150410
//    {
//        NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
//        if(![NSString isBlankString:tk])
//        {
//            [afAppDotNetAPIClient setHttpHeader:@"TK" value:tk];
//        }
//    }
//    
//    //    NSLog(@"DataModelEngine, %@", urlPath);
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
//    };
//    
//    if ([method isEqualToString:@"POST"]) {
//        [afAppDotNetAPIClient postPath:urlPath
//                            parameters:parameters
//                          headerFields:headerFields
//                                   tag:urlModule
//                               success:^(AFHTTPRequestOperation *operation, id JSON) {
//                                   NSInteger httpStatusCode =[operation.response statusCode];
//                                   NSString *errCode = [NSString fomatEnumCode:urlModule];
//                                   
//                                   if (httpStatusCode != 200) {
//                                       NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, url, JSON];
//                                       [LTDataCenter writeToErrorLogFile:logInfo];
//                                   }
//                                   
//                                   if (![NSJSONSerialization isValidJSONObject:JSON]) {
//                                       
//                                       NSString *logInfo = [NSString stringWithFormat:@"接口返回错误, 不是合法的JSON httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
//                                       [LTDataCenter writeToErrorLogFile:logInfo];
//                                       
//                                       if (errorBlock) {
//                                           errorBlock(nil);
//                                       }
//                                       
//                                       sendErrorStatisticBlock(errCode,httpStatusCode);
//                                   }
//                                   else{
//                                       if (completionBlock) {
//                                           completionBlock(JSON);
//                                       }
//                                   }
//                               }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                   if (errorBlock) {
//                                       errorBlock(nil);
//                                   }
//                                   
//                                   NSInteger httpStatusCode =[operation.response statusCode];
//                                   NSString *errCode =[NSString fomatEnumCode:urlModule];
//                                   sendErrorStatisticBlock(errCode,httpStatusCode);
//
//                                   if ([error code]!= NSURLErrorCancelled) {
//                                       sendErrorStatisticBlock(errCode,httpStatusCode);
//                                   }
//                                   
//                                   NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, error:%@", httpStatusCode, urlModule, url, error];
//                                   [LTDataCenter writeToErrorLogFile:logInfo];
//                               }];
//        
//    }else{
//        [afAppDotNetAPIClient getPath:urlPath
//                           parameters:nil
//                         headerFields:headerFields
//                                  tag:urlModule
//                              success:^(AFHTTPRequestOperation *operation, id JSON) {
//                                  NSInteger httpStatusCode =[operation.response statusCode];
//                                  NSString *errCode = [NSString fomatEnumCode:urlModule];
//                                  
//                                  if (httpStatusCode != 200) {
//                                      NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, url, JSON];
//                                      [LTDataCenter writeToErrorLogFile:logInfo];
//                                  }
//                                  
//                                  if (![NSJSONSerialization isValidJSONObject:JSON]) {
//                                      
//                                      NSString *logInfo = [NSString stringWithFormat:@"接口返回错误, 不是合法的JSON httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
//                                      [LTDataCenter writeToErrorLogFile:logInfo];
//                                      
//                                      if (errorBlock) {
//                                          errorBlock(nil);
//                                      }
//                                      
//                                      sendErrorStatisticBlock(errCode,httpStatusCode);
//                                  }
//                                  else{
//                                      if (completionBlock) {
//                                          completionBlock(JSON);
//                                      }
//                                  }
//                              }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                  NSLog(@"operation == %@",operation.response);
//                                  if (errorBlock) {
//                                      errorBlock(error);
//                                  }
//                                  NSInteger httpStatusCode =[operation.response statusCode];
//                                  NSString *errCode =[NSString fomatEnumCode:urlModule];
//                                  sendErrorStatisticBlock(errCode, httpStatusCode);
//
//                                  NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, error:%@", httpStatusCode, urlModule, url, error];
//                                  [LTDataCenter writeToErrorLogFile:logInfo];
//                              }];
//        
//    }
//    
//    return;
//    
//}
////by handongyang param associatedName :server接受的图片名称
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                   andHttpMethod:(NSString *)method
//                   andParameters:(NSDictionary *)parameters
//                       postImage:(UIImage *)postImage
//                  associatedName:(NSString *)associatedName
//               completionHandler:(LTDataCompletionBlock)completionBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock{
//    // add additional contentTypes which is not supported by default
//    
//    /*
//     [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//     */
//    // create AFAppDotNetAPIClient with base url
//    
//    
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];
//    NSString * sso_tk = @"";
//    if ([SettingManager isUserLogin]) {
//        sso_tk = [SettingManager userCenterTVToken];
//        if ([NSString empty:sso_tk]) {
//            sso_tk = @"";
//        }
//    }
//    
//    [afAppDotNetAPIClient setHttpHeader:@"SSOTK" value:sso_tk];
//    if (nil == afAppDotNetAPIClient) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    // request url path
//    
//    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
//                                                   andDynamicValues:arrayDynamicValues
//                                                   andUrlHeadValues:nil];
//    
//    
//    if ([NSString isBlankString:urlPath]) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    //add header-TK  yjyan 20150410
//    {
//        NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
//        if(![NSString isBlankString:tk])
//        {
//            [afAppDotNetAPIClient setHttpHeader:@"TK" value:tk];
//        }
//    }
//    
//    //    NSLog(@"DataModelEngine, %@", urlPath);
//    
//    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                                 andDynamicValues:arrayDynamicValues
//                                                 andUrlHeadValues:nil];
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
//    __block NSString *customAssociatName = associatedName;
//    if ([method isEqualToString:@"POST"]) {
//        [afAppDotNetAPIClient POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            if (postImage) {
//                if (!customAssociatName) {
//                    customAssociatName = @"img";
//                }
//                NSString* imgName = [NSString stringWithFormat: @"%@.jpg",
//                                     [NSString stringWithFormat: @"%ld", time (NULL)]];
//                NSData *imgData = UIImageJPEGRepresentation(postImage, 1);
//                [formData appendPartWithFileData:imgData name:customAssociatName fileName:imgName mimeType: @"image/jpeg"];
//            }
//        } success:^(AFHTTPRequestOperation *operation, id JSON) {
//            NSInteger httpStatusCode =[operation.response statusCode];
//            NSString *errCode = [NSString fomatEnumCode:urlModule];
//            if (![NSJSONSerialization isValidJSONObject:JSON]) {
//                
//                if (errorBlock) {
//                    errorBlock(nil);
//                }
//                
//                sendErrorStatisticBlock(errCode,httpStatusCode);
//            }
//            else{
//                if (completionBlock) {
//                    completionBlock(JSON);
//                }
//            }
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            if (errorBlock) {
//                errorBlock(nil);
//            }
//            
//            NSInteger httpStatusCode =[operation.response statusCode];
//            NSString *errCode =[NSString fomatEnumCode:urlModule];
//            sendErrorStatisticBlock(errCode,httpStatusCode);
//            //                                    if ([error code]==NSURLErrorTimedOut) {
//            //                                          //超时
//            //                                         errCode = [NSString fomatEnumCode:LTDCFailedCodeMeiziRequestTimeout];
//            //                                    }
//            if ([error code]!= NSURLErrorCancelled)
//            {
//                sendErrorStatisticBlock(errCode,httpStatusCode);
//            }
//            
//        }];
//        
//    }
//    return;
//
//}
//
//
//
//+ (BOOL)isDataCached:(LTURLModule)urlModule andDynamicValues:(NSArray *)arrayDynamicValues {
//    BOOL isCached = NO;
//    
//    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                                 andDynamicValues:arrayDynamicValues];
//    
//    if ([LTDataModelEngine isLocalDataExisted:url]) {
//        isCached = YES;
//    }
//    
//    return isCached;
//}
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
//                    errorHandler:(LTDataErrorBlock)errorBlock
//{
//    [LTDataModelEngine refreshTaskWithUrlModule:urlModule
//                               andDynamicValues:arrayDynamicValues
//                                    isNeedCache:isNeedCache
//                                  andHttpMethod:method
//                                  andParameters:parameters
//                              completionHandler:completionBlock
//                                nochangeHandler:nochangeBlock
//                                   emptyHandler:emptyBlock
//                             tokenExpiredHander:tokenExpiredBlock
//                                ipShieldHandler:^(NSString *country, NSString *message) {
//                                    if (errorBlock) {
//                                        errorBlock(nil);
//                                    }
//                                }
//                                   errorHandler:errorBlock];
//}
//
//
//// 内部使用
//+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
//                andDynamicValues:(NSArray *)arrayDynamicValues
//                     isNeedCache:(BOOL)isNeedCache
//                   andHttpMethod:(NSString *)method
//                   andParameters:(NSDictionary *)parameters
//                             url:(NSString *)url
//                       localBody:localBody
//               completionHandler:(LTDataCompletionBodyBlock)completionBlock
//                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
//                    emptyHandler:(LTDataEmptyBlock)emptyBlock
//              tokenExpiredHander:(LTDataTokenExpiredBlock)tokenExpiredBlock
//                 ipShieldHandler:(LTDataIPShieldBlock)ipShieldBlock
//                    errorHandler:(LTDataErrorBlock)errorBlock {
//    if ([NetworkReachability connectedToNetwork]) {
//        NSTimeInterval utimeStart = [[NSDate date]timeIntervalSince1970];
//        [LTDataModelEngine refreshTaskWithUrlModule:urlModule
//                                   andDynamicValues:arrayDynamicValues
//                                      andHttpMethod:method
//                                      andParameters:parameters
//                                  completionHandler:^(NSDictionary *respondDict) {
//#if 0
//                                      NSString *respondString = [respondDict JSONRepresentation];
//#else
//                                      NSData* data = [NSJSONSerialization dataWithJSONObject: respondDict options: 0 error: nil];
//                                      NSString* respondString = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//#endif
//                                      
//                                      LTDataModel *dataModel = nil;
//                                      NSError *parseError = nil;
//                                      
//                                      @try {
//                                          dataModel = [[LTDataModel alloc] initWithDictionary:respondDict error:&parseError];
//                                      }
//                                      @catch (NSException *exception) {
//                                          
//                                          NSString *errInfo = [NSString stringWithFormat:@"接口异常了, errorUserInfo:%@, errorDescription:%@, urlModule:%u, url:%@, respondDict:%@", parseError.userInfo, parseError.localizedDescription, urlModule, url, respondDict];
//                                          [LTDataCenter writeToErrorLogFile:errInfo];
//                                          
//                                          if (errorBlock) {
//                                              errorBlock(nil);
//                                          }
//                                          
//                                          NSAssert(NO, errInfo);
//                                          
//                                          return;
//                                      }
//                                      @finally {
//
//                                      }
//                                      
//                                      NSTimeInterval  utimeEnd = [[NSDate date]timeIntervalSince1970];
//                                      CGFloat utime =utimeEnd-utimeStart;
//                                      NSString *utimeString =(utime>=0)?[NSString stringWithFormat:@"%.2f",utime]:@"";
//                                      
//                                      if (    nil == dataModel
//                                          ||  nil == dataModel.header
//                                          ||  dataModel.header.status!=DataStatusNormal
//                                          ||  utime>[SettingManager getDefaultTimeOut]) {
//                                          NSString *errCode = [NSString fomatEnumCode:urlModule];
//                                          NSString *statusCode =(dataModel.header.status>0)?[NSString stringWithFormat:@"200_%d",dataModel.header.status]:@"200_-";
//                                          NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
//                                                                                       andDynamicValues:arrayDynamicValues];
//                                          [LTDataCenter addErrorData:errCode
//                                                              andCid:@""
//                                                              andPid:@""
//                                                              adnVid:@""
//                                                      andDownloadUrl:@""
//                                                          andPlayUrl:@""
//                                                           andPlayVt:VIDEO_CODE_UNKNOWN
//                                                       andLivingCode:@""
//                                                       andRequestUrl:url
//                                                       andStatusCode:statusCode
//                                                            andUtime:utimeString
//                                                         andPlayUUid:nil
//                                                      andisPlayError:YES];
//                                          
//                                          // 请求失败，写入错误日志
//                                          if (nil == dataModel
//                                              ||  nil == dataModel.header
//                                              ||  dataModel.header.status != DataStatusNormal) {
//                                              NSString *errlog =[NSString stringWithFormat:@"请求失败, urlModule:%d url:%@ errorDict:%@",urlModule,url,respondDict];
//                                              [LTDataCenter writeToErrorLogFile:errlog];
//                                          }
//                                      }
//                                      
//                                      if (      nil == dataModel
//                                          ||    nil == dataModel.header
//                                          ||    nil == dataModel.body) {
//                                          if (errorBlock) {
//                                              errorBlock(nil);
//                                          }
//                                          
//                                      }
//                                      else{
//                                          switch (dataModel.header.status) {
//                                              case DataStatusNormal:
//                                              {
//                                                  if (isNeedCache
//                                                      &&[LTDataModelEngine isLocalDataExisted:url]
//                                                      &&[localBody isEqualToDictionary:dataModel.body]) {
//                                                      //                                                      NSLog(@"取到的数据与缓存数据相同，不做变化");
//                                                      return;
//                                                  }
//                                                  if (completionBlock) {
//                                                      
//                                                      if(LTURLModule_Video_VF == urlModule
//                                                         || LTURLModule_Video_VF_And_Advertise == urlModule
//                                                         )
//                                                      {
//                                                          if(dataModel.body && dataModel.header)
//                                                          {
//                                                              if(respondDict && [[respondDict allKeys]containsObject:@"header"])
//                                                              {
//                                                                  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataModel.body];
//                                                                  [dic setObject:respondDict[@"header"] forKey:@"header"];
//                                                                  dataModel.body = dic;
//                                                              }
//                                                          }
//                                                      }
//                                                      
//                                                      BOOL isNeed = [LTDataModelEngine check:urlModule body:dataModel.body];
//                                                      
//                                                      if (!isNeed && isNeedCache) {
//                                                          if ([LTDataModelEngine isLocalDataExisted:url]) {
//                                                              // 如果有缓存直接return
//                                                              
//                                                              NSString *logInfo = [NSString stringWithFormat:@"数据展示缓存问题, 之前有缓存, url:%@, 当前：!isNeed && isNeedCache", url];
//                                                              [LTDataCenter writeToErrorLogFile:logInfo];
//                                                              return;
//                                                          } else {
//                                                              
//                                                              [LTDataCenter writeToErrorLogFile:@"数据展示缓存问题, 当前无缓存: !isNeed && isNeedCache"];
//                                                              
//                                                              // 没有的话返回error
//                                                              if (errorBlock) {
//                                                                  errorBlock(nil);
//                                                                  return;
//                                                              }
//                                                          }
//                                                      }
//                                                      
//                                                      @try {
//                                                          completionBlock(dataModel.body, dataModel.header.markid);
//                                                          
//                                                          //返回成功后，写入缓存
//                                                          if (isNeedCache) {
//                                                              if(!([LTDataModelEngine isLocalDataExisted:url] &&
//                                                                   [respondDict isEqualToDictionary:[LTDataModelEngine getLocalData:url]])){
//                                                                  [LTDataModelEngine writeToFile:respondDict andUrlPath:url];
//                                                              }
//                                                          }
//                                                      } @catch (NSException *exception) {
//                                                          
//                                                          NSString *errInfo = [NSString stringWithFormat:@"接口回调异常了, errorUserInfo:%@, errorDescription:%@, urlModule:%u, url:%@, respondDict:%@", parseError.userInfo, parseError.localizedDescription, urlModule, url, respondDict];
//                                                          [LTDataCenter writeToErrorLogFile:errInfo];
//                                                          
//                                                          if (errorBlock) {
//                                                              errorBlock(nil);
//                                                          }
//                                                          
//                                                          NSAssert(NO, errInfo);
//                                                          
//                                                          return;
//                                                      } @finally {
//                                                          
//                                                      }
//                                                  }
//                                              }
//                                                  break;
//                                              case DataStatusNotChange:
//                                              {
//                                                  if (nochangeBlock) {
//                                                      nochangeBlock();
//                                                  }
//                                              }
//                                                  break;
//                                              case DataStatusEmpty:
//                                              {
//                                                  if (emptyBlock) {
//                                                      emptyBlock();
//                                                  }
//                                                  NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
//                                                  [LTDataCenter writeToErrorLogFile:errlog];
//                                              }
//                                                  break;
//                                              case DataStatusTokenExpired:
//                                              {
//                                                  if (tokenExpiredBlock) {
//                                                      tokenExpiredBlock();
//                                                  }
//                                                  NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
//                                                  [LTDataCenter writeToErrorLogFile:errlog];
//                                              }
//                                                  break;
//                                              case DataStatusIPShield:
//                                              {
//                                                  NSDictionary *dictBody = dataModel.body;
//                                                  NSString *country = [NSString safeString:dictBody[@"country"]];
//                                                  NSString *message = [NSString safeString:dictBody[@"message"]];
//                                                  if (ipShieldBlock) {
//                                                      ipShieldBlock(country, message);
//                                                  }
//                                              }
//                                                  break;
//                                              case DataStatusAbnormal:
//                                              default:
//                                              {
//                                                  if (errorBlock) {
//                                                      errorBlock(nil);
//                                                  }
//                                                  NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
//                                                  [LTDataCenter writeToErrorLogFile:errlog];
//                                                  
//                                              }
//                                                  break;
//                                          }
//                                      }
//                                      
//                                  } errorHandler:^(NSError *error) {
//                                      if (errorBlock) {
//                                          errorBlock(error);
//                                      }
//                                      
//                                      
//                                  }];
//    }else{
//        if (![LTDataModelEngine getLocalData:url]||!isNeedCache) {
//            if (errorBlock) {
//                errorBlock(nil);
//            }
//        }
//    }
//}
//
//+ (BOOL)check:(LTURLModule)urlModule body:(NSDictionary *)body
//{
//    /*
//     App首页：除去焦点图、直播位、老的直播区块推广位、热词、搜索框、重磅推荐、数据为空区块后，区块还大于等于B且焦点图个数大于等于B，正常写入缓存
//     频道首页和子页面由于是同一个接口并且子页面也可能出现多个区块的情况
//     作如下处理: 除去直播位、热词、搜索框、电影付费入口、二级导航、数据为空区块后，区块还大于零，正常写入缓存
//     */
//    
//    BOOL isNeedCache = NO;
//    
//    NSError *parseError = nil;
//    switch (urlModule) {
//        case LTURLModule_Recommend_Personalized:
//        {
//            // app首页
//            @try {
//                LTChannelIndexModel *channelIndexData = [[LTChannelIndexModel alloc] initWithDictionary:body error:&parseError];
//                isNeedCache = [channelIndexData isShouldCache:YES];
//                
//                if (parseError != nil) {
//                    NSString *errorCodeInfo = [NSString stringWithFormat:@"首页:LTRecommendModel parse exception:%@", parseError];
//                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
//                }
//            }
//            @catch (NSException *exception) {
//                NSString *errorCodeInfo = [NSString stringWithFormat:@"首页:LTRecommendModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
//                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
//            }
//            @finally {}
//        }
//            break;
//        case LTURLModule_Channel_Index:
//        {
//            // 频道页
//            @try {
//                LTChannelIndexModel *channelIndexData = [[LTChannelIndexModel alloc] initWithDictionary:body error:nil];
//                isNeedCache = [channelIndexData isShouldCache:NO];
//
//                if (parseError != nil) {
//                    NSString *errorCodeInfo = [NSString stringWithFormat:@"频道页:LTChannelIndexModel parse exception:%@", parseError];
//                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
//                }
//            }
//            @catch (NSException *exception) {
//                NSString *errorCodeInfo = [NSString stringWithFormat:@"频道页:LTChannelIndexModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
//                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
//            }
//            @finally {}
//        }
//            break;
//            
//        case LTURLModule_Channel_NewList_5_9:
//        {
//            // 频道墙
//            @try {
//                LTNewChannelModel *channelModel = [[LTNewChannelModel alloc]initWithDictionary:body error:nil];
//                isNeedCache = [channelModel isShouldCache];
//                
//                if (parseError != nil) {
//                    NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel parse exception:%@", parseError];
//                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
//                }
//            }
//            @catch (NSException *exception) {
//                NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
//                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
//            }
//            @finally {}
//        }
//            break;
//        case LTURLModule_Channel_NewList_6_5:
//        {
//            NSLog(@"body == %@",body);
//            // 6.5 频道墙
//            @try {
//                LTChannelWallModel *channelModel = [[LTChannelWallModel alloc]initWithDictionary:body error:nil];
//                isNeedCache = [channelModel isShouldCache];
//                
//                if (parseError != nil) {
//                    NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel6.5 parse exception:%@", parseError];
//                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
//                }
//            }
//            @catch (NSException *exception) {
//                NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
//                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
//            }
//            @finally {}
//        }
//            break;
//        default:
//            isNeedCache = YES;
//            break;
//    }
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
//    __block NSDictionary *localBody=[NSDictionary dictionary];
//    if (isNeedCache) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            if([LTDataModelEngine isLocalDataExisted:url]){
//                NSDictionary *dict= [LTDataModelEngine getLocalData:url];
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
//                        [LTDataModelEngine refreshTaskWithUrlModule:urlModule
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
//                [LTDataModelEngine refreshTaskWithUrlModule:urlModule
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
//            [LTDataModelEngine refreshTaskWithUrlModule:urlModule
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
//+ (BOOL) writeToFile:(NSDictionary *)responseData andUrlPath:(NSString *)urlPath{
//    
//  
//    if ([NSString isBlankString:urlPath]) {
//        return NO;
//    }
//    
//    
//    NSString *strUrl = [NSString stringWithFormat:@"%@",urlPath];
//    strUrl = [strUrl subStringByRemoveMutableParams];
//    
//    NSString *urlDataDir = [FileManager appUrlDataCachePath];
//    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W"
//                                                      withString:@"_"];
//    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
//    BOOL bResult = [responseData writeToFile:fullPath
//                                                     atomically:YES];
//    if (bResult) {
////        NSLog(@"write success...");
//    }
//    
//    return bResult;
//}
//
//+ (BOOL)isLocalDataExisted:(NSString *)urlString{
//    
//    NSString *strUrl = [urlString subStringByRemoveMutableParams];
//    
//    NSString *urlDataDir = [FileManager appUrlDataCachePath];
//    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W"
//                                                      withString:@"_"];
//    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
//    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
//        return YES;
//    }
//    
//    return NO;
//    
//}
//
//+ (NSDictionary *)getLocalData:(NSString *)urlString{
//    
//    // use local url data
//    NSString *strUrl = [urlString subStringByRemoveMutableParams];
//    
//    NSString *urlDataDir = [FileManager appUrlDataCachePath];
//    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W"
//                                                      withString:@"_"];
//    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
//    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
//        NSDictionary *responseDict =[NSDictionary dictionaryWithContentsOfFile:fullPath];
//        if (![NSObject empty:responseDict]) {
//            
////            NSLog(@"use local data ok");
//            return responseDict;
//        }
//        
//    }
//    
//     
//    return  nil;
//    
//}
//
//+(NSDictionary *)getLocalDataBody:(NSString *)urlString{
//    @autoreleasepool {
//        LTDataModel *dataModel = [[LTDataModel alloc] initWithDictionary:[LTDataModelEngine getLocalData:urlString] error:nil];
//        if (      nil == dataModel
//            ||    nil == dataModel.header
//            ||    nil == dataModel.body) {
//            return nil;
//        }
//        
//        if (dataModel.header.status == DataStatusNormal) {
//            return dataModel.body;
//        }
//        return nil;
//    }
//}
//
//#pragma mark - 广告拼接
//
//+(void)cancelPlayUrlMergeOperation
//{
//    /*
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    */
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedPlayUrlMergeClient];
//    [afAppDotNetAPIClient cancelAllHTTPOperationsWithMethod:@"POST" path:nil];
//}
//
//+ (void)playUrlMergeWithAhl:(NSArray *)ahl
//                      andVl:(NSString *)vl
//                     andAts:(NSArray *)atl
//          completionHandler:(LTDataCompletionBlock)completionBlock
//               errorHandler:(LTDataErrorBlock)errorBlock
//{
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedPlayUrlMergeClient];
//    
//    if (nil == afAppDotNetAPIClient) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    if ([NSString isBlankString:vl]) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    NSMutableArray *mutAhl = [NSMutableArray array];
//    if (ahl && [ahl isKindOfClass:[NSArray class]]) {
//        for (NSString *eleAhl in ahl) {
//            [mutAhl addObject:[eleAhl stringByAppendingString:@"&tss=ios"]];
//        }
//    }
//    
//    NSMutableArray *mutAtl = [NSMutableArray array];
//    if (atl && [atl isKindOfClass:[NSArray class]]) {
//        for (NSString *eleAtl in atl) {
//            [mutAtl addObject:[eleAtl stringByAppendingString:@"&tss=ios"]];
//        }
//    }
//    
//    NSDictionary *parameters = @{@"ahl" : [NSString safeString:[mutAhl componentsJoinedByString:@"|"]],
//                                 @"vl"  : [NSString safeString:vl],
//                                 @"atl" : [NSString safeString:[mutAtl componentsJoinedByString:@"|"]]
//                                 };
//    
//    [afAppDotNetAPIClient POST:@""
//                    parameters:parameters
//                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                           if (![NSJSONSerialization isValidJSONObject:responseObject]) {
//                               if (errorBlock) {
//                                   errorBlock(nil);
//                               }
//                           }
//                           else{
//                               if (completionBlock) {
//                                   completionBlock(responseObject);
//                               }
//                           }
//                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                           if (errorBlock) {
//                               errorBlock(error);
//                           }
//                       }];
//    
//    return;
//}
//
//+ (void)playUrlMergeWithAhl:(NSArray *)ahl
//                      andVl:(NSString *)vl
//                     andAts:(NSArray *)atl
//                     andAml:(NSArray *)aml
//                     andAmp:(NSArray *)amp
//                 cdeEnabled:(BOOL)enabled
//          completionHandler:(LTDataCompletionBlock)completionBlock
//               errorHandler:(LTDataErrorBlock)errorBlock
//{
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedPlayUrlMergeClient];
//    
//    if (nil == afAppDotNetAPIClient) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    if ([NSString isBlankString:vl]) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    NSString *m3vArg = @"";
//    NSString *m3vStr = [SettingManager getStringValueFromUserDefaults:kM3vValue];
//    if([NSString isBlankString:m3vStr]){
//        m3vStr = @"3";
//    }
//    m3vArg = [NSString stringWithFormat:@"&m3v=%@",m3vStr];
//    
//    NSMutableArray *mutAhl = [NSMutableArray array];
//    if (ahl && [ahl isKindOfClass:[NSArray class]]) {
//        for (NSString *eleAhl in ahl) {
//            [mutAhl addObject:[eleAhl stringByAppendingString:@"&tss=ios"]];
//        }
//    }
//    
//    NSMutableArray *mutAtl = [NSMutableArray array];
//    if (atl && [atl isKindOfClass:[NSArray class]]) {
//        for (NSString *eleAtl in atl) {
//            [mutAtl addObject:[eleAtl stringByAppendingString:@"&tss=ios"]];
//        }
//    }
//    
//    NSMutableDictionary* parameters = nil;
//    if (aml == nil || amp == nil) {
//        
//        parameters = [NSMutableDictionary
//                      dictionaryWithDictionary: @{
//                                                @"ahl" : [NSString safeString:[mutAhl componentsJoinedByString:@"|"]],
//                                                @"vl"  : [NSString safeString:vl],
//                                                @"atl" : [NSString safeString:[mutAtl componentsJoinedByString:@"|"]],
//                                                @"bks" :  @"2",
//                                                @"once" : @"2"
//                                                }];
//
//    } else {
//        
//        NSMutableArray *mutAml = [NSMutableArray array];
//        if (aml && [aml isKindOfClass:[NSArray class]]) {
//            for (NSString *eleAml in aml) {
//                [mutAml addObject:[eleAml stringByAppendingString:@"&tss=ios"]];
//            }
//        }
//        
//        NSMutableArray *mutAmp = [NSMutableArray array];
//        if (amp && [amp isKindOfClass:[NSArray class]]) {
//            for (NSString *eleAmp in amp) {
//                [mutAmp addObject:eleAmp];
//            }
//        }
//
//        parameters = [NSMutableDictionary
//                      dictionaryWithDictionary: @{
//                                                @"ahl" : [NSString safeString:[mutAhl componentsJoinedByString:@"|"]],
//                                                @"vl"  : [NSString safeString:vl],
//                                                @"atl" : [NSString safeString:[mutAtl componentsJoinedByString:@"|"]],
//                                                @"aml" : [NSString safeString:[mutAml componentsJoinedByString:@"|"]],
//                                                @"amp" : [NSString safeString:[mutAmp componentsJoinedByString:@"|"]],
//                                                @"bks" :  @"2",
//                                                @"once" : @"2"
//                                                }];
//    }
//    
//    [afAppDotNetAPIClient POST:@""
//                    parameters:parameters
//                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                           if (![NSJSONSerialization isValidJSONObject:responseObject]) {
//                               if (errorBlock) {
//                                   errorBlock(nil);
//                               }
//                           }
//                           else{
//                               if (completionBlock) {
//                                   completionBlock(responseObject);
//                               }
//                           }
//                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                           if (errorBlock) {
//                               errorBlock(error);
//                           }
//                           
//                       }];
//    
//    return;
//}
//
//+ (void)playUrlMergeWithAhl:(NSArray *)ahl
//                      andVl:(NSString *)vl
//                     andAts:(NSArray *)atl
//                 cdeEnabled:(BOOL)enabled
//          completionHandler:(LTDataCompletionBlock)completionBlock
//               errorHandler:(LTDataErrorBlock)errorBlock
//{
//    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedPlayUrlMergeClient];
//    
//    if (nil == afAppDotNetAPIClient) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    if ([NSString isBlankString:vl]) {
//        if (errorBlock) {
//            errorBlock(nil);
//        }
//        return;
//    }
//    
//    NSMutableArray *mutAhl = [NSMutableArray array];
//    if (ahl && [ahl isKindOfClass:[NSArray class]]) {
//        for (NSString *eleAhl in ahl) {
//            [mutAhl addObject:[eleAhl stringByAppendingString:@"&tss=ios"]];
//        }
//    }
//    
//    NSMutableArray *mutAtl = [NSMutableArray array];
//    if (atl && [atl isKindOfClass:[NSArray class]]) {
//        for (NSString *eleAtl in atl) {
//            [mutAtl addObject:[eleAtl stringByAppendingString:@"&tss=ios"]];
//        }
//    }
//    
//    NSMutableDictionary* parameters = [NSMutableDictionary
//                                       dictionaryWithDictionary: @{
//                                                                   @"ahl" : [NSString safeString:[mutAhl componentsJoinedByString:@"|"]],
//                                                                   @"vl"  : [NSString safeString:vl],
//                                                                   @"atl" : [NSString safeString:[mutAtl componentsJoinedByString:@"|"]],
//                                                                   @"bks" :  @"2",
//                                                                   @"once" : @"2"
//                                                                   }];
//    
//    [afAppDotNetAPIClient POST:@""
//                    parameters:parameters
//                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                           if (![NSJSONSerialization isValidJSONObject:responseObject]) {
//                               if (errorBlock) {
//                                   errorBlock(nil);
//                               }
//                           }
//                           else{
//                               if (completionBlock) {
//                                   completionBlock(responseObject);
//                               }
//                           }
//                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                           if (errorBlock) {
//                               errorBlock(error);
//                           }
//
//                       }];
//    
//    return;
//}
//
//@end
//#else


NSInteger getStatusCode(NSURLSessionDataTask *task) {
    NSInteger httpStatusCode = -1;
    
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *response = task.response;
        httpStatusCode = response.statusCode;
    }
    return httpStatusCode;
}

//@interface LTDataModelEngine()<RCTBridgeModule>
//
//@end

@implementation LTDataModelEngine

#pragma mark - React Methods

//RCT_EXPORT_MODULE(LTDataModelEngine)
//
//RCT_EXPORT_METHOD(getTKByUrlPath:(NSString *)path callback:(RCTResponseSenderBlock)callback) {
//    if (path == nil || path.length == 0) {
//        callback(@[@""]);
//    } else {
//        NSString *tk = [EncryptHelper getLTTKByUrlPath:path];
//        callback(@[tk]);
//    }
//}

#pragma mark - common

+ (void)sendStatistics:(LTDataCenterStatisticsType)sType
           withUrlPath:(NSString *)path
     completionHandler:(LTDataCenterCompletionBlock)completionBlock
          errorHandler:(LTDataErrorBlock)errorBlock
{
    /*
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"image/gif"]]; // fixme
     */
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient = nil;
#ifdef DEVELOP_MODE_FOR_STATISTICS
    if (    sType == LTDataCenterStatisticsTypeKVAction
        ||  sType == LTDataCenterStatisticsTypeKVLogin
        ||  sType == LTDataCenterStatisticsTypeKVLogout
        ||  sType == LTDataCenterStatisticsTypeKVEnv
        ||  sType == LTDataCenterStatisticsTypeKVPlay
        ||  sType == LTDataCenterStatisticsTypeKVQuery
        ||  sType == LTDataCenterStatisticsTypeKVError) {
        afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterKVClient];
    }
    else if (sType == LTDataCenterStatisticsTypeKVAd)
    {
         afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterKVClientForAd];
    }
    else{
        afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterClient];
    }
#else
    if (    sType == LTDataCenterStatisticsTypeKVAction
        ||  sType == LTDataCenterStatisticsTypeKVLogin
        ||  sType == LTDataCenterStatisticsTypeKVLogout
        ||  sType == LTDataCenterStatisticsTypeKVEnv
        ||  sType == LTDataCenterStatisticsTypeKVPlay
        ||  sType == LTDataCenterStatisticsTypeKVAd
        ||  sType == LTDataCenterStatisticsTypeKVQuery
        ||  sType == LTDataCenterStatisticsTypeKVError) {
        afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterKVClient];
    }
    else{
        afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedDataCenterClient];
    }
    
#endif
    
    if (nil == afAppDotNetAPIClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    if ([NSString isBlankString:path]) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    
    NSString *dcFlag = [LTDataCenter urlFlagForStatisticsType:sType];
    if ([NSString isBlankString:dcFlag]) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    NSString *fullPath = [dcFlag stringByAppendingString:path];
    
#ifdef SWITCH_OFF_FOR_STATISTICS
    NSLog(@"data center switch off, %d, %@%@", sType, afAppDotNetAPIClient.baseURL.absoluteString, fullPath);
    return;
#endif
    
    fullPath = [NSString stringWithFormat:@"%@&apprunid=%@", fullPath, [SettingManager getVirtualLoginUUID]];
    
    [afAppDotNetAPIClient GET:fullPath
                   parameters:nil
                      success:^(NSURLSessionDataTask *operation, id responseObject) {
                          if (completionBlock) {
                              completionBlock();
                          }
                      } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                          if (errorBlock) {
                              errorBlock(nil);
                          }
                      }];
}

+ (void)requestWithUrl:(NSString *)url
      completionHandler:(LTDataCompletionBlock)completionBlock
          errorHandler:(LTDataErrorBlock)errorBlock
{
    /*
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
     */
    AFAppDotNetAPIClient *afAppDotNetAPIClient =[AFAppDotNetAPIClient sharedClientWithUrl:url];
    if (nil == afAppDotNetAPIClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    [afAppDotNetAPIClient GET:url
                   parameters:nil
                      success:^(NSURLSessionDataTask *operation, id responseObject) {
                          NSData *data =(NSData *)responseObject;
                          
                          NSError *error;
                          NSDictionary *JSONDict = nil;
                          
                          if (data != nil) {
                              JSONDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                          }
                          
                          if (![NSJSONSerialization isValidJSONObject:JSONDict]) {
                              if (errorBlock) {
                                  errorBlock(nil);
                              }
                          }
                          else{
                              if (completionBlock) {
                                  completionBlock(JSONDict);
                              }
                          }
                      } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                          if (errorBlock) {
                              errorBlock(error);
                          }
                      }];

    return;
}

+ (void)requestXMLWithUrl:(NSString *)url
                urlModule:(LTURLModule)urlModule
        completionHandler:(void (^)(NSXMLParser *responseXMLParser))completionBlock
             errorHandler:(LTDataErrorBlock)errorBlock

{
    NSURL *requestURL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    NSURLSessionDataTask *op = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSXMLParser *parser = (NSXMLParser *)responseObject;
            
            if (parser == nil) {
                
                if (errorBlock) {
                    
                    errorBlock(nil);
                    
                }
                
            }else{
                
                if (completionBlock) {
                    
                    completionBlock(parser);
                    
                }
            }
        }
        else {
            NSLog(@"Error: %@", error);
            if (errorBlock) {
                
                errorBlock(error);
                
            }
        }
    }];

    [op resume];
    
    return;
    
}


+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock{
    // add additional contentTypes which is not supported by default
    
    [LTDataModelEngine refreshTaskWithUrlModule:urlModule
                               andDynamicValues:arrayDynamicValues
                               andUrlHeadValues:nil
                                  andHttpMethod:method
                                  andParameters:parameters
                              completionHandler:completionBlock
                                   errorHandler:errorBlock];
}

+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                         outTime:(float)time
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock
{
    return [LTDataModelEngine refreshTaskWithUrlModule:urlModule
                                      andDynamicValues:arrayDynamicValues
                                         andHttpMethod:method
                                         andParameters:parameters
                                       andHeaderFields:nil
                                               outTime:time
                                     completionHandler:completionBlock
                                          errorHandler:errorBlock];
}

+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                 andHeaderFields:(NSDictionary *)headerFields
                         outTime:(float)time
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock
{
    // add additional contentTypes which is not supported by default
    /*
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    */
    // create AFAppDotNetAPIClient with base url
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];
    NSString * sso_tk = @"";
    if ([SettingManager isUserLogin]) {
        sso_tk = [SettingManager userCenterTVToken];
        if ([NSString empty:sso_tk]) {
            sso_tk = @"";
        }
    }
    
    [afAppDotNetAPIClient setHttpHeader:@"SSOTK" value:sso_tk];
    if (nil == afAppDotNetAPIClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    // request url path
    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
                                                   andDynamicValues:arrayDynamicValues];
    
    if ([NSString isBlankString:urlPath]) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    //add header-TK  yjyan 20150410
    {
        NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
        if(![NSString isBlankString:tk])
        {
            [afAppDotNetAPIClient setHttpHeader:@"TK" value:tk];
        }
    }
    
    if ([method isEqualToString:@"POST"]) {
        [afAppDotNetAPIClient postPath:urlPath
                            parameters:parameters
                          headerFields:headerFields
                               timeOut:time
                               success:^(NSURLSessionDataTask *operation, id JSON) {
                                   
                                   NSInteger httpStatusCode = getStatusCode(operation);
                                   
                                   if (httpStatusCode != 200) {
                                       NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
                                       [LTDataCenter writeToErrorLogFile:logInfo];
                                   }
                                   
                                   if (![NSJSONSerialization isValidJSONObject:JSON]) {
                                       
                                       NSString *logInfo = [NSString stringWithFormat:@"接口返回错误, 不是合法的JSON httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
                                       [LTDataCenter writeToErrorLogFile:logInfo];
                                       
                                       if (errorBlock) {
                                           errorBlock(nil);
                                       }
                                   }
                                   else{
                                       if (completionBlock) {
                                           completionBlock(JSON);
                                       }
                                   }

                               } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                   
                                   NSInteger httpStatusCode = getStatusCode(operation);
                                   
                                   NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, error:%@", httpStatusCode, urlModule, urlPath, error];
                                   [LTDataCenter writeToErrorLogFile:logInfo];
                                   
                                   if (errorBlock) {
                                       errorBlock(nil);
                                   }
                               }];
    }else{
        [afAppDotNetAPIClient getPath:urlPath
                           parameters:nil
                         headerFields:headerFields
                              timeOut:time
                              success:^(NSURLSessionDataTask *operation, id JSON) {
                              
                                  
                              NSInteger httpStatusCode = getStatusCode(operation);
                                  
                              if (httpStatusCode != 200) {
                                    NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
                                    [LTDataCenter writeToErrorLogFile:logInfo];
                              }
                                  
                              if (![NSJSONSerialization isValidJSONObject:JSON]) {
                                  
                                  NSString *logInfo = [NSString stringWithFormat:@"接口返回错误, 不是合法的JSON httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
                                  [LTDataCenter writeToErrorLogFile:logInfo];
                                  
                                  if (errorBlock) {
                                      errorBlock(nil);
                                  }
                              }
                              else{
                                  if (completionBlock) {
                                      completionBlock(JSON);
                                  }
                              }
                            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                
                                NSInteger httpStatusCode = getStatusCode(operation);
                                
                                NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, error:%@", httpStatusCode, urlModule, urlPath, error];
                                [LTDataCenter writeToErrorLogFile:logInfo];
                                
                                if (errorBlock) {
                                    errorBlock(error);
                                }
                            }];
    }
    return;
}

+(void)cancelAllHttpOperationWithUrlModule:(LTURLModule)urlModule
{
    /*
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    */
    // create AFAppDotNetAPIClient with base url
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];

    [afAppDotNetAPIClient cancelAllHTTPOperationsByUrlModule:urlModule];
}

+(void)cancelAllHttpOperationWithUrlModule:(LTURLModule)urlModule  andDynamicValues:(NSArray *)arrayDynamicValues{
    /*
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    */
    // create AFAppDotNetAPIClient with base url
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];

    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
                                                   andDynamicValues:arrayDynamicValues];
    
    [afAppDotNetAPIClient cancelAllHTTPOperationsWithMethod:@"GET" path:urlPath];
}



+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
               completionHandler:(LTDataCompletionBodyBlock)completionBlock
                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
                    emptyHandler:(LTDataEmptyBlock)emptyBlock
                    errorHandler:(LTDataErrorBlock)errorBlock{
    
    return  [LTDataModelEngine refreshTaskWithUrlModule:urlModule andDynamicValues:arrayDynamicValues
                                            isNeedCache:YES
                                          andHttpMethod:@"GET"
                                          andParameters:nil
                                      completionHandler:completionBlock
                                        nochangeHandler:nochangeBlock
                                           emptyHandler:emptyBlock
                                     tokenExpiredHander:nil
                                           errorHandler:errorBlock];
}


+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                andUrlHeadValues:(NSArray *)arrayHeadValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock{
    [LTDataModelEngine refreshTaskWithUrlModule:urlModule andDynamicValues:arrayDynamicValues andUrlHeadValues:arrayHeadValues andHttpMethod:method andParameters:parameters andHeaderFields:nil completionHandler:completionBlock errorHandler:errorBlock];
}


+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                andUrlHeadValues:(NSArray *)arrayHeadValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                 andHeaderFields:(NSDictionary *)headerFields
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock{
    // add additional contentTypes which is not supported by default
    
    /*
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    */
    // create AFAppDotNetAPIClient with base url
    
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];
    NSString * sso_tk = @"";
    if ([SettingManager isUserLogin]) {
        sso_tk = [SettingManager userCenterTVToken];
        if ([NSString empty:sso_tk]) {
                sso_tk = @"";
        }
    }
    
    [afAppDotNetAPIClient setHttpHeader:@"SSOTK" value:sso_tk];
    if (nil == afAppDotNetAPIClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
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
    
    //add header-TK  yjyan 20150410
    {
        NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
        if(![NSString isBlankString:tk])
        {
            [afAppDotNetAPIClient setHttpHeader:@"TK" value:tk];
        }
    }
    
    //2016.12.28 添加dmsTK、dmsUID到header中（注：只针对LTURLModule_UC_UserInfo这种获取用户信息的请求类型）
    if (LTURLModule_UC_UserInfo == urlModule) {
        BOOL dmsSwitch = [SettingManager DMSSwitch];  //暂代开机接口中的开关
        BOOL isHK = [SettingManager isHK];
        if (dmsSwitch && !isHK) {
            NSString *dmsTK = [SettingManager DMSTK];
            NSString *dmsUID = [SettingManager DMSUID];
            [afAppDotNetAPIClient setHttpHeader:@"dmstk" value:dmsTK];
            [afAppDotNetAPIClient setHttpHeader:@"dmsuserid" value:dmsUID];
        }
    }
    //----end----
    
    //    NSLog(@"DataModelEngine, %@", urlPath);
    
    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
                                                 andDynamicValues:arrayDynamicValues
                                                 andUrlHeadValues:arrayHeadValues];
    
    __block NSTimeInterval utimeStart = [[NSDate date]timeIntervalSince1970];
    void (^sendErrorStatisticBlock)(NSString *errorCode,NSInteger httpStatusCode) =^(NSString *errorCode,NSInteger httpStatusCode){
        NSTimeInterval  utimeEnd = [[NSDate date]timeIntervalSince1970];
        CGFloat utime =utimeEnd-utimeStart;
        NSString *utimeString =(utime>=0)?[NSString stringWithFormat:@"%.2f",utime]:@"";
        
        if ([NetworkReachability connectedToNetwork]){
            [LTDataCenter addErrorData:errorCode
                                andCid:@""
                                andPid:@""
                                adnVid:@""
                        andDownloadUrl:@""
                            andPlayUrl:@""
                             andPlayVt:VIDEO_CODE_UNKNOWN
                         andLivingCode:@""
                         andRequestUrl:url
                         andStatusCode:[NSString stringWithFormat:@"%ld_-",(long)httpStatusCode]
                              andUtime:utimeString
                           andPlayUUid:nil];
        }
    };
    
    if ([method isEqualToString:@"POST"]) {
        [afAppDotNetAPIClient postPath:urlPath
                            parameters:parameters
                          headerFields:headerFields
                                   tag:urlModule
                               success:^(NSURLSessionDataTask *operation, id JSON) {
                                   NSInteger httpStatusCode = getStatusCode(operation);
                                   NSString *errCode = [NSString fomatEnumCode:urlModule];
                                   
                                   if (httpStatusCode != 200) {
                                       NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, url, JSON];
                                       [LTDataCenter writeToErrorLogFile:logInfo];
                                   }
                                   
                                   if (![NSJSONSerialization isValidJSONObject:JSON]) {
                                       
                                       NSString *logInfo = [NSString stringWithFormat:@"接口返回错误, 不是合法的JSON httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
                                       [LTDataCenter writeToErrorLogFile:logInfo];
                                       
                                       if (errorBlock) {
                                           errorBlock(nil);
                                       }
                                       
                                       sendErrorStatisticBlock(errCode,httpStatusCode);
                                   }
                                   else{
                                       if (completionBlock) {
                                           completionBlock(JSON);
                                       }
                                   }
                               }failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                   if (errorBlock) {
                                       errorBlock(nil);
                                   }
                                   
                                   NSInteger httpStatusCode = getStatusCode(operation);
                                   
                                   NSString *errCode =[NSString fomatEnumCode:urlModule];
                                   sendErrorStatisticBlock(errCode,httpStatusCode);

                                   if ([error code]!= NSURLErrorCancelled) {
                                       sendErrorStatisticBlock(errCode,httpStatusCode);
                                   }
                                   
                                   NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, error:%@", httpStatusCode, urlModule, url, error];
                                   [LTDataCenter writeToErrorLogFile:logInfo];
                               }];
        
    }else{
        [afAppDotNetAPIClient getPath:urlPath
                           parameters:nil
                         headerFields:headerFields
                                  tag:urlModule
                              success:^(NSURLSessionDataTask *operation, id JSON) {
                                  NSInteger httpStatusCode = getStatusCode(operation);
                                  NSString *errCode = [NSString fomatEnumCode:urlModule];
                                  
                                  if (httpStatusCode != 200) {
                                      NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, url, JSON];
                                      [LTDataCenter writeToErrorLogFile:logInfo];
                                  }
                                  
                                  if (![NSJSONSerialization isValidJSONObject:JSON]) {
                                      
                                      NSString *logInfo = [NSString stringWithFormat:@"接口返回错误, 不是合法的JSON httpStatusCode:%ld, urlModule:%ld, url:%@, json:%@", httpStatusCode, urlModule, urlPath, JSON];
                                      [LTDataCenter writeToErrorLogFile:logInfo];
                                      
                                      if (errorBlock) {
                                          errorBlock(nil);
                                      }
                                      
                                      sendErrorStatisticBlock(errCode,httpStatusCode);
                                  }
                                  else{
                                      if (completionBlock) {
                                          completionBlock(JSON);
                                      }
                                  }
                              }failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                  NSLog(@"operation == %@",operation.response);
                                  if (errorBlock) {
                                      errorBlock(error);
                                  }
                                  NSInteger httpStatusCode = getStatusCode(operation);
                                  NSString *errCode =[NSString fomatEnumCode:urlModule];
                                  sendErrorStatisticBlock(errCode, httpStatusCode);

                                  NSString *logInfo = [NSString stringWithFormat:@"接口请求错误, httpStatusCode:%ld, urlModule:%ld, url:%@, error:%@", httpStatusCode, urlModule, url, error];
                                  [LTDataCenter writeToErrorLogFile:logInfo];
                              }];
        
    }
    
    return;
    
}
//by handongyang param associatedName :server接受的图片名称
+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                       postImage:(UIImage *)postImage
                  associatedName:(NSString *)associatedName
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock{
    // add additional contentTypes which is not supported by default
    
    /*
     [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
     */
    // create AFAppDotNetAPIClient with base url
    
    
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedClientWithUrlModule:urlModule];
    NSString * sso_tk = @"";
    if ([SettingManager isUserLogin]) {
        sso_tk = [SettingManager userCenterTVToken];
        if ([NSString empty:sso_tk]) {
            sso_tk = @"";
        }
    }
    
    [afAppDotNetAPIClient setHttpHeader:@"SSOTK" value:sso_tk];
    if (nil == afAppDotNetAPIClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    // request url path
    
    NSString *urlPath = [LTRequestURLManager getRequestPathByModule:urlModule
                                                   andDynamicValues:arrayDynamicValues
                                                   andUrlHeadValues:nil];
    
    
    if ([NSString isBlankString:urlPath]) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    //add header-TK  yjyan 20150410
    {
        NSString *tk = [EncryptHelper getLTTKByUrlPath:urlPath];
        if(![NSString isBlankString:tk])
        {
            [afAppDotNetAPIClient setHttpHeader:@"TK" value:tk];
        }
    }
    
    //    NSLog(@"DataModelEngine, %@", urlPath);
    
    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
                                                 andDynamicValues:arrayDynamicValues
                                                 andUrlHeadValues:nil];
    
    __block NSTimeInterval utimeStart = [[NSDate date]timeIntervalSince1970];
    void (^sendErrorStatisticBlock)(NSString *errorCode,NSInteger httpStatusCode) =^(NSString *errorCode,NSInteger httpStatusCode){
        NSTimeInterval  utimeEnd = [[NSDate date]timeIntervalSince1970];
        CGFloat utime =utimeEnd-utimeStart;
        NSString *utimeString =(utime>=0)?[NSString stringWithFormat:@"%.2f",utime]:@"";
        
        if ([NetworkReachability connectedToNetwork]){
            [LTDataCenter addErrorData:errorCode
                                andCid:@""
                                andPid:@""
                                adnVid:@""
                        andDownloadUrl:@""
                            andPlayUrl:@""
                             andPlayVt:VIDEO_CODE_UNKNOWN
                         andLivingCode:@""
                         andRequestUrl:url
                         andStatusCode:[NSString stringWithFormat:@"%ld_-",(long)httpStatusCode]
                              andUtime:utimeString
                           andPlayUUid:nil];
        }
        
    };
    __block NSString *customAssociatName = associatedName;
    if ([method isEqualToString:@"POST"]) {
        [afAppDotNetAPIClient POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (postImage) {
                if (!customAssociatName) {
                    customAssociatName = @"img";
                }
                NSString* imgName = [NSString stringWithFormat: @"%@.jpg",
                                     [NSString stringWithFormat: @"%ld", time (NULL)]];
                NSData *imgData = UIImageJPEGRepresentation(postImage, 1);
                [formData appendPartWithFileData:imgData name:customAssociatName fileName:imgName mimeType: @"image/jpeg"];
            }
        } success:^(NSURLSessionDataTask *operation, id JSON) {
            NSInteger httpStatusCode = getStatusCode(operation);
            NSString *errCode = [NSString fomatEnumCode:urlModule];
            if (![NSJSONSerialization isValidJSONObject:JSON]) {
                
                if (errorBlock) {
                    errorBlock(nil);
                }
                
                sendErrorStatisticBlock(errCode,httpStatusCode);
            }
            else{
                if (completionBlock) {
                    completionBlock(JSON);
                }
            }
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            if (errorBlock) {
                errorBlock(nil);
            }
            
            NSInteger httpStatusCode = getStatusCode(operation);
            NSString *errCode =[NSString fomatEnumCode:urlModule];
            sendErrorStatisticBlock(errCode,httpStatusCode);
            //                                    if ([error code]==NSURLErrorTimedOut) {
            //                                          //超时
            //                                         errCode = [NSString fomatEnumCode:LTDCFailedCodeMeiziRequestTimeout];
            //                                    }
            if ([error code]!= NSURLErrorCancelled)
            {
                sendErrorStatisticBlock(errCode,httpStatusCode);
            }
            
        }];
        
    }
    return;

}



+ (BOOL)isDataCached:(LTURLModule)urlModule andDynamicValues:(NSArray *)arrayDynamicValues {
    BOOL isCached = NO;
    
    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
                                                 andDynamicValues:arrayDynamicValues];
    
    if ([LTDataModelEngine isLocalDataExisted:url]) {
        isCached = YES;
    }
    
    return isCached;
}

+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                     isNeedCache:(BOOL)isNeedCache
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
               completionHandler:(LTDataCompletionBodyBlock)completionBlock
                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
                    emptyHandler:(LTDataEmptyBlock)emptyBlock
              tokenExpiredHander:(LTDataTokenExpiredBlock)tokenExpiredBlock
                    errorHandler:(LTDataErrorBlock)errorBlock
{
    [LTDataModelEngine refreshTaskWithUrlModule:urlModule
                               andDynamicValues:arrayDynamicValues
                                    isNeedCache:isNeedCache
                                  andHttpMethod:method
                                  andParameters:parameters
                              completionHandler:completionBlock
                                nochangeHandler:nochangeBlock
                                   emptyHandler:emptyBlock
                             tokenExpiredHander:tokenExpiredBlock
                                ipShieldHandler:^(NSString *country, NSString *message) {
                                    if (errorBlock) {
                                        errorBlock(nil);
                                    }
                                }
                                   errorHandler:errorBlock];
}


// 内部使用
+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                     isNeedCache:(BOOL)isNeedCache
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                             url:(NSString *)url
                       localBody:localBody
               completionHandler:(LTDataCompletionBodyBlock)completionBlock
                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
                    emptyHandler:(LTDataEmptyBlock)emptyBlock
              tokenExpiredHander:(LTDataTokenExpiredBlock)tokenExpiredBlock
                 ipShieldHandler:(LTDataIPShieldBlock)ipShieldBlock
                    errorHandler:(LTDataErrorBlock)errorBlock {
    if ([NetworkReachability connectedToNetwork]) {
        NSTimeInterval utimeStart = [[NSDate date]timeIntervalSince1970];
        [LTDataModelEngine refreshTaskWithUrlModule:urlModule
                                   andDynamicValues:arrayDynamicValues
                                      andHttpMethod:method
                                      andParameters:parameters
                                  completionHandler:^(NSDictionary *respondDict) {
#if 0
                                      NSString *respondString = [respondDict JSONRepresentation];
#else
                                      NSData* data = [NSJSONSerialization dataWithJSONObject: respondDict options: 0 error: nil];
                                      NSString* respondString = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
#endif
                                      
                                      LTDataModel *dataModel = nil;
                                      NSError *parseError = nil;
                                      
                                      @try {
                                          dataModel = [[LTDataModel alloc] initWithDictionary:respondDict error:&parseError];
                                      }
                                      @catch (NSException *exception) {
                                          
                                          NSString *errInfo = [NSString stringWithFormat:@"接口异常了, errorUserInfo:%@, errorDescription:%@, urlModule:%u, url:%@, respondDict:%@", parseError.userInfo, parseError.localizedDescription, urlModule, url, respondDict];
                                          [LTDataCenter writeToErrorLogFile:errInfo];
                                          
                                          if (errorBlock) {
                                              errorBlock(nil);
                                          }
                                          
                                          NSAssert(NO, errInfo);
                                          
                                          return;
                                      }
                                      @finally {

                                      }
                                      
                                      NSTimeInterval  utimeEnd = [[NSDate date]timeIntervalSince1970];
                                      CGFloat utime =utimeEnd-utimeStart;
                                      NSString *utimeString =(utime>=0)?[NSString stringWithFormat:@"%.2f",utime]:@"";
                                      
                                      if (    nil == dataModel
                                          ||  nil == dataModel.header
                                          ||  dataModel.header.status!=DataStatusNormal
                                          ||  utime>[SettingManager getDefaultTimeOut]) {
                                          NSString *errCode = [NSString fomatEnumCode:urlModule];
                                          NSString *statusCode =(dataModel.header.status>0)?[NSString stringWithFormat:@"200_%d",dataModel.header.status]:@"200_-";
                                          NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
                                                                                       andDynamicValues:arrayDynamicValues];
                                          [LTDataCenter addErrorData:errCode
                                                              andCid:@""
                                                              andPid:@""
                                                              adnVid:@""
                                                      andDownloadUrl:@""
                                                          andPlayUrl:@""
                                                           andPlayVt:VIDEO_CODE_UNKNOWN
                                                       andLivingCode:@""
                                                       andRequestUrl:url
                                                       andStatusCode:statusCode
                                                            andUtime:utimeString
                                                         andPlayUUid:nil
                                                      andisPlayError:YES];
                                          
                                          // 请求失败，写入错误日志
                                          if (nil == dataModel
                                              ||  nil == dataModel.header
                                              ||  dataModel.header.status != DataStatusNormal) {
                                              NSString *errlog =[NSString stringWithFormat:@"请求失败, urlModule:%d url:%@ errorDict:%@",urlModule,url,respondDict];
                                              [LTDataCenter writeToErrorLogFile:errlog];
                                          }
                                      }
                                      
                                      if (      nil == dataModel
                                          ||    nil == dataModel.header
                                          ||    nil == dataModel.body) {
                                          if (errorBlock) {
                                              errorBlock(nil);
                                          }
                                          
                                      }
                                      else{
                                          switch (dataModel.header.status) {
                                              case DataStatusNormal:
                                              {
                                                  if (isNeedCache
                                                      &&[LTDataModelEngine isLocalDataExisted:url]
                                                      &&[localBody isEqualToDictionary:dataModel.body]) {
                                                      //                                                      NSLog(@"取到的数据与缓存数据相同，不做变化");
                                                      return;
                                                  }
                                                  if (completionBlock) {
                                                      
                                                      if(LTURLModule_Video_VF == urlModule
                                                         || LTURLModule_Video_VF_And_Advertise == urlModule
                                                         )
                                                      {
                                                          if(dataModel.body && dataModel.header)
                                                          {
                                                              if(respondDict && [[respondDict allKeys]containsObject:@"header"])
                                                              {
                                                                  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataModel.body];
                                                                  [dic setObject:respondDict[@"header"] forKey:@"header"];
                                                                  dataModel.body = dic;
                                                              }
                                                          }
                                                      }
                                                      
                                                      BOOL isNeed = [LTDataModelEngine check:urlModule body:dataModel.body];
                                                      
                                                      if (!isNeed && isNeedCache) {
                                                          if ([LTDataModelEngine isLocalDataExisted:url]) {
                                                              // 如果有缓存直接return
                                                              
                                                              NSString *logInfo = [NSString stringWithFormat:@"数据展示缓存问题, 之前有缓存, url:%@, 当前：!isNeed && isNeedCache", url];
                                                              [LTDataCenter writeToErrorLogFile:logInfo];
                                                              return;
                                                          } else {
                                                              
                                                              [LTDataCenter writeToErrorLogFile:@"数据展示缓存问题, 当前无缓存: !isNeed && isNeedCache"];
                                                              
                                                              // 没有的话返回error
                                                              if (errorBlock) {
                                                                  errorBlock(nil);
                                                                  return;
                                                              }
                                                          }
                                                      }
                                                      
                                                      @try {
                                                          completionBlock(dataModel.body, dataModel.header.markid);
                                                          
                                                          //返回成功后，写入缓存
                                                          if (isNeedCache) {
                                                              if(!([LTDataModelEngine isLocalDataExisted:url] &&
                                                                   [respondDict isEqualToDictionary:[LTDataModelEngine getLocalData:url]])){
                                                                  [LTDataModelEngine writeToFile:respondDict andUrlPath:url];
                                                              }
                                                          }
                                                      } @catch (NSException *exception) {
                                                          
                                                          NSString *errInfo = [NSString stringWithFormat:@"接口回调异常了, errorUserInfo:%@, errorDescription:%@, urlModule:%u, url:%@, respondDict:%@", parseError.userInfo, parseError.localizedDescription, urlModule, url, respondDict];
                                                          [LTDataCenter writeToErrorLogFile:errInfo];
                                                          
                                                          if (errorBlock) {
                                                              errorBlock(nil);
                                                          }
                                                          
                                                          NSAssert(NO, errInfo);
                                                          
                                                          return;
                                                      } @finally {
                                                          
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
                                                  NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
                                                  [LTDataCenter writeToErrorLogFile:errlog];
                                              }
                                                  break;
                                              case DataStatusTokenExpired:
                                              {
                                                  if (tokenExpiredBlock) {
                                                      tokenExpiredBlock();
                                                  }
                                                  NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
                                                  [LTDataCenter writeToErrorLogFile:errlog];
                                              }
                                                  break;
                                              case DataStatusIPShield:
                                              {
                                                  NSDictionary *dictBody = dataModel.body;
                                                  NSString *country = [NSString safeString:dictBody[@"country"]];
                                                  NSString *message = [NSString safeString:dictBody[@"message"]];
                                                  if (ipShieldBlock) {
                                                      ipShieldBlock(country, message);
                                                  }
                                              }
                                                  break;
                                              case DataStatusAbnormal:
                                              default:
                                              {
                                                  if (errorBlock) {
                                                      errorBlock(nil);
                                                  }
                                                  NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",urlModule,url,respondString];
                                                  [LTDataCenter writeToErrorLogFile:errlog];
                                                  
                                              }
                                                  break;
                                          }
                                      }
                                      
                                  } errorHandler:^(NSError *error) {
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

+ (BOOL)check:(LTURLModule)urlModule body:(NSDictionary *)body
{
    /*
     App首页：除去焦点图、直播位、老的直播区块推广位、热词、搜索框、重磅推荐、数据为空区块后，区块还大于等于B且焦点图个数大于等于B，正常写入缓存
     频道首页和子页面由于是同一个接口并且子页面也可能出现多个区块的情况
     作如下处理: 除去直播位、热词、搜索框、电影付费入口、二级导航、数据为空区块后，区块还大于零，正常写入缓存
     */
    
    BOOL isNeedCache = NO;
    
    NSError *parseError = nil;
    switch (urlModule) {
        case LTURLModule_Recommend_Personalized:
        {
            // app首页
            @try {
                LTRecommendModel *recommendModel = [[LTRecommendModel alloc] initWithDictionary:body error:&parseError];
                isNeedCache = [recommendModel isShouldCache];
                
                if (parseError != nil) {
                    NSString *errorCodeInfo = [NSString stringWithFormat:@"首页:LTRecommendModel parse exception:%@", parseError];
                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                }
            }
            @catch (NSException *exception) {
                NSString *errorCodeInfo = [NSString stringWithFormat:@"首页:LTRecommendModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
            }
            @finally {}
        }
            break;
        case LTURLModule_Channel_Index:
        {
            // 频道页
            @try {
                LTChannelIndexModel *channelIndexData = [[LTChannelIndexModel alloc] initWithDictionary:body error:nil];
                isNeedCache = [channelIndexData isShouldCache];

                if (parseError != nil) {
                    NSString *errorCodeInfo = [NSString stringWithFormat:@"频道页:LTChannelIndexModel parse exception:%@", parseError];
                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                }
            }
            @catch (NSException *exception) {
                NSString *errorCodeInfo = [NSString stringWithFormat:@"频道页:LTChannelIndexModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
            }
            @finally {}
        }
            break;
            
        case LTURLModule_Channel_NewList_5_9:
        {
            // 频道墙
            @try {
                LTNewChannelModel *channelModel = [[LTNewChannelModel alloc]initWithDictionary:body error:nil];
                isNeedCache = [channelModel isShouldCache];
                
                if (parseError != nil) {
                    NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel parse exception:%@", parseError];
                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                }
            }
            @catch (NSException *exception) {
                NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
            }
            @finally {}
        }
            break;
        case LTURLModule_Channel_NewList_6_5:
        {
            NSLog(@"body == %@",body);
            // 6.5 频道墙
            @try {
                LTChannelWallModel *channelModel = [[LTChannelWallModel alloc]initWithDictionary:body error:nil];
                isNeedCache = [channelModel isShouldCache];
                
                if (parseError != nil) {
                    NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel6.5 parse exception:%@", parseError];
                    [LTDataCenter writeToErrorLogFile:errorCodeInfo];
                }
            }
            @catch (NSException *exception) {
                NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙:LTNewChannelModel check parse exception, errorDes:%@, body:%@", parseError.localizedDescription, body];
                [LTDataCenter writeToErrorLogFile:errorCodeInfo];
            }
            @finally {}
        }
            break;
        default:
            isNeedCache = YES;
            break;
    }
    return isNeedCache;
}


+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                     isNeedCache:(BOOL)isNeedCache
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
               completionHandler:(LTDataCompletionBodyBlock)completionBlock
                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
                    emptyHandler:(LTDataEmptyBlock)emptyBlock
              tokenExpiredHander:(LTDataTokenExpiredBlock)tokenExpiredBlock
                 ipShieldHandler:(LTDataIPShieldBlock)ipShieldBlock
                    errorHandler:(LTDataErrorBlock)errorBlock
{
    NSString *url = [LTRequestURLManager formatRequestURLByModule:urlModule
                                                 andDynamicValues:arrayDynamicValues];
    
    //解决首页和频道首页因播放记录不同而导致获取缓存数据错误
    if (urlModule == LTURLModule_Recommend_Personalized) {
        //首页读取和存入缓存时移除所有拼接参数
        url = [LTRequestURLManager formatRequestURLByModule:urlModule
                                           andDynamicValues:nil];
    }else if (urlModule == LTURLModule_Channel_Index){
        //频道首页读取和存入缓存时移除播放记录参数
        if (arrayDynamicValues.count >= 4) {
            NSMutableArray *finalArray = [[NSMutableArray alloc] initWithObjects:[arrayDynamicValues firstObject], nil];
            url = [LTRequestURLManager formatRequestURLByModule:urlModule
                                               andDynamicValues:finalArray];
        }
    }

    __block NSDictionary *localBody=[NSDictionary dictionary];
    if (isNeedCache) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if([LTDataModelEngine isLocalDataExisted:url]){
                NSDictionary *dict= [LTDataModelEngine getLocalData:url];
                LTDataModel *localDataModel = [[LTDataModel alloc] initWithDictionary:dict error:nil];
                if ((localDataModel.header.status == DataStatusNormal) && completionBlock) {
                    localBody = [NSDictionary dictionaryWithDictionary:localDataModel.body];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 标记是否缓存返回
                        if (localDataModel.body && [localDataModel.body isKindOfClass:[NSDictionary class]]) {
                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:localDataModel.body];
                            [dic setValue:@(1) forKey:kIsCacheBack];
                            localDataModel.body = dic;
                        }
                        completionBlock(localDataModel.body, localDataModel.header.markid);
                        
                        [LTDataModelEngine refreshTaskWithUrlModule:urlModule
                                                   andDynamicValues:arrayDynamicValues
                                                        isNeedCache:isNeedCache
                                                      andHttpMethod:method
                                                      andParameters:parameters
                                                                url:url
                                                          localBody:localBody
                                                  completionHandler:completionBlock
                                                    nochangeHandler:nochangeBlock
                                                       emptyHandler:emptyBlock
                                                 tokenExpiredHander:tokenExpiredBlock
                                                    ipShieldHandler:ipShieldBlock
                                                       errorHandler:errorBlock];
                    });
                    
                    return;
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [LTDataModelEngine refreshTaskWithUrlModule:urlModule
                                           andDynamicValues:arrayDynamicValues
                                                isNeedCache:isNeedCache
                                              andHttpMethod:method
                                              andParameters:parameters
                                                        url:url
                                                  localBody:localBody
                                          completionHandler:completionBlock
                                            nochangeHandler:nochangeBlock
                                               emptyHandler:emptyBlock
                                         tokenExpiredHander:tokenExpiredBlock
                                            ipShieldHandler:ipShieldBlock
                                               errorHandler:errorBlock];
            });
        });
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [LTDataModelEngine refreshTaskWithUrlModule:urlModule
                                       andDynamicValues:arrayDynamicValues
                                            isNeedCache:isNeedCache
                                          andHttpMethod:method
                                          andParameters:parameters
                                                    url:url
                                              localBody:localBody
                                      completionHandler:completionBlock
                                        nochangeHandler:nochangeBlock
                                           emptyHandler:emptyBlock
                                     tokenExpiredHander:tokenExpiredBlock
                                        ipShieldHandler:ipShieldBlock
                                           errorHandler:errorBlock];
        });
    }
}


#pragma mark - local data

+ (BOOL) writeToFile:(NSDictionary *)responseData andUrlPath:(NSString *)urlPath{
    
  
    if ([NSString isBlankString:urlPath]) {
        return NO;
    }
    
    
    NSString *strUrl = [NSString stringWithFormat:@"%@",urlPath];
    strUrl = [strUrl subStringByRemoveMutableParams];
    
    NSString *urlDataDir = [FileManager appUrlDataCachePath];
    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W"
                                                      withString:@"_"];
    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
    BOOL bResult = [responseData writeToFile:fullPath
                                                     atomically:YES];
    if (bResult) {
//        NSLog(@"write success...");
    }
    
    return bResult;
}

+ (BOOL)isLocalDataExisted:(NSString *)urlString{
    
    NSString *strUrl = [urlString subStringByRemoveMutableParams];
    
    NSString *urlDataDir = [FileManager appUrlDataCachePath];
    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W"
                                                      withString:@"_"];
    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
        return YES;
    }
    
    return NO;
}

+ (void)removeLocalData:(NSString *)urlString {
    NSString *strUrl = [urlString subStringByRemoveMutableParams];
    
    NSString *urlDataDir = [FileManager appUrlDataCachePath];
    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W"
                                                      withString:@"_"];
    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
        [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
    }
}

+ (NSDictionary *)getLocalData:(NSString *)urlString{
    
    // use local url data
    NSString *strUrl = [urlString subStringByRemoveMutableParams];
    
    NSString *urlDataDir = [FileManager appUrlDataCachePath];
    NSString *path = [strUrl stringByReplacingOccurrencesOfRegex:@"\\W"
                                                      withString:@"_"];
    NSString *fullPath = [urlDataDir stringByAppendingPathComponent:path];
    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])	{
        NSDictionary *responseDict =[NSDictionary dictionaryWithContentsOfFile:fullPath];
        if (![NSObject empty:responseDict]) {
            
//            NSLog(@"use local data ok");
            return responseDict;
        }
        
    }
    
     
    return  nil;
    
}

+(NSDictionary *)getLocalDataBody:(NSString *)urlString{
    @autoreleasepool {
        LTDataModel *dataModel = [[LTDataModel alloc] initWithDictionary:[LTDataModelEngine getLocalData:urlString] error:nil];
        if (      nil == dataModel
            ||    nil == dataModel.header
            ||    nil == dataModel.body) {
            return nil;
        }
        
        if (dataModel.header.status == DataStatusNormal) {
            return dataModel.body;
        }
        return nil;
    }
}

#pragma mark - 广告拼接

+(void)cancelPlayUrlMergeOperation
{
    /*
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    */
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedPlayUrlMergeClient];
    [afAppDotNetAPIClient cancelAllHTTPOperationsWithMethod:@"POST" path:nil];
}

+ (void)playUrlMergeWithAhl:(NSArray *)ahl
                      andVl:(NSString *)vl
                     andAts:(NSArray *)atl
          completionHandler:(LTDataCompletionBlock)completionBlock
               errorHandler:(LTDataErrorBlock)errorBlock
{
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedPlayUrlMergeClient];
    
    if (nil == afAppDotNetAPIClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    if ([NSString isBlankString:vl]) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    NSMutableArray *mutAhl = [NSMutableArray array];
    if (ahl && [ahl isKindOfClass:[NSArray class]]) {
        for (NSString *eleAhl in ahl) {
            [mutAhl addObject:[eleAhl stringByAppendingString:@"&tss=ios"]];
        }
    }
    
    NSMutableArray *mutAtl = [NSMutableArray array];
    if (atl && [atl isKindOfClass:[NSArray class]]) {
        for (NSString *eleAtl in atl) {
            [mutAtl addObject:[eleAtl stringByAppendingString:@"&tss=ios"]];
        }
    }
    
    NSDictionary *parameters = @{@"ahl" : [NSString safeString:[mutAhl componentsJoinedByString:@"|"]],
                                 @"vl"  : [NSString safeString:vl],
                                 @"atl" : [NSString safeString:[mutAtl componentsJoinedByString:@"|"]]
                                 };
    
    [afAppDotNetAPIClient POST:@""
                    parameters:parameters
                       success:^(NSURLSessionDataTask *operation, id responseObject) {
                           if (![NSJSONSerialization isValidJSONObject:responseObject]) {
                               if (errorBlock) {
                                   errorBlock(nil);
                               }
                           }
                           else{
                               if (completionBlock) {
                                   completionBlock(responseObject);
                               }
                           }
                       } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                           if (errorBlock) {
                               errorBlock(error);
                           }
                       }];
    
    return;
}

+ (void)playUrlMergeWithAhl:(NSArray *)ahl
                      andVl:(NSString *)vl
                     andAts:(NSArray *)atl
                     andAml:(NSArray *)aml
                     andAmp:(NSArray *)amp
                 cdeEnabled:(BOOL)enabled
          completionHandler:(LTDataCompletionBlock)completionBlock
               errorHandler:(LTDataErrorBlock)errorBlock
{
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedPlayUrlMergeClient];
    
    if (nil == afAppDotNetAPIClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    if ([NSString isBlankString:vl]) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    NSString *m3vArg = @"";
    NSString *m3vStr = [SettingManager getStringValueFromUserDefaults:kM3vValue];
    if([NSString isBlankString:m3vStr]){
        m3vStr = @"3";
    }
    m3vArg = [NSString stringWithFormat:@"&m3v=%@",m3vStr];
    
    NSMutableArray *mutAhl = [NSMutableArray array];
    if (ahl && [ahl isKindOfClass:[NSArray class]]) {
        for (NSString *eleAhl in ahl) {
            [mutAhl addObject:[eleAhl stringByAppendingString:@"&tss=ios"]];
        }
    }
    
    NSMutableArray *mutAtl = [NSMutableArray array];
    if (atl && [atl isKindOfClass:[NSArray class]]) {
        for (NSString *eleAtl in atl) {
            [mutAtl addObject:[eleAtl stringByAppendingString:@"&tss=ios"]];
        }
    }
    
    NSMutableDictionary* parameters = nil;
    if (aml == nil || amp == nil) {
        
        parameters = [NSMutableDictionary
                      dictionaryWithDictionary: @{
                                                @"ahl" : [NSString safeString:[mutAhl componentsJoinedByString:@"|"]],
                                                @"vl"  : [NSString safeString:vl],
                                                @"atl" : [NSString safeString:[mutAtl componentsJoinedByString:@"|"]],
                                                @"bks" :  @"2",
                                                @"once" : @"2"
                                                }];

    } else {
        
        NSMutableArray *mutAml = [NSMutableArray array];
        if (aml && [aml isKindOfClass:[NSArray class]]) {
            for (NSString *eleAml in aml) {
                [mutAml addObject:[eleAml stringByAppendingString:@"&tss=ios"]];
            }
        }
        
        NSMutableArray *mutAmp = [NSMutableArray array];
        if (amp && [amp isKindOfClass:[NSArray class]]) {
            for (NSString *eleAmp in amp) {
                [mutAmp addObject:eleAmp];
            }
        }

        parameters = [NSMutableDictionary
                      dictionaryWithDictionary: @{
                                                @"ahl" : [NSString safeString:[mutAhl componentsJoinedByString:@"|"]],
                                                @"vl"  : [NSString safeString:vl],
                                                @"atl" : [NSString safeString:[mutAtl componentsJoinedByString:@"|"]],
                                                @"aml" : [NSString safeString:[mutAml componentsJoinedByString:@"|"]],
                                                @"amp" : [NSString safeString:[mutAmp componentsJoinedByString:@"|"]],
                                                @"bks" :  @"2",
                                                @"once" : @"2"
                                                }];
    }
    
    [afAppDotNetAPIClient POST:@""
                    parameters:parameters
                       success:^(NSURLSessionDataTask *operation, id responseObject) {
                           if (![NSJSONSerialization isValidJSONObject:responseObject]) {
                               if (errorBlock) {
                                   errorBlock(nil);
                               }
                           }
                           else{
                               if (completionBlock) {
                                   completionBlock(responseObject);
                               }
                           }
                       } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                           if (errorBlock) {
                               errorBlock(error);
                           }
                           
                       }];
    
    return;
}

+ (void)playUrlMergeWithAhl:(NSArray *)ahl
                      andVl:(NSString *)vl
                     andAts:(NSArray *)atl
                 cdeEnabled:(BOOL)enabled
          completionHandler:(LTDataCompletionBlock)completionBlock
               errorHandler:(LTDataErrorBlock)errorBlock
{
    AFAppDotNetAPIClient *afAppDotNetAPIClient = [AFAppDotNetAPIClient sharedPlayUrlMergeClient];
    
    if (nil == afAppDotNetAPIClient) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    if ([NSString isBlankString:vl]) {
        if (errorBlock) {
            errorBlock(nil);
        }
        return;
    }
    
    NSMutableArray *mutAhl = [NSMutableArray array];
    if (ahl && [ahl isKindOfClass:[NSArray class]]) {
        for (NSString *eleAhl in ahl) {
            [mutAhl addObject:[eleAhl stringByAppendingString:@"&tss=ios"]];
        }
    }
    
    NSMutableArray *mutAtl = [NSMutableArray array];
    if (atl && [atl isKindOfClass:[NSArray class]]) {
        for (NSString *eleAtl in atl) {
            [mutAtl addObject:[eleAtl stringByAppendingString:@"&tss=ios"]];
        }
    }
    
    NSMutableDictionary* parameters = [NSMutableDictionary
                                       dictionaryWithDictionary: @{
                                                                   @"ahl" : [NSString safeString:[mutAhl componentsJoinedByString:@"|"]],
                                                                   @"vl"  : [NSString safeString:vl],
                                                                   @"atl" : [NSString safeString:[mutAtl componentsJoinedByString:@"|"]],
                                                                   @"bks" :  @"2",
                                                                   @"once" : @"2"
                                                                   }];
    
    [afAppDotNetAPIClient POST:@""
                    parameters:parameters
                       success:^(NSURLSessionDataTask *operation, id responseObject) {
                           if (![NSJSONSerialization isValidJSONObject:responseObject]) {
                               if (errorBlock) {
                                   errorBlock(nil);
                               }
                           }
                           else{
                               if (completionBlock) {
                                   completionBlock(responseObject);
                               }
                           }
                       } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                           if (errorBlock) {
                               errorBlock(error);
                           }

                       }];
    
    return;
}

@end
//#endif
