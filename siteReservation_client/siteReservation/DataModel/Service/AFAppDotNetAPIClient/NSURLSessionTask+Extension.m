//
//  NSURLSessionDataTask+Extension.m
//  LeTVMobileDataModel
//
//  Created by 王易平 on 16/7/11.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "NSURLSessionTask+Extension.h"

static void* NSURLSessionDataTaskRequestTagKey = &NSURLSessionDataTaskRequestTagKey;

@implementation NSURLSessionTask (Extension)

- (NSInteger)requestTag {
    NSNumber *tagNum = objc_getAssociatedObject(self, NSURLSessionDataTaskRequestTagKey);
    if (!tagNum) {
        return 0;
    }
    return [tagNum integerValue];
}

- (void)setRequestTag:(NSInteger)requestTag {
    objc_setAssociatedObject(self, NSURLSessionDataTaskRequestTagKey, [NSNumber numberWithInteger:requestTag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
