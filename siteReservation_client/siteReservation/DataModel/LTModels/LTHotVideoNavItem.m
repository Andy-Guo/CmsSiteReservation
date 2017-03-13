//
//  LTHotVideoNavItem.m
//  LeTVMobileDataModel
//
//  Created by zhangyongtao on 15/9/7.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTHotVideoNavItem.h"

@implementation LTHotVideoNavItem

+ (NSArray *)praseWithDict:(NSDictionary *)dict
{
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:dict.count];
    if (dict != nil && [dict isKindOfClass:[NSDictionary class]]) {
        for (NSDictionary * dictionary in dict[@"hotpoint_channel"]) {
            LTHotVideoNavItem * item = [[LTHotVideoNavItem alloc] init];
            item.channel_name = dictionary[@"channel_name"];
            item.page_id = [dictionary[@"page_id"] integerValue];
            item.sort = [dictionary[@"sort"] integerValue];
            item.display = [dictionary[@"display"] integerValue];
            [array addObject:item];
        }
    }
    return array;
}

@end
