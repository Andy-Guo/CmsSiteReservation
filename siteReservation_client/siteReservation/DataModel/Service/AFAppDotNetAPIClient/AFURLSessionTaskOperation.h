//
//  AFURLSessionTaskOperation.h
//  LeTVMobileDataModel
//
//  Created by 王易平 on 16/7/11.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFURLSessionTaskOperation : NSBlockOperation

@property (nonatomic, weak) NSURLSessionDataTask *task;

+(instancetype) operationWithURLSessionTask:(NSURLSessionDataTask *)task;

@end
