//
//  LTPromotionModel.m
//  LetvIphoneClient
//
//  Created by Chen Jianjun on 13-11-6.
//
//

#import "LTPromotionModel.h"

@implementation LTPromotionModel

+ (JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data":@"promotionData", @"spread_status":@"spreadStatus"}];
}

@end

@implementation LTPromotionSubModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"locationId", @"type":@"type", @"pic":@"pic", @"word":@"word", @"url":@"url"}];
}

@end