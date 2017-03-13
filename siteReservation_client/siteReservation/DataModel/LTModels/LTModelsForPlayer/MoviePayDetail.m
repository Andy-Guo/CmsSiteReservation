//
//  MoviePayDetail.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-22.
//
//

#import "MoviePayDetail.h"
//#import "NSString+HTTPExtensions.h"

@implementation MoviePayDetail

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"chargetype"       : @"__allowMonth",
            @"chargeflatform"   : @"__singlePrice",
            @"validDays"        : @"__payDate",
            }];
}


- (VIPAllowMonth)allowMonth
{
    VIPAllowMonth tAllowMonth = VIP_ALLOWMONTH_UNDEFINE;
    if (![NSString isBlankString:self.__allowMonth]) {
        tAllowMonth = [self.__allowMonth intValue];
    }
    if (    tAllowMonth < VIP_ALLOWMONTH_UNDEFINE
        ||  tAllowMonth >= VIP_ALLOWMONTH_COUNT) {
        tAllowMonth = VIP_ALLOWMONTH_UNDEFINE;
    }
    
    return tAllowMonth;
}

- (float)singlePrice
{
    return [self.__singlePrice floatValue];
}

- (NSInteger)payDate
{
    return [self.__payDate integerValue];
}

- (BOOL)isPayForMonth
{
    if (    VIP_ALLOWMONTH_BOTH == self.allowMonth
        ||  VIP_ALLOWMONTH_MONTH == self.allowMonth) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isPayForSingle
{
    return (VIP_ALLOWMONTH_SINGLE == self.allowMonth);
}

@end
