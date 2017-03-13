// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//#import "SettingManager.h"
#import "AFAppDotNetAPIClient.h"
#import "LTDataCenterCommDef.h"
#import "LTDataCenterEnumDef.h"

//#import "AFJSONRequestOperation.h"
#import "LTRequestURLManager.h"
#import "NSURLSessionTask+Extension.h"
#import "AFURLSessionTaskOperation.h"

//#ifdef LT_IPAD_CLIENT
//
//
//static NSString* const kAFAppDotNetAPIBaseURLString = @"https://alpha-api.app.net/";
//
//@implementation AFAppDotNetAPIClient
//
//+ (AFAppDotNetAPIClient*) sharedDataCenterClient
//{
//    static AFAppDotNetAPIClient* _sharedClient = nil;
//    static dispatch_once_t onceToken;
//
//    dispatch_once (&onceToken, ^{
//        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_HEAD]];
//    });
//    return _sharedClient;
//}
//
//+ (AFAppDotNetAPIClient*) sharedDataCenterKVClient
//{
//    static AFAppDotNetAPIClient* _sharedClient = nil;
//    static dispatch_once_t onceToken;
//
//    dispatch_once (&onceToken, ^{
//        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_KV_HEAD]];
//    });
//    return _sharedClient;
//}
//
//#ifdef DEVELOP_MODE_FOR_STATISTICS
//+ (AFAppDotNetAPIClient*) sharedDataCenterKVClientForAd
//{
//    static AFAppDotNetAPIClient* _sharedClient = nil;
//    static dispatch_once_t onceToken;
//
//    dispatch_once (&onceToken, ^{
//        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_KV_HEAD_AD]];
//    });
//    return _sharedClient;
//}
//#endif
//
//+ (AFAppDotNetAPIClient*) sharedDataCenterClientTest
//{
//    static AFAppDotNetAPIClient* _sharedClient = nil;
//    static dispatch_once_t onceToken;
//
//    dispatch_once (&onceToken, ^{
//        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_NEW_TEST_HEAD]];
//    });
//    return _sharedClient;
//}
//
//+ (AFAppDotNetAPIClient*) sharedDataCenterKVClientTest
//{
//    static AFAppDotNetAPIClient* _sharedClient = nil;
//    static dispatch_once_t onceToken;
//
//    dispatch_once (&onceToken, ^{
//        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_NEW_TEST_KV_HEAD]];
//    });
//    return _sharedClient;
//}
//
//+ (AFAppDotNetAPIClient*) sharedPlayUrlMergeClient
//{
//    static AFAppDotNetAPIClient* _sharedClient = nil;
//    static dispatch_once_t onceToken;
//
//    dispatch_once (&onceToken, ^{
//        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_AD_PINJIE_HEAD]];
//    });
//    return _sharedClient;
//}
//
//+ (AFAppDotNetAPIClient*) sharedClientWithUrlModule: (LTURLModule) urlModule
//{
//    AFAppDotNetAPIClient* afAppDotNetAPIClient = nil;
//    LTRequestURLType urlType = [LTRequestURLManager getRequestURLTypeByModule: urlModule];
//    LTRequestURLDomainType urlDomainType = [LTRequestURLManager getRequestURLDomainTypeByModule: urlModule];
//
//    static dispatch_once_t onceToken;
//
//    static AFAppDotNetAPIClient* s_sharedTestClinet = nil;
//
//    static AFAppDotNetAPIClient* s_sharedDynamicClientNormal = nil;
//    static AFAppDotNetAPIClient* s_sharedDynamicClientSearch = nil;
//    static AFAppDotNetAPIClient* s_sharedDynamicClientMeizi = nil;
//    static AFAppDotNetAPIClient* s_sharedDynamicClientPay = nil;
//    static AFAppDotNetAPIClient* s_sharedDynamicClientUser = nil;
//    static AFAppDotNetAPIClient* s_sharedDynamicClientRecommend = nil;
//    static AFAppDotNetAPIClient* s_sharedDynamicClientLive = nil;
//    static AFAppDotNetAPIClient* s_sharedDynamicClieentLead = nil;
//
//    static AFAppDotNetAPIClient* s_sharedStaticClientNormal = nil;
//    static AFAppDotNetAPIClient* s_sharedStaticClientSearch = nil;
//    static AFAppDotNetAPIClient* s_sharedStaticClientMeizi = nil;
//    static AFAppDotNetAPIClient* s_sharedStaticClientPay = nil;
//    static AFAppDotNetAPIClient* s_sharedStaticClientUser = nil;
//    static AFAppDotNetAPIClient* s_sharedStaticClientRecommend = nil;
//    static AFAppDotNetAPIClient* s_sharedStaticClientLive = nil;
//    static AFAppDotNetAPIClient* s_sharedStaticClieentLead = nil;
//
//
//    static AFAppDotNetAPIClient* s_sharedClientLiveNew = nil;
//
//    static AFAppDotNetAPIClient* s_sharedClientPlayCombine = nil;
//    static AFAppDotNetAPIClient* s_sharedClientPlayCombineTest = nil;
//
//    dispatch_once (&onceToken, ^{
//        s_sharedTestClinet = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_TEST_HEAD]];
//        
//#if DEBUG
//        // 如果是DEBUG模式，并且用户是香港，则使用香港的测试环境
//        if ([SettingManager isHK]) {
//            s_sharedTestClinet = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_HK_TEST_HEAD]];
//        }
//#endif
//
//        s_sharedDynamicClientNormal = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD]];
//        s_sharedDynamicClientSearch = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_SEARCH]];
//        s_sharedDynamicClientMeizi = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_MEIZI]];
//        s_sharedDynamicClientPay = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_PAY]];
//        s_sharedDynamicClientUser = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_USER]];
//        s_sharedDynamicClientRecommend = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_RECOMMEND]];
//        s_sharedDynamicClientLive = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_LIVE]];
//        s_sharedDynamicClieentLead = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_LEAD]];
//
//        s_sharedStaticClientNormal = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD]];
//        s_sharedStaticClientSearch = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_SEARCH]];
//        s_sharedStaticClientMeizi = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_MEIZI]];
//        s_sharedStaticClientPay = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_PAY]];
//        s_sharedStaticClientUser = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_USER]];
//        s_sharedStaticClientRecommend = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_RECOMMEND]];
//        s_sharedStaticClientLive = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_LIVE]];
//        s_sharedStaticClieentLead = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_LEAD]];
//
//        s_sharedClientLiveNew = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_LIVE_NEW_HEAD]];
//
//        s_sharedClientPlayCombine = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_PLAY_COMBINE_HEAD]];
//        s_sharedClientPlayCombineTest = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_PLAY_COMBINE_HEAD_TEST]];
//        
//#if DEBUG
//        if ([SettingManager isHK]) {
//            s_sharedClientPlayCombineTest = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_PLAY_COMBINE_HEAD_HK_TEST]];
//        }
//#endif
//    });
//
//    BOOL bSettingTest = [SettingManager isTestApi];
//
//    BOOL bForced2Test = ((LTURLModule_IAP_Receipt_Test == urlModule)
//                         || (LTURLModule_IAP_OrderID_Test == urlModule));
//    
//    BOOL bForced2Product = (LTURLModule_ApiStatus == urlModule);
//    
////#ifdef DEBUG
////    bForced2Product = NO;
////#endif
//
//    BOOL bUseTestAPI =((bSettingTest && !bForced2Product)
//                        || bForced2Test
//                        );
//
//    if (bUseTestAPI) {
//        afAppDotNetAPIClient = s_sharedTestClinet;
//        if (LTRequestURL_LiveNew == urlType) {
//            afAppDotNetAPIClient = s_sharedClientLiveNew;
//        } else if (LTRequestURL_PlayCombine == urlType) {
//            afAppDotNetAPIClient = s_sharedClientPlayCombineTest;
//        }
//    } else {
//        switch (urlType) {
//        case LTRequestURL_Static:
//        {
//            switch (urlDomainType) {
//            case LTRequestURLDomainTypeSearch:
//                afAppDotNetAPIClient = s_sharedStaticClientSearch;
//                break;
//            case LTRequestURLDomainTypeMeizi:
//                afAppDotNetAPIClient = s_sharedStaticClientMeizi;
//                break;
//            case LTRequestURLDomainTypePay:
//                afAppDotNetAPIClient = s_sharedStaticClientPay;
//                break;
//            case LTRequestURLDomainTypeUser:
//                afAppDotNetAPIClient = s_sharedStaticClientUser;
//                break;
//            case LTRequestURLDomainTypeRecommend:
//                afAppDotNetAPIClient = s_sharedStaticClientRecommend;
//                break;
//            case LTRequestURLDomainTypeLive:
//                afAppDotNetAPIClient = s_sharedStaticClientLive;
//                break;
//            case LTRequestURLDomainTypeLead:
//                afAppDotNetAPIClient = s_sharedStaticClieentLead;
//                break;
//            case LTRequestURLDomainTypeNormal:
//            default:
//                afAppDotNetAPIClient = s_sharedStaticClientNormal;
//                break;
//            }
//        }
//        break;
//        case LTRequestURL_Dynamic:
//        {
//            switch (urlDomainType) {
//            case LTRequestURLDomainTypeSearch:
//                afAppDotNetAPIClient = s_sharedDynamicClientSearch;
//                break;
//            case LTRequestURLDomainTypeMeizi:
//                afAppDotNetAPIClient = s_sharedDynamicClientMeizi;
//                break;
//            case LTRequestURLDomainTypePay:
//                afAppDotNetAPIClient = s_sharedDynamicClientPay;
//                break;
//            case LTRequestURLDomainTypeUser:
//                afAppDotNetAPIClient = s_sharedDynamicClientUser;
//                break;
//            case LTRequestURLDomainTypeRecommend:
//                afAppDotNetAPIClient = s_sharedDynamicClientRecommend;
//                break;
//            case LTRequestURLDomainTypeLive:
//                afAppDotNetAPIClient = s_sharedDynamicClientLive;
//                break;
//            case LTRequestURLDomainTypeLead:
//                afAppDotNetAPIClient = s_sharedDynamicClieentLead;
//                break;
//            case LTRequestURLDomainTypeNormal:
//            default:
//                afAppDotNetAPIClient = s_sharedDynamicClientNormal;
//                break;
//            }
//        }
//        break;
//        case LTRequestURL_LiveNew:
//        {
//            afAppDotNetAPIClient = s_sharedClientLiveNew;
//        }
//        break;
//
//        case LTRequestURL_PlayCombine:
//        {
//            afAppDotNetAPIClient = s_sharedClientPlayCombine;
//        }
//        break;
//        default:
//            break;
//        }
//    }
//
//    return afAppDotNetAPIClient;
//}
//
//+ (AFAppDotNetAPIClient*) sharedClientWithUrl: (NSString*) url
//{
//    static AFAppDotNetAPIClient* _sharedClient = nil;
//
//    /*
//       static dispatch_once_t onceToken;
//       dispatch_once(&onceToken, ^{
//     */
//    _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: url]];
//    /*});
//     */
//    return _sharedClient;
//}
//
//- (id) initWithBaseURL: (NSURL*) url
//{
//    self = [super initWithBaseURL: url];
//    if (!self) {
//        return nil;
//    }
//
//    [self.requestSerializer setValue: @"application/json" forHTTPHeaderField: @"Accept"];
//    self.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.responseSerializer.acceptableContentTypes = [NSSet setWithArray: @[
//                                                          @"application/json",
//                                                          @"plain/text",
//                                                          @"text/html",
//                                                          @"image/gif",
//                                                      ]];
//
//    return self;
//}
//
//- (AFHTTPRequestOperation*) getPath: (NSString*) path
//                         parameters: (NSDictionary*) parameters
//                       headerFields: (NSDictionary*) headerFields
//                            timeOut: (float) time
//                            success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                            failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
//{
//    NSMutableURLRequest* request = [self.requestSerializer
//                                    requestWithMethod: @"GET"
//                                            URLString: [[NSURL URLWithString: [self getEncodedPath: path] relativeToURL: self.baseURL] absoluteString]
//                                           parameters: parameters];
//
//    if (time > 0) {
//        request.timeoutInterval = time;
//    }
//    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    for (NSString* key in headerFields) {
//        [request setValue: headerFields[key] forHTTPHeaderField: key];
//    }
//    AFHTTPRequestOperation* operation =
//        [self HTTPRequestOperationWithRequest: request
//                                      success: ^(AFHTTPRequestOperation* operation, id responseObject) {
//        success (operation, responseObject);
//    } failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
//        failure (operation, error);
//    }];
//    [self.operationQueue addOperation: operation];
//
//    return operation;
//}
//
//- (AFHTTPRequestOperation*) postPath: (NSString*) path
//                          parameters: (NSDictionary*) parameters
//                        headerFields: (NSDictionary*) headerFields
//                             timeOut: (float) time
//                             success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                             failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
//{
//    NSMutableURLRequest* request = [self.requestSerializer
//                                    requestWithMethod: @"POST"
//                                            URLString: [[NSURL URLWithString: [self getEncodedPath: path] relativeToURL: self.baseURL] absoluteString]
//                                           parameters: parameters];
//
//    if (time > 0) {
//        request.timeoutInterval = time;
//    }
//    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    for (NSString* key in headerFields) {
//        [request setValue: headerFields[key] forHTTPHeaderField: key];
//    }
//    AFHTTPRequestOperation* operation =
//        [self HTTPRequestOperationWithRequest: request
//                                      success: ^(AFHTTPRequestOperation* operation, id responseObject) {
//        success (operation, responseObject);
//    } failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
//        failure (operation, error);
//    }];
//    [self.operationQueue addOperation: operation];
//
//    return operation;
//}
//
//- (AFHTTPRequestOperation*) getPath: (NSString*) path
//                         parameters: (NSDictionary*) parameters
//                       headerFields: (NSDictionary*) headerFields
//                                tag: (NSInteger) tag
//                            success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                            failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
//{
//    
//    AFHTTPRequestOperation* operation = [self getPath: path
//                                           parameters: parameters
//                                         headerFields: headerFields
//                                              timeOut: -1
//                                              success: success
//                                              failure: failure];
//
//    operation.requestTag = tag;
//    return operation;
//}
//
//- (AFHTTPRequestOperation*) postPath: (NSString*) path
//                          parameters: (NSDictionary*) parameters
//                        headerFields: (NSDictionary*) headerFields
//                                 tag: (NSInteger) tag
//                             success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                             failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
//{
//    AFHTTPRequestOperation* operation = [self postPath: path
//                                            parameters: parameters
//                                          headerFields: headerFields
//                                               timeOut: -1
//                                               success: success
//                                               failure: failure];
//
//    operation.requestTag = tag;
//
//    return operation;
//}
//
//- (void) uploadFileFromFeedbackWithUrlPath: (NSString*) urlPath
//                              withFilePath: (NSString*) filePath
//                       withFeedBackContent: (NSString*) feedback
//                           withImagesArray: (NSArray*) imagesArray
//                                   success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                                   failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
//{
//    [self POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        for (int i = 0; i < [imagesArray count]; i++) {
//            NSData* data = [imagesArray objectAtIndex: i];
//            NSString* fileName = @"pic";
//            if (i > 0) {
//                fileName = [fileName stringByAppendingString: [NSString stringWithFormat: @"%d", i]];
//            }
//            NSString* uploadFileName = [fileName stringByAppendingString: @".jpg"];
//            [formData appendPartWithFileData: data name: fileName fileName: uploadFileName mimeType: @"image/jpeg"];
//        }
//        [formData appendPartWithFormData: [feedback dataUsingEncoding: NSUTF8StringEncoding] name: @"feedback"];
//        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath] name: @"file" error: nil];
//    } success:success failure:failure];
//
//    return;
//}
//
//- (void) uploadFileFromFeedbackWithUrlPath: (NSString*) urlPath
//                              withFilePath: (NSString*) filePath
//                                parameters: (id)parameters
//                       withFeedBackContent: (NSString*) feedback
//                           withImagesArray: (NSArray*) imagesArray
//                                   success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                                   failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
//{
//    [self POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        for (int i = 0; i < [imagesArray count]; i++) {
//            NSData* data = [imagesArray objectAtIndex: i];
//            NSString* fileName = @"pic";
//            if (i > 0) {
//                fileName = [fileName stringByAppendingString: [NSString stringWithFormat: @"%d", i]];
//            }
//            NSString* uploadFileName = [fileName stringByAppendingString: @".jpg"];
//            [formData appendPartWithFileData: data name: fileName fileName: uploadFileName mimeType: @"image/jpeg"];
//        }
//        [formData appendPartWithFormData: [feedback dataUsingEncoding: NSUTF8StringEncoding] name: @"feedback"];
//        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath] name: @"file" error: nil];
//    } success:success failure:failure];
//    
//    return;
//}
//
//- (void)uploadFileWithUrlPath:(NSString *)urlPath withContent:(NSString *)textContent withImage:(UIImage *)image success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
//    [self POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        NSString* imgName = [NSString stringWithFormat: @"%@.jpg",
//                             [NSString stringWithFormat: @"%ld", time (NULL)]];
//        NSData *imgData = UIImageJPEGRepresentation(image, 1);
//        [formData appendPartWithFileData:imgData name: @"img" fileName: imgName mimeType: @"image/jpeg"];
//        [formData appendPartWithFormData: [textContent dataUsingEncoding: NSUTF8StringEncoding] name: @"title"];
//    } success:success failure:failure];
//    return;
//    
//}
//#pragma mark -
//- (void) uploadFileWithUrlPath: (NSString*) urlPath
//                  withFilePath: (NSString*) filePath
//           withFeedBackContent: (NSString*) feedback
//                       success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                       failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
//{
//    [self POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFormData: [feedback dataUsingEncoding: NSUTF8StringEncoding] name: @"feedback"];
//        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath] name: @"file" error: nil];
//    } success:success failure:failure];
//
//    return;
//}
//
//- (void) uploadFileWithUrlPath: (NSString*) urlPath
//                  withFilePath: (NSString*) filePath
//                    parameters: (id)parameters
//           withFeedBackContent: (NSString*) feedback
//                       success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                       failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
//{
//    [self POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFormData: [feedback dataUsingEncoding: NSUTF8StringEncoding] name: @"feedback"];
//        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath] name: @"file" error: nil];
//    } success:success failure:failure];
//    
//    return;
//}
//
//- (void) cancelAllHTTPOperationsWithMethod: (NSString*) method
//                                      path: (NSString*) path
//{
//    NSURL* url = [NSURL URLWithString: [self getEncodedPath: path] relativeToURL: self.baseURL];
//    NSMutableURLRequest* request = [self.requestSerializer requestWithMethod: method
//                                                                   URLString: [url path]
//                                                                  parameters: nil];
//    NSString* pathToBeMatched = [[request URL] path];
//
//    for (NSOperation* operation in [self.operationQueue operations]) {
//        if (![operation isKindOfClass: [AFHTTPRequestOperation class]]) {
//            continue;
//        }
//
//        BOOL hasMatchingMethod = !method || [method isEqualToString: [[(AFHTTPRequestOperation*)operation request] HTTPMethod]];
//        BOOL hasMatchingPath = [[[[(AFHTTPRequestOperation*)operation request] URL] path] isEqual: pathToBeMatched];
//
//        if (hasMatchingMethod && hasMatchingPath) {
//            [operation cancel];
//        }
//    }
//
//    return;
//}
//
//- (void)cancelAllRequest {
//    for (NSOperation* operation in [self.operationQueue operations]) {
//        
//        if (![operation isKindOfClass: [AFHTTPRequestOperation class]]) {
//            continue;
//        }
//        
//        [operation cancel];
//    }
//}
//
//- (void) cancelAllHTTPOperationsByUrlModule: (LTURLModule) urlModule
//{
//    if (urlModule == LTURLModule_Unknown) {
//        return;
//    }
//
//    for (NSOperation* operation in [self.operationQueue operations]) {
//        if (![operation isKindOfClass: [AFHTTPRequestOperation class]]) {
//            continue;
//        }
//
//        AFHTTPRequestOperation* requestOperation = (AFHTTPRequestOperation*) operation;
//        if (requestOperation.requestTag == urlModule) {
//            [requestOperation cancel];
//        }
//    }
//
//    return;
//}
//
//- (void) setHttpHeader: (NSString*) header value: (NSString*) value
//{
//    [self.requestSerializer setValue: value forHTTPHeaderField: header];
//}
//
//- (void) upLoadImageDataWithUrl: (NSString*) urlPath
//                  withImageData: (NSData*) imageData
//                        success: (void (^)(AFHTTPRequestOperation*, id)) success
//                        failure: (void (^)(AFHTTPRequestOperation*, NSError*)) failure
//{
////    NSString* fullUrl = [NSString stringWithFormat: @"%@%@", self.baseURL, urlPath];
////    NSError* error = nil;
////    NSMutableURLRequest* fileUpRequest =
////        [self.requestSerializer multipartFormRequestWithMethod: @"POST"
////                                                     URLString: fullUrl
////                                                    parameters: nil
////                                     constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
////        NSString* imgName = [NSString stringWithFormat: @"%@.jpg", [NSString stringWithFormat: @"%ld", time (NULL)]];
////        [formData appendPartWithFileData: imageData name: @"img" fileName: imgName mimeType: @"image/jpeg"];
////    }
////                                                         error: &error
////        ];
////
////    if (error) {
////        NSLog (@"error:%@", error);
////    }
////
////    AFHTTPRequestOperation* operation = [self HTTPRequestOperationWithRequest: fileUpRequest
////                                                                      success: ^(AFHTTPRequestOperation* operation, id responseObject) {
////        if (success) {
////            success (operation, responseObject);
////        }
////    } failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
////        if (failure) {
////            failure (operation, error);
////        }
////    }];
////
////    [self.operationQueue addOperation: operation];
//    [self POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        NSString* imgName = [NSString stringWithFormat: @"%@.jpg", [NSString stringWithFormat: @"%ld", time (NULL)]];
//        [formData appendPartWithFileData: imageData name: @"img" fileName: imgName mimeType: @"image/jpeg"];
//    } success:success failure:failure];
//
//    return;
//}
//
//- (NSString*) getEncodedPath: (NSString*) path
//{
//    if (!path) {
//        path = @"";
//    }
//    if ([self.baseURL.absoluteString isEqualToString: LT_URL_DC_HEAD]
//        || [self.baseURL.absoluteString isEqualToString: LT_URL_DC_KV_HEAD]
//        || [self.baseURL.absoluteString isEqualToString: LT_URL_DC_NEW_TEST_HEAD]
//        || [self.baseURL.absoluteString isEqualToString: LT_URL_DC_NEW_TEST_KV_HEAD]) {
//        // 数据统计不用再编码
//    } else {
//        path = [path stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    }
//
//    return path;
//}
//
//@end
//#else



@interface AFAppDotNetAPIClient ()

@property (nonatomic, strong) NSMutableArray *taskStorage;

@end

static NSString* const kAFAppDotNetAPIBaseURLString = @"https://alpha-api.app.net/";

@implementation AFAppDotNetAPIClient

+ (AFAppDotNetAPIClient*) sharedDataCenterClient
{
    static AFAppDotNetAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;

    dispatch_once (&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_HEAD]];
    });
    return _sharedClient;
}

+ (AFAppDotNetAPIClient*) sharedDataCenterKVClient
{
    static AFAppDotNetAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;

    dispatch_once (&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_KV_HEAD]];
    });
    return _sharedClient;
}

#ifdef DEVELOP_MODE_FOR_STATISTICS
+ (AFAppDotNetAPIClient*) sharedDataCenterKVClientForAd
{
    static AFAppDotNetAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;

    dispatch_once (&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_KV_HEAD_AD]];
    });
    return _sharedClient;
}
#endif

+ (AFAppDotNetAPIClient*) sharedDataCenterClientTest
{
    static AFAppDotNetAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;

    dispatch_once (&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_NEW_TEST_HEAD]];
    });
    return _sharedClient;
}

+ (AFAppDotNetAPIClient*) sharedDataCenterKVClientTest
{
    static AFAppDotNetAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;

    dispatch_once (&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_URL_DC_NEW_TEST_KV_HEAD]];
    });
    return _sharedClient;
}

+ (AFAppDotNetAPIClient*) sharedPlayUrlMergeClient
{
    static AFAppDotNetAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;

    dispatch_once (&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_AD_PINJIE_HEAD]];
    });
    return _sharedClient;
}

+ (AFAppDotNetAPIClient*) sharedClientWithUrlModule: (LTURLModule) urlModule
{
    AFAppDotNetAPIClient* afAppDotNetAPIClient = nil;
    LTRequestURLType urlType = [LTRequestURLManager getRequestURLTypeByModule: urlModule];
    LTRequestURLDomainType urlDomainType = [LTRequestURLManager getRequestURLDomainTypeByModule: urlModule];

    static dispatch_once_t onceToken;

    static AFAppDotNetAPIClient* s_sharedTestClinet = nil;

    static AFAppDotNetAPIClient* s_sharedDynamicClientNormal = nil;
    static AFAppDotNetAPIClient* s_sharedDynamicClientSearch = nil;
    static AFAppDotNetAPIClient* s_sharedDynamicClientMeizi = nil;
    static AFAppDotNetAPIClient* s_sharedDynamicClientPay = nil;
    static AFAppDotNetAPIClient* s_sharedDynamicClientUser = nil;
    static AFAppDotNetAPIClient* s_sharedDynamicClientRecommend = nil;
    static AFAppDotNetAPIClient* s_sharedDynamicClientLive = nil;
    static AFAppDotNetAPIClient* s_sharedDynamicClieentLead = nil;

    static AFAppDotNetAPIClient* s_sharedStaticClientNormal = nil;
    static AFAppDotNetAPIClient* s_sharedStaticClientSearch = nil;
    static AFAppDotNetAPIClient* s_sharedStaticClientMeizi = nil;
    static AFAppDotNetAPIClient* s_sharedStaticClientPay = nil;
    static AFAppDotNetAPIClient* s_sharedStaticClientUser = nil;
    static AFAppDotNetAPIClient* s_sharedStaticClientRecommend = nil;
    static AFAppDotNetAPIClient* s_sharedStaticClientLive = nil;
    static AFAppDotNetAPIClient* s_sharedStaticClieentLead = nil;


    static AFAppDotNetAPIClient* s_sharedClientLiveNew = nil;

    static AFAppDotNetAPIClient* s_sharedClientPlayCombine = nil;
    static AFAppDotNetAPIClient* s_sharedClientPlayCombineTest = nil;
    static AFAppDotNetAPIClient* s_sharedClientLeBPay= nil;
    static AFAppDotNetAPIClient* s_sharedClientLeBPayTest = nil;

    dispatch_once (&onceToken, ^{
        s_sharedTestClinet = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_TEST_HEAD]];
        
#if DEBUG
        // 如果是DEBUG模式，并且用户是香港，则使用香港的测试环境
        if ([SettingManager isHK]) {
            s_sharedTestClinet = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_HK_TEST_HEAD]];
        }
#endif

        s_sharedDynamicClientNormal = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD]];
        s_sharedDynamicClientSearch = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_SEARCH]];
        s_sharedDynamicClientMeizi = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_MEIZI]];
        s_sharedDynamicClientPay = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_PAY]];
        s_sharedDynamicClientUser = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_USER]];
        s_sharedDynamicClientRecommend = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_RECOMMEND]];
        s_sharedDynamicClientLive = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_LIVE]];
        s_sharedDynamicClieentLead = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_DYNAMIC_HEAD_LEAD]];

        s_sharedStaticClientNormal = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD]];
        s_sharedStaticClientSearch = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_SEARCH]];
        s_sharedStaticClientMeizi = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_MEIZI]];
        s_sharedStaticClientPay = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_PAY]];
        s_sharedStaticClientUser = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_USER]];
        s_sharedStaticClientRecommend = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_RECOMMEND]];
        s_sharedStaticClientLive = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_LIVE]];
        s_sharedStaticClieentLead = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_STATIC_HEAD_LEAD]];

        s_sharedClientLiveNew = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_LIVE_NEW_HEAD]];

        s_sharedClientPlayCombine = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_PLAY_COMBINE_HEAD]];
        s_sharedClientPlayCombineTest = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_PLAY_COMBINE_HEAD_TEST]];
        s_sharedClientLeBPayTest = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_LB_TEST_HEAD]];
        s_sharedClientLeBPay = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_LB_HEAD]];

#if DEBUG
        if ([SettingManager isHK]) {
            s_sharedClientPlayCombineTest = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: LT_REQUEST_URL_PLAY_COMBINE_HEAD_HK_TEST]];
        }
#endif
    });

    BOOL bSettingTest = [SettingManager isTestApi];

    BOOL bForced2Test = ((LTURLModule_IAP_Receipt_Test == urlModule)
                         || (LTURLModule_IAP_OrderID_Test == urlModule));
    
    BOOL bForced2Product = (LTURLModule_ApiStatus == urlModule);
    
#ifdef DEBUG
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kTestAPIKey]) {
        BOOL isTestApi = [[NSUserDefaults standardUserDefaults] boolForKey:kTestAPIKey];
        
        if (isTestApi) {
            bForced2Product = NO;
        }
    }
#endif

    BOOL bUseTestAPI = ((bSettingTest && !bForced2Product)|| bForced2Test
                        
                        );

    if (bUseTestAPI) {
        afAppDotNetAPIClient = s_sharedTestClinet;
        if (LTRequestURL_LiveNew == urlType) {
            afAppDotNetAPIClient = s_sharedClientLiveNew;
        } else if (LTRequestURL_PlayCombine == urlType) {
            afAppDotNetAPIClient = s_sharedClientPlayCombineTest;
        } else if (LTRequestURL_LebPay == urlType) {
            afAppDotNetAPIClient = s_sharedClientLeBPayTest;
        }
    } else {
        switch (urlType) {
        case LTRequestURL_Static:
        {
            switch (urlDomainType) {
            case LTRequestURLDomainTypeSearch:
                afAppDotNetAPIClient = s_sharedStaticClientSearch;
                break;
            case LTRequestURLDomainTypeMeizi:
                afAppDotNetAPIClient = s_sharedStaticClientMeizi;
                break;
            case LTRequestURLDomainTypePay:
                afAppDotNetAPIClient = s_sharedStaticClientPay;
                break;
            case LTRequestURLDomainTypeUser:
                afAppDotNetAPIClient = s_sharedStaticClientUser;
                break;
            case LTRequestURLDomainTypeRecommend:
                afAppDotNetAPIClient = s_sharedStaticClientRecommend;
                break;
            case LTRequestURLDomainTypeLive:
                afAppDotNetAPIClient = s_sharedStaticClientLive;
                break;
            case LTRequestURLDomainTypeLead:
                afAppDotNetAPIClient = s_sharedStaticClieentLead;
                break;
            case LTRequestURLDomainTypeNormal:
            default:
                afAppDotNetAPIClient = s_sharedStaticClientNormal;
                break;
            }
        }
        break;
        case LTRequestURL_Dynamic:
        {
            switch (urlDomainType) {
            case LTRequestURLDomainTypeSearch:
                afAppDotNetAPIClient = s_sharedDynamicClientSearch;
                break;
            case LTRequestURLDomainTypeMeizi:
                afAppDotNetAPIClient = s_sharedDynamicClientMeizi;
                break;
            case LTRequestURLDomainTypePay:
                afAppDotNetAPIClient = s_sharedDynamicClientPay;
                break;
            case LTRequestURLDomainTypeUser:
                afAppDotNetAPIClient = s_sharedDynamicClientUser;
                break;
            case LTRequestURLDomainTypeRecommend:
                afAppDotNetAPIClient = s_sharedDynamicClientRecommend;
                break;
            case LTRequestURLDomainTypeLive:
                afAppDotNetAPIClient = s_sharedDynamicClientLive;
                break;
            case LTRequestURLDomainTypeLead:
                afAppDotNetAPIClient = s_sharedDynamicClieentLead;
                break;
            case LTRequestURLDomainTypeNormal:
            default:
                afAppDotNetAPIClient = s_sharedDynamicClientNormal;
                break;
            }
        }
        break;
        case LTRequestURL_LiveNew:
        {
            afAppDotNetAPIClient = s_sharedClientLiveNew;
        }
        break;
        case LTRequestURL_LebPay:
        {
            afAppDotNetAPIClient = s_sharedClientLeBPay;
        }
        break;
                
        case LTRequestURL_PlayCombine:
        {
            afAppDotNetAPIClient = s_sharedClientPlayCombine;
        }
        break;
        default:
            break;
        }
    }

    return afAppDotNetAPIClient;
}

+ (AFAppDotNetAPIClient*) sharedClientWithUrl: (NSString*) url
{
    static AFAppDotNetAPIClient* _sharedClient = nil;

    /*
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
     */
    _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL: [NSURL URLWithString: url]];
    /*});
     */
    return _sharedClient;
}

- (id) initWithBaseURL: (NSURL*) url
{
    self = [super initWithBaseURL: url];
    if (!self) {
        return nil;
    }

    [self.requestSerializer setValue: @"application/json" forHTTPHeaderField: @"Accept"];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithArray: @[
                                                          @"application/json",
                                                          @"plain/text",
                                                          @"text/html",
                                                          @"image/gif",
                                                      ]];

    return self;
}

- (NSURLSessionDataTask*) getPath: (NSString*) path
                         parameters: (NSDictionary*) parameters
                       headerFields: (NSDictionary*) headerFields
                            timeOut: (float) time
                            success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                            failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure
{
    NSMutableURLRequest* request = [self.requestSerializer
                                    requestWithMethod: @"GET"
                                            URLString: [[NSURL URLWithString: [self getEncodedPath: path] relativeToURL: self.baseURL] absoluteString]
                                           parameters: parameters
                                                error:nil];

    if (time > 0) {
        request.timeoutInterval = time;
    }
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    for (NSString* key in headerFields) {
        [request setValue: headerFields[key] forHTTPHeaderField: key];
    }
    __weak AFAppDotNetAPIClient *weakSelf = self;
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        [weakSelf.taskStorage removeObject:task];
        
        if (!error) {
            success(task, responseObject);
        }
        else {
            failure(task, error);
        }
    }];
    [task resume];
    [self.taskStorage addObject:task];
    return task;
}

- (NSURLSessionDataTask*) postPath: (NSString*) path
                          parameters: (NSDictionary*) parameters
                        headerFields: (NSDictionary*) headerFields
                             timeOut: (float) time
                             success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                             failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure
{
    NSMutableURLRequest* request = [self.requestSerializer
                                    requestWithMethod: @"POST"
                                            URLString: [[NSURL URLWithString: [self getEncodedPath: path] relativeToURL: self.baseURL] absoluteString]
                                           parameters: parameters
                                                error:nil];

    if (time > 0) {
        request.timeoutInterval = time;
    }
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    for (NSString* key in headerFields) {
        [request setValue: headerFields[key] forHTTPHeaderField: key];
    }
    __weak AFAppDotNetAPIClient *weakSelf = self;
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        [weakSelf.taskStorage removeObject:task];
        
        if (!error) {
            success(task, responseObject);
        }
        else {
            failure(task, error);
        }
    }];
    [task resume];
    [self.taskStorage addObject:task];
    return task;
}

- (NSURLSessionDataTask*) getPath: (NSString*) path
                         parameters: (NSDictionary*) parameters
                       headerFields: (NSDictionary*) headerFields
                                tag: (NSInteger) tag
                            success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                            failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure
{
    
    NSURLSessionDataTask* operation = [self getPath: path
                                           parameters: parameters
                                         headerFields: headerFields
                                              timeOut: -1
                                              success: success
                                              failure: failure];
    operation.taskDescription = [@(tag) stringValue];
//    operation.requestTag = tag;
    return operation;
}

- (NSURLSessionDataTask*) postPath: (NSString*) path
                          parameters: (NSDictionary*) parameters
                        headerFields: (NSDictionary*) headerFields
                                 tag: (NSInteger) tag
                             success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                             failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure
{
    NSURLSessionDataTask* operation = [self postPath: path
                                            parameters: parameters
                                          headerFields: headerFields
                                               timeOut: -1
                                               success: success
                                               failure: failure];
    operation.taskDescription = [@(tag) stringValue];
//    operation.requestTag = tag;
    [operation resume];
    return operation;
}

- (void) uploadFileFromFeedbackWithUrlPath: (NSString*) urlPath
                              withFilePath: (NSString*) filePath
                       withFeedBackContent: (NSString*) feedback
                           withImagesArray: (NSArray*) imagesArray
                                   success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                                   failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure
{
    [self POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < [imagesArray count]; i++) {
            NSData* data = [imagesArray objectAtIndex: i];
            NSString* fileName = @"pic";
            if (i > 0) {
                fileName = [fileName stringByAppendingString: [NSString stringWithFormat: @"%d", i]];
            }
            NSString* uploadFileName = [fileName stringByAppendingString: @".jpg"];
            [formData appendPartWithFileData: data name: fileName fileName: uploadFileName mimeType: @"image/jpeg"];
        }
        [formData appendPartWithFormData: [feedback dataUsingEncoding: NSUTF8StringEncoding] name: @"feedback"];
        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath] name: @"file" error: nil];
    } success:success failure:failure];

    return;
}

- (void) uploadFileFromFeedbackWithUrlPath: (NSString*) urlPath
                              withFilePath: (NSString*) filePath
                                parameters: (id)parameters
                       withFeedBackContent: (NSString*) feedback
                           withImagesArray: (NSArray*) imagesArray
                                   success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                                   failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure
{
    [self POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < [imagesArray count]; i++) {
            NSData* data = [imagesArray objectAtIndex: i];
            NSString* fileName = @"pic";
            if (i > 0) {
                fileName = [fileName stringByAppendingString: [NSString stringWithFormat: @"%d", i]];
            }
            NSString* uploadFileName = [fileName stringByAppendingString: @".jpg"];
            [formData appendPartWithFileData: data name: fileName fileName: uploadFileName mimeType: @"image/jpeg"];
        }
        [formData appendPartWithFormData: [feedback dataUsingEncoding: NSUTF8StringEncoding] name: @"feedback"];
        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath] name: @"file" error: nil];
    } success:success failure:failure];
    
    return;
}

- (void)uploadFileWithUrlPath:(NSString *)urlPath withContent:(NSString *)textContent withImage:(UIImage *)image success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    [self POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSString* imgName = [NSString stringWithFormat: @"%@.jpg",
                             [NSString stringWithFormat: @"%ld", time (NULL)]];
        NSData *imgData = UIImageJPEGRepresentation(image, 1);
        [formData appendPartWithFileData:imgData name: @"img" fileName: imgName mimeType: @"image/jpeg"];
        [formData appendPartWithFormData: [textContent dataUsingEncoding: NSUTF8StringEncoding] name: @"title"];
    } success:success failure:failure];
    return;
    
}
#pragma mark -
- (void) uploadFileWithUrlPath: (NSString*) urlPath
                  withFilePath: (NSString*) filePath
           withFeedBackContent: (NSString*) feedback
                       success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                       failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure
{
    [self POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData: [feedback dataUsingEncoding: NSUTF8StringEncoding] name: @"feedback"];
        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath] name: @"file" error: nil];
    } success:success failure:failure];

    return;
}

- (void) uploadFileWithUrlPath: (NSString*) urlPath
                  withFilePath: (NSString*) filePath
                    parameters: (id)parameters
           withFeedBackContent: (NSString*) feedback
                       success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                       failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure
{
    [self POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData: [feedback dataUsingEncoding: NSUTF8StringEncoding] name: @"feedback"];
        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath] name: @"file" error: nil];
    } success:success failure:failure];
    
    return;
}

- (void) cancelAllHTTPOperationsWithMethod: (NSString*) method
                                      path: (NSString*) path
{
    NSURL* url = [NSURL URLWithString: [self getEncodedPath: path] relativeToURL: self.baseURL];
    NSMutableURLRequest* request = [self.requestSerializer requestWithMethod: method
                                                                   URLString: [url path]
                                                                  parameters: nil
                                                                       error:nil];
    NSString* pathToBeMatched = [[request URL] path];

    for (NSURLSessionTask *task in self.taskStorage) {
        if (![task isKindOfClass:[NSURLSessionDataTask class]]) {
            continue;
        }
        
        BOOL hasMatchingMethod = !method || [method isEqualToString:
                                             task.currentRequest.HTTPMethod];
        
        BOOL hasMatchingPath = [task.currentRequest.URL.path isEqual: pathToBeMatched];
        
        if (hasMatchingMethod && hasMatchingPath) {
            [task cancel];
        }
        
    }

    return;
}

- (void)cancelAllRequest {
    for (NSURLSessionTask *task in self.taskStorage) {
        if (![task isKindOfClass:[NSURLSessionDataTask class]]) {
            continue;
        }
        
        [task cancel];
    }
}

- (void) cancelAllHTTPOperationsByUrlModule: (LTURLModule) urlModule
{
    if (urlModule == LTURLModule_Unknown) {
        return;
    }

    for (NSURLSessionDataTask *task in self.taskStorage) {
        if ([task.taskDescription integerValue] == urlModule) {
            [task cancel];
        }
    }
    
    return;
}

- (void) setHttpHeader: (NSString*) header value: (NSString*) value
{
    [self.requestSerializer setValue: value forHTTPHeaderField: header];
}

- (void) upLoadImageDataWithUrl: (NSString*) urlPath
                  withImageData: (NSData*) imageData
                        success: (void (^)(NSURLSessionDataTask*, id)) success
                        failure: (void (^)(NSURLSessionDataTask*, NSError*)) failure
{
//    NSString* fullUrl = [NSString stringWithFormat: @"%@%@", self.baseURL, urlPath];
//    NSError* error = nil;
//    NSMutableURLRequest* fileUpRequest =
//        [self.requestSerializer multipartFormRequestWithMethod: @"POST"
//                                                     URLString: fullUrl
//                                                    parameters: nil
//                                     constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
//        NSString* imgName = [NSString stringWithFormat: @"%@.jpg", [NSString stringWithFormat: @"%ld", time (NULL)]];
//        [formData appendPartWithFileData: imageData name: @"img" fileName: imgName mimeType: @"image/jpeg"];
//    }
//                                                         error: &error
//        ];
//
//    if (error) {
//        NSLog (@"error:%@", error);
//    }
//
//    AFHTTPRequestOperation* operation = [self HTTPRequestOperationWithRequest: fileUpRequest
//                                                                      success: ^(AFHTTPRequestOperation* operation, id responseObject) {
//        if (success) {
//            success (operation, responseObject);
//        }
//    } failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
//        if (failure) {
//            failure (operation, error);
//        }
//    }];
//
//    [self.operationQueue addOperation: operation];
    [self POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString* imgName = [NSString stringWithFormat: @"%@.jpg", [NSString stringWithFormat: @"%ld", time (NULL)]];
        [formData appendPartWithFileData: imageData name: @"img" fileName: imgName mimeType: @"image/jpeg"];
    } success:success failure:failure];

    return;
}

- (NSString*) getEncodedPath: (NSString*) path
{
    if (!path) {
        path = @"";
    }
    if ([self.baseURL.absoluteString isEqualToString: LT_URL_DC_HEAD]
        || [self.baseURL.absoluteString isEqualToString: LT_URL_DC_KV_HEAD]
        || [self.baseURL.absoluteString isEqualToString: LT_URL_DC_NEW_TEST_HEAD]
        || [self.baseURL.absoluteString isEqualToString: LT_URL_DC_NEW_TEST_KV_HEAD]) {
        // 数据统计不用再编码
    } else {
        path = [path stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    }

    return path;
}

- (NSMutableArray *)taskStorage {
    if (!_taskStorage) {
        _taskStorage = [NSMutableArray array];
    }
    return _taskStorage;
}

@end
//#endif
