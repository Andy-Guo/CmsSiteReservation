//
//  AtListModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-2.
//
//

#import "AtListModel.h"

#ifndef LT_IPAD_CLIENT

@implementation AtWebModel

@end

@implementation AtSubjectModel

@end

@implementation AtWebInnerModel

@end

@implementation AtLivingModel

@end

@implementation AtTvLivingModel

@end


@implementation AtListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"at_3" : @"atWeb",
            @"at_4" : @"atSubject",
            @"at_5" : @"atWebInner",
            @"at_6" : @"atLiving",
            @"at_8" : @"atTvLiving"
            }];
}

@end

#else

@implementation AtWebModel

@end

@implementation AtSubjectModel

@end

@implementation AtWebInnerModel

@end

@implementation AtLivingModel

@end

@implementation AtTvLivingModel

@end


@implementation AtListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"at_3" : @"atWeb",
                                                       @"at_4" : @"atSubject",
                                                       @"at_5" : @"atWebInner",
                                                       @"at_6" : @"atLiving",
                                                       @"at_8" : @"atTvLiving"
                                                       }];
}

@end

#endif
