//
//  AFAppDotNetAPIClient+Extension.m
//  LetvIphoneClient
//
//  Created by wangduan on 14-8-4.
//
//

//#ifdef LT_IPAD_CLIENT
//#import "AFAppDotNetAPIClient+Extension.h"
//#import <LeTVMobileFoundation/LTCDEModel.h>
//
//@implementation AFAppDotNetAPIClient (Extension)
//
//-(void)getWoUrl:(NSString *)urlString
//        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    [self GET:urlString
//   parameters:nil
//      success:success
//      failure:failure];
//}
//
//-(void)getLiveShoppingInfo:(NSString *)urlString success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    [self GET:urlString
//   parameters:nil
//      success:success
//      failure:failure];
//}
//
//
//
//-(void)getCDEContactNumberUrl:(NSString *)urlString
//                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    [self GET:urlString
//   parameters:nil
//      success:success
//      failure:failure];
//}
//
//+(void)getContactNum:(void(^)(NSString * code,NSString * numberString))successBlock
//{
//    NSString * supporturl = [LTCDEModel supportUrl];
//    
//    AFAppDotNetAPIClient * afAppAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
//    [afAppAPIClient getCDEContactNumberUrl:supporturl success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([NSJSONSerialization isValidJSONObject:responseObject]) {
//            if (![NSObject empty:responseObject] && [responseObject isKindOfClass:[NSDictionary class]]){
//                if ([[responseObject safeValueForKey:@"errorCode"] integerValue] == 0) {
//                    NSString * mServiceNumber = [responseObject safeValueForKey:@"serviceNumber"];
//                    if (![NSString isBlankString:mServiceNumber] && mServiceNumber.length > 6) {
//                        NSString * mNumStr = [mServiceNumber substringFromIndex:mServiceNumber.length - 6];
//                        if (successBlock) {
//                            successBlock([responseObject safeValueForKey:@"errorCode"],mNumStr);
//                        }
//                    }
//                }
//                else
//                {
//                    if (successBlock) {
//                        successBlock(nil,nil);
//                    }
//                }
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (successBlock) {
//            successBlock(nil,nil);
//        }
//    }];
//}
//@end
//#else



#import <LetvMobileFoundation/LTCDEModel.h>
#import <LetvMobileDataModel/AFAppDotNetAPIClient+Extension.h>


@implementation AFAppDotNetAPIClient (Extension)

-(void)getWoUrl:(NSString *)urlString
        success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    [self GET:urlString
   parameters:nil
      success:success
      failure:failure];
}

-(void)getLiveShoppingInfo:(NSString *)urlString success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    [self GET:urlString
   parameters:nil
      success:success
      failure:failure];
}



-(void)getCDEContactNumberUrl:(NSString *)urlString
                      success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    [self GET:urlString
   parameters:nil
      success:success
      failure:failure];
}

+(void)getContactNum:(void(^)(NSString * code,NSString * numberString))successBlock
{
    NSString * supporturl = [LTCDEModel supportUrl];
    
    AFAppDotNetAPIClient * afAppAPIClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    [afAppAPIClient getCDEContactNumberUrl:supporturl success:^(NSURLSessionDataTask *operation, id responseObject) {
        if ([NSJSONSerialization isValidJSONObject:responseObject]) {
            if (![NSObject empty:responseObject] && [responseObject isKindOfClass:[NSDictionary class]]){
                if ([[responseObject safeValueForKey:@"errorCode"] integerValue] == 0) {
                    NSString * mServiceNumber = [responseObject safeValueForKey:@"serviceNumber"];
                    if (![NSString isBlankString:mServiceNumber] && mServiceNumber.length > 6) {
                        NSString * mNumStr = [mServiceNumber substringFromIndex:mServiceNumber.length - 6];
                        if (successBlock) {
                            successBlock([responseObject safeValueForKey:@"errorCode"],mNumStr);
                        }
                    }
                }
                else
                {
                    if (successBlock) {
                        successBlock(nil,nil);
                    }
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (successBlock) {
            successBlock(nil,nil);
        }
    }];
}
@end
//#endif
