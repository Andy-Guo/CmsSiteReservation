//
//  LeMPSessionParameter.m
//  LeTVMobilePlayer
//
//  Created by xingbo on 16/10/17.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "LeMPSessionParameter.h"

@implementation LeMPSessionParameter

- (LeMPSessionParameter *)nextSessionParameter
{
    if (!_nextSessionParameter) {
        _nextSessionParameter = [[LeMPSessionParameter alloc] init];
    }
    return _nextSessionParameter;
}
@end
