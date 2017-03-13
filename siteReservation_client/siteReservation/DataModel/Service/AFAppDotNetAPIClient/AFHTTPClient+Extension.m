//
//  AFHTTPClient+Extension.m
//  LetvIphoneClient
//
//  Created by pdh on 13-11-26.
//
//

#import "AFHTTPClient+Extension.h"
#import "LTRequestURLManager.h"
#import "AFHTTPRequestOperation+Extension.h"

@implementation AFHTTPClient (letv)
#pragma mark - added by Letv
- (void)cancelAllHTTPOperationsByUrlModule:(LTURLModule)urlModule
{
    if (urlModule == LTURLModule_Unknown) {
        return;
    }
    
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        
        AFHTTPRequestOperation *requestOperation = (AFHTTPRequestOperation *)operation;
        
        if (requestOperation.requestTag == urlModule) {
            [requestOperation cancel];
        }
        
//        NSString *path = [[[(AFHTTPRequestOperation *)operation request] URL] absoluteString];
//        
//        if ([LTRequestURLManager getUrlModuleByUrl:path] == urlModule) {
//            
//            NSLog(@"!! cancel request1: %@", path);
//            
//            [operation cancel];
//            
//            NSLog(@"!! cancel request2: %@", path);
//        }
    }
    
    return;
}

- (void)upLoadImageDataWithUrl:(NSString *)urlPath withImageData:(NSData *)imageData success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSMutableURLRequest *fileUpRequest = [self multipartFormRequestWithMethod:@"POST" path:urlPath parameters:nil constructingBodyWithBlock:^(id formData) {
        NSString *imgName = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%ld", time(NULL)]];
        [formData appendPartWithFileData:imageData name:@"img" fileName:imgName mimeType:@"image/jpeg"];
    }];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:fileUpRequest success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}
@end
