//
//  LTChannelFilterModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-11-6.
//
//

#import "LTChannelFilterModel.h"
#import <LeTVMobileFoundation/LeTVMobileFoundation.h>
//#import "NSObject+ObjectEmpty.h"
@implementation LTFilterParamModel

@end

@implementation LTFilterValueModel

@end

@implementation LTFilterKeyModel

@end

@implementation LTFilterModel

- (BOOL)isFilterModelValuesExist
{
    if (![NSObject empty:self.types]) {
        for (LTFilterKeyModel *keyModel in self.types) {
            if (![NSObject empty:keyModel.items]) {
                return YES;
            }
        }
    }
    
    return NO;
}

@end

@implementation LTChannelFilterModel

@end
