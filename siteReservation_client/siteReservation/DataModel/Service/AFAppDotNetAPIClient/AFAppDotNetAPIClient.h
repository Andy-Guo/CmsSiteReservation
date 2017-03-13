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

//#import "LeTVOpenSource.h"
//#import "OpenSourceRename.h"
//#import "AFHTTPClient.h"
//#import <LetvMobileOpenSource/AFHTTPClient.h>
#import <LetvMobileOpenSource/AFHttpSessionManager.h>
//#import "AFHTTPRequestOperationManager.h"
#import <LetvMobileOpenSource/AFNetworking.h>
#import <LetvMobileDataModel/LTRequestURLDefine.h>
//#ifdef LT_IPAD_CLIENT
//@interface AFAppDotNetAPIClient : AFHTTPRequestOperationManager
//// ç§»å° AFAppDotNetAPIClient+LTURLModule
//+ (AFAppDotNetAPIClient *)sharedClientWithUrlModule:(LTURLModule)urlModule;
//+ (AFAppDotNetAPIClient *)sharedDataCenterClient;
//
//+ (AFAppDotNetAPIClient *)sharedDataCenterKVClient;
//
//#ifdef DEVELOP_MODE_FOR_STATISTICS
//+ (AFAppDotNetAPIClient *)sharedDataCenterKVClientForAd;
//#endif
//
//+ (AFAppDotNetAPIClient *)sharedDataCenterClientTest;
//
//+ (AFAppDotNetAPIClient *)sharedDataCenterKVClientTest;
//
//+ (AFAppDotNetAPIClient *)sharedClientWithUrl:(NSString *)url;
//
//+ (AFAppDotNetAPIClient *)sharedPlayUrlMergeClient;
//
//- (AFHTTPRequestOperation *)getPath:(NSString *)path
//                         parameters:(NSDictionary *)parameters
//                       headerFields:(NSDictionary *)headerFields
//                            timeOut:(float)time
//                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//- (AFHTTPRequestOperation *)postPath:(NSString *)path
//                          parameters:(NSDictionary *)parameters
//                        headerFields:(NSDictionary *)headerFields
//                             timeOut:(float)time
//                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//- (AFHTTPRequestOperation *)postPath:(NSString *)path
//                          parameters:(NSDictionary *)parameters
//                        headerFields:(NSDictionary *)headerFields
//                                 tag:(NSInteger)tag
//                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//- (AFHTTPRequestOperation *)getPath:(NSString *)path
//                         parameters:(NSDictionary *)parameters
//                       headerFields:(NSDictionary *)headerFields
//                                tag:(NSInteger)tag
//                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
///**
// *  äº§ååé¦çé¢åé¦æ¥å£,å¸¦ä¸ä¼ å¤ä¸ªå¾ç
// *
// *  @param urlPath     æ¥å£å°å
// *  @param feedback    åé¦å
// å®¹
// *  @param imagesArray å¾çæ°ç»(NSData)
// *  @param success     æååè°
// *  @param failure     å¤±è´¥åè°
// */
//- (void)uploadFileFromFeedbackWithUrlPath:(NSString *)urlPath
//                             withFilePath:(NSString *)filePath
//                      withFeedBackContent:(NSString *)feedback
//                          withImagesArray:(NSArray *)imagesArray
//                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//- (void) uploadFileWithUrlPath: (NSString*) urlPath
//                  withFilePath: (NSString*) filePath
//                    parameters: (id)parameters
//           withFeedBackContent: (NSString*) feedback
//                       success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                       failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure;
//
//-(void)uploadFileWithUrlPath:(NSString *)urlPath
//                withFilePath:(NSString *)filePath
//         withFeedBackContent:(NSString *)feedback
//                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//- (void)uploadFileWithUrlPath:(NSString *)urlPath
//                  withContent:(NSString *)textContent
//                    withImage:(UIImage *)image
//                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//- (void) uploadFileFromFeedbackWithUrlPath: (NSString*) urlPath
//                              withFilePath: (NSString*) filePath
//                                parameters: (id)parameters
//                       withFeedBackContent: (NSString*) feedback
//                           withImagesArray: (NSArray*) imagesArray
//                                   success: (void (^)(AFHTTPRequestOperation* operation, id responseObject)) success
//                                   failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure;
//
//- (void)cancelAllHTTPOperationsWithMethod:(NSString *)method
//                                     path:(NSString *)path;
//
//- (void)cancelAllRequest;
//
//- (void)cancelAllHTTPOperationsByUrlModule:(LTURLModule)urlModule;
//
//- (void)setHttpHeader:(NSString *)header value:(NSString *)value;
//
//- (void)upLoadImageDataWithUrl:(NSString *)urlPath
//                 withImageData:(NSData *)imageData
//                       success:(void (^)(AFHTTPRequestOperation *, id))success
//                       failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
//
//@end
//#else


@interface AFAppDotNetAPIClient : AFHTTPSessionManager
// 移到 AFAppDotNetAPIClient+LTURLModule
+ (AFAppDotNetAPIClient *)sharedClientWithUrlModule:(LTURLModule)urlModule;
+ (AFAppDotNetAPIClient *)sharedDataCenterClient;

+ (AFAppDotNetAPIClient *)sharedDataCenterKVClient;

#ifdef DEVELOP_MODE_FOR_STATISTICS
+ (AFAppDotNetAPIClient *)sharedDataCenterKVClientForAd;
#endif

+ (AFAppDotNetAPIClient *)sharedDataCenterClientTest;

+ (AFAppDotNetAPIClient *)sharedDataCenterKVClientTest;

+ (AFAppDotNetAPIClient *)sharedClientWithUrl:(NSString *)url;

+ (AFAppDotNetAPIClient *)sharedPlayUrlMergeClient;

- (NSURLSessionDataTask *)getPath:(NSString *)path
                         parameters:(NSDictionary *)parameters
                       headerFields:(NSDictionary *)headerFields
                            timeOut:(float)time
                            success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (NSURLSessionDataTask *)postPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                        headerFields:(NSDictionary *)headerFields
                             timeOut:(float)time
                             success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (NSURLSessionDataTask *)postPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                        headerFields:(NSDictionary *)headerFields
                                 tag:(NSInteger)tag
                             success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (NSURLSessionDataTask *)getPath:(NSString *)path
                         parameters:(NSDictionary *)parameters
                       headerFields:(NSDictionary *)headerFields
                                tag:(NSInteger)tag
                            success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 *  产品反馈界面反馈接口,带上传多个图片
 *
 *  @param urlPath     接口地址
 *  @param feedback    反馈内容
 *  @param imagesArray 图片数组(NSData)
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)uploadFileFromFeedbackWithUrlPath:(NSString *)urlPath
                             withFilePath:(NSString *)filePath
                      withFeedBackContent:(NSString *)feedback
                          withImagesArray:(NSArray *)imagesArray
                                  success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (void) uploadFileWithUrlPath: (NSString*) urlPath
                  withFilePath: (NSString*) filePath
                    parameters: (id)parameters
           withFeedBackContent: (NSString*) feedback
                       success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                       failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure;

-(void)uploadFileWithUrlPath:(NSString *)urlPath
                withFilePath:(NSString *)filePath
         withFeedBackContent:(NSString *)feedback
                     success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
- (void)uploadFileWithUrlPath:(NSString *)urlPath
                      withContent:(NSString *)textContent
                        withImage:(UIImage *)image
                          success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (void) uploadFileFromFeedbackWithUrlPath: (NSString*) urlPath
                              withFilePath: (NSString*) filePath
                                parameters: (id)parameters
                       withFeedBackContent: (NSString*) feedback
                           withImagesArray: (NSArray*) imagesArray
                                   success: (void (^)(NSURLSessionDataTask* operation, id responseObject)) success
                                   failure: (void (^)(NSURLSessionDataTask* operation, NSError* error)) failure;

- (void)cancelAllHTTPOperationsWithMethod:(NSString *)method
                                     path:(NSString *)path;

- (void)cancelAllRequest;

- (void)cancelAllHTTPOperationsByUrlModule:(LTURLModule)urlModule;

- (void)setHttpHeader:(NSString *)header value:(NSString *)value;

- (void)upLoadImageDataWithUrl:(NSString *)urlPath
                 withImageData:(NSData *)imageData
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end
//#endif
