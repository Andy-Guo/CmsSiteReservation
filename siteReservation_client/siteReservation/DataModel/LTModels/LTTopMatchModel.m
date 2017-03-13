//
//  LTTopMatchModel.m
//  LetvIphoneClient
//
//  Created by wangduan on 14-4-25.
//
//

#import "LTTopMatchModel.h"


@implementation LTImageUrlItemModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"100*100" : @"icon100_100",
                                                       @"120*90" : @"icon120_90",
                                                       }];
}

@end

@implementation LTTopMatchItemModel


@end

@implementation LTTopMatchModel

@end