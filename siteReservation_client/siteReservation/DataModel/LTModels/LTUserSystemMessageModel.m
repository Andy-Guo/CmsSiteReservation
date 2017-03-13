//
//  LTUserSystemMessageModel.m
//  LeTVMobileDataModel
//
//  Created by Speed on 15/8/28.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTUserSystemMessageModel.h"

@implementation LTSystemMessageDetailModel

@end

@implementation LTSystemMessageModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"messageId"}];
}

@end

@implementation LTUserSystemMessageModel

@end

@implementation  LTUserSystemMessageModelData

@end

@implementation LTUnreadMessageModel

@end
