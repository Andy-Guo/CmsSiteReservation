//
//  LTLiveEngine.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-11-18.
//
//

#import <Foundation/Foundation.h>

typedef void (^LTLiveDataCompletionBlock)();
typedef void (^LTLiveDataErrorCompletionBlock)(NSError *error);

@interface LTLiveEngine : NSObject

+ (void)liveOrderWithDataModel:(id)dataModel
//                      andIndex:(NSInteger)index
             completionHandler:(LTLiveDataCompletionBlock)completionBlock
                   errorHander:(LTLiveDataErrorCompletionBlock)errorBlock;

+ (void)cancelLiveOrderWithDataModel:(id)dataModel
//                            andIndex:(NSInteger)index
                   completionHandler:(LTLiveDataCompletionBlock)completionBlock
                         errorHander:(LTLiveDataErrorCompletionBlock)errorBlock;

+ (void)liveOrderWithChannelModel:(id)channelModel
              channelDetailModel:(id)detailModel
               completionHandler:(LTLiveDataCompletionBlock)completionBlock
                     errorHander:(LTLiveDataErrorCompletionBlock)errorBlock;

+ (void)cancelLiveOrderWithChannelModel:(id)channelModel
                    channelDetailModel:(id)detailModel
                     completionHandler:(LTLiveDataCompletionBlock)completionBlock errorHander:(LTLiveDataErrorCompletionBlock)errorBlock;
+ (void)cancelMultiOrdersWithParas:(NSArray *)models
                 completionHandler:(LTLiveDataCompletionBlock)completionBlock
                       errorHander:(LTLiveDataErrorCompletionBlock)errorBlock;




@end
