//
//  AFURLSessionTaskOperation.m
//  LeTVMobileDataModel
//
//  Created by 王易平 on 16/7/11.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "AFURLSessionTaskOperation.h"

@implementation AFURLSessionTaskOperation

+ (instancetype)operationWithURLSessionTask:(NSURLSessionDataTask *)task {
    AFURLSessionTaskOperation *op = [self blockOperationWithBlock:^{
        [task resume];
    }];
    op.task = task;
    return op;
}

@end
