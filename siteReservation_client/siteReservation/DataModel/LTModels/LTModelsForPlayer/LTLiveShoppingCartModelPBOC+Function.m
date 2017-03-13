//
//  LTLiveShoppingCartModelPBOC+Function.m
//  LeTVMobileDataModel
//
//  Created by Daemonson on 16/3/31.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTLiveShoppingCartModelPBOC+Function.h"

@implementation LTLiveShoppingCartModelPBOC (Function)
- (NSInteger)getShoppingCartCount {
    NSInteger count = [[self.result safeValueForKey:@"cartItemCount"] integerValue];
    return count;
}
@end
