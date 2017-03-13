//
//  LTDataModelEngine.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>
#import <LetvMobileDataModel/LTRequestURLDefine.h>

typedef void (^LTDataCompletionBlock)(NSDictionary* responseDic);
typedef void (^LTDataCompletionBodyBlock)(NSDictionary* bodyDict, NSString *markid);
typedef void (^LTDataCenterCompletionBlock)();
typedef void (^LTDataNoChangeBlock)();
typedef void (^LTDataEmptyBlock)();
typedef void (^LTDataErrorBlock)(NSError* error);
typedef void (^LTDataTokenExpiredBlock)();
typedef void (^LTDataIPShieldBlock)(NSString *country, NSString *message);
typedef void (^LTPlayUrlMergeCompletionBlock)(NSString *murl);

@interface LTDataModelEngine : NSObject

+ (void)sendStatistics:(LTDataCenterStatisticsType)sType
           withUrlPath:(NSString *)path
     completionHandler:(LTDataCenterCompletionBlock)completionBlock
          errorHandler:(LTDataErrorBlock)errorBlock;

+ (void)requestWithUrl:(NSString *)url
     completionHandler:(LTDataCompletionBlock)completionBlock
          errorHandler:(LTDataErrorBlock)errorBlock;

+ (void)requestXMLWithUrl:(NSString *)url
                urlModule:(LTURLModule)urlModule
        completionHandler:(void (^)(NSXMLParser *responseXMLParser))completionBlock
             errorHandler:(LTDataErrorBlock)errorBlock;

+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
               completionHandler:(LTDataCompletionBodyBlock)completionBlock
                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
                    emptyHandler:(LTDataEmptyBlock)emptyBlock
                    errorHandler:(LTDataErrorBlock)errorBlock;

+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                andUrlHeadValues:(NSArray *)arrayHeadValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock;

//cfxiao 增加可以设置包头信息的请求
+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                andUrlHeadValues:(NSArray *)arrayHeadValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                 andHeaderFields:(NSDictionary *)headerFields
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock;


+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock;

//by handongyang param associatedName :defined by server defalut is img
+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                       postImage:(UIImage *)postImage
                  associatedName:(NSString *)associatedName
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock;

//增加可以设置超时时间的请求
+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                         outTime:(float)time
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock;

+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
                 andHeaderFields:(NSDictionary *)headerFields
                         outTime:(float)time
               completionHandler:(LTDataCompletionBlock)completionBlock
                    errorHandler:(LTDataErrorBlock)errorBlock;

+ (void)refreshTaskWithUrlModule:(LTURLModule)urlModule
                andDynamicValues:(NSArray *)arrayDynamicValues
                     isNeedCache:(BOOL)isNeedCache
                   andHttpMethod:(NSString *)method
                   andParameters:(NSDictionary *)parameters
               completionHandler:(LTDataCompletionBodyBlock)completionBlock
                 nochangeHandler:(LTDataNoChangeBlock)nochangeBlock
                    emptyHandler:(LTDataEmptyBlock)emptyBlock
              tokenExpiredHander:(LTDataTokenExpiredBlock)tokenExpiredBlock
                    errorHandler:(LTDataErrorBlock)errorBlock;

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
                    errorHandler:(LTDataErrorBlock)errorBlock;

+(void)cancelAllHttpOperationWithUrlModule:(LTURLModule)urlModule  andDynamicValues:(NSArray *)arrayDynamicValues;

+(void)cancelAllHttpOperationWithUrlModule:(LTURLModule)urlModule;

+ (BOOL) writeToFile:(NSDictionary *)responseData andUrlPath:(NSString *)urlPath;
+ (BOOL)isLocalDataExisted:(NSString *)urlString;
+ (NSDictionary *)getLocalData:(NSString *)urlString;
+ (NSDictionary *)getLocalDataBody:(NSString *)urlString;
+ (void)removeLocalData:(NSString *)urlString;

+ (BOOL)isDataCached:(LTURLModule)urlModule andDynamicValues:(NSArray *)arrayDynamicValues;

+(void)cancelPlayUrlMergeOperation;
+ (void)playUrlMergeWithAhl:(NSArray *)ahl
                      andVl:(NSString *)vl
                     andAts:(NSArray *)atl
          completionHandler:(LTDataCompletionBlock)completionBlock
               errorHandler:(LTDataErrorBlock)errorBlock;

+ (void)playUrlMergeWithAhl:(NSArray *)ahl
                      andVl:(NSString *)vl
                     andAts:(NSArray *)atl
                 cdeEnabled:(BOOL)enabled
          completionHandler:(LTDataCompletionBlock)completionBlock
               errorHandler:(LTDataErrorBlock)errorBlock;

+ (void)playUrlMergeWithAhl:(NSArray *)ahl
                      andVl:(NSString *)vl
                     andAts:(NSArray *)atl
                     andAml:(NSArray *)aml
                     andAmp:(NSArray *)amp
                 cdeEnabled:(BOOL)enabled
          completionHandler:(LTDataCompletionBlock)completionBlock
               errorHandler:(LTDataErrorBlock)errorBlock;

@end
