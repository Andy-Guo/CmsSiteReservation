//
//  LTDataModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import "LTDataModel.h"
//#import "NSString+HTTPExtensions.h"

@implementation LTHeaderModel

#pragma mark - properties
-(void)setStatusWithNSString:(NSString*)status
{
    if ([NSString isBlankString:status]) {
        _status = DataStatusAbnormal;
    }
    else if ([status isEqualToString:@"1"]) {
        _status = DataStatusNormal;
    }
    else if ([status isEqualToString:@"2"]) {
        _status = DataStatusEmpty;
    }
    else if ([status isEqualToString:@"3"]) {
        _status = DataStatusAbnormal;
    }
    else if ([status isEqualToString:@"4"]) {
        _status = DataStatusNotChange;
    }
    else if ([status isEqualToString:@"5"]){
        _status = DataStatusTokenExpired;   // fixme
    }
    else if ([status isEqualToString:@"6"]){
        _status = DataStatusIPShield;
    }
    else{
        _status = DataStatusAbnormal;
    }
}

@end



@implementation LTDataModel


@end
