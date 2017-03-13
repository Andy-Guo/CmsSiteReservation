//
//  AFHTTPClient+Extension.h
//  LetvIphoneClient
//
//  Created by pdh on 13-11-26.
//
//

#import <Foundation/Foundation.h>
#import "SqlDBHelper.h"
#import "LTRequestURLDefine.h"
#import <LetvMobileOpenSource/AFHTTPClient.h>
#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

//@class AFHTTPClient;
@interface AFHTTPClient (letv)
#pragma mark - added by Letv
- (void)cancelAllHTTPOperationsByUrlModule:(LTURLModule)urlModule;

- (void)upLoadImageDataWithUrl:(NSString *)urlPath
                  withImageData:(NSData *)imageData
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
