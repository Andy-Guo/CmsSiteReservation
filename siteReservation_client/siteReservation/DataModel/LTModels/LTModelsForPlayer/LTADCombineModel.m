//
//  LTADMergeModel.m
//  LetvIphoneClient
//
//  Created by chen on 14-3-3.
//
//

#import "LTADCombineModel.h"
//#import "NSString+HTTPExtensions.h"
#import <LeTVMobileFoundation/LeTVMobileFoundation.h>

@implementation LTADCombineModel

- (void)setAhtWithNSString:(NSString *)aht {
    if ([NSString isBlankString:aht]) {
        _aht = nil;
        return;
    }
    _aht = [aht componentsSeparatedByString:@","];
}

- (void)setAmpWithNSString:(NSString *)amp {
    if ([NSString isBlankString:amp]) {
        _amp = nil;
        return;
    }
    _amp = [amp componentsSeparatedByString:@","];
}

- (void)setAmsWithNSString:(NSString *)ams {
    if ([NSString isBlankString:ams]) {
        _ams = nil;
        return;
    }
    _ams = [ams componentsSeparatedByString:@","];
}

- (void)setAmtWithNSString:(NSString *)amt {
    if ([NSString isBlankString:amt]) {
        _amt = nil;
        return;
    }
    _amt = [amt componentsSeparatedByString:@","];
}

- (void)setAhsWithNSString:(NSString*)ahs
{
    if ([NSString isBlankString:ahs]) {
        _ahs = nil;
        return;
    }
    
    _ahs = [ahs componentsSeparatedByString:@","];
}

- (void)setAtsWithNSString:(NSString*)ats
{
    if ([NSString isBlankString:ats]) {
        _ats = nil;
        return;
    }
    
    _ats = [ats componentsSeparatedByString:@","];
}

-(NSInteger)getAdAhsCount
{
    return [self.ahs count];
}

-(BOOL)isAhsSuccess:(NSInteger)adIndex
{
    if (nil == self.ahs) {
        return NO;
    }
    
    if (adIndex >= self.ahs.count) {
        return NO;
    }
    
    return ([self.ahs[adIndex] integerValue] > 0);
}

- (BOOL)isCombineFailed
{
    if (    [NSString isBlankString:self.vs]
        ||  [self.vs integerValue] <= 0) {
        return YES;
    }
    
    BOOL isAllAhsFailed = YES;
    for (NSString *relAd in self.ahs) {
        if ([relAd integerValue] > 0) {
            isAllAhsFailed = NO;
        }
    }
    
    BOOL isAllAtsFailed = YES;
    for (NSString *relAd in self.ats) {
        if ([relAd integerValue] > 0) {
            isAllAtsFailed = NO;
        }
    }
    
    BOOL isAllAmsFailed = YES;
    for (NSString *relAd in self.ams) {
        if ([relAd integerValue] > 0) {
            isAllAmsFailed = NO;
        }
    }
    
    if (isAllAhsFailed && isAllAtsFailed && isAllAmsFailed) {
        return YES;
    }
    
    if ([NSString isBlankString:self.muri]||[NSString isBlankString:self.m3u8]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"vid"]) {
        return YES;
    }
    return NO;
}

@end
