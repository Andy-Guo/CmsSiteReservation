//
//  LTUserCommentReplyModel.m
//  LeTVMobileDataModel
//
//  Created by Speed on 15/9/8.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTUserCommentReplyModel.h"

@implementation LTuserCommentInfoModel

@end

@implementation LTUserCommentReplyInfoModel

@end

@implementation LTUserCommentReplyContentModel

@end

@implementation LTUserCommentReplyDataModel

+ (JSONKeyMapper *) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"messageId"}];
}

@end

@implementation LTUserCommentReplyModel

@end
