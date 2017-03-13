//
//  LTDataModelEngineCurl.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>

#import <LetvMobileDataModel/LTRequestURLDefine.h>
#import <LetvMobileDataModel/LTDataModelEngine.h>

//@lyh 添加 NSDictionary* extraData 参数 TODO:网络接口上报参数传递
typedef void (^LTDataCompletionBlockCurlData)(NSData* response,NSDictionary* extraData);
typedef void (^LTDataCompletionBlockCurlPBData)(NSData* pbData,LTHeaderModelPBOC *header,NSDictionary* extraData);
typedef void (^LTDataCompletionBlockCurlDict)(NSDictionary* response);

typedef void (^LTDataErrorBlockCurl)(NSError* error);


@interface LTDataModelEngineCurl : NSObject

+ (void)refreshUrlModule:(LTURLModule)urlModule
        andDynamicValues:(NSArray *)arrayDynamicValues
        andUrlHeadValues:(NSArray *)arrayHeadValues
           andHttpMethod:(NSString *)method
           andTimeoutSec:(NSInteger)timeout
           andParameters:(NSData *)parameters
         andHeaderFields:(NSDictionary *)headerFields
   completionHandlerData:(LTDataCompletionBlockCurlData)completionBlock
            errorHandler:(LTDataErrorBlock)errorBlock;

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
            errorHandler:(LTDataErrorBlock)errorBlock;


+(void)cancelOperationWithUrlModule:(LTURLModule)urlModule;
+ (NSData *)getLocalDataBody:(NSString *)urlString;
@end
