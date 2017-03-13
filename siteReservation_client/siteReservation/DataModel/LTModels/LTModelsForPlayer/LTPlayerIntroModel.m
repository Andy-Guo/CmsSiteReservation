//
//  LTPlayerIntroModel.m
//  LeTVMobileDataModel
//
//  Created by zyf on 15/3/30.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTPlayerIntroModel.h"

@implementation LTPlayerIntroModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description"  : @"desc",
                                                       }];
}

@end
