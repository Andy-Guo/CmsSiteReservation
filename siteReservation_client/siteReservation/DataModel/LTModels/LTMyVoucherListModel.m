//
//  LTMyVoucherListModel.m
//  LeTVMobileDataModel
//
//  Created by Speed on 15/11/6.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTMyVoucherListModel.h"

@implementation LTMyVoucherModel

+ (JSONKeyMapper *) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"voucherId"}];
}

- (void) updateDateFormatter
{
    if (self.cancelTime.length > 0) {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[self.cancelTime longLongValue]/1000];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.cancelTime = [NSString stringWithFormat:@"有效期至%@",[dateFormatter stringFromDate:date]];
    }
    
    if ([self.type isEqualToString:@"0"] && self.currentNum.length == 1 && ![self.currentNum isEqualToString:@"0"]) {
        self.currentNum = [NSString stringWithFormat:@"0%@",self.currentNum];
    }
}

@end

@implementation LTMyVoucherListValuesModel

@end

@implementation LTMyVoucherListModel

@end
