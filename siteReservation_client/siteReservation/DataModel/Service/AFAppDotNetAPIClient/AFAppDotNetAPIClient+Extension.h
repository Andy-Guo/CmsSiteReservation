//
//  AFAppDotNetAPIClient+Extension.h
//  LetvIphoneClient
//
//  Created by wangduan on 14-8-4.
//
//联通流量专属接口类别

//#ifdef LT_IPAD_CLIENT
////#import "OpenSourceRename.h"
//#import "AFAppDotNetAPIClient.h"
//
//@interface AFAppDotNetAPIClient (Extension)
//
////ç´æ¥è¯·æ±url
//-(void)getWoUrl:(NSString *)urlString
//        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
///**
// *  æåç´æ­è¾¹çè¾¹ä¹°ä¿¡æ¯
// *
// *  @param urlString <#urlString description#>
// *  @param success   <#success description#>
// *  @param failure   <#failure description#>
// */
//-(void)getLiveShoppingInfo:(NSString *)urlString success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
////å¡é¡¿æè¯CDEç¸å
//
//+(void)getContactNum:(void(^)(NSString * code,NSString * numberString))successBlock;
//
//@end
//#else



//#import "OpenSourceRename.h"
#import <LetvMobileDataModel/AFAppDotNetAPIClient.h>

@interface AFAppDotNetAPIClient (Extension)

//直接请求url
-(void)getWoUrl:(NSString *)urlString
      success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
/**
 *  或取直播边看边买信息
 *
 *  @param urlString <#urlString description#>
 *  @param success   <#success description#>
 *  @param failure   <#failure description#>
 */
-(void)getLiveShoppingInfo:(NSString *)urlString success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//卡顿投诉CDE相关http请求
+(void)getContactNum:(void(^)(NSString * code,NSString * numberString))successBlock;

@end
//#endif
