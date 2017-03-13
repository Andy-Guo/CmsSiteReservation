//
//  LTRequestURLManager.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-4-18.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTRequestURLInfo.h>

@interface LTRequestURLManager : NSObject

+ (NSString *)formatRequestURLByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues;

+ (NSString *)formatRequestURLByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues
                      andUrlHeadValues:(NSArray *)arrayUrlHeadValues;

+ (LTRequestURLType)getRequestURLTypeByModule:(LTURLModule)urlModule;

+ (LTRequestURLDomainType)getRequestURLDomainTypeByModule:(LTURLModule)urlModule;

+ (NSString *)getRequestPathByModule:(LTURLModule)urlModule
                    andDynamicValues:(NSArray *)arrayDynamicValues;

+ (LTURLModule)getUrlModuleByUrl:(NSString *)urlString;

#ifdef LT_IPAD_CLIENT
+ (LTURLModule)getUrlModuleByUrl:(NSString *)urlString
                       fromIndex:(NSInteger)fromIndex
                         toIndex:(NSInteger)toIndex;
#endif

+ (NSString *)getLiveNewHeaderByModule:(LTURLModule)urlModule
                      andDynamicValues:(NSArray *)arrayDynamicValues;

+ (NSString *)getRequestPathByModule:(LTURLModule)urlModule
                    andDynamicValues:(NSArray *)arrayDynamicValues
                    andUrlHeadValues:(NSArray *)arrayUrlHeadValues;
//获取clientId
+ (NSString *)liveClientId;
@end
