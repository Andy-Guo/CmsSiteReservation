//
//  LTProductAttentionModelPBOC+Function.m
//  LeTVMobileDataModel
//
//  Created by Daemonson on 16/3/31.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LTProductAttentionModelPBOC+Function.h"

@implementation LTProductAttentionModelPBOC (Function)
/**
 *  获取商品关注人数
 *
 *  @return 商品关注人数
 */
- (NSString *)getProductAttentionCont {
    NSInteger count = [[self.result safeValueForKey:@"cartTotalCount"] integerValue];
    NSString *totalCount = [NSString stringWithFormat:@"%ld", (long)count];
    if ([NSString isBlankString:totalCount]) {
        return @"0";
    }
    //格式化
    totalCount = [NSString getCommentNumberWithNumber:@(count)];
    return totalCount;
}
@end
